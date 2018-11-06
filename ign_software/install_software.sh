#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p /opt/ign
cd /opt/ign

hg clone https://bitbucket.org/ignitionrobotics/ign-cmake 
hg clone https://bitbucket.org/ignitionrobotics/ign-math 
hg clone https://bitbucket.org/ignitionrobotics/ign-msgs 
hg clone https://bitbucket.org/ignitionrobotics/ign-tools 
hg clone https://bitbucket.org/ignitionrobotics/ign-transport

mkdir -p ign-cmake/build  
mkdir -p ign-math/build  
mkdir -p ign-msgs/build  
mkdir -p ign-tools/build  
mkdir -p ign-transport/build

cd ign-cmake/build
cmake ..
make install

cd ../../ign-tools/build
cmake ..
make install

cd ../../ign-msgs/build
cmake ..
make install

cd ../../ign-math/build
cmake ..
make install

cd ../../ign-transport/build
cmake ..
make install
