use Dancer ':syntax';
use Blog::Tools;

my $menubar = [
    { href => '/admin/menubarhor', text => 'menubar' },
    { href => '/admin/blog/posts', text => 'post' },
    { href => '/admin/blog/categories', text => 'categories' },
];

prefix '/admin/blog' => sub {
    
    get '/posts' => require_role root => sub {
        my @posts = database->quick_select('posts', {});

        template 'blog/admin/posts', {
            posts => \@posts,
            menubarh => $menubar,
        };
    };

    get '/posts/del/:id' => require_role root =>  sub {
        database->quick_delete('posts', { id => params->{id} });
    };

    any ['post', 'get'] => '/posts/add' => require_role root => sub {
        if(request->method eq 'POST') {
            if(params->{'send'} eq 'SEND') {
                database->quick_insert('posts', {
                    title => params->{title},
                    slug => params->{slug},
                    content => params->{content},
                    category => params->{category},
                    tags => params->{tags},
                    author => session('logged_in_user'),
                    timestamp => time, # TODO: time format
                    thumbnail => params->{thumbnail},
                });
            }
        }

        template 'blog/admin/posts_add', {
            menubarh => $menubar,
        };
    };

    any ['post', 'get'] => '/posts/edit/:id' => require_role root  => sub {
        if(request->method eq 'POST') {
            database->quick_update('posts', { id => params->{id}},
                {
                    title => params->{title},
                    slug => params->{slug},
                    content => params->{content},
                    category => params->{category},
                    tags => params->{tags},
                    thumbnail => params->{thumbnail},
                 }
            );
        }
        my @p = database->quick_select('posts', { id => params->{id} });

        template 'blog/admin/posts_add', {
            menubarh => $menubar,
            p => $p[0],
        };
    };

    
    any ['post', 'get'] => '/categories' => require_role root => sub {
        if(request->method eq 'POST') {
            if(params->{namenew} && params->{slugnew}) {
                database->quick_insert('categories', { 'name' => params->{namenew}, 'slug' => params->{slugnew}, 'parent_id' => params->{parent_idnew} });
            }
            
            for(grep { $_ =~ m/name/ig && $_ !~ m/new$/ } keys params) {
                if(m/(\d+)$/) {
                    my $id = $1;
                    if (!params->{$_}) {
                        database->quick_delete('categories', { 'id' => $id });
                    } else {
                        database->quick_update('categories', {'id' => $id }, { 'name' => params->{"name$id"}, 'slug' => params->{"slug$id"}, 'parent_id' => params->{"parent_id$id"} });
                    }
                }
            }
        }
        
        template 'blog/admin/categories', {
            menubarh => $menubar,
            categories => &categories,
        };
    };

    get '/categories/del/:id' => require_role root => sub {
        database->quick_delete('categories', { id => params->{id} });
        # TODO: delete subcategories
    };
    
};

true;
