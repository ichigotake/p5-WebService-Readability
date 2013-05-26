#!/bin/env perl

use strict;
use warnings;
use utf8;
use WebService::Readability;
use Data::Dumper;

my $r = WebService::Readability->new(
    username        => 'username',
    password        => 'password',
    consumer_key    => 'Key',
    consumer_secret => 'Secret',
    token => 'Token',
);

print Dumper $r->parser->info;
print Dumper $r->reader->info;

