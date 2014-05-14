#!/usr/bin/env perl6
use Test;
use URI::Template;

my   @valid-templates = ( q[{] X~ «. ; / ? & \# ''» X~ q[foo}] );
my @invalid-templates = ( q[{] X~ «£ _ ¬ ( ~ \\ \'» X~ q[foo}] ),
                        <} { foo} {foo {}>;

plan @valid-templates + @invalid-templates;

lives_ok { URI::Template.new(template => $_) }, $_ for   @valid-templates;
 dies_ok { URI::Template.new(template => $_) }, $_ for @invalid-templates;
