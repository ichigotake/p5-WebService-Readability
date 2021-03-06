#!/bin/env perl

use strict;
use warnings;
use lib qw(lib);
use WebService::Readability::Reader;

my $r = WebService::Readability::Reader->new(
    username        => 'username',
    password        => 'password',
    consumer_key    => 'Key',
    consumer_secret => 'Secret'
);

my $res = $r->bookmarks;

for my$article ( @{$res->{content}->{bookmarks}} ) {
    print "------\n";
    print "title: " . $article->{article}->{title} . "\n";
    print "url: " . $article->{article}->{url} . "\n";
}

