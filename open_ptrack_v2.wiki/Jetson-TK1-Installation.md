# OpenPTrack Jetson TK1 Installation Guide

OpenPTrack is currently being ported and tested to work on the [Jetson TK1](http://www.nvidia.com/object/jetson-tk1-embedded-dev-kit.html). As the TK1 has an ARM processor, the installation process and libraries deviate from the Master branch installation process.

**This installation guide is still under development, and this process may change in the future.**

**N.B.:** Intrinsic calibration cannot be completed on the TK1. This process needs to be completed on a different machine, and then the intrinsic calibration files need to be moved to the TK1.

**N.B.2:** The TK1 and the TX1 cannot be used to run the master processes.  

**N.B.3:** Only the Kinect v2 can be used with the TK1; the Kinect v1 **WILL NOT WORK**.

## Flashing the TK1

**N.B.:** This process needs to be completed on a secondary **Ubuntu** machine.

Before starting the OpenPTrack TK1 installation process, your device needs to be flashed per the following specifications:

**1.** Download the nVidia [Jetpack](https://github.com/OpenPTrack/open_ptrack/blob/jetson-dev/jetpack/JetPackTK1-1.1-cuda6.5-linux-x64.run).

**2.** In the Terminal, navigate to the folder where the JetPackTK1 1.1 package was downloaded, and then run:

    chmod +x JetPack*
    ./JetPack...run

**3.** When the installation process starts, select custom:
![](https://cloud.githubusercontent.com/assets/4822247/12691437/b7c392bc-c6a0-11e5-9829-cc64d1b6a310.png)

**4.** During the custom installation process, uncheck all of the packages to be installed, except:

    Jetson TK1 Development Pack
    Linux for Tegra R2 1.3
    Post Setup
    Flash Device

Your custom installation screen should now look like this:
![](https://cloud.githubusercontent.com/assets/4822247/12691440/bba67ad4-c6a0-11e5-932c-706b78e82e86.png)

**5.** Now follow the installation screen until you are prompted to put your device in Recovery Mode:
![](https://cloud.githubusercontent.com/assets/4822247/12691442/be3069cc-c6a0-11e5-946f-32b501d4bf52.png)

To put your TK1 in recover mode, follow these steps:

⦁ Power off the TK1 (if it is powered on);

⦁ Connect the TK1 with a Micro USB cable to the computer to which you downloaded the JetPack;

⦁ Power on the TK1 (connect the AC adapter, then press the POWER button if the fan does not start automatically);

⦁ Press and hold the FORCE RECOVERY BUTTON. While pressing it, press and release the RESET button; after two seconds, release the FORCE RECOVERY BUTTON.

**N.B.:** To verify your TK1 is indeed in recovery mode, in the Terminal window, run:

    lsusb

If there is an entry for an nVidia device, your TK1 is in Recovery Mode.

**6.** Follow the installation prompts as needed. 

##Installing OpenPTrack on Flashed TK1

**1.** After flashing your TK1, SSH into it by:
    
    ssh -X ubuntu@tegra-ubuntu.local

The default username and password will be:

    ubuntu

**2.** Enable full USB 3.0 Performance:

Edit `/boot/extlinux/extlinux.conf` by changing the following entry:

    usb_port_owner_info=0

to the following:

    usb_port_owner_info=2

Additionally, add the following line to the end of the document:

    usbcore.autosuspend=-1

**3.** Now the udev rules for the Kinect v2 needs to be added. To do this, create `/etc/udev/rules.d/90-kinect2.rules` with the following text:

    # ATTR{product}=="Kinect2"
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"

**4.** Now install utilities and permits for Ubuntu Universe and Multiverse:

	sudo apt-add-repository universe
	sudo apt-add-repository multiverse
	sudo apt-get update
	sudo apt-get install -y bash-completion command-not-found locate git gitg vim

**5.** Install and configure ROS base system and Point Cloud Library:

	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
	sudo apt-get update
	sudo apt-get install -y ros-indigo-desktop
	sudo apt-get install -y python-rosinstall
	sudo add-apt-repository -y ppa:v-launchpad-jochen-sprickerhof-de/pcl
	sudo apt-get update
	sudo apt-get install -y libpcl-1.7-all
	sudo apt-get install -y ros-indigo-compressed-depth-image-transport ros-indigo-compressed-image-transport ros-indigo-pcl-ros ros-indigo-camera-info-manager ros-indigo-driver-base ros-indigo-calibration
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	mkdir -p ~/workspace/ros/catkin/src
	cd ~/workspace/ros/catkin
	catkin_make --force-cmake
	echo "export KINECT_DRIVER=openni" >> ~/.bashrc
	echo "export LC_ALL=C" >> ~/.bashrc
	echo "source /home/ubuntu/workspace/ros/catkin/devel/setup.bash" >> ~/.bashrc

**6.** Install and configure NTP per the [ installation guide](https://github.com/OpenPTrack/open_ptrack/wiki/Time%20Synchronization).

**7.** Install CUDA:

	wget http://developer.download.nvidia.com/compute/cuda/6_5/rel/installers/cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb
	sudo dpkg -i cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb
	sudo apt-get update
	sudo apt-get install -y cuda-toolkit-6-5
	sudo usermod -a -G video $USER
	echo "# Add CUDA bin & library paths:" >> ~/.bashrc
	echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc
	echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
	source ~/.bashrc

**8.** Install Libfreenect2 and Max Performance Scripts:

First, reboot your TK1:

    sudo reboot

After reboot, SSH back into the device:

    ssh -X ubuntu@tegra-ubuntu.local

Install the required scripts:

	cd 
	sudo apt-get install -y build-essential libturbojpeg libtool autoconf libudev-dev cmake mesa-common-dev freeglut3-dev libxrandr-dev doxygen libxi-dev libjpeg-turbo8-dev
	git clone https://github.com/openptrack/libfreenect2.git
	cd libfreenect2
	git checkout jetson-dev
	cd depends
	./install_deps.sh
	sudo ln -s /usr/lib/arm-linux-gnueabihf/libturbojpeg.so.0.0.0 /usr/lib/arm-linux-gnueabihf/libturbojpeg.so
	cd ..
	cd jetson_scripts
	chmod +x *
	sudo cp * /usr/bin

**9.** Verify Protonect Installation:

Run:

    sudo MaxPerformance &> /dev/null

Any print out on the terminal is fine as long as it is not an error. Now run:

    sudo Status

If everything has been installed correctly, the Terminal print out should look like:

    CPUs active (it should be 0-3):
    0-3
    CPUs freq (it should be 2032500000):
    2320500
    2320500
    2320500
    2320500
    CPU governor (it should be userspace):
    userspace
    userspace
    userspace
    userspace
    GPU clock (it should be 852000000):
    852000000
    GPU memory clock (it should be 924000000):
    924000000

If the print out from `sudo Status` does not look like this, reboot your TK1 and run the command again. If the print out is still not correct, verify that all of the installation steps have been followed.

**10.** Plug your Kinect v2 into a power source **BEFORE** plugging in the Kinect v2 to the USB 3.0 port. After the Kinect v2 is powered, proceed to connect it to the TK1 USB 3.0 port. Now run:

	cd ../examples/protonect/
	mkdir build && cd build
	cmake ..
	make -j4
	../bin/Protonect

If all libraries and directions were followed properly, you will now see (with some delay, as the visualization is being delivered over SSH) three windows with the depth image, RGB image, and IR image. If you do not receive any images, and your terminal is only printing the following:

     [DepthPacketStreamParser::handleNewData] subpacket incomplete (needed X received Y)]

Then verify that your TK1 was set to max performance mode correctly and that your Kinect v2 is connected to the TK1 properly. If you are receiving USB errors, there is a possibility your Protonect library was linked to the incorrect version of libusb. To fix this, first try rebooting your TK1 and running the commands (above) again; then, connect to the correct library.

Once you are seeing the three images, kill the Protonect process and run:

	sudo make install

**11.** Install IAI_KINECT2:

	cd /home/ubuntu/workspace/ros/catkin/src
	git clone https://github.com/OpenPTrack/iai_kinect2
	cd iai_kinect2
	git checkout jetson-dev
	Catkin

If you see an internal compiler error, run:

	CatkinJ1

You can verify the installation by running:

	sudo MaxPerformance &> /dev/null
	roslaunch kinect2_bridge kinect2_bridge_ir.launch

The Terminal print out should look similar to:

    [CudaDepthPacketProcessor] avg. time: 21.5727ms -> ~46.3548Hz
    [TegraJpegRgbPacketProcessor] avg. time: 17.6418ms -> ~56.6837Hz

Once this command is running, and the information verified, the process can be killed. 

You can check the point cloud frequency by running:

    rostopic hz /kinect2_head/depth_ir/points

(The command `roslaunch kinect2_bridge kinect2_bridge_ir.launch` must be running!)

You should see the Hz around 20-21 FPS.

**12.** Install OpenPTrack:

	cd /home/ubuntu/workspace/ros/catkin/src
	git clone https://github.com/OpenPTrack/open_ptrack
	cd open_ptrack
	git checkout jetson-dev
	cd scripts
	chmod +x *
	./calibration_toolkit_install.sh
	cd /home/ubuntu/workspace/ros/catkin/
	catkin_make --pkg calibration_msgs
	catkin_make --pkg opt_msgs
	CatkinJ1

After OpenPTrack has been installed, follow the same procedures for configuration that are outlined in the Wiki. The next step in the process will be [Pre-Calibration Configuration](https://github.com/OpenPTrack/open_ptrack/wiki/Pre-Calibration-File-Configuration).

**N.B.:** We suggest, if you are installing OpenPTrack on more than one TK1, that you clone your completed Ubuntu OpenPTrack installation, then flash the remaining TK1s with the Operating System clone. To do this, after you verify the completed TK1 OpenPTrack installation, clone your successful Ubuntu OS, and then install the clone on the remaining TK1s that will be used in your OpenPTrack network. The cloning directions can be found [here](https://github.com/OpenPTrack/open_ptrack/blob/jetson-dev/docs/jetson_imaging_guide.txt).

 