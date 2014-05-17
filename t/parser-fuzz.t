#!/usr/bin/env perl6
use Test;
use URI::Template;

# "_" is included here because it should be valid - as the first character of a variable name.
my   @valid-prefixes = qw{ + # . / ; ? & _ }, q{};
my @invalid-prefixes = qw{ £ $ ^ * ( ) - : };

# TODO - figure out how to correctly handle these
my @reserved-prefixes = qw{ = , ! @ | };
@invalid-prefixes.push(@reserved-prefixes);

my   @valid-templates = (q[{] X~   @valid-prefixes X~ q[foo}]);
my @invalid-templates = (q[{] X~ @invalid-prefixes X~ q[foo}]), <} { foo} {foo {}>;

plan @valid-templates + @invalid-templates;

{ lives_ok { URI::Template.new($_) }, "'$_' works" } for   @valid-templates;
{  dies_ok { URI::Template.new($_) }, "'$_' fails" } for @invalid-templates;
