package WebService::Readability::Base;

use strict;
use warnings;
use utf8;
use JSON;
use OAuth::Lite::Consumer;
use OAuth::Lite::Token;
use LWP::UserAgent;
use parent qw/Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/
    username password consumer_key consumer_secret token
    ua request_token access_token consumer
/);

sub new {
    my ($class, @args) = @_;
    my $self = bless { @args }, $class;

    $self->ua(LWP::UserAgent->new);

    return $self;
}

sub api_uri {
    my ($self, $resource) = @_;

    my %endpoint = (
        base_url  => 'www.readability.com',
        authorize => 'www.readability.com/api/rest/v1/oauth/authorize/',
        request_token => 'www.readability.com/api/rest/v1/oauth/request_token/',
        access_token  => 'www.readability.com/api/rest/v1/oauth/access_token/',
    );

    return $endpoint{$resource};
}

sub _create_instance {
    my ($self, $class) = @_;

    my %args;
    if ($self->username) {
        $args{username} = $self->username;
    }
    if ($self->password) {
        $args{password} = $self->password;
    }
    if ($self->consumer_key) {
        $args{consumer_key} = $self->consumer_key;
    }
    if ($self->consumer_secret) {
        $args{consumer_secret} = $self->consumer_secret;
    }

    return $class->new(%args);
}

sub oauth_consumer {
    my ($self, @args) = @_;
    return OAuth::Lite::Consumer->new(@args);
}

sub oauth_token {
    my ($self, @args) = @_;
    return OAuth::Lite::Token->new(@args);
}

1;
__DATA__

=head1 NAME

WebService::Readability - base class for all WebService::Readability modules

=head1 AUTHOR

ichigotake

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

