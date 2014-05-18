#!/usr/bin/env perl6

# hey, do I have any plans?
my $today = Date.today;

my $blog_data_dir  = 'data/posts';

for dir $blog_data_dir -> $fn {
    unless $fn.basename.substr(0, 1) eq '.' {
        my $date = Date.new($fn.IO.lines.shift);
        say "$fn is planned for $date"
            if $date > $today;
    }
}
