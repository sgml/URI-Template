#!/usr/bin/env perl6
use Test;
use URI::Template;

my %test-data =
    '/~{username}/' => {
        '/~fred/' => { :username<fred> },
        '/~mark/' => { :username<mark> },
    },
    '/dictionary/{term:1}/{term}' => {
        '/dictionary/c/cat' => { :term<cat> },
        '/dictionary/d/dog' => { :term<dog> },
    },
    '/search{?q,lang}' => {
        '/search?q=cat&lang=en'   => { :q<cat>,   :lang<en> },
        '/search?q=chien&lang=fr' => { :q<chien>, :lang<fr> },
    },
    '/foo{?query,number}' => {
        '/foo?query=mycelium&number=100' => { :query<mycelium>, :number<100> },
        '/foo?number=100'                => { :number<100> },
        '/foo'                           => { },
    },
;

plan [+] %test-data.values».elems;

for %test-data.kv -> $template, $data {
    my $t = URI::Template.new($template);

    for %$data.kv -> $uri, $params {
        my $formatted = $t.format($params);
        is $formatted, $uri,                    "Reconstructing original URI via template";

        # All of these examples look possible, so we should try this at some point
        #ok my $parsed = $t.parse($uri),         "Parsing URI via template";
        #is_deeply $parsed, $params;
    }
}
