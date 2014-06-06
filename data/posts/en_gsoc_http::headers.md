2014-05-20
[Google Summer of Code] HTTP::Headers
perl6, gsoc
sergot
perl6
gsoc_logo.png
Hey people!

I participate in Google Summer of Code this year, my project is to add TLS/SSL support to Perl 6, with all HTTP::* modules and LWP::UserAgent as well!

This will be a very good summer! Well, we'll be able to write a lot of new stuff after ending this project.

This is my first post about **GSoC** and it is about [HTTP::Headers](https://github.com/sergot/http-headers) module.

The main goal of this module is to provide functionality for handling HTTP headers. It's simple - that's my starting point.

While writing I tried to keep it similar to [Perl 5 module](https://metacpan.org/pod/HTTP::Headers). Headers are represented by a hash - every key-value pair is called a field, key is a name of single header (names are cases insensitive).

Example usage:

        use HTTP::Headers;
        my $h = HTTP::Headers.new(Accept => 'text/plain');

        my $a = $h.header('Accept');             # get
        $h.remove-header('Accept');              # delete
        $h.header(Content-Type => 'text/plain'); # set

        say $h.Str("\r\n");                # print headers as a string

We are able to store multiple values in such fields

        my $h = HTTP::Headers.new(Accept => <text/plain text/html>);

We can also push new values to existing field:

        $h.push-header(Accept => <image/jpeg image/png>);

Why do we need this?
=====================

HTTP::Message uses this to store HTTP headers, thus HTTP::{Request, Response} use it too (because they inherit from HTTP::Message).

What do you think about it?

And, as always, feel free to contribute!
