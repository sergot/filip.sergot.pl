use Dancer ':syntax';

my $menubar = [
    { href => '/admin/menubarhor', text => 'menubar' },
    { href => '/admin/blog/posts/add', text => 'Dodaj Post' },
    { href => '/admin/blog/categories', text => 'categories' },
];

prefix '/admin/blog' => sub {
    
    get '/posts' => require_role root => sub {
        # TODO

        template 'blog/admin/posts', {
            posts => [],
        };
    };

    get '/posts/del/:id' => require_role root =>  sub {
        database->quick_delete('posts', { id => params->{id} });
    };

    any ['post', 'get'] => '/posts/add' => require_role root => sub {
        # TODO

        template 'blog/admin/posts_add', {
            menubarh => $menubar,
        };
    };

    any ['post', 'get'] => '/posts/:id' => require_role root  => sub {
        # TODO params->{id}

        template 'blog/admin/post_edit', {
            post => [],
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
        
        my @categories = database->quick_select('categories', {});
        #@categories = sort { $a->{name} cmp $b->{name} } @categories; # something weird happens when using order by asc or sort - items duplication
        my $CATS = [];

        for(@categories) {
            sort_categories(\@categories, $CATS, $_->{id}) if !cat_in($_->{id}, $CATS);
            $_->{ind} = [0..count_indentation(\@categories, $_->{parent_id})]; # a better way?
        }
        debug $CATS;

        template 'blog/admin/categories', {
            menubarh => $menubar,
            categories => $CATS,
        };
    };

    get '/categories/del/:id' => require_role root => sub {
        database->quick_delete('categories', { id => params->{id} });
        # TODO: delete subcategories
    };
    
};

sub count_indentation {
    my ($tab, $id) = @_;

    if($id != -1 && (my @p_id = grep { $_->{id} == $id } @$tab)) {
        my $p = $p_id[0]->{parent_id};
        return 1 + count_indentation($tab, $p);
    }

    return 0;
}

sub sort_categories {
    my ($all, $sorted, $id) = @_;
    my @a = grep { $_->{id} == $id } @$all;
    push @$sorted, $a[0];

    if($id != -1 && (my @child = grep { $_->{parent_id} eq $id; } @$all)) {
        sort_categories($all, $sorted, $child[0]->{id});
    }
}

sub cat_in {
    my ($item, $in) = @_;

    for(@$in) {
        return true if $_->{id} eq $item;
    }
    return false;
}

true;
