This page guides you through the steps to install the softwares and drivers that are needed for OpenPTrack v2.

## CUDA 
CUDA is required for use with NVIDIA GPUs and as such is needed for OpenPTrack V2

First install the following driver:

     sudo apt-get install -y ocl-icd-opencl-dev

Get the CUDA 8 installer:

     wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda.run

Make the file executable:

     chmod +x cuda.run

Run the file:

     sudo ./cuda.run

     <press q>
     <type accept and enter>
     <press n> <DO NOT install the driver when it asks!>
     <press y>
     <press Enter>
     <press y>
     <press n>
     <press Enter>

Get cudnn 5.1 for CUDA 8:
     
     wget https://www.dropbox.com/s/cx95583vbf1ifzm/cudnn-8.0-linux-x64-v5.1.tgz?dl%3D0&sa=D&ust=1507541105896000&usg=AFQjCNEU511fT00n547PxPt_P6cfSLPVWw
     tar -zxvf cudnn*
     sudo cp cuda/include/* /usr/local/cuda/include
     sudo cp cuda/lib64/* /usr/local/cuda/lib64/

Finally,

     echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> ~/.bashrc
     echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bashrc


## Libfreenect2 
This is an open source driver for Kinect V2. To install do the following: 

     cd
     cd workspace 
     git clone https://github.com/openptrack/libfreenect2
     cd libfreenect2
     git checkout 1604
     cd depends/
     sudo apt-get install -y git cmake cmake-curses-gui libxmu-dev libxi-dev libgl1-mesa-dev dos2unix xorg-dev libglu1-mesa-dev libtool automake libudev-dev libgtk2.0-dev pkg-config libjpeg-turbo8-dev libturbojpeg libglewmx-dev
     ./install_ubuntu.sh
     sudo ln -f -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so
     cd ../examples/protonect/
     mkdir build && cd build
     cmake ..
     make
     sudo make install

     echo '# ATTR{product}=="Kinect2"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666"
     SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"' > ~/90-kinect2.rules
     sudo mv ~/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules


## iai_kinect2
This allows ROS to work with the Kinect V2. To install do the following: 

     cd /home/$USER/workspace/ros/src
     git clone https://github.com/openptrack/iai_kinect2
     cd iai_kinect2
     git checkout 1604


## ceres_solver

     sudo apt-get install cmake libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev -y --force-yes
     mkdir /tmp/ceres_install
     cd /tmp/ceres_install
     git clone https://ceres-solver.googlesource.com/ceres-solver 
     cd ceres-solver
     git fetch --tags
     git checkout tags/1.9.0
     cd ..
     mkdir ceres-bin
     cd ceres-bin
     cmake ../ceres-solver
     make -j8
     make test
     sudo make install
     sudo rm -R /tmp/ceres_install


## calibration_toolkit

     cd ~/workspace/ros/src
     git clone https://github.com/iaslab-unipd/calibration_toolkit
     cd calibration_toolkit
     git fetch origin --tags
     git checkout tags/v0.2


## OpenCV

[OpenCV](https://opencv.org/) is the leading open source library for computer vision. The following steps will guide you to install OpenCV from source (note that depending on your hardware, this may take some hours): 

     cd
     cd workspace
     sudo apt-get update
     git clone https://github.com/marketto89/opencv
     cd opencv
     git checkout 3.1.0-with-cuda8
     mkdir release
     cd release  
     cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local/opencv3 -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -D WITH_IPP=ON -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs ..
     make -j8 -l8
     sudo make install
     printf '#OpenCV\nPKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opencv3/lib/pkgconfig\nexport PKG_CONFIG_PATH\n' >> ~/.bashrc  
     printf 'PATH=$PATH:/usr/local/opencv3/bin\nexport PATH\n' >> ~/.bashrc  
     printf 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/opencv3/lib\nexport LD_LIBRARY_PATH\n' >> ~/.bashrc  
     source ~/.bashrc
     sudo ln -s /usr/local/opencv3/share/OpenCV/3rdparty/lib/libippicv.a /usr/local/lib/libippicv.a


## rtpose_wrapper

     cd ~/workspace/ros/src
     git clone https://bitbucket.org/mcarraro/rtpose_wrapper
     cd rtpose_wrapper
     git checkout integration-1604
     sudo apt-get --assume-yes install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev
     make all -j8


## ZED Install (Optional)
If you are using a ZED Camera, follow these steps:

     cd ~
     wget https://www.stereolabs.com/developers/downloads/archives/ZED_SDK_Linux_Ubuntu16_v2.0.1.run

     <Make sure ZED is plugged into Computer>

     chmod +x ZED_SDK_Linux_Ubuntu16_v2.0.1.run
     ./ZED_SDK_Linux_Ubuntu16_v2.0.1.run
     <Go through install steps>

     cd 
     cd workspace/ros/src
     git clone https://bitbucket.org/mcarraro/zed_wrapper_opt
     cd ..

Finish the installation [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/OpenPTrack-v2-Modules)