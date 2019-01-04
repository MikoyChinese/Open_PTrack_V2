To run just the person tracking module on a single camera, run the following command:

`roslaunch tracking single_camera_tracking_node.launch enable_pose:=false enable_people_tracking:=true enable_object:=false`

It is also possible to have all modules activated either with:

`roslaunch tracking single_camera_tracking_node.launch enable_pose:=true enable_people_tracking:=true enable_object:=true`

or simply:

`roslaunch tracking single_camera_tracking_node.launch`


It is possible to activate or deactivate modules by setting the flags to true or false. 

Note: Depending on your graphic processor, running pose annotation with the other two modules may be too much for your node.

Sometimes when you run person tracking, a window may pop up asking you to select three points. This is to set the ground plane manually. Also sometimes due to a reflective or dark colored floor, tracking may not function properly or function all. This can also be solved by setting the ground plane manually.  See [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Manual-Ground-Plane) for the information.

Once the command is running, a rviz window will automatically open. Rviz is used for visualizing data in OPT. See [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Visualizing-OPT-Data-in-RViz) for instructions on visualizing data in OPT.  You can choose your topics and subsequently save the configuration. OPT v2 comes with a default rviz configuration: SingleCameraTracking.rviz. 

![rviz configuration for single tracking ](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Just%20Tracking%20Single.png)


You also have the option to view the image as captured by the sensor by checking the SimpleImage option.
![Tracking + SimpleImage](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Tracking%20%2B%20simple%20image.png)