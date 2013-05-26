package WebService::Readability::Reader;
use strict;
use warnings;
use utf8;
use parent qw(WebService::Readability::Base);


sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);

    unless ( $self->consumer ) {
        $self->{consumer} = $self->oauth_consumer(
            consumer_key => $self->{consumer_key},
            consumer_secret => $self->{consumer_secret},
        );
    }

    unless ( $self->request_token ) {
        $self->{request_token} = $self->{consumer}->obtain_access_token(
            url => 'https://' . $self->api_uri('access_token'),
            params => {
                x_auth_username => $self->{username},
                x_auth_password => $self->{password},
                x_auth_mode => 'client_auth',
            }
        );
    }

    unless ( $self->access_token ) {
        $self->{access_token} = $self->oauth_token(
            token => $self->{request_token}->{token}->{token},
            secret => $self->{request_token}->{token}->{secret},
        );
    }

    return $self;
}

sub info {
    my ($self) = @_;
    return $self->api_request($self->build_endpoint('/api/rest/v1/'));
}

sub api_request {
    my ($self, $endpoint, $params, $method) = @_;
    $method ||= 'GET';

    my $req = $self->consumer->gen_oauth_request(
        token => $self->access_token,
        method => $method,
        url => $endpoint,
        params => $params,
    );

    my $res = $self->ua->request($req);
    my $content= ($res->is_success) ? JSON::from_json($res->content) : {};

    return {
        response => $res,
        content  => $content,
    };
}

sub build_endpoint {
    my ($self, $endpoint) = @_;
    $endpoint ||= '';

    my $protocol = ($endpoint) ? 'https://' : 'http://';

    return $protocol . $self->api_uri('base_url') . $endpoint;
}

sub bookmarks {
    my ($self, $values, $method) = @_;
    $method ||= 'GET';

    my $id;
    if (exists($values->{id})) {
        $id = "/$values->{id}";
        delete $values->{id};
    } else {
        $id = "";
    }

    my $endpoint = $self->build_endpoint('/api/rest/v1/bookmarks') . $id;
    return $self->api_request($endpoint, $values, 'GET');
}

sub tags {
    my ($self, $tag_id, $method) = @_;
    $method ||= 'GET';
    my $id = ($tag_id) ? "/$tag_id" : '';

    return $self->api_request($self->build_endpoint('/api/rest/v1/tags'.$id), undef, 'GET');
}

sub contributions {
    my ($self, $values, $method) = @_;
    return $self->api_request($self->build_endpoint('/api/rest/v1/contributions'));
}

1;
__END__

=head1 NAME

WebService::Readability::Reader - Readability Reader API

=head1 SYNOPSIS

    use WebService::Readability::Reader;

    my $reader = WebService::Readability::Reader->new(
        consumer_key => 'Key',
        consumer_secret => 'Secret',
        username => 'login_name',
        password => 'login_password',
    );

    my $bookmarks = $reader->bookmarks();
    my $taged_articles = $reader->tag(tag => 'tag');

=head1 AUTHOR

ichigotake

=head1 SEE ALSO

Reader API Docs — Readability L<https://www.readability.com/developers/api/reader>

WebService::Readability

=head1 LISENCE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

