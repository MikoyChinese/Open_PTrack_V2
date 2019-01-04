### Supported Imagers

RGB-D Imagers currently supported:

* [Mesa SwissRanger 4500](http://hptg.com/industrial/)
* [Kinect V2](http://support.xbox.com/en-US/browse/xbox-one/kinect?icid=furl_xboxone-kinect)
* [ZED Stereo Camera](https://www.stereolabs.com)

Legacy:
* [Kinect V1](https://support.xbox.com/en-US/browse/xbox-360/accessories/Kinect) (XBOX, not Kinect for Windows)
* [Stereo Camera](https://www.ptgrey.com/blackfly-usb3-vision-cameras) (Point Grey Blackfly - USB or IP) 

**N.B.:** Legacy imagers should still function with OpenPTrack V2. However, driver updates are not supported by the OpenPTrack team.


### Supported Hardware
The main requirement for each compute node: Linux x86-compatible hardware capable of running Ubuntu 16.04 and the Robot Operating System (ROS). Most likely, one compute node will be needed per imager. Our deployment experience suggests that modern Ubuntu-compatible machines with i7 CPUs and at least 8GB RAM constitutes a good setup for each node. Running on pre-2011 hardware is not recommended. OpenPTrack will not compile on a machine with less than 2.7GB RAM.  

Faster CPUs can mean better tracking performance, and may also enable running more than one detection process (i.e., more than one sensor) per node. Do not run any node close to 100% CPU utilization, or tracking performance will most likely suffer. 

Kinect V2 support requires a CUDA-capable GPU. Nvidia GPUs tested so far: Nvidia GeForce 650, 660, 670, 740, 750, 760, 770, 840, 850, 860, 870, 1070 and 1080.

**N.B.:** Pose annotation requires an Nvidia 1070 or 1080 chip set, with the 1080 being recommended.


The [Deployment Guide](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Deployment-Guide) contains additional hardware recommendations, in the [Tested Hardware](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Tested-Hardware) section.

### Supported OS

* Person and object detection and tracking & pose annotation hosts: Ubuntu 16.04. 
* Consumers: Any platform that can receive UDP datagrams.