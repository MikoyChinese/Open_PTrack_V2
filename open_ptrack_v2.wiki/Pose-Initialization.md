In order to add new poses to the gallery the user should strike and maintain the pose for some time using a single/multiple sensor network. This is very difficult to do in large areas, so it is suggested to use a single sensor or a small camera network in a small space.
 
* Run the tracking node and all the detection nodes (only enable_pose flag is required, others could be optionally set as false)
* Try to walk in the space looking at RViz. If the skeleton is good enough (it is not shaky) you can try to add the pose.
* In another terminal 
`roslaunch record_pose record_pose.launch pose_name:=<pose_name>`
* RUN to the best point covered by your network and strike the pose you want to record.
* Maintain it until you see that the node has finished (bold white writings: [record_pose-1] process has finished cleanly)
* Look in gallery_pose/data for the new pose (should be a folder with the highest number). In that folder that should be a txt file (the only thing that matters for the library) and two auto-generated images of the skeleton recorded. If they make sense you are ok (please note that the top view can have the limbs shifted ahead, do not worry about that), otherwise you should remove the folder and update poses.csv removing the last line (which should be relative at the recorded pose, PLEASE: REMOVE ONLY THAT LINE!).

To remove poses just remove the folder with the correct id or rename it (with some letters no numbers). You can also update the poses.csv but PLEASE be sure that there are no empty lines (except for the last one) but even if you do not update it it is going to work anyway. 
