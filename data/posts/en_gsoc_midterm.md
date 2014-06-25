2014-06-25
[GSoC] Midterm report
perl6, gsoc
sergot
perl6
gsoc_logo.png
Hi!

I have just submitted my midterm evaluation questionnaire! This part of Google Summer of Code was really great, I learnt a lot. I want to write here about my progress in the project.

What did I do during the first part of Google Summer of Code?
=======================

Here you can find my previous posts about GSoC:

+ [HTTP::Headers ](http://filip.sergot.pl/en/blog/perl6/gsoc_http::headers/)
+ [HTTP::Message, HTTP::Cookies and DateTime::Parse](http://filip.sergot.pl/en/blog/perl6/gsoc_http_cookies_message_datetime_parse/)

What's new?
==============

The **important** thing is that I merged all the HTTP::* repos into one, [HTTP::UserAgent](https://github.com/sergot/http-useragent/), you can still find old repos, I just wanted to keep the commits history.

After this period, a simple HTTP client is available, just:

        use HTTP::UserAgent :simple;

        my $content = get "filip.sergot.pl";
        say $content;

or:

        getprint "filip.sergot.pl";

That's how you can print the sourcecode of a website.

We have also a prototype of more complex UserAgent working.

        use HTTP::UserAgent;

        my $ua = HTTP::UserAgent.new( :useragent('firefox_linux') );
        say $ua.get('http://ua.offensivecoder.com/').content;

Wait! But what is the 'firefox_linux' there? And here the HTTP::UserAgent::Common comes, providing the list of most commonly used User-Agents.
It is built according to this [article](http://techblog.willshouse.com/2012/01/03/most-common-user-agents/):

        chrome_w7_64   => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36
                           (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36',

        firefox_w7_64  => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0)
                           Gecko/20100101 Firefox/29.0',

        ie_w7_64       => 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0;
                           rv:11.0) like Gecko',

        chrome_w81_64  => 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36
                           (KHTML, like Gecko) Chrome/34.0.1847.131 Safari/537.36',

        firefox_w81_64 => 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0)
                           Gecko/20100101 Firefox/29.0',

        mob_safari_osx => 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_1 like Mac OS X)
                           AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D201
                           Safari/9537.53',

        safari_osx     => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2)
                           AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3
                           Safari/537.75.14',

        chrome_osx     => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2)
                           AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.131
                           Safari/537.36',

        firefox_linux  => 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0)
                           Gecko/20100101 Firefox/29.0',

        chrome_linux   => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36
                           (KHTML, like Gecko) Chrome/34.0.1847.132 Safari/537.36',

So we don't have to remember all those crazy names in User-Agent header content, anyway, we are still able to write what we want.


What's next?
=============

Here is the plan for the next part of GSoC:

+ HTTP::UserAgent: implement handling cookies
+ implement TLS support
+ write rich spectests
+ write wide, rich documentation
