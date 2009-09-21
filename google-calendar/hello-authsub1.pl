use strict;
use warnings;
use utf8;
use Net::Google::AuthSub;

my $auth = Net::Google::AuthSub->new;

print $auth->request_token(
    'http://localhost/',
    'http://www.google.com/calendar/feeds/',
    session => 1), "\n";
