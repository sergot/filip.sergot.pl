use Dancer ':syntax';

prefix '/blog' => sub {
    
    get '/' => sub {
        my @menubarhor = database->quick_select('menubarhor', {}, { order_by => { asc => 'position' } });
        
        template 'blog/index', {
            menubarh => \@menubarhor,
        };
    };
    
};

true;