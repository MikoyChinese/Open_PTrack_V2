# File Configuration
This section describes how to configure a few OpenPTrack files that will allow each node to communicate properly across the network, and identify their associated imager.

## 1. Modify the .bashrc.

Every sensor should be connected to a PC on the same Gigabit Ethernet network. One PC will be the master, where the calibration code and the tracking code will run, while the other PCs will run the sensor drivers (during calibration) and the people detection code (during distributed detection and tracking). To allow communication between software nodes in different computers, the environment variable `ROS_MASTER_URI` on every client PC must be set to the IP address of the master PC. Additionally, the `ROS_IP` and `ROS_PC_NAME` environment variables must be set on every PC. If you are using [Docker Images](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images), see instructions below. This can be done temporarily on a terminal by typing the following commands:

     export ROS_MASTER_URI=http://<MASTER_IP>:11311/
     export ROS_IP=<MACHINE_IP>
     export ROS_PC_NAME=<MACHINE_NAME>

For example:

     export ROS_MASTER_URI=http://192.168.100.101:11311/
     export ROS_IP=192.168.100.102
     export ROS_PC_NAME=PC1-Example

Note that the PC names to be assigned can be whatever the user wants, not necessarily related to the real name of the PCs. To set them definitively, they can be added directly to the end of the `.bashrc` file in the home folder by typing:

     echo "export ROS_MASTER_URI=http://192.168.100.101:11311/" >> ~/.bashrc
     echo "export ROS_IP=192.168.100.102" >> ~/.bashrc
     echo "export ROS_PC_NAME=PC1-Example" >> ~/.bashrc

or:

     gedit ~/.bashrc

If gedit is used, the same variables need to be set in the `bashrc` file:

     ROS_MASTER_URI=http://192.168.100.101:11311/
     ROS_IP=192.168.100.102
     ROS_PC_NAME=PC1-Example

If you are using [Docker Images](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images), all you need to do is edit the ros_network.env file inside the open_ptrack_docker_config folder with the information described above:
     
    cd ~/open_ptrack_docker_config/multi_camera_tracking
    gedit ros_network.env
     

## 2. Create files for multi-sensor calibration.

Multi-sensor calibration is performed by running a calibration node in the master PC and a sensor driver in every PC attached to a sensor (one driver node for every sensor). The network must be configured in the `opt_calibration/conf/camera_network.yaml` file. 

First, make that file. 

Below is a `camera_network.yaml` file for a network composed of two PCs with two sensors each:

```
# Camera network parameters
network:
  - pc: "PC1-Example"
    sensors:
      - type: kinect1
        id: "Kinect_Left"
        serial: "A00364820345039A"
      - type: kinect1
        id: "Kinect_Right"
        serial: "A00345482325021B"
  - pc: "PC1-Example"
    sensors:
      - type: kinect2
        id: "Kinect_PC2"
      - type: sr4500
        id: "SwissRanger"
        ip: "192.168.1.42"
      - type: stereo_pg
        id: "blackfly_stereo"
        serial_left: "13310958"
        serial_right: "13310959"
```

**N.B.:** Pay particular attention to the leading spaces. Do not use Tab.

**N.B.2:** In the `opt_calibration/conf/camera_network.yaml`: 

       - pc: "PC1-Example"

needs to match the `.bashrc`:

      ROS_PC_NAME=

A PC is added to the network with the parameter `pc: "<ROS_PC_NAME>"` preceded by a minus that indicates that it belongs to a list (see yaml documentation above).

Then, for each PC, the list of the connected sensors is added with the parameter sensors.
For each sensor, two to four parameters can be defined:
* `type` (mandatory) defines the type of the sensor. It must be `kinect1` for the 1st Kinect version, `kinect2` for the 2nd Kinect version, `sr4500` for Swiss Rangers SR4500, and `stereo_pg` for custom stereo pairs composed of Point Grey cameras. 
* `id` (mandatory) is the unique name to identify the sensor in the network.
* `serial` (optional, for Kinects only) defines the serial number of the Kinects to make them distinguishable in the same PC.
* `ip` (mandatory, for SwissRangers only) is the local IP address of the SwissRanger (can be the same for each one if connected to different PCs).
* `serial_left`, `serial_right` (optional, for stereo only) define the serial numbers of the left and right cameras of the stereo pair. The serials of the cameras attached to a PC can be retrieved with `rosrun pointgrey_camera_driver list_cameras`.

The parameters of the checkerboard used for calibration must also be added:

```
# Checkerboard parameters
checkerboard:
  rows: 6
  cols: 5
  cell_width: 0.12
  cell_height: 0.12
```

**Note:** The rows and cols parameters are defined by the number of chess intersections in rows and columns (cols), not the number of squares along the edge of the checkerboard. The width and height measurements are in meters. See more information [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Checkerboard-Initialization-and-Configuration)