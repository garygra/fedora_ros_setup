#!/bin/bash
set -e

if [ $1 -eq 0 ] ; then
    echo "First argument needed: a name of a normal (not root) user "
    exit 1
fi

if [ $2 -eq 0 ] ; then
    echo "Second argument needed: the ros distro to install "
    exit 1
fi

sudo -u "$1" rosdep update

mkdir -p /opt/ros/kinetc/ros_catkin_ws

cd /opt/ros/kinetic/ros_catkin_ws

rosinstall_generator desktop_full --rosdistro "$2" --deps --wet-only --tar > "${2}-desktop-full-wet.rosinstall"
wstool init -j4 src "${2}-desktop-full-wet.rosinstall"
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
