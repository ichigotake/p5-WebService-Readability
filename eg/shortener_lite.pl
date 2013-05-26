#!/bin/env perl

use strict;
use warnings;
use lib qw(lib);
use WebService::Readability::Shortener;

my $url = WebService::Readability::Shortener->get('http://hachiojipm.org/');

print $url . "\n";

