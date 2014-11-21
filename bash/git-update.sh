#!/bin/bash

spinner() {
        local pid=${1}
        local delay=0.175
        local spinstr='|/-\'
        local infotext=${2}
        tput civis;

        while [ "$(ps a | awk '{print $1}' | grep ${pid})" ]; do
                local temp=${spinstr#?}
                printf " [%c] %s" "${spinstr}" "${infotext}"
                local spinstr=${temp}${spinstr%"${temp}"}
                sleep ${delay}
                printf "\b\b\b\b\b\b"

                for i in $(seq 1 ${#infotext}); do
                        printf "\b"
                done
        done

        printf " \b\b\b\b"
        tput cnorm;
}

## Banner 
##################################################
clear
echo " +------------------------------------+"
echo " | This script will update your local |"
echo " | git repo with the remote origin    |"
echo " +------------------------------------+"
echo

read -ep " please enter your local git repo: " -i "/opt/git" repodir
cd ${repodir}

for repo in *; do
	cd ${repo}
	git fetch > /dev/null 2>&1 & \
		spinner ${!} " checking remote origin repo: ${repo} ..."
	echo 
	echo -n ' '
	git pull
	cd ..
done

exit 0
