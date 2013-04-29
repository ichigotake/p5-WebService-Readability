package WebService::Readability;
use strict;
use warnings;
use OAuth::Lite::Consumer;
use parent qw/Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/consumer request_token access_token/);

use JSON;

our $VERSION = '0.1';
our $ENDPOINT = {
    base_url        => 'www.readability.com/api',
    authorize       => 'www.readability.com/api/rest/v1/oauth/authorize/',
    request_token   => 'www.readability.com/api/rest/v1/oauth/request_token/',
    access_token    => 'www.readability.com/api/rest/v1/oauth/access_token/',
};

sub new {
    my ($class, @args) = @_;
    my $self = bless {@args}, $class;

    unless ( $self->consumer ) {
        $self->{consumer} = OAuth::Lite::Consumer->new(
            consumer_key => $self->{consumer_key},
            consumer_secret => $self->{consumer_secret},
        );
    }

    unless ( $self->request_token ) {
        $self->{request_token} = $self->{consumer}->obtain_access_token(
            url => 'https://' . $self->ENDPOINT->{access_token},
            params => {
                x_auth_username => $self->{username},
                x_auth_password => $self->{password},
                x_auth_mode => 'client_auth',
            }
        );
    }

    unless ( $self->access_token ) {
        $self->{access_token} = OAuth::Lite::Token->new(
            token => $self->{request_token}->{token}->{token},
            secret => $self->{request_token}->{token}->{secret},
        );
    }

    return $self;
}

sub oauth_request {
    my ($self, $endpoint, $method) = @_;
    $method ||= 'GET';

    return $self->consumer->gen_oauth_request(
        token => $self->access_token,
        method => $method,
        url => $endpoint,
    );
}

sub reader {
    my ($self) = @_;

    unless (exists($self->{reader})) {
        $self->{reader} = WebService::Readability::ReaderAPI->new(
            consumer        => $self->{consumer},
            request_token   => $self->{request_token},
            access_token    => $self->{access_token},
        );
    }

    return $self->{reader};
}

sub parser {
    my ($self) = @_;

    unless (exists($self->{parser})) {
        $self->{parser} = WebService::Readability::ParserAPI->new(
            consumer        => $self->{consumer},
            request_token   => $self->{request_token},
            access_token    => $self->{access_token},
        );
    }

    return $self->{parser};
}

1;
__END__

=encodinf utf8

=head1 NAME

WebService::Readability - Readability webservice modules base class

=head1 SEE ALSO

Developers — Readability L<https://www.readability.com/developers>

=head1 AUTHOR

@ichigotake

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

