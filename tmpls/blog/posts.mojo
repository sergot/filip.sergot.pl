% my ($lang, $posts) = @_;
% for $posts.list -> $post {
                <div id="content">
                    <div id="blueline"></div>
                    <div id="postwin">
                        <div id="post">
% if $post.thumbnail {
                            <div class="postthumbnail">
                                <img src="/img/blog/<%= $post.thumbnail %>" width="200" height="200" alt="<%= $post.title %>">
                            </div>
% }
                            <h2 class="posttitle">
                                <a href="/<%= $lang %>/blog/<%= $post.category %>/<%= $post.file %>"><%= $post.title %></a>
                            </h2>
                            <div id="postinfo"><span class="postauthor"><%= $post.author %></span><span class="postdate"><%= $post.date %></span></div>
                            <div class="postdesc">
                            <%= $post.short %>
                            ...
                            </div>
                            <span class="bluesubmit">
                                <a href="/<%= $lang %>/blog/<%= $post.category %>/<%= $post.file %>" class="bluelink">Read more</a>
                            </span>
                        </div>
                    </div>
                </div>
% }
