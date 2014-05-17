module TestSpecExamples;

use Test;
use Test::Corpus;
use URI::Template;

sub test-templates-using-params(%params) is export {
    run-tests sub ($in, $out, $test) {
        is  URI::Template.new($in.slurp.chomp).format(%params),
            $out.slurp.chomp,
            $test;
    }
}
