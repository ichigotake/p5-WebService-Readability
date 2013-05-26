#!/bin/env perl

use strict;
use warnings;
use lib qw(lib);
use WebService::Readability::Parser;
use Data::Dumper;

my $r = WebService::Readability::Parser->new(
    token => 'Token',
);

my $res = $r->parser({ url => 'http://hachiojipm.org/' });

print Dumper $res->{content};

