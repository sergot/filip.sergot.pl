% my ($site) = @_;
                <div id="content">
                    <div id="blueline"></div>
                    <div id="postwin">
                        <div id="post">
% if $site.thumbnail.defined {
                            <span class="postthumbnail">
                                <img src="img/site/<%= $site.thumbnail %>" width="200" height="200" alt="<%= $site.title %>">
                            </span>
% }
                            <h2 class="posttitle">
                                <%= $site.title %>
                            </h2>
                            <div class="postdesc">
                            <%= $site.content %>
                            </div>
                        </div>
                    </div>
                </div>
