#!/usr/bin/env perl6
use Test;
use URI::Template;

my %test-data =
    '/~{username}/' => {
        '/~fred/' => [ :username<fred> ],
        '/~mark/' => [ :username<mark> ],
    },
    '/dictionary/{term:1}/{term}' => {
        '/dictionary/c/cat' => [ :term<cat> ],
        '/dictionary/d/dog' => [ :term<dog> ],
    },
    '/search{?q,lang}' => {
        '/search?q=cat&lang=en'   => [ :q<cat>,   :lang<en> ],
        '/search?q=chien&lang=fr' => [ :q<chien>, :lang<fr> ],
    },
    '/foo{?query,number}' => {
        '/foo?query=mycelium&number=100' => [ :query<mycelium>, :number<100> ],
        '/foo?number=100'                => [ :number<100> ],
        '/foo'                           => [ ],
    },
;

plan %test-data.elems + (4 * [+] %test-data.values».elems);

for %test-data.kv -> $template, $data {
    ok my $t = URI::Template.new(:$template),   "Constructing an object for '$template'";

    for %$data.kv -> $uri, $params {
        ok my $formatted = $t.format($params),  "Reconstructing original URI via template";
        is $formatted, $uri;

        # All of these examples are possible, so we should try
        ok my $parsed = $t.parse($uri),         "Parsing URI via template";
        is_deeply $parsed, $params;
    }
}
