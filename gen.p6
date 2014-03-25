use BreakDancer;
use Template::Mojo;
use Text::Markdown;

class Link {
    has $.location;
    has $.title;
    has $.lang;
}

class Site {
    has $.title;
    has $.content;
    has $.lang;
    has $.file;
    has $.thumbnail;
}

class Post {
    has $.file;
    has $.title;
    has $.content;
    has $.date;
    has $.author;
    has @.tags;
    has $.lang;
    has $.category;
    has $.thumbnail;
}

my $templates_dir  = 'tmpls';
my $blog_data_dir  = 'data/posts';
my $sites_data_dir = 'data/sites';

my @languages = <
    pl
    en
>;

# TODO: menu can be generated better
my @menu = (
    Link.new(
        location => '/pl',
        title    => 'home',
        lang     => 'pl',
    ),
    Link.new(
        location => '/en',
        title    => 'home',
        lang     => 'en',
    ),
    Link.new(
        location => '/pl/site/kontakt',
        title    => 'kontakt',
        lang     => 'pl',
    ),
    Link.new(
        location => '/en/site/contact',
        title    => 'contact',
        lang     => 'en',
    ),
);

sub MAIN(Str $what?) {
    if ! $what {
        sites;
        blog;
    } elsif $what ~~ 'blog' {
        blog;
    } elsif $what ~~ 'sites' {
        sites;
    } else {
        say "You cannot generate $what.";
    }
}

# subroutines

sub sites {
    say 'generating sites...';

    my @sites;

    for dir $sites_data_dir -> $fn {
        my @lines = $fn.IO.lines;
        @sites.push:
            Site.new(
                content => parse-markdown(@lines.join("<br>\n")).to_html,
                title   => $fn.basename.substr(3),
                file    => $fn.basename.substr(3),
                lang    => $fn.basename.substr(0, 2),
            );
    }

    for @sites -> $site {
        gen "/{$site.lang}/site/{$site.file}", sub {
            my $content = Template::Mojo.new(slurp 'tmpls/sites/site.mojo').render($site);
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($site.lang, @menu.grep({ .lang ~~ $site.lang }).item, $content);
        } 
    }
}

sub blog {
    say 'generating blog...';
    my @posts;

    for dir $blog_data_dir -> $fn {
        my @lines = $fn.IO.lines;

        @posts.push:
            Post.new(
                file      => $fn.basename.substr(3),
                title     => $fn.basename.substr(3),
                date      => Date.new(@lines.shift),
                tags      => @lines.shift.split(',')>>.trim,
                author    => @lines.shift,
                category  => @lines.shift,
                thumbnail => @lines.shift,
                content   => parse-markdown(@lines.join("<br>\n")).to_html,
                lang      => $fn.basename.split('_').substr(0, 2),
            );
    }
    my $count = @posts.elems;

    # generate index page with 10 posts
    for @languages -> $lang {
        gen "/$lang", sub {
            my $content;
            $content = Template::Mojo.new(slurp 'tmpls/blog/posts.mojo').render($lang, @posts.grep({ .lang ~~ $lang }).sort(
                { $^b.date <=> $^a.date }
            )[^10].item);

            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($lang, @menu.grep({ .lang ~~ $lang }).item, $content);
        };
    }

    for @posts -> $post {
        gen "/{$post.lang}/blog/{$post.category}/{$post.file}", sub {
            my $p = Template::Mojo.new(slurp 'tmpls/blog/post.mojo').render($post);
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($post.lang, @menu.grep({ .lang ~~ $post.lang }).item, $p);
        };
    }
}
