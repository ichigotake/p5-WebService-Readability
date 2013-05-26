#!/bin/env perl

use strict;
use warnings;
use lib qw(lib);
use WebService::Readability::Shortener;
use Data::Dumper;

my $content = WebService::Readability::Shortener->shortener('http://hachiojipm.org/');

if ( $content->{content}->{success} ) {
    print Dumper $content->{content};
} else {
    print "request failed\n";
}

