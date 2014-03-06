use BreakDancer;
use Template::Mojo;

class Site {
    has $.title;
    has $.content;
}

class Post {
    has $.title;
    has $.content;
    has $.date;
    has @.tags;
}

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
}

sub get_items(Str $location) {
    my @items = dir "data/$location";
}
