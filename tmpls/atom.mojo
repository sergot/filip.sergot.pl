% my ($lang, $date, $posts) = @_;
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
    <title>filip.sergot.pl</title>
    <link href="http://filip.sergot.pl" />
    <link rel="self" href="http://filip.sergot.pl/<%= $lang %>/blog/index.atom" />
    <updated><%= $date %></updated>
    <id>http://filip.sergot.pl/</id>

% for $posts.list -> $post {
    <entry>
        <title><%= $post.title %><title>
        <link href="http://filip.sergot.pl/blog/<%= $post.category %>/<%= $post.file %>/"/>
        <id>tag:filip.sergot.pl,<%= $post.date %>:blog/<%= $post.category %>/<%= $post.file %>/</id>
        <author>
            <name><%= $post.author %></name>
        </author>
        <updated><%= $post.date %></updated>
        <content type="html">
            <%= $post.content %>
        </content>
    </entry>
% }
</feed>
