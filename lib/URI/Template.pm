class URI::Template:auth<github:flussence>:ver<0.0.1>;

use URI::Template::Actions;
use URI::Template::Grammar;

has Str $.template;
has     $.parsed;

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
        say $_.perl;
        when Str  { take $_ }
        when Pair {
            fail 'Level 2+ operators NYI' if .value;
            fail 'Compound values NYI' if .key.elems > 1;
            take ~%params{.key}
        }
    }
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    ...
}
