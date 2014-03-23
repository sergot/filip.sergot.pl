% my ($posts) = @_;
% for $posts.list -> $post {
                <div id="content">
                    <div id="blueline"></div>
                    <div id="postwin">
                        <div id="post">
% if $post.thumbnail.defined {
                            <span class="postthumbnail">
                                <img src="img/blog/logo.jpg" width="200" height="200" alt="Miniatura">
                            </span>
% }
                            <h2 class="posttitle">
                                <%= $post.title %>
                            </h2>
                            <div id="postinfo"><span class="postauthor"><%= $post.author %></span><span class="postdate"><%= $post.date %></span></div>
                            <p class="postdesc">
                            <%= $post.content.substr(0, 100) %>...
                            </p>
                            <span class="bluesubmit">
                                <a href="/blog/<%= $post.file %>" class="bluelink">Read more</a>
                            </span>
                         </div>
                    </div>
                </div>
% }
