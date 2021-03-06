# Test logging in and out.
# Before `make install` is performed this script should be runnable with
# `make test`. After `make install` it should work as `perl 10-login.t`.

use strict;
require 5.006001;
use warnings;

use Bric::Mech;
use Test::More;

if (exists $ENV{BRICOLAGE_SERVER} && exists $ENV{BRICOLAGE_USERNAME}
      && exists $ENV{BRICOLAGE_PASSWORD}) {
    plan tests => 8;
} else {
    plan skip_all => "Bricolage env vars not set.\n"
      . "See 'README' for installation instructions.";
}

my $mech = Bric::Mech->new();

# Login
ok(! $mech->logged_in, 'not logged in');
$mech->login();
like($mech->content, qr/sideNav/, 'login succeeds');
ok($mech->logged_in, 'logged_in');
ok(! $mech->in_leftnav, 'not in leftnav');
# (can't check get_server b/c it generally gets munged)
is($mech->get_username, $ENV{BRICOLAGE_USERNAME}, 'get_username');
is($mech->get_password, $ENV{BRICOLAGE_PASSWORD}, 'get_password');

# Logout
$mech->logout();
like($mech->content, qr/bricolage_login/, 'logout succeeds');
ok(! $mech->logged_in, 'not logged in');
