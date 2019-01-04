# nVidia Jetson TX1 Installation Guide

**Note:** The NVIDIA Jetpack Version 2.2 is currently unsupported. [Jetpack version 2.1](https://developer.nvidia.com/embedded/jetpack-2_1) needs to be used when configuring your TX1 for OpenPTrack.

OpenPTrack is currently being ported and tested to work on the [Jetson TX1](http://www.nvidia.com/object/jetson-tx1-module.html). As the TX1 has an ARM processor, the installation process and libraries deviate from the Master branch installation process.

**N.B.:** Currently, the onboard USB 3.0 port on the TX1 cannot support the required bandwidth for the Kinect v2. A workaround for this is to use an external PCIe USB 3.0 card with a Renesas uPD720202 chipset, such as this: [Rosewill](http://www.newegg.com/Product/Product.aspx?Item=N82E16815166038&nm_mc=KNC-GoogleAdwords-PC&cm_mmc=KNC-GoogleAdwords-PC-_-pla-_-Add-On+Cards-_-N82E16815166038&gclid=CjwKEAiA9c-2BRC_vaaJ0Ybps30SJABlqxDeiK3I1DWoFdOX1ScVoedT6LmASITELVDelDJRDR31WRoCvU_w_wcB&gclsrc=aw.ds).

**N.B.2:** Intrinsic calibration cannot be completed on the TX1. This process needs to be completed on a different machine, and then the intrinsic calibration files need to be moved to the TX1.

**N.B.3:** The TX1 and the TK1 cannot be used to run the master processes.

**N.B.4:** Only the Kinect v2 can be used with the TK1; the Kinect v1 **WILL NOT WORK**.

## Flashing the TX1

**1.** Download the nVidia [Jetpack](https://developer.nvidia.com/embedded/dlc/jetpack-l4t-2_0). A login will be required to download this file. Creating an account is free.

**2.** Now, in terminal windows, navigate to where the Jetpack file was downloaded, and run:

      chmod +x JetPack*

Then:

      ./JetPack...run

**3.** This [guide](http://developer.download.nvidia.com/embedded/L4T/r23_Release_v1.0/NVIDIA_Jetson_TX1_Developer_Kit_User_Guide.pdf) can be used to flash the TX1. When configuring the Jetpack installation for the TX1, it should look like this:

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/tx1_jetpack_install.jpg?raw=true)

## Configuring TX1 for OpenPTrack

**1.** After the Jetpack installation is complete, SSH into the TX1 from another machine:

     ssh -XC ubuntu@tegra-ubuntu

The default password is `ubuntu`, if requested.

**2.** Enabling full 3.0 performance is needed. To do this, on the TX1:

     gedit /boot/extlinux/extlinux.conf

Then, the line `usb_port_owner_info=0` needs to be changed to:

     usb_port_owner_info=2

And the following line needs to be added as the last command in the `extlinux.conf` file:

    usbcore.autosuspend=-1

**3.** The udev rule for the Kinect v2 needs to be added. To do this, create `/etc/udev/rules.d/90-kinect2.rules` by:

     sudo gedit /etc/udev/rules.d/90-kinect2.rules

The following text needs to be added to the `90-kinect2.rules`:

     # ATTR{product}=="Kinect2"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"

**4.** Now, create the MaxPerformance scripts, and give them execution permissions:

**4.1.** Create `/usr/bin/CPUSetterTX1` with the following text:

     sudo gedit /usr/bin/CPUSetterTX1

With the text:

     #!/bin/bash
     # online all CPUs - ignore errors for already-online units
     echo "onlining CPUs: ignore errors..."
     for i in 0 1 2 3 ; do
	     echo 1 > /sys/devices/system/cpu/cpu${i}/online
     done
     echo "Online CPUs: `cat /sys/devices/system/cpu/online`"
     # set CPUs to max freq (perf governor not enabled on L4T yet)
     echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
     cpumax=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies | awk '{print $NF}'`
     echo "${cpumax}" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
     for i in 0 1 2 3 ; do
	     echo "CPU${i}: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`"
     done

Now, save `CPUSetterTX1` and give it execution permissions:

     sudo chmod +x /usr/bin/CPUSetterTX1

**4.2.** Create `/usr/bin/GPUSetterTX1` with the following text:

     sudo gedit /usr/bin/GPUSetterTX1

With the text:

     #!/bin/bash
     # max GPU clock (should read from debugfs)
     cat /sys/kernel/debug/clock/gbus/max > /sys/kernel/debug/clock/override.gbus/rate
     echo 1 > /sys/kernel/debug/clock/override.gbus/state
     echo "GPU: `cat /sys/kernel/debug/clock/gbus/rate`"
     # max EMC clock (should read from debugfs)
     cat /sys/kernel/debug/clock/emc/max > /sys/kernel/debug/clock/override.emc/rate
     echo 1 > /sys/kernel/debug/clock/override.emc/state
     echo "EMC: `cat /sys/kernel/debug/clock/emc/rate`"

Now, save `GPUSetterTX1`, and then give it execution permissions:

     sudo chmod +x /usr/bin/GPUSetterTX1

**4.3.** Create `/usr/bin/MaxPerformanceTX1` with the following text:

     sudo gedit /usr/bin/MaxPerformanceTX1

With the text:

     #!/bin/bash
     NoAutosuspending
     # turn on fan for safety
     echo "Enabling fan for safety..."
     if [ ! -w /sys/kernel/debug/tegra_fan/target_pwm ] ; then
	     echo "Cannot set fan -- exiting..."
     fi
     echo 255 > /sys/kernel/debug/tegra_fan/target_pwm
     CPUSetterTX1
     GPUSetterTX1

Now, save `MaxPerformanceTX1`, and then give it execution permissions:

     sudo chmod +x /usr/bin/MaxPerformanceTX1

**5.** If installed, uninstall the `opencv4tegra` packet:

     sudo apt-get remove --purge libopencv4tegra*

**6.** Install utilities and permits for Ubuntu Universe and Multiverse:

	sudo apt-add-repository universe
	sudo apt-add-repository multiverse
	sudo apt-get update
	sudo apt-get install -y bash-completion command-not-found locate git gitg vim

**7.** Install `libopencv-dev` packet:

     sudo apt-get install libopencv-dev

**8.** Install and configure ROS base system and Point Cloud Library:

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

**9.** Install and configure NTP per the [installation guide](https://github.com/OpenPTrack/open_ptrack/wiki/Time%20Synchronization).

**10.** Install Libfreenect2 and Max Performance Scripts.

     sudo reboot

After rebooting, SSH back into the TX1:

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

**11.** Change line `118` of `examples/protonect/CMakeLists.txt` from:

     FIND_LIBRARY(TEGRA_JPEG_LIBRARY jpeg PATHS /usr/lib/arm-linux-gnueabihf/tegra NO_DEFAULT_PATH)

to:

     FIND_LIBRARY(TEGRA_JPEG_LIBRARY nvjpeg PATHS /usr/lib/arm-linux-gnueabihf/tegra NO_DEFAULT_PATH)     

**12.** Verify Protonect Installation.

Run (Note: this script needs to be run each time the TX1 is restarted):

     sudo MaxPerformanceTX1 &> /dev/null

Any print out on the terminal is fine as long as it is not an error. Now run:

     sudo Status

The terminal print out should be this:

     CPUs active (it should be 0-3):
     0-3
     CPUs freq (it should be 2032500000):
     1912500
     1912500
     1912500
     1912500
     CPU governor (it should be userspace):
     userspace
     userspace
     userspace
     userspace
     GPU clock (it should be 852000000):
     998400000
     GPU memory clock (it should be 924000000):
     1600000000


If the print out from `sudo Status` does not look like this, reboot your TX1 and run the command again. If the print out is still not correct, verify that all of the installation steps have been followed.

**13.** Plug in your Kinect v2 to a power source **BEFORE** plugging in the Kinect v2 to the external PCIe USB 3.0 port. After the Kinect v2 is powered, then proceed to connect it to the TK1 USB 3.0 port. Now run:

	cd ../examples/protonect/
	mkdir build && cd build
	cmake ..
	make -j4
	../bin/Protonect

If all libraries and directions were followed properly, you will now see (with some delay, as the visualization is being delivered over SSH) three windows with the depth image, RGB image, and IR image. If you do not receive any images, and your terminal is only printing:

     [DepthPacketStreamParser::handleNewData] subpacket incomplete (needed X received Y)]

then verify that your TX1 was set to max performance mode correctly and that your Kinect v2 is connected to the TX1 properly. If you are receiving USB errors, there is a possibility your Protonect library was linked to the incorrect version of libusb. To fix this, first try rebooting your TX1 and running the commands (above) again; then, connect to the correct library.

Once you are seeing the three images, kill the process and run:

	sudo make install

**14.** Install IAI_KINECT2:

	cd /home/ubuntu/workspace/ros/catkin/src
	git clone https://github.com/OpenPTrack/iai_kinect2
	cd iai_kinect2
	git checkout jetson-dev

Now, Change row `86` of `~/workspace/ros/catkin/src/iai_kinect2/kinect2_bridge/CMakeLists.txt` from:

     /usr/lib/arm-linux-gnueabihf/tegra/libjpeg.so

to:

     /usr/lib/arm-linux-gnueabihf/tegra/libnvjpeg.so

Now run:

	Catkin

If you see an internal compiler error, run:

	CatkinJ1

You can verify the installation by running:

	sudo MaxPerformanceTX1 &> /dev/null
	roslaunch kinect2_bridge kinect2_bridge_ir.launch

The Terminal print out should look similar to:

    [CudaDepthPacketProcessor] avg. time: 21.5727ms -> ~46.3548Hz
    [TegraJpegRgbPacketProcessor] avg. time: 17.6418ms -> ~56.6837Hz

Once this command is running, and the information verified, the process can be killed. Additionally, you can check the point cloud frequency by running:

    rostopic hz /kinect2_head/depth_ir/points

(The command `roslaunch kinect2_bridge kinect2_bridge_ir.launch` must be running!)

**15.** Install OpenPTrack:

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

**N.B.:** We suggest, if you are installing OpenPTrack on more than one TX1, that you clone your completed Ubuntu OpenPTrack installation, and then flash the remaining TX1s with the Operating System clone. To do this:

**Cloning TX1 Ubuntu Image**

**1.** Find where `tegraflash.py` is located (usually under the JetPack folder).

**2.** Put your device in FORCE RECOVERY mode (it must be attached via the micro-USB cable to a Ubuntu computer). It is in FORCE RECOVERY mode if `lsusb` shows a `NVidia Corp. device`.

**3.** Then, in the terminal, navigate to where your `tegraflash.py` is located on your Ubuntu machine (**NOT** the TX1) and run:

        sudo ./tegraflash.py --bl cboot.bin --applet nvtboot_recovery.bin --chip 0x21 --cmd “read APP clone_image_name.img”

**Restoring Clone to New TX1**

**1.** Find where `tegraflash.py` is located (usually within the JetPack folder).

**2.** Put your new device in FORCE RECOVERY mode (it must be attached via the micro-USB cable to the computer). It is in FORCE RECOVERY mode if `lsusb` shows an `NVidia Corp. device`.

**3.** Then, in the terminal, navigate to where your `tegraflash.py` is located on your Ubuntu machine (**NOT** the TX1) and run the following:

         sudo ./tegraflash.py --bl cboot.bin --applet nvtboot_recovery.bin --chip 0x21 --cmd “write APP restore_image_name.img”

Now you have a clone of your TX1 OpenpTrack installation.

**N.B.**: The cloning and restoring process takes slightly over an hour to complete.
