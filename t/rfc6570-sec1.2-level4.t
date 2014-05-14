#!/usr/bin/env perl6
use lib qw{t/};
use TestSpecExamples;
use Test::Corpus;

my $params = [
    var   => 'value',
    hello => 'Hello World!',
    path  => '/foo/bar',
    list  => <red green blue>,
    keys  => [ :semi<,>, :dot<.>, :comma<,> ];
];

run-tests( &test-templates.assuming(:$params), :tests-per-block(3) );
