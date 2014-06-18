module TestSpecExamples;

use Test;
use Test::Corpus;
use URI::Template;

sub test-templates-using-params(%params) is export {
    run-tests sub ($in, $out, $test) {
        my $template = $in.slurp.chomp;
        my $uri = URI::Template.new($template).format(%params);

        is $uri, $out.slurp.chomp, "test file $test - $template";
    }
}
