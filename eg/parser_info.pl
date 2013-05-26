#!/bin/env perl

use strict;
use warnings;
use lib qw(../lib);
use lib qw(lib);
use WebService::Readability::Parser;
use Data::Dumper;

my $r = WebService::Readability::Parser->new(
    token           => 'Token',
);

my $res = $r->info;

print Dumper $res->{content};

