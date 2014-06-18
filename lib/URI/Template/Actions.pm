class URI::Template::Actions:auth<github:flussence>:ver<0.0.1>;

method TOP($/)          { make $<piece>».ast }
method  piece($/)       { make $/.values[0].ast }
method   literal($/)    { make ~$/ }
method   expr($/)       { make [$<var-list>».ast] => $<op>.?ast }
method    op($/)        { make ~$/ }
method     op-reserved  { ??? 'Reserved operator encountered' }
method    var-list($/)  { make [$<var>».ast] => $<mod-lv4>.?ast }
method     var($/)      { make ~$/ }
method     mod-lv4($/)  { make $<prefix>.?ast // $<explode>.Str }
method      prefix($/)  { make $<max-length>.Int }
