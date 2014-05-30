% my ($lang, $topmenu, $categories, $content, $title) = @_;
<!DOCTYPE html>
<html>
    <head>
        <title><%= $title %> :: filip.sergot.pl</title>
        <meta charset="UTF-8">
        
        <meta name="description" content="Mostly about programming. Perl, Perl6, C and many others. Science too.">
        <meta name="keywords" content="programming,perl,perl6,hacking,c,science">
        <meta name="author" content="Filip Sergot">

        <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
        
        <link rel="stylesheet" type="text/css" href="/css/style.css">

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <!-- There will be some JS, I promise! :) -->
        <script src="/js/main.js"></script>
        
        <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css'/>
        
        <!-- Piwik -->
        <script type="text/javascript">
            var _paq = _paq || [];
            _paq.push(["setDocumentTitle", document.domain + "/" + document.title]);
            _paq.push(["setCookieDomain", "*.sergot.pl"]);
            _paq.push(["setDomains", ["*.sergot.pl"]]);
            _paq.push(["trackPageView"]);
            _paq.push(["enableLinkTracking"]);

            (function() {
              var u=(("https:" == document.location.protocol) ? "https" : "http") + "://piwik.agilob.net/";
              _paq.push(["setTrackerUrl", u+"piwik.php"]);
              _paq.push(["setSiteId", "7"]);
              var d=document, g=d.createElement("script"), s=d.getElementsByTagName("script")[0]; g.type="text/javascript";
              g.defer=true; g.async=true; g.src=u+"piwik.js"; s.parentNode.insertBefore(g,s);
            })();
        </script>
        <!-- End Piwik Code -->
    </head>
    <body>
        <div id="all">
            <div id="header">
                <div id="logo">
                    <img src="/img/logo.jpg" class="logo" alt="Filip Sergot :: filip.sergot.pl :: logo" width="200" style="float: left; vertical-align: middle;">
                    <div class="logotext">sergot's homepage</div>
                    <div class="logodesc">Programming and stuff.</div>
                </div>
                <div id="menubarhor">
                    <ul class="menubarhor">
% for $topmenu.list -> $m {
    <li><a href="<%= $m.location %>"><%= $m.title %></a></li>
% }
                    </ul>
                    <ul class="menubarhor" style="float: right; margin-right: 4px;">
                        <li><a href="/index.atom">rss</a></li>
                    </ul>
                </div>
            </div>
            <div id="centrum">
                <%= $content %>
                <div id="menubar">
                    <div id="menudark">
                        <form action="" method="post">
                            <input type="text" class="searchtext" value="Not available yet..." disabled>
                            <input type="submit" class="bluesubmit" value="Search" disabled>
                        </form>
                    </div>
                    <div id="menu">
                        <h2 class="menu">Menu</h2>
                        <ul class="menu">
% for $topmenu.list -> $m {
                            <li><a href="<%= $m.location %>"><%= $m.title %></a></li>
% }
                        </ul>
                    </div>
                    <div id="menu">
                        <h2 class="menu">categories</h2>
                        <ul class="menu">
% for $categories.list -> $cat {
                            <li><a href="/<%= $lang %>/blog/<%= $cat %>"><%= $cat %></a></li>
% }
                        </ul>
                    </div>
                </div>
            </div>
            <div id="footer">
                <div id="extends">
                    <div id="extcol">
                        <a class="twitter-timeline"  href="https://twitter.com/fsergot"  data-widget-id="454173781959778305">Tweets by @fsergot</a>
                        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
                    </div>
                    <div id="extcol">
                        <h3 id="aboutthissite">About this site</h3>
                        <p>This site is generated using <a href="https://github.com/sergot/BreakDancer" target="_blank">BreakDancer</a>.</p>
                        <p>The sourcecode of this site is on <a href="https://github.com/sergot/filip.sergot.pl" target="_blank">github</a>, feel free to contribute.</p>
                        <p>The <a href="/img/logo.jpg" target="_blank">logo</a> designed by <a href="http://facebook.com/cukiereq.zuzu" target="_blank">cukiereq</a>.</p>
                        <p>Oh, I should have added.. this site is still being <a href="https://github.com/sergot/filip.sergot.pl#roadmap" target="_blank">developed</a>. Any feedback is likely to receive. :)</p>
                    </div>
                    <div id="extcol">
                        <h3>About me</h3>
                        <p>
                            <img src="/img/filipsergot.jpeg" alt="Filip Sergot" width="100" style="float: right">
                            Hi! My name is Filip Sergot. I am a programmer, hacker, science enthusiast, fascinated by computers, always having my head in the clouds.
                        </p>
                        <p>
                            I'm quite social, I think:<br>
                            <a href="https://github.com/sergot" target="_blank">GitHub</a><br>
                            <a href="http://twitter.com/fsergot" target="_blank">Twitter</a><br>
                        </p>
                    </div>
                </div>
                <div id="infofooter"><span class="infofooter">filip.sergot.pl &copy; Filip Sergot</span></div>
            </div>
        </div>
    </body>
</html>
