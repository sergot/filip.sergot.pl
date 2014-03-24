% my ($lang, $topmenu, $content) = @_;
<!DOCTYPE html>
<html>
    <head>
        <title>filip.sergot.pl - coming soon...</title>
        <meta charset="UTF-8">
        
        <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
        
        <link rel="stylesheet" type="text/css" href="/css/style.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
                    <img src="img/logo.jpg" class="logo" alt="Filip Sergot :: filip.sergot.pl :: logo" width="200" style="vertical-align:middle">
                    <span class="logotext">filip.sergot.pl</span>
                </div>
                <div id="menubarhor">
                    <ul class="menubarhor">
% for $topmenu.list -> $m {
    <li><a href="/<%= $lang %>/<%= $m.location %>"><%= $m.title %></a></li>
% }
                    </ul>
                </div>
            </div>
            <div id="centrum">
                <%= $content %>
                <div id="menubar">
                    <div id="menudark">
                        <form action="" method="post">
                            <input type="text" class="searchtext" value="Search..">
                            <input type="submit" class="bluesubmit" value="Search">
                        </form>
                    </div>
                    <div id="menu">
                        <h2 class="menu">Menu</h2>
                        <ul class="menu">
                            <li><a href="#">a</a></li>
                            <li><a href="#">b</a></li>
                            <ul>
                                <li><a href="#">c</a></li>
                            </ul>
                            <li><a href="#">d</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="footer">
                <div id="extends"><div id="extcol">COL1</div><div id="extcol">COL2</div><div id="extcol">COL3</div></div>
                <div id="infofooter"><span class="infofooter">filip.sergot.pl &copy; Filip Sergot</span></div>
            </div>
        </div>
    </body>
</html>
