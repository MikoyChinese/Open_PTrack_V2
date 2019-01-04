Only experts should use this!

This helps you to find a new refinement matrix for each sensor. Basically, the idea is that each point cloud in the network is displayed in Rviz with a different color (the user should add them/change the color). 

NOTE: Theoretically, the calibration is not the same in all the spots. Please, consider that this tool, as it is described, is making you do the calibration looking at just one spot. Anyway, it is useful in particular for camera networks with restricted FOV.

From now on, I suppose your camera network is composed of 3 cameras called kinect_01 kinect_02 and kinect_03. I consider kinect_01 as the reference camera, but it could be any one of the three.

* Perform the usual network calibration with the checkerboard.
* From the tracker, start OPTv2 with the following command 
`roslaunch tracking tracking_node.launch enable_people_tracking:=false enable_object:=false enable_pose:=false.`
 You can close RViz when it opens. 

* From each detector, start OPTv2 with the following:
 `roslaunch detection detection_node.launch enable_people_tracking:=false enable_object:=false enable_pose:=false`
* From the local machine you are using (no SSH):
  * Go inside opt_utils->launch and edit _manual_cloud_refinement.launch_ to reflect your camera network. In particular, there should be a parameter called `sensor_name<i>` for each camera with its correct name and a `<node>...</node>` tag for each sensor_name`<i>` (what's already written in the file should help you). When adding a new `<node> </node>` you should copy everything as it is and change only the sensor_name`<i>`  (with the one just added)
  * from a terminal launch `roslaunch opt_utils manual_cloud_refinement.launch`
  * from another terminal launch rviz (i.e. `rosrun rviz rviz`)
  * In RViz, using the top-left menu, you should set the Fixed Frame under Global Options to _world_
  * Add the TF in RViz (Add->TF)
  * Add the _**raw**_ reference camera point cloud colored in white (i.e. add the topic _/kinect_01/depth_ir/points_, to color it just apply a flat color and choose white)
  * Add the _**manual refined**_ kinect_02 point cloud using a flat color different than white(i.e. add the topic _/kinect_02/depth_ir/points_manual_refined_ )
  * Add the ``_**manual refined**_`` kinect_03 point cloud using a flat color different from the two previously chosen (i.e. add the topic _/kinect_03/depth_ir/points_manual_refined_)
  * At this point you should see in RViz the three point clouds. If this is not the case, there is something wrong. Check the previous points.
  * Place a big object in the scene (i.e. a checkerboard) to be used as a reference for applying the transformation
  * Open another terminal and run `rosrun rqt_reconfigure rqt_reconfigure `
  * From the window, select one of the cloud_manual_refinement node on the left, considering that each one operates on one cloud (the name should suggest you which one). In this case, you should modify cloud_manual_refinement_kinect_02 and cloud_manual_refinement_kinect_03. Modifying the transl_x, transl_y, transl_z, rot_x, rot_y and rot_z parameters you should see the correspondent refined cloud which is translating/rotating around the world coordinate system accordingly. Modify the parameters to align the current point cloud to the white cloud using the reference object. Each transl/rot you are applying is expressed wrt the world ref system. Looking at its axis (TF) should give you an idea of what transformation to apply (remember, Red/Green/Blue are X/Y/Z).
  * When you are satisfied with the result, copy the last matrix outputted in the terminal in a file called `registration_kinect_<i>_ir_optical_frame.txt` (where `kinect_<i>` is either kinect_02 or kinect_03 in this case) in the tracker's opt_calibration/conf folder.
  * Do the same for all the cameras in your camera network. 
* Once finished, close everything and run OPTv2 normally with the refinement set it  to true (which should be the default option).
