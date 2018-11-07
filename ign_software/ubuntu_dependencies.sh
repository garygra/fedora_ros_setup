#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt install -y mercurial doxygen cppcheck # global
apt install -y ruby-ronn ruby-dev # ign-transport 
apt install -y libprotobuf-dev protobuf-compiler libprotoc-dev # ign-msgs

