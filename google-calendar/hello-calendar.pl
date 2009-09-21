use strict;
use warnings;
use utf8;
use Net::Google::Calendar;

my ($email) = @ARGV;

my $cal = Net::Google::Calendar->new(url => "http://www.google.com/calendar/feeds/$email/public/full");

for my $e ($cal->get_events()) {
    print $e->title(), "\n";
}
