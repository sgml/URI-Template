class URI::Template:auth<github:flussence>:ver<0.0.1>;

use URI::Template::Grammar;

has Str $!template;
has     $!parsed;

method new(Str $template) {
    my $parsed = URI::Template::Grammar.parse($template)
        or fail "Parsing failed for '$template'";

    self.bless(:$template, :$parsed);
}

#= Creates a URI by filling in the parameters.
method format(%params) returns Str {
    ...
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    ...
}

#= URI::Escape isn't specific enough to do what we want here
my sub uri-escape(Str $str) {
    join q{}, do for $str.split(/ <[\x20..\x21]> /, :all) {
        when Match { .ord.fmt('%%%02x') }
        default    { $_ }
    }
}
