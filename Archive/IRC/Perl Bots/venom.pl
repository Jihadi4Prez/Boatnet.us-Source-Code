#!/usr/local/bin/perl -w
# venom.pl
# A simple IRC robot.
# Usage: perl venom.pl

use strict;

# We will use a raw socket to connect to the IRC server.
use IO::Socket;

# The server to connect to and our details.
my $server = "SERVER IP";
my $nick = "simple_bot";
my $login = "simple_bot";

# The channel which the bot will join.
my $channel = "#B1NARY";

# Connect to the IRC server.
my $sock = new IO::Socket::INET(PeerAddr => $server,
                                PeerPort => 6667,
                                Proto => 'tcp') or
                                    die "Can't connect\n";

# Log on to the server.
print $sock "NICK $nick\r\n";
print $sock "USER $login 8 * :Perl IRC Venom Bot\r\n";

# Read lines from the server until it tells us we have connected.
while (my $input = <$sock>) {
    # Check the numerical responses from the server.
    if ($input =~ /004/) {
        # We are now logged in.
        last;
    }
    elsif ($input =~ /433/) {
        die "Nickname is already in use.";
    }
}

# Join the channel.
print $sock "JOIN $channel\r\n";

# Keep reading lines from the server.
while (my $input = <$sock>) {
    chop $input;
    if ($input =~ /^PING(.*)$/i) {
        # We must respond to PINGs to avoid being disconnected.
        print $sock "PONG $1\r\n";
    }
    else {
        # Print the raw line received by the bot.
        print "$input\n";
    }
}