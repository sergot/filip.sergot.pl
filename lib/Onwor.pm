package Onwor;

use warnings;
use strict;

use Dancer ':syntax';
use Dancer::Plugin::Auth::Extensible;
use Dancer::Plugin::Database;
use Dancer::Template::TemplateToolkit;

use Onwor::Admin;
use Blog;
use Blog::Admin;

use Digest::MD5;

our $VERSION = '0.1';

set template => 'template_toolkit';

get '/' => sub {
    my @menubarhor = database->quick_select('menubarhor', {}, { order_by => { asc => 'position' } });
    
    template 'index', {
        menubarh => \@menubarhor,
    };
};

get '/login' => sub {
    template 'form';
};

post '/login' => sub {
    my $login = params->{login};
    my $pass = params->{password};
    
    my ($success, $realm) = authenticate_user(
        $login, Digest::MD5::md5_hex($pass)
    );
    
    if($success) {
        session logged_in_user => $login;
        session logged_in_user_realm => $realm;
        return "YES!";
    } else {
        return "NO!";
    }
};

get '/login/denied' => sub {
    return "NIE MASZ DOSTEPU...";
};

get '/logout' => sub {
    session->destroy;
};

true;
