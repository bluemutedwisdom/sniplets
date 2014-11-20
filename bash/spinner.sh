#!/bin/bash

spinner() {
	local pid=${1}
	local delay=0.175
	local spinstr='|/-\'
	local infotext=${2}

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
}

sleep 30 &
spinner ${!} "Doing something that takes a long time."
