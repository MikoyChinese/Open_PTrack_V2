## Calibration Refinement:

We have found that running calibration refinement, `roslaunch opt_calibration opt_calibration_refinement.launch`, after each new calibration is essential to all sensors having a uniform, flat ground plane, and it helps reduce ghost and/or spurious tracks. We have also found that it helps to walk a vertical pattern and then a crisscrossing horizontal pattern.

To run calibration refinement:

First, ensure all of the sensors in the network have their detection process running:

     roslaunch detection detection_node_<sensor_id>.launch

Then, verify that `roslaunch tracking tracking_node.launch` is **NOT** running. If it is, then control+c in that terminal window to stop the operation.

Now, run:

     roslaunch opt_calibration opt_calibration_refinement.launch

A new Rviz window should appear, and you can walk a pattern in the space wherein all of the sensors have detected and tracked you during the refinement operation. 

**N.B.:** When running calibration refinement, it is critical that only **one** person is in the space, **and** that when walking during refinement, the person does not walk the same path in the same direction. If this happens, the refinement process will now work. (A walking pattern that has worked well for us is shown below.)

The following image is an example of the calibration refinement walking process. As you can see, a grid was created by a pattern of walking the extents of the tracking space vertically then horizontally.

![Calibration_Refinement_Example](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/6.%2020150430_Calibration_Refinement.png?raw=true)

Then, after completing the calibration refinement walking process, save the results by entering the following command into a new terminal window: 

     rostopic pub /opt_calibration/action std_msgs/String "save" -1