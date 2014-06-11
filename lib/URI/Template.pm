class URI::Template:auth<github:flussence>:ver<0.0.1>;

use URI::Template::Actions;
use URI::Template::Grammar;

has Str   $.template;
has Match $.parsed;

method new(Str $template) {
    my $parsed = URI::Template::Grammar.parse(
        $template,
        actions => URI::Template::Actions.new
    ) or fail;

    self.bless(:$template, :$parsed);
}

#= Creates a URI by filling in the parameters.
method format(%params) returns Str {
    return join q{}, gather for $.parsed.ast {
        when Str    { take $_ }
        when Array  {
            fail 'Level 2+ operators NYI' if .[1];
            fail 'Compound values NYI'    if .[0].elems > 1;
            take pct-escape(%params{.[0]} // fail "Undefined variable {.[0]}");
        }
        default     { ??? }
    }
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    ...
}

#= Escape URI characters
sub pct-escape($str) {
    # List borrowed from RFC 3986
    my @allowed = 'a'..'z', 'A'..'Z', '0'..'9', qw{- . _ ~};

    # Idea recycled from Str.indent (maybe there's a better way to do this)
    $str.split(/ @allowed+ /, :all).map({
        when Match { $_ }
        when Str   { .ords».fmt('%%%02x').join }
    }).join;
}
