#!/usr/bin/env perl6

use BreakDancer;
use Template::Mojo;
use Text::Markdown;
use DateTime::Format::W3CDTF;

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
    has $.content is rw;
    has $.date is rw;
    has $.author;
    has @.tags;
    has $.lang;
    has $.category;
    has $.thumbnail;
}

my $w3c = DateTime::Format::W3CDTF.new;

my $templates_dir  = 'tmpls';
my $blog_data_dir  = 'data/posts';
my $sites_data_dir = 'data/sites';

my @languages = <
    pl
    en
>;

my @categories = <
    perl6
    others
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

my @posts;

for dir $blog_data_dir -> $fn {
    unless $fn.basename.substr(0, 1) eq '.' {
        my @lines = $fn.IO.lines;

        @posts.push:
            Post.new(
                file      => $fn.basename.substr(3, $fn.basename.chars - 3 - 3),
                title     => $fn.basename.substr(3, $fn.basename.chars - 3 - 3).split('_').join(' '),
                date      => Date.new(@lines.shift),
                tags      => @lines.shift.split(',')>>.trim,
                author    => @lines.shift,
                category  => @lines.shift,
                thumbnail => @lines.shift,
                content   => parse-markdown(@lines.join("<br>\n")).to_html,
                lang      => $fn.basename.split('_').substr(0, 2),
            );
    }
}
@posts .= sort({
    $^b.date <=> $^a.date
});

sub MAIN(Str $what?) {
    if ! $what {
        sites;
        blog;
        rss;
    } elsif $what ~~ 'blog' {
        blog;
    } elsif $what ~~ 'sites' {
        sites;
    } elsif $what eq 'rss' {
        rss;
    } else {
        say "You cannot generate $what.";
    }
}

# subroutines
sub rss {
    say 'generating rss...';

    # html scape
    @posts.map({ .content = html_escape(.content) });
    @posts.map({ .date = $w3c.parse(~.date) });

    $BreakDancer::ext = '.atom';
    for @languages -> $lang {
        gen "/$lang", sub {
            my $posts = @posts.grep({ .lang ~~ $lang })[^10].item;

            return Template::Mojo.new(slurp 'tmpls/atom.mojo').render($lang, $w3c.parse(~Date.today), $posts);
        };

        for @categories -> $cat {
            gen "/$lang/blog/$cat", sub {
                my $posts = @posts.grep({ .lang ~~ $lang && .category ~~ $cat })[^10].item;

                return Template::Mojo.new(slurp 'tmpls/atom.mojo').render($lang, $w3c.parse(~Date.today), $posts);
            }
        }
    }
}

sub sites {
    say 'generating sites...';

    my @sites;

    for dir $sites_data_dir -> $fn {
        unless $fn.basename.substr(0, 1) eq '.' {
            my @lines = $fn.IO.lines;
            @sites.push:
                Site.new(
                    content => parse-markdown(@lines.join("<br>\n")).to_html,
                    title   => $fn.basename.substr(3, $fn.basename.chars - 3 - 3).split('_').join(' '),
                    file    => $fn.basename.substr(3, $fn.basename.chars - 3 - 3),
                    lang    => $fn.basename.substr(0, 2),
                );
        }
    }

    for @sites -> $site {
        gen "/{$site.lang}/site/{$site.file}", sub {
            my $content = Template::Mojo.new(slurp 'tmpls/sites/site.mojo').render($site);
            my @newmenu = @menu.grep({ .lang ~~ $site.lang });
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($site.lang, @newmenu.item, @categories.item, $content, $site.title);
        } 
    }
}

sub blog {
    say 'generating blog...';

    my $count = @posts.elems;

    # generate index pages with recent 10 posts
    for @languages -> $lang {
        gen "/$lang", sub {
            my $content;
            $content = Template::Mojo.new(slurp 'tmpls/blog/posts.mojo').render($lang, @posts.grep({ .lang ~~ $lang })[^10].item);

            my @newmenu = @menu.grep({ .lang ~~ $lang });
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($lang, @newmenu.item, @categories.item, $content, 'home');
        };
        for @categories -> $cat {
            gen "/$lang/blog/$cat", sub {
                my $content;
                $content = Template::Mojo.new(slurp 'tmpls/blog/posts.mojo').render($lang, @posts.grep({ .lang ~~ $lang && .category ~~ $cat })[^10].item);

                my @newmenu = @menu.grep({ .lang ~~ $lang });
                return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($lang, @newmenu.item, @categories.item, $content, $cat);
            }
        }
    }

    for @posts -> $post {
        gen "/{$post.lang}/blog/{$post.category}/{$post.file}", sub {
            my $p = Template::Mojo.new(slurp 'tmpls/blog/post.mojo').render($post);
            my @newmenu = @menu.grep({ .lang ~~ $post.lang });
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($post.lang, @newmenu.item, @categories.item, $p, $post.title);
        };
    }
}

sub html_escape {
    $^text.trans:
        ['<', '>', '&'] => ['&lt;', '&gt;', '&amp;'];
}
