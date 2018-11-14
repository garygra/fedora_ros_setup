#!/bin/bash
set -e

if [ -z  $1 ] ; then
    echo "First argument needed: a name of a normal (not root) user "
    exit 1
fi

if [ -z $2 ] ; then
    echo "Second argument needed: the ros distro to install "
    exit 1
fi

#if [ sudo -u "$1 rosdep update" ] ; then
#	echo "rosdep update done" 
#else
#	echo "rosdep existed" 
#fi

mkdir -p /opt/ros/kinetic/ros_catkin_ws

cd /opt/ros/kinetic/ros_catkin_ws


if [ ! -f "${2}-desktop-full-wet.rosinstall" ] ; then
	rosinstall_generator-2.7 desktop_full --rosdistro "$2" --deps --wet-only --tar > "${2}-desktop-full-wet.rosinstall"
	wstool init -j4 src "${2}-desktop-full-wet.rosinstall"
fi
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
