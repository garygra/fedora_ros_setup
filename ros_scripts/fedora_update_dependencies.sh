#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

dnf install -y python-rosdep pyparsing python-rosinstall_generator python-wstool python-rosinstall @buildsys-build
dnf install -y collada-dom-devel python-matplotlib PyQwt-devel gtk2-devel tinyxml-devel PyQt4 yaml-cpp-devel\
	python-nose pcl-devel opencv-devel ogre-devel libuuid-devel console-bridge-devel sbcl tango-icon-theme\
	fltk-fluid cppunit-devel python-empy python-netifaces pcl-tools mesa-libGL-devel urdfdom-devel apr-devel\
	vtk-java pcl wxPython-devel qhull-devel numpy cmake urdfdom-headers-devel python-mock PyOpenGL log4cxx-devel\
	PyQt4-devel libtool-ltdl-devel libtheora-devel assimp libtool hddtemp gtest-devel libjpeg-turbo-devel graphviz\
	fltk-devel poco-devel gazebo-devel eigen3-devel python-psutil pydot mesa-libGLU-devel python-pygraphviz lz4-devel\
	python-pillow-qt opencv-python sip-devel qt-devel assimp-devel tinyxml2 tinyxml2-devel python-qt5 python-qt5-devel\
	bullet bullet-extras bullet-devel python2-defusedxml