To run just object detection on a single camera, run the following command:

`roslaunch tracking single_camera_tracking_node.launch enable_pose:=false enable_people_tracking:=false enable_object:=true`

It is also possible to run with other modules activated by setting the enable flags for the modules to true. For example, the command below sets all modules to true:

`roslaunch tracking single_camera_tracking_node.launch enable_pose:=true enable_people_tracking:=true enable_object:=true`


Note: Depending on your graphic processor, running pose annotation with the other two modules activated may be too much for your node.

Once the command is running, a rviz window will automatically open. Rviz is used for visualizing data in OPT. See [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Visualizing-OPT-Data-in-RViz) for instructions on visualizing data in OPT. You can choose your topics and subsequently save the configuration. OPT v2 comes with a default rviz configuration: SingleCameraTracking.rviz. 

![rviz configuration for single tracking ](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Just%20Tracking%20Single.png)

To view the object detection select objectTrackingImage in the SingleCameraTracking.rviz. 

![Object Detection using Single Camera](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/ObjectDetectionUsingSingleCamera.png)

You also have the option to view the image as captured by the sensor by checking the SimpleImage option in the SingleCameraTracking.rviz.
![Tracking + SimpleImage](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Tracking%20%2B%20simple%20image.png)