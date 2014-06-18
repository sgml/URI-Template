#use Grammar::Tracer;

grammar URI::Template::Grammar:auth<github:flussence>:ver<0.0.1>;

token TOP               {^ <piece>+ $}
token  piece            { <literal> | <expr> }
token   literal         { [ <-[ \s \' \\ '"%<>`{|}' ] -cntrl>
                          | <.percent> ]+ }
token   expr            { '{' ~ '}' [ <op>? <var-list>+ % ',' ] }
token    op             { <op-lv2> | <op-lv3> | <op-reserved> }
token     op-lv2        { <[+#]> }
token     op-lv3        { <[./;?&]> }
token     op-reserved   { <[=,!@|]> }
token    var-list       { [ <var>+ % '.' ] <mod-lv4>? }
token     var           { [ <[a..z A..Z 0..9 _]>
                          | <.percent> ]+ }
token     mod-lv4       { <prefix> | $<explode> = '*' }
token      prefix       { ':' $<max-length> = [ <[0..9]> ** 1..4 ] }

token percent           { '%' <.xdigit> ** 2 }
