[KB] Rough notes for errors that have been run into
### After updating to new version, and it isn't working (why is it not working? What is showing up?)

//I am going to clean this all up
* reinstall the Kinect:
1. go inside your ROS workspace (i.e. usually /home/$USER/workspace/ros/catkin/src)
2. 
git clone https://github.com/OpenPTrack/libfreenect2.git;

cd libfreenect2
git checkout iai_kinect2

cd depends/

3. sudo apt-get install -y git cmake cmake-curses-gui libXmu-dev libXi-dev libgl1-mesa-dev dos2unix xorg-dev libglu1-mesa-dev libtool automake libudev-dev libgtk2.0-dev pkg-config libjpeg-turbo8-dev libturbojpeg libglewmx-dev --reinstall

./install_ubuntu.sh
sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so

cd ../examples/protonect/
cmake .
make -j4
sudo make install

< go inside your ROS workspace (i.e. usually /home/$USER/workspace/ros/catkin/src)  >

git clone https://github.com/OpenPTrack/iai_kinect2.git
cd iai_kinect2

git checkout development

echo '# ATTR{product}=="Kinect2"

SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"' > ~/90-kinect2.rules
sudo mv ~/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules

< go inside your ROS workspace before src (i.e. usually /home/$USER/workspace/ros/catkin)  >
catkin_make
< reboot >
< disconnect and reconnect the Kienct v2 to the USB3.0 port of the computer >
< wait a couple of seconds >



sudo apt-get install -y ocl-icd-opencl-dev --reinstall

### Machines Crash - Completely turn off

* try resetting power strip

### OS GUI freezes

* Likely to be due to the Nvidia driver crashing
* sudo service light dm restart

### ntpq offset is unreasonable 

* sudo service ntp restart

//the following are when we try to run detection

### Error message - [pcl::PCDReader::readHeader] Could not find file '/tmp/background_<sensor_id>

* background subtraction enabled - this is ok

### Error message - Set process thread priority to: 19

* Unplug USB and replug to that respective machine

### Error message: No valid frame. Move the camera to a better position. OR [ERROR'[longnumber.longnumber]:CV_bridge exception: Unrecognized image encoding

* not enough points on the floor
//make sure to add the notes about the issue that came up from the Gnocchi email thread
