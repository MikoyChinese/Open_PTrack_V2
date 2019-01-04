# OpenPTrack Quick Start Guide Example

We have found it very helpful to keep a document on one of the tracking computers, listing, in the appropriate order, all the commands needed to calibrate and run tracking for the specific OpenPTrack system. 

Below is an example of one of our quick start guides, which has three (3) Kinect v2s, named in the `network_camera.yaml` as `kinectv2_left`, `kinectv2_right`, and `kinectv2_center` on three computers with IP addresses of 192.168.100.101, 192.168.100.102, and 192.168.100.103 respectively:

## Calibration

First, on the master computer (192.168.100.101), run:

     roscore

     roslaunch opt_calibration calibration_initializer.launch

Now, on all computers in the OpenPTrack system including .101 (ssh -XC 192.168.100.102 and ssh -XC 192.168.100.103), run:

     roslaunch opt_calibration listener.launch

Then, on each computer connected to a Kinect v2, run:

     sudo ~/workspace/ros/catkin/devel/lib/kinect2_bridge/./kinect2_bridge

**Ignore the error!**

Now, on the computer with the IP address of 192.168.100.101, run:

     roslaunch opt_calibration opt_calibration_master.launch

     roslaunch opt_calibration sensor_kinectv2_left.launch

Again, on the computer with the IP address of  192.168.100.102 (ssh -XC 192.168.100.102), run:

     roslaunch opt_calibration sensor_kinectv2_right.launch

Lastly, on the computer with the IP address of 192.168.100.103 (ssh -XC 192.168.100.103), run:

     roslaunch opt_calibration sensor_kinectv2_center.launch


[Calibrate per the standard](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Calibration-in-Practice) procedure. After the completion of calibration, save the calibration file:

     rostopic pub /opt_calibration/action std_msgs/String "save" -1

Next, with the `listeners` still running:

     roslaunch opt_calibration detection_initializer.launch 

To finish the calibration process, kill all the terminal commands that are still running. Now you can move on to the detection and tracking start-up process.

## Detection and Tracking 

**N.B.:** The `sudo ./kinect2_bridge` command only needs to be run again if the computer has been restarted.

To start the detection and tracking process, on the master machine (192.168.100.101), run:

     roscore

     roslaunch tracking tracking_node.launch

     roslaunch detection detection_node_kinectv2_left.launch

Next, on the computer with the IP address of 192.168.100.102, run:

     roslaunch detection detection_node_kinectv2_right.launch

Last, on the computer with the IP address of 192.168.100.103, run:

      roslaunch detection detection_node__kinectv2_center.launch

Now person detection and tracking will be running, and OpenPTrack will track people in your active tracking area!
### N.B.: The instructions above for detection and tracking activate the person tracking, pose annotation and object detection modules at the same time. It is possible to activate or deactivate modules by running the commands with flags as shown below and setting the flags to true or false. In the examples shown below for the master machine(192.168.100.101), only the person tracking module is activated. 

      roslaunch tracking tracking_node.launch enable_pose:=false enable_object:=false enable_people_tracking:=true

      roslaunch detection detection_node_kinectv2_left.launch enable_pose:=false enable_object:=false enable_people_tracking:=true



