class URI::Template::Actions:auth<github:flussence>:ver<0.0.1>;

method TOP($/)          { make $<piece>».ast }
method  piece($/)       { make $/.values[0].ast }
method   literal($/)    { make ~$/ }
method   expr($/)       { make [$<var>».ast.item, $<op>.?ast] }
method    op($/)        { make ~$/ }
method     op-reserved  { ??? }
method    var($/)       { make [$<var-name>».ast.item, $<mod-lv4>.?ast] }
method     var-name($/) { make ~$/ }
method     mod-lv4($/)  { ??? }
