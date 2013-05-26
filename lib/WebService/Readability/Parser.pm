package WebService::Readability::Parser;

use strict;
use warnings;
use utf8;
use parent qw/WebService::Readability::Base/;
use URI::QueryParam;
use HTTP::Request::Common qw/GET POST HEAD PUT DELETE/;

 
sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);

    return $self;
}

sub api_request {
    my ($self, $endpoint, $params, $method) = @_;
    $params->{token} = $self->{token};
    $method ||= 'GET';

    my $res;
    my $_method = uc($method);
    if ($_method eq 'POST') {
        $res = $self->ua->request(POST $endpoint, $params);
    }
    else {
        my $u = URI->new($endpoint);
        $u->query_param( $_ => $params->{$_} ) for (keys %$params);

        if ($_method eq 'GET') {
            $res = $self->ua->request(GET $u->as_string);
        }
        elsif ($_method eq 'PUT') {
            $res = $self->ua->request(PUT $u->as_string);
        }
        elsif ($_method eq 'DELETE') {
            $res = $self->ua->request(DELETE $u->as_string);
        }
    }

    my $content = ($res->is_success) ? JSON::from_json($res->content) : {};

    return {
        response => $res,
        content => $content,
    };
}

sub build_endpoint {
    my ($self, $endpoint) = @_;
    $endpoint ||= '';

    my $protocol = ($endpoint) ? 'https://' : 'http://';

    return $protocol . $self->api_uri('base_url') . $endpoint;
}

sub info {
    my ($self) = @_;
    return $self->api_request($self->build_endpoint('/api/content/v1/'), undef, 'GET');
}

sub parser {
    my ($self, $values, $method) = @_;
    $method ||= 'GET';

    my $param;
    $param->{url} = $values->{url} if exists($values->{url});
    $param->{id} = $values->{id} if exists($values->{id});
    $param->{max_pages} = $values->{max_pages} if exists($values->{max_pages});

    return $self->api_request($self->build_endpoint('/api/content/v1/parser'), $param, $method);
}

1;
__END__

=head1 NAME

WebService::Readability::Parser - Readability Parser API

=head1 SYNOPSIS

    use WebService::Readability::Parser;

    my $parser = WebService::Readability::Parser->new(
        token => 'Token'
    );

    my $res = $parser->parser({ url => });

=head1 AUTHOR

ichigotake

=head1 SEE ALSO

Parser API Docs — Readability L<https://www.readability.com/developers/api/parser>

WebService::Readability

=head1 LISENCE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

