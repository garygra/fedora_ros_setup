#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p /opt/ign
cd /opt/ign

declare -a arr=("ign-cmake" "ign-tools" "ign-math" "ign-transport" "ign-msgs")

for i in "${arr[@]}"
do
	if [ -d "$i" ]; then
		echo "$i exists, pulling updates"
		cd "$i"
		hg pull
		cd ..
	else
		echo "Clonning $i"
		hg clone "https://bitbucket.org/ignitionrobotics/$i"
	fi
	mkdir -p "$i/build"
	cd "$i/build"
	if cmake .. ; then
		if make install ; then
			echo "$i installed"
		else 
			exit 1;
		fi
	else
		exit 2;
	fi
	cd ../../
done
