#!/usr/bin/env perl6
use lib qw{t/};
use TestSpecExamples;
use Test::Corpus;

my $params = [
    count       => <one two three>,
    dom         => <example com>,
    dub         => 'me/too',
    hello       => 'Hello World!',
    half        => '50%',
    var         => 'value',
    who         => 'fred',
    base        => 'http://example.com/home/',
    path        => '/foo/bar',
    list        => <red green blue>,
    keys        => [ :semi<;> , :dot<.> , :comma<,> ],
    v           => '6',
    x           => '1024',
    y           => '768',
    empty       => '',
    empty_keys  => [],
    undef       => Nil,
];

run-tests( simple-test &apply-template.assuming(:$params) );
