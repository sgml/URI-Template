module TestSpecExamples;

use Test;
use URI::Template;

sub apply-template($in, :$params) is export {
    URI::Template.new(template => $in).format($params),
}
