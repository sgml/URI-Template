module TestSpecExamples;

use Test;
use URI::Template;

sub test-templates($in, $out, $testname, :$params) is export {
    ok my $t = URI::Template.new(template => $in.slurp),    "Constructing template object";
    ok my $formatted = $t.format($params),                  "Applying template";
    is $formatted, $out.slurp,                              "Template produces correct value";
}
