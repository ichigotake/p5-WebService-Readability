package WebService::Readability::Shortener;
use strict;
use warnings;
use WebService::Readability;
use LWP::UserAgent;
use HTTP::Request::Common qw/POST/;
use JSON;


our $VERSION = '0.1';
our $ENDPOINT = 'http://'.$WebService::Readability::ENDPOINT->{base_url}. '/shortener/v1/urls';

sub get {
    my ($self, $url) = @_;
    my $content = $self->shortener($url);
    
    return unless $content->{success};

    return (exists($content->{meta}->{rdd_url})) ? $content->{meta}->{rdd_url} : '';
}

sub shortener {
    my ($self, $url) = @_;
    my $endpoint = $WebService::Readability::Shortener::ENDPOINT;
    
    my %param = (url => $url);
    my $req = POST($endpoint, [url => $url]);

    my $ua = LWP::UserAgent->new;

    my $res = $ua->request($req);

    return ($res->is_success) ? JSON::from_json($res->content) : {};
}

__END__

=head1 NAME

WebService::Readability::Shortener - Shorten long URLs using Readability API

=head1 SYNOPSIS

    my $url = WebService::Readability::Shortener->get('http://search.cpan.org/');

    my $response = WebService::Readability::Shortener->get('http://search.cpan.org/');

=head1 DESCRIPTION

    Shorten long URLs and deliver a great reading view with a single, unique URL using the Shortener API. 
    I<source of a quate: official document>

=head1 METHODS

=item get

Alias to get shortener URL from I<shortener> method.

=item shortener

Get API responce with Shortener API.

see format L<https://www.readability.com/developers/api/shortener#http://www.readability.com/api/shortener/v1#urlSuccessRepresentation>

=head1 ISSUES

http://github.com/ichigotake/p5-WebService-Readability

=head1 SEE ALSO

Shortener API Docs — Readability L<https://www.readability.com/developers/api/shortener>

=head1 AUTHOR

ichigotake C<< <k.wisiiy __@__ gmail.com> >>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

