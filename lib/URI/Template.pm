class URI::Template:auth<github:flussence>:ver<0.0.1>;

use URI::Template::Actions;
use URI::Template::Grammar;

has Str   $.template;
has Match $.parsed;

method new(Str $template) {
    my $parsed = URI::Template::Grammar.parse(
        $template,
        actions => URI::Template::Actions.new
    ) or die 'Parsing template failed';

    self.bless(:$template, :$parsed);
}

#= Creates a URI by filling in the parameters.
method format(%params) returns Str {
    return join q{}, gather for $.parsed.ast {
        # A literal: «"http://example.com/foo/bar"»
        when Str  { take $_ }
        # An expression AST: «[ [var, ...] => lv4-modifier?, ...] => lv2-operator?»
        when Pair {
            my $var = .key[0].key[0];

            warn 'Level 2 operators NYI' if .value;
            warn 'Level 4 modifiers NYI' if .key[0].value;
            warn 'Comma-separated NYI'   if .key[0].elems > 1;
            warn 'Dot-separated NYI'     if .key[0].key.elems > 1;

            unless %params{$var} {
                fail "Template references undefined variable {$var.perl}, these were given:\n"
                    ~ %params.keys».perl.join(qq{\n}).indent(4);
            }

            take pct-escape(%params{$var});
        }
        # Things that shouldn't happen
        default { !!! 'Template contains a ' ~ .WHAT }
    }
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    ... 'Deconstructing URIs via template is NYI'
}

#= Escape URI characters
sub pct-escape($str) returns Str {
    # List borrowed from RFC 3986
    my @allowed = 'a'..'z', 'A'..'Z', '0'..'9', qw{- . _ ~};

    # TODO - make a module out of this split-map-join pattern, maybe
    $str.split(/ @allowed+ /, :all).map({
        when Match { $_ }
        # FIXME not utf-8 compliant
        when Str   { .ords».fmt('%%%02x').join }
    }).join;
}
