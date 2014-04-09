% my ($post) = @_;
                <div id="content">
                    <div id="blueline"></div>
                    <div id="postwin">
                        <div id="post">
% if $post.thumbnail.defined {
                            <span class="postthumbnail">
                                <img src="img/blog/<%= $post.thumbnail %>" width="200" height="200" alt="Miniatura">
                            </span>
% }
                            <h2 class="posttitle">
                                <%= $post.title %>
                            </h2>
                            <div id="postinfo"><span class="postauthor"><%= $post.author %></span><span class="postdate"><%= $post.date %></span></div>
                            <p class="postdesc">
                            <%= $post.content %>
                            </p>
                        </div>
                    </div>
                </div>
