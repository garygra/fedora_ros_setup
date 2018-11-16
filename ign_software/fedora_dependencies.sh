#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

dnf install -y mercurial doxygen cppcheck # global
dnf install -y rubygem-ronn ruby-devel zeromq czmq cppzmq-devel uuid-devel uuid-c++-devel libuuid-devel # ign-transport 
dnf install -y protobuf protobuf-devel protobuf-compiler # ign-msgs
