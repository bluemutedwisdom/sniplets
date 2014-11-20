#!/usr/bin/env python

import urllib2
import sys

url = 'http://tnx.nl/ip'
req = urllib2.Request(url)
get = urllib2.urlopen(req)

print("You ipaddress is: %s" % get.read())

sys.exit(0)
