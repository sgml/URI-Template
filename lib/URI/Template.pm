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
    return $.parsed.ast.map({
        $_ when Str;
        stringify($_, %params) when Pair;
    }).join
}

sub stringify(Pair $_, %params) {
    fail 'Level 2+ operators NYI' if .key;
    fail 'Compound values NYI' if .value.elems > 1;

    ~%params{.value}
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    ...
}
