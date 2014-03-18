use BreakDancer;
use Template::Mojo;

class Link {
    has $.location;
    has $.title;
}

class Site {
    has $.title;
    has $.content;
    has $.lang;
}

class Post {
    has $.file;
    has $.title;
    has $.content;
    has $.date;
    has @.tags;
    has $.lang;
}

my $templates_dir  = 'tmpls';
my $blog_data_dir  = 'data/posts';
my $sites_data_dir = 'data/sites';

my @languages = <
    pl
    en
>;

my $menu = (Link.new(:location<a>, :title<a>), Link.new(:location<b>, :title<b>)).item;

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
}

sub blog {
    say 'generating blog...';
    my @posts;

    for dir $blog_data_dir -> $fn {
        my @lines = $fn.IO.lines;

        @posts.push:
            Post.new(
                file    => $fn.basename.substr(3),
                title   => $fn.basename.substr(3),
                date    => Date.new(@lines.shift),
                tags    => @lines.shift.split(',')>>.trim,
                content => @lines.join("\n"),
                lang    => $fn.basename.split('_').substr(0, 2),
            );
    }
    my $count = @posts.elems;

    for @languages -> $lang {
        gen "/$lang", sub {
            my $content;
            for @posts.sort({ $^b.date <=> $^a.date })[0..9] -> $post {
                $content ~= Template::Mojo.new(slurp 'tmpls/blog/post.mojo').render($post);
                $content ~= "\n";
            }

            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($menu, $content);
        };
    }

    for @posts -> $post {
        gen "/{$post.lang}/blog/{$post.file}", sub {
            my $p = Template::Mojo.new(slurp 'tmpls/blog/post.mojo').render($post);
            return Template::Mojo.new(slurp 'tmpls/layout.mojo').render($menu, $p);
        };
    }
}
