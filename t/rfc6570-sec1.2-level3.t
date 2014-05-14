#!/usr/bin/env perl6
use lib qw{t/};
use TestSpecExamples;
use Test::Corpus;

my $params = [
    var   => 'value',
    hello => 'Hello World!',
    empty => '',
    path  => '/foo/bar',
    x     => '1024',
    y     => '768',
];

run-tests( simple-test &apply-template.assuming(:$params) );
