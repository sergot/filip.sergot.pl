2014-07-14
[GSoC] OpenSSL and IO::Socket::SSL status
perl6, gsoc
sergot
perl6
gsoc_logo.png
Hi!

I can proudly annouce that Perl 6 has [OpenSSL bindings](https://github.com/sergot/openssl) available now! \o/

We have low level bindings and a high level wrapper, you can simply write:


    use OpenSSL;

    my $ssl = OpenSSL.new;
    # set up the connection here
    # ...
    $ssl.set-fd($fd);

    $ssl.connect;

    $ssl.write("GET /\r\n\r\n");
    say $ssl.read(100);

    $ssl.shutdown;


But if you don't want to use high level wrapper, you can use OpenSSL particular modules, like:

- OpenSSL::SSL - contains declaration of SSL struct and functions to hadnle it
- OpenSSL::Ctx - contains declaration of SSL_CTX struct and functions to handle it
- OpenSSL::Cipher and so on... (see [this](https://github.com/sergot/openssl/tree/master/lib/OpenSSL))

The thing which is not clear above is the "set up the connection" section.
I've wrote [IO::Socket::SSL](https://github.com/sergot/io-socket-ssl) which provides
high level API, the same as IO::Socket::INET, for SSL connections. It does 
"set up the connection" for us, using written in C client_connect function
which returns connection's file descriptor, it's needed by `$ssl.set-fd($fd)`,
it is because OpenSSL wants to own the connection.


    int client_connect(char *hostname, int port) {
        // ...
        return handle; // fd
    }

We can do the same but in another way, we just have to pass a file descriptor to `.set-fd($)`.

Using IO::Socket::SSL, we can write:


    use IO::Socket::SSL;

    my $sock = IO::Socket::SSL.new(:host<filip.sergot.pl>, :port(443));
    $sock.send("GET / HTTP/1.1\r\nHost: filip.sergot.pl\r\n\r\n");
    say 'Response: ', $sock.recv;


Simple as that. :)

Anyway... The most exciting thingis, that [HTTP::UserAgent](https://github.com/sergot/http-useragent)
can handle SSL now! Some bugs are known but it works in some cases.

As I [wrote earlier](http://filip.sergot.pl/en/blog/perl6/gsoc_midterm/), we are able to connect to sites which use SSL like this:


    say $ua.get('https://filip.sergot.pl').content;

... above example returns 403 error just because my site doesn't use SSL but has this port (443) open.


### What's next?

I want to get rid of bugs, implement server stuff of OpenSSL,
implement more features and do some cleaning after all.

There is only one month left! :)

