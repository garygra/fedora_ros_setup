#!/bin/bash
set -e


if [ $1 -eq 0 ] ; then
    echo "First argument needed: fedora version "
fi

echo "Installing basics..."

dnf update -y
dnf install -y wget 
rpm -y -ivh https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$1.noarch.rpm
rpm -y -ivh https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$1.noarch.rpm

dnf -y update
dnf groupinstall -y "Development Tools" "Development Libraries" 
dnf install -y gcc cmake qt qt-creator libXaw unrar p7zip p7zip-plugins kernel-headers kernel-devel chrome-gnome-shell vim screen system-config-printer

echo "Done installing basics"
