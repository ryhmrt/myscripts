use strict;
use warnings;
use utf8;
use Net::Google::AuthSub;

my ($username, $token) = @ARGV;


my $auth = Net::Google::AuthSub->new;
$auth->auth($username, $token);

print $auth->session_token, "\n";
