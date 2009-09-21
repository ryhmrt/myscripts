use strict;
use warnings;
use utf8;
use Net::Google::Calendar;

my ($username, $token) = @ARGV;

my $cal = Net::Google::Calendar->new;
$cal->auth($username, $token);

my @calendars = $cal->get_calendars;
$cal->set_calendar($calendars[0]);

for my $e ($cal->get_events()) {
    print join(' - ', $e->when), ': ', $e->title(), "\n";
}
