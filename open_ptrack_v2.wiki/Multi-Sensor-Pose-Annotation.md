Once [multi-sensor calibration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration) has been performed, it is possible to run multi-sensor pose annotation by simply running a detection node for every sensor and a tracking node in the master PC.

In Gnocchi, there are enable flags for person tracking, pose recognition and object detection. Depending on what modules you want to run,the flags can be set to true or false. However, note that running pose annotation with object detection requires an architecture of 1070 or more. 

For just pose annotation, in the master PC, run:

    roslaunch tracking tracking_node.launch enable_pose:=true enable_object:=false enable_people_tracking:=false

The above publishes calibration data, performs annotation, and opens Rviz in order to show poses. And in every PC attached to a sensor, the launch file `detection_node_<sensor_id>.launch` saved previously should be run as follows:

    roslaunch detection detection_node_<sensor>.launch enable_pose:=true enable_object:=false enable_people_tracking:=false


After running the tracking node, Rviz is opened. Rviz is used for visualizing data in OPT. See [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Visualizing-OPT-Data-in-RViz) for instructions on visualizing data in OPT. You can choose your topics and subsequently save the configuration. OPT V2 comes with a default rviz configuration for multi-sensor setups: MultiCameraTracking.rviz.

![Default Multi-Sensor Rviz Configuration](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Multi-Camera%20Setting.png)

**N.B.:** It is important that all PCs are synchronized in time. The Internet can be used to update clock information. Future work includes implementation of an alternative option for synchronization. If the PCs are not synchronized in time, an error will appear in the tracking command line, such as:

    [ERROR] [1396947072.332131826]: transform exception: Lookup would require extrapolation into the past.
