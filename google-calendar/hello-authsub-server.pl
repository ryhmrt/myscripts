use strict;
use warnings;
use utf8;
use Net::Google::AuthSub;
use Net::Google::Calendar;
use Net::HTTPServer;

my $server = Net::HTTPServer->new(
    port => 9999,
    log => 'STDOUT',
);

$server->RegisterURL('/', sub {
    my $req = shift;
    my $res = $req->Response();
    $res->Print(<<EOH);
        <html>
        <body>
        <form action="/req">
        username:
        <input type="text" name="username">
        <input type="submit" value="GO">
        </form>
        </body>
        </html>
EOH
    return $res;
});

$server->RegisterURL('/req', sub {
    my $req = shift;
    my $res = $req->Response();
    my $username = $req->Env->{username};
    my $auth = Net::Google::AuthSub->new;
    my $request_url = $auth->request_token(
        "http://localhost:9999/res?username=$username",
        'http://www.google.com/calendar/feeds/',
        session => 1);

    $res->Print(<<EOH);
        <html>
        <body>
        <a href="$request_url">goto request page.</a>
        </body>
        </html>
EOH
    return $res;
});

$server->RegisterURL('/res', sub {
    my $req = shift;
    my $res = $req->Response();
    my $username = $req->Env->{username};
    my $token = $req->Env->{token};
    
    print "token: $token\n";

    my $auth = Net::Google::AuthSub->new;
    $auth->auth($username, $token);
    my $session_token = $auth->session_token();

    print "session-token: $session_token\n";

    $res->Print(<<EOH);
        <html>
        <body>
EOH

    my $cal = Net::Google::Calendar->new;
    $cal->auth($username, $session_token);
    
    my @calendars = $cal->get_calendars;
    $cal->set_calendar($calendars[0]);
    
    for my $e ($cal->get_events()) {
        $res->Print('<p>');
        $res->Print(join(' - ', $e->when));
        $res->Print(': ');
        $res->Print($e->title());
        $res->Print('</p>');
        $res->Print("\n");
    }
    $res->Print(<<EOH);
        </body>
        </html>
EOH

    eval {
        # failed... why?
        $auth->revoke_token();
    };

    return $res;
});

print "go to http://localhost:9999/\n";

$server->Start();
$server->Process();
$server->Stop();
