#use Grammar::Tracer;

grammar URI::Template::Grammar:auth<github:flussence>:ver<0.0.1>;

# High-level stuff
token TOP           { ^ [ <literal> | <expression> ]+ $ }
token literal       { <.literal-char>+ }
token expression    { '{' ~ '}' [ <operator>? <variable-list> ] }

# Bits and pieces
token operator      { <op-lv2> | <op-lv3> | <op-reserved> }
token variable-list { <variable-spec>+ % ',' }
token variable-spec { <variable-name> <modifier-lv4>? }
token variable-name { <.varchar> [ '.'? <.varchar> ]* }
token modifier-lv4  { <prefix> | <explode> }
token prefix        { ':' <max-length> }
token explode       { '*' }

# Raw stuff
token literal-char  {
    #`( This isn't a carbon copy of the spec, but I really can't be bothered writing out all of
    #   <ucschar> and <iprivate> )
    <-cntrl -[ \s \" \% \' \< \> \\ \` \{ \| \} ]> | <.pct-encoded>
}
token op-lv2        { <[+#]> }
token op-lv3        { <[./;?&]> }
token op-reserved   { <[=,!@|]> { die 'Reserved operator encountered' } }
token varchar       { <[a..z A..Z 0..9 _]> | <.pct-encoded> }
token max-length    { <[0..9]> ** 1..4 }

token pct-encoded   { '%' <.xdigit> ** 2 }
