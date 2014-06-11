module TestSpecExamples;

use Test;
use Test::Corpus;
use URI::Template;

sub test-templates-using-params(%params) is export {
    run-tests sub ($in, $out, $test) {
        my $uri = URI::Template.new($in.slurp.chomp).format(%params);

        # Don't die immediately on seeing one of these
        todo $uri.message if not $uri and $uri.?message ~~ /NYI/;

        is $uri, $out.slurp.chomp, $test
    }
}
