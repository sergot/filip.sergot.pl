use Dancer ':syntax';
use Blog::Tools;

prefix '/blog' => sub {
    
    get '/' => sub {
        my @menubarhor = database->quick_select('menubarhor', {}, { order_by => { asc => 'position' } });
        my @posts = database->quick_select('posts', {}, { order_by => { asc => 'timestamp' }});
        
        template 'blog/index', {
            menubarh => \@menubarhor,
            posts => \@posts, # TODO: pagination
        };
    };

    get '/:slug/' => sub {
        my @menubarhor = database->quick_select('menubarhor', {}, { order_by => { asc => 'position' } });
        my $post = database->quick_select('posts', { slug => params->{slug} });

        template 'blog/post', {
            menubarh => \@menubarhor,
            post => $post,
        }
    }
    
};

true;
