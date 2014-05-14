class URI::Template:auth<github:flussence>:ver<0.0.1>;

has Str $.template;

#= Creates a URI by filling in the parameters.
method format(@params) returns Str {
    $.template;
}

#= Attempts to parse a list of variables out of a given URI.
method parse(Str $uri) returns Array {
    []
}
