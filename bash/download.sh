#!/bin/bash

download() {
	local url=${1}
	
	tput civis;
	echo -n "    "
	
	wget --progress -O ${dst} ${url} 2>&1 | grep --line-buffered "%" | \
		sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
	
	echo -ne "\b\b\b\b"
	echo "done."
	tput cnorm;
}

echo -n "Downloading Ubuntu: "
download http://releases.ubuntu.com/14.04.1/ubuntu-14.04.1-server-amd64.iso
