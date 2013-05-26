package WebService::Readability;
use strict;
use warnings;
use utf8;
use parent qw/WebService::Readability::Base/;
use WebService::Readability::Parser;
use WebService::Readability::Reader;
use WebService::Readability::Shortener;

our $VERSION = '0.2';


sub shortener {
    return shift->_create_instance('WebService::Readability::Shortener');
}

sub parser {
    return shift->_create_instance('WebService::Readability::Parser');
}

sub reader {
    return shift->_create_instance('WebService::Readability::Reader');
}

1;
__END__

=encodinf utf8

=head1 NAME

WebService::Readability - Access all the capabilities of Readability

=head1 SYNOPSIS

    use WebService::Readability;

    my $r = WebService::Readability->new(
        # for Reader API
        username        => 'username',
        password        => 'password',
        consumer_key    => 'Key',
        consumer_secret => 'Secret'
        # for Parser API
        token => 'Token',
    );

    #format: $r->$api_name->$api_method($param, $method)

    $r->reader->reader->bookmarks({
        order => '-date_added',
        page  => 2,
    }, 'GET');

    $r->parser->parser({
        url => 'https://github.com/ichigotake/p5-WebService-Readability',
    }, 'GET');

=head1 SEE ALSO

Developers — Readability L<https://www.readability.com/developers>

WebService::Readability::Shortener

WebService::Readability::Parser

WebService::Readability::Reader

=head1 AUTHOR

@ichigotake

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

