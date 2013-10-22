use Dancer ':syntax';
use Dancer::Plugin::Auth::Extensible;

my $menubar = [
    { href => '/admin/menubarhor', text => 'menubar' },
    { href => '/admin/blog/posts/add', text => 'Dodaj Post' },
    { href => '/admin/blog/categories', text => 'categories' },
];

prefix '/admin' => sub {
    get '/' => require_role root => sub {
        template 'admin/index', {
            menubarh => $menubar,
        }
    };
    
    any ['post', 'get'] => '/menubarhor' => require_role root => sub {        
        if(request->method eq 'POST') {
            if(params->{textnew} && params->{hrefnew} && params->{positionnew}) {
                database->quick_insert('menubarhor', { 'text' => params->{textnew}, 'href' => params->{hrefnew}, 'position' => params->{positionnew} });
            }
            
            for(grep { $_ =~ m/text/ig && $_ !~ m/new$/ } keys params) {
                if(m/(\d+)$/) {
                    my $id = $1;
                    if (!params->{$_}) {
                        database->quick_delete('menubarhor', { 'id' => $id });
                    } else {
                        database->quick_update('menubarhor', {'id' => $id }, { 'text' => params->{"text$id"}, 'href' => params->{"href$id"}, 'position' => params->{"position$id"} }); # TODO: optymalizacja
                    }
                }
            }
        }
        
        my @links = database->quick_select('menubarhor', {}, { order_by => 'position' });
        
        template 'admin/menubarh', {
            menubarh => $menubar,
            links => \@links
        };
    };
    
};

sub in {
    my ($item, $tab) = @_;
    for my $i (@$tab) {
    return true if $i == $_;
    }
    return false;
}

true;
