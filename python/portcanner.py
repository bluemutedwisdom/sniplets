#!/usr/bin/env python

import socket
import subprocess
import sys
from datetime import datetime

# Clear the terminal
subprocess.call('clear', shell=True)

# Ask for input
remoteServer = raw_input("Enter a remote host to scan: ")
remoteServerIp = socket.gethostbyname(remoteServer)

# Print a nice banner.
print "-" * 60
print "Please wait, scanning remote host: ", remoteServerIp
print "-" * 60

# Getting start time
t1 = datetime.now()

try:
	for port in range(1, 1025):
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		result = sock.connect_ex((remoteServerIp, port))
		if result == 0:
			print "Port {}: \t Open".format(port)
		sock.close()

except KeyboardInterrupt:
	print "You pressed ctrl + c"
	sys.exit(127)

except socket.gaierror:
	print "Could not resolve hostname. Stopping."
	sys.exit(1)

except socket.error:
	print "Could not connect to server."
	sys.exit(1)

t2 = datetime.now()
total = t2 - t1

print "Scanning completed in: ", total
sys.exit(0)
