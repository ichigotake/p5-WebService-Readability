# NAME

WebService::Readability - Access all the capabilities of Readability

# SYNOPSIS

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

# SEE ALSO

Developers — Readability [https://www.readability.com/developers](https://www.readability.com/developers)

WebService::Readability::Shortener

WebService::Readability::Parser

WebService::Readability::Reader

# AUTHOR

@ichigotake

# LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
