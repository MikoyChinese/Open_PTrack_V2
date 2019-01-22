#!/bin/bash
# Location: China
# System: Ubuntu16.04 or Docker
UBUNTU_VERSION=`lsb_release -c -s`
ROS_DISTRO=kinetic

ROS_PACKAGES="python-rosinstall ros-$ROS_DISTRO-cmake-modules"

echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $UBUNTU_VERSION main" | sudo tee /etc/apt/sources.list.d/ros-latest.list
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-$ROS_DISTRO-desktop-full -y
sudo rosdep init
rosdep update
sudo apt-get install $ROS_PACKAGES -y --force-yes

# Configure.
. /opt/ros/kinetic/setup.bash
mkdir -p ~/workspace/ros/src
cd ~/workspace/ros/
catkin_make --force-cmake
echo "source ~/workspace/ros/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
