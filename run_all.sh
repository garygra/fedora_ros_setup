#!/bin/bash
set -e

reg_user="$(whoami)"

if [ "$(whoami)" != "root" ]
then
	options=$(getopt -o dvhf --longoptions ros_distro:,fedora_version:,verbose,HELP -- "$@" )
	[ $? -eq 0 ] || { 
    	echo "Incorrect options provided"
	    exit 1
	}

	VERBOSE=false
	HELP=false
	ROS_DISTRO="kinetic"
	FED_DISTRO=

	eval set -- "$options"
	printf "Options: "
	while true; do
	    case "$1" in
		-d | --ros_distro ) printf "ROS distro: $2 \n" ;  ROS_DISTRO="$2" ; shift 2 ;;
		-f | --fedora_version ) printf "Fedora distro: $2 \n" ;  FED_DISTRO="$2" ; shift 2 ;;
	    -v | --verbose ) printf "Verbose set \n" ;  VERBOSE=true; shift ;;
	    -h | --HELP ) printf "Printing help: \n" ; HELP=true; shift ;;
	    --) shift; break ;;
	    * ) break ;;
	    esac
	done

	if [ "$HELP" = true ] ; then
		cat << EOF
usage: [-dvhf] [--verbose] [--help]
       [--fedora_version VERSION] [--ros_distro VERSION]

Script for installing all the setup used for robotics in a fedora system at ITAM
Intended for using it in a fresh installation of fedora.

-h, --HELP			Print this message and exit.
-f, --fedora_distro		Set fedora distro number, NEEDED.
-d, --ros_distro 		Set ros distro to install, default: ${ROS_DISTRO}
-v, --verbose 			Set verbose output
EOF
		exit
	fi

	if [ -z "$FED_DISTRO" ] ; then
    	echo "Fedora distro number needed, use option --fedora_version=DISTRO"
    	exit 1
	fi

    sudo "$0" "$reg_user $FED_DISTRO $ROS_DISTRO"
    exit
fi

echo "Running as: $reg_user."
echo "Regular user: $1"

echo "Running setup"

declare -a setup=("install_basics.sh $2" "change_bash.sh")

for i in "${setup[@]}"
do
	if "./setup_scripts/$i" ; then
		echo "$i done."
	else
		exit 1;
	fi
done

echo "Installing ROS"

./ros_scripts/ros_install.sh "$1 $3"

echo "Installing ign software"

./ign_software/fedora_dependecies.sh 
./ign_software/install_software.sh

echo "DONE."