requires 'JSON';
requires 'LWP::UserAgent';
requires 'LWP::Protocol::https';
requires 'Class::Accessor::Fast';
requires 'OAuth::Lite::Consumer';
requires 'HTTP::Request::Common';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

