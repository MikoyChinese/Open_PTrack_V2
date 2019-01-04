To start the OpenPTrack v2 installation process, a few Personal Package Archives (PPA) and dependencies are required. This page walks you through the process.

## PPA

Begin by installing the following PPAs:

     sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
     sudo apt-add-repository -y ppa:obsproject/obs-studio
     sudo apt-add-repository -y ppa:graphics-drivers/ppa
     sudo add-apt-repository -y ppa:yannubuntu/boot-repair
     sudo add-apt-repository -y ppa:levi-armstrong/ppa
     wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
     sudo apt-get install -y apt-transport-https
     echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
     sudo apt-get update

Now, install the required software and libraries:

     sudo apt-get install -y sublime-text grub-customizer exfat-fuse exfat-utils vim terminator gitg cmake-curses-gui gparted meld cowsay fortune gimp synaptic libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev ncdu filezilla nvidia-384 p7zip-full openssh-client openssh-server boot-repair

Next, the ROS distribution list needs to be referenced:

     sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

...as does the required key:

     sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

Now, update Ubuntu to reflect these changes:

     sudo apt-get update

...and install [rosdep](http://wiki.ros.org/rosdep) &  ROS Python:

     sudo apt-get install ros-kinetic-desktop-full python-rosinstall -y
     sudo rosdep init

Update rosdep:

     rosdep update

Then, BASHRC needs to call ROS Kinetic:

     echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

     source ~/.bashrc

Next catkin_make:

     cd
     mkdir -p workspace/ros/src && cd workspace/ros
     catkin_make
     echo "source /home/$USER/workspace/ros/devel/setup.bash" >> /home/$USER/.bashrc

Continue the installation [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/CUDA-and-Other-Softwares-Installation)