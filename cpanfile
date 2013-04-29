requires 'JSON';
requires 'LWP::UserAgent';
requires 'Class::Accessor::Fast';
requires 'OAuth::Lite::Consumer';
requires 'HTTP::Request::Common';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

