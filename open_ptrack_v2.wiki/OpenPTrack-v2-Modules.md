Having installed [dependencies](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Dependencies) and [softwares and drivers](https://github.com/OpenPTrack/open_ptrack_v2/wiki/CUDA-and-Other-Softwares-Installation), you can now install OpenPTrack v2.

## Base

To install the basic OpenPTrack package, do the following:

     cd ~/workspace/ros/src
     git clone https://github.com/openptrack/open_ptrack_v2 open_ptrack
     cd open_ptrack
     source ~/.bashrc
     cd ../..
     catkin_make

## Weights for YOLO

     roscd yolo_detector/darknet_opt
     wget -O coco.weights https://pjreddie.com/media/files/yolo.weights

## NTP

     sudo apt-get install ntp -y

**N.B.:** Having installed NTP, ensure you follow the steps [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization) under [Configuration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Configuration) to configure it.


## OpenFace Dependencies

If you want to run face recognition on OpenPTrack, there are some other dependencies required. Having already installed the [OpenPTrack package](https://github.com/OpenPTrack/open_ptrack_v2/wiki/OpenPTrack-v2-Modules#base), please run the following to install the dependencies for OpenFace(this may take a while):  

     cd ~/workspace/ros/src/open_ptrack/recognition/install_scripts
     ./install_all.sh
     
     Choose 'yes' to the question about automatically prepending torch location.

     cd
     sudo apt-get install -y python-qt4 python-pip
     pip install requests



Having finished the build and installation, please proceed to the [Configuration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Configuration).
