use strict;
use Test::More;

use_ok $_ for qw(
    WebService::Readability
    WebService::Readability::Base
    WebService::Readability::Parser
    WebService::Readability::Reader
    WebService::Readability::Shortener
);

done_testing;

