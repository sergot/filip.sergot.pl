% my ($post) = @_;
                <div id="content">
                    <div id="blueline"></div>
                    <div id="postwin">
                        <div id="post">
% if $post.thumbnail {
                            <span class="postthumbnail">
                                <img src="/img/blog/<%= $post.thumbnail %>" width="200" height="200" alt="<%= $post.title %>">
                            </span>
% }
                            <h2 class="posttitle">
                                <%= $post.title %>
                            </h2>
                            <div id="postinfo"><span class="postauthor"><%= $post.author %></span><span class="postdate"><%= $post.date %></span></div>
                            <p class="postdesc">
                            <%= $post.content %>
                            </p>
                            <br>
                            <hr>
                            <div id="disqus_thread"></div>
                                <script type="text/javascript">
                                    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                                    var disqus_shortname = 'sergotshomepage'; // required: replace example with your forum shortname

                                    /* * * DON'T EDIT BELOW THIS LINE * * */
                                    (function() {
                                        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                                        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                                        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                                    })();
                                </script>
                                <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                                <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
                
                        </div>
                    </div>
                </div>
