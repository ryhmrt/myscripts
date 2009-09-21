use strict;
use warnings;
use utf8;
use Net::Google::Calendar;

my ($username, $password) = @ARGV;

my $cal = Net::Google::Calendar->new;
$cal->login($username, $password);

my @calendars = $cal->get_calendars;
$cal->set_calendar($calendars[0]);

for my $e ($cal->get_events()) {
    print join(' - ', $e->when), ': ', $e->title(), "\n";
}
