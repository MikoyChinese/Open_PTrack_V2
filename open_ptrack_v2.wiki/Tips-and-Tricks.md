### Updating to Latest Version

To update to the latest version:

    roscd open_ptrack/..
    git pull
    cd ~/workspace/ros/catkin
    catkin_make --pkg opt_msgs
    catkin_make --pkg opt_msgs
    catkin_make --force-cmake

**Now you've got the latest code!**

**N.B.:** Two `--pkg opt_msgs` commands are included above, as sometimes this must be performed twice for all interdependent submodules to compile completely.

**N.B. 2:** To update OpenPTrack without losing local `tracking.yaml` and `detection.yaml` configuration changes, from `~/open_ptrack/detection` and `~/open_ptrack/tracking`, before you run the command `git pull` above:

    git stash save
    git pull

Then, after updating your OpenPTrack version per the directions above: 

    git stash apply

It is important to merge any conflicts manually, in order to ensure that any *new* parameters or settings in configuration files are retained from the latest source without overwriting local parameters. 

### Quitting a Process

ROS has many layers. Simply using `Ctrl-c` in a sensor window will often not stop a detection node entirely. Rather than rebooting to ensure a clean start, one may simply:

    pkill -f ros; pkill -f nodelet; pkill -f XnSensor  

### ROS Tricks

* **realtime** parametric modification:

        rosrun rqt_reconfigure rqt_reconfigure

* **record** detection and tracking messages:

        rosbag record -b0 /tf /detector/detections /tracker/tracks

* **record** a given Kinect sensor:

        roslaunch opt_calibration sensor_<kinect_name>.launch
        rosbag record -b0 /tf <kinect_name>/depth_registered/image_raw <kinect_name>/depth_registered/camera_info <kinect_name>/rgb/image_raw <kinect_name>/rgb/camera_info <kinect_name>/depth_registered/disparity 

* **record** a given Swiss Ranger:

        rosbag record -b0 /tf <swissranger_name>/confidence/image_raw <swissranger_name>/camera_info <swissranger_name>/pointcloud2_raw

* **playback** a `rosbag` recording:

        rosbag play <filename>.bag

* **view all topics** being published:

        rostopic list

* **view info** of any rosbag:

        rosbag info <bag_name> 

* **fps** of a given topic:

        rostopic hz /Kinect1/rgb/image_rect_color

* **view** tracking broadcast / json data:

        roslaunch opt_utils udp_listener.launch

* **inspect** each sensor’s detection:

        rostopic hz /<camera_name>/ground_based_people_detector_<camera_name>/detections

**N.B.:** It is also possible to subscribe to a `detections` topic, and then the Rviz view is correlated with a sensor by color. See **Multi-camera Detection Visualization** (below).

### Multi-camera Detection Visualization

In order to make the debugging process easier for a multi-node system, visualizing the detections coming from every sensor is made possible with the ROS visualizer in the master node, or any PC in the network by running `rosrun rviz rviz`, then loading the appropriate `Rviz` file, as already done for tracking information. It is possible to visualize:

1. markers showing the current detection positions from every camera;
2. detection trajectories for every camera.

**N.B.:** Detections coming from different cameras are shown with different colors.

In more detail (see the image below as a reference):

1. Press `Add`, then select `MarkerArray`, and press `OK`. Then, select/write in the `Marker Topic` field: `/detector/markers_array`.
To inspect only the detections/markers coming from a specific camera, enlarge the `Namespaces` menu and then select only the camera/cameras of interest.
2. Press `Add`, then select `PointCloud2`, and press `OK`. Then, select/write in the `Topic` field: `/detector/history`. Please note that the length of these trajectories depends on the `detection_history_size` parameter in the following file: 
https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_multicamera.yaml.

![Detection Bug](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/Detection_debug.png)

### Restore previous calibration

The network (extrinsic) calibration information is stored in this file:

        ~/workspace/ros/catkin/open_ptrack/opt_calibration/conf/camera_poses.yaml

You can save a copy of this file with the name you prefer and use these instructions to restore it:

1) substitute this file with the calibration file you want to restore:

        ~/workspace/ros/catkin/open_ptrack/opt_calibration/conf/camera_poses.yaml

2) repeat [Step 2](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration#2-create-files-for-multi-sensor-people-tracking) of the network calibration guide.

Now the old calibration has been restored.

**N.B.:** This process does not restore the [calibration refinement procedure](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration#3-perform-multi-imager-calibration-refinement---optional) results. Thus, it should be repeated.