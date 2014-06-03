2014-06-03
[GSoC] HTTP::Message, HTTP::Cookies and DateTime::Parse
perl6, gsoc
sergot
perl6
gsoc_logo.png
Hi there!

First two weeks of Google Summer of Code have just ended, it's time for a summary!

I posted about [HTTP::Headers](http://filip.sergot.pl/en/blog/perl6/gsoc_http::headers/) already so this post will be about HTTP::Message, HTTP::Cookies and something I didn't plan to have as a standalone module: DateTime::Parse ([FROGGS](http://usev5.wordpress.com/)++).

[HTTP::Message](https://github.com/sergot/http-message)
===============

This module wraps every HTTP message receiving from servers. 

        use HTTP::Message;

        my $msg =
            "HTTP/1.1 200 OK\r\n"
          ~ "Server: Apache/2.2.3 (CentOS)\r\n"
          ~ "Last-Modified: Sat, 31 May 2014 16:39:02 GMT\r\n"
          ~ "ETag: \"16d3e2-20416-4fab4ccb03580\"\r\n"
          ~ "Vary: Accept-Encoding\r\n"
          ~ "Content-Type: text/plain; charset=UTF-8\r\n"
          ~ "Date: Mon, 02 Jun 2014 17:07:52 GMT\r\n"
          ~ "X-Varnish: 1992382947 1992382859\r\n"
          ~ "Age: 40\r\n"
          ~ "Via: 1.1 varnish\r\n"
          ~ "Connection: close\r\n"
          ~ "X-Cache: HIT\r\n"
          ~ "X-Cache-Hits: 2\r\n"
          ~ "\r\n"
          ~ "008000\r\n"
          ~ "# Last updated Sat May 31 16:39:01 2014 (UTC)\n"
          ~ "# \n"
          ~ "# Explanation of the syntax:\n";

        my $m = HTTP::Message.new.parse($msg);
        say ~$m;

Yes, we have just parsed a HTTP message, now - we can edit it

        $m.add_content("Some new content!!");
        say "content:" ~ $m.content;

        $m.header( Vary => 'Age' );
        say $m.header('Vary');

... and remove one header:

        $m.remove_header('Via');

... or delete the whole message:

        $m.clear;

We can write HTTP::Request and HTTP::Response now, using this HTTP::Message module.

The plan is to make it able to handle encoding stuff (like chunked encoding).


[HTTP::Cookies](https://github.com/sergot/http-cookies)
===============

Another accomplishment is the HTTP::Cookies module, what makes us able to store HTTP cookies.

Here is an example:

        use HTTP::Cookies;

        my $file = './cookies.dat';

        my $c = HTTP::Cookies.new(
            file     => $file,
            autosave => 1,
        );

        $c.set_cookie(
            'Set-Cookie: name1=value1; Expires=DATE; Path=/; Domain=somedomain; secure'
        );

        say ~$c;

The 'autosave' option means that every change will be saved immediately.

We can find our cookies in $file too:

        $ cat cookies.dat 
         #LWP6-Cookies-0.1
         Set-Cookie: name1=value1; Expires=DATE; Path=/; Domain=somedomain; secure

... later, we can load this file:

        $c.load;

HTTP::Request and HTTP::Response will be using this module for cookies handling, so we'll be able e.g. to log into a website etc.

[DateTime::Parse](https://github.com/sergot/datetime-parse)
===============

Another thing, which actually appeard unexpectedly, is DateTime::Parse module. We can use it, to parse e.g. HTTP dates (like *Last-Modified: Sat, 31 May 2014 16:39:02 GMT*). It supports *RFC1123* and *RFC850* time formats for now.

It is built using very powerful Perl 6 feature: [Grammar](https://github.com/sergot/datetime-parse/blob/master/lib/DateTime/Parse/Grammar.pm6) and [Actions](https://github.com/sergot/datetime-parse/blob/master/lib/DateTime/Parse/Actions.pm6).

We are able to compare dates like this:

        say Date.today < DateTime::Parse.new("Sat, 31 May 2014 16:39:02 GMT").Date;

As you can see, we're losing the time in this comparision, it'll be improved I hope.

Plans
===============

[FROGGS](http://usev5.wordpress.com/), [mortiz](http://perlgeek.de/) and I decided to change the name of LWP modules to HTTP, so from now it's not a LWP::UserAgent but HTTP::UserAgent. The reason was that we want to keep all the modules used to http stuff, with the same name: **HTTP**. :) 

It is the third week of Google Summer of Code and here is the plan:

    - complete HTTP::Request and HTTP::Response modules
        - with cookies working
        - with encoding/decoding working
    - write HTTP::Simple
    - write lwp tools: lwp-request, lwp-dump and lwp-download (should we name them http-* as well?)

I really enjoyed the first two weeks of coding under care of awesome mentors.

Do you wonder about participating in next year? You should!


