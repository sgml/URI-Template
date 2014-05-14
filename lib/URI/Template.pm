class URI::Template:auth<github:flussence>:ver<0.0.1>;

has Str $.template;

#= Creates a URI by filling in the parameters.
method format(%params) returns Str {
    join q{}, map &uri-escape,
        do for $.template.split(/ '{' ( <[a..z]>+ ) '}' /, :all) {
            when Match { %params{~$_[0]}.Str }
            default    { $_ }
        }
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    []
}

#= URI::Escape isn't specific enough to do what we want here
my sub uri-escape($str) {
    join q{}, do for $str.split(/ <[\x20..\x21]> /, :all) {
        when Match { .ord.fmt('%%%02x') }
        default    { $_ }
    }
}
