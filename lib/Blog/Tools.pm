sub categories {
        my @categories = database->quick_select('categories', {});
        #@categories = sort { $a->{name} cmp $b->{name} } @categories; # something weird happens when using order by asc or sort - items duplication
        my $CATS = [];

        for(@categories) {
            sort_categories(\@categories, $CATS, $_->{id}) if !cat_in($_->{id}, $CATS);
            $_->{ind} = [0..count_indentation(\@categories, $_->{parent_id})]; # a better way?
        }

        return $CATS;
}

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
