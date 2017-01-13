#Mass Scanner Created By Militarise

import time
import sys
import subprocess

start = int(input("Enter A Start Range :"))
end = int(input("Enter A End Range :"))
starttime = time.time()

print("Mass Scanner Started.")

for numb in range(int(start), int(end)):
	try:
		subprocess.call("./class 22 -a " + str(numb) + " -s 10 -i eth0", shell=True)
		print("Now Scanning Range " + str(numb))
	except:
		print("The Scanner Returned An Error, This Could Be Caused By Anything Such As A Keyboard Interupt")