#!/usr/bin/env perl6
use lib qw{t/};
use TestSpecExamples;

test-templates-using-params {
    var   => 'value',
    hello => 'Hello World!',
    empty => '',
    path  => '/foo/bar',
    x     => '1024',
    y     => '768',
};
