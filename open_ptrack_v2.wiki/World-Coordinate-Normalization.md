# World Coordinate Normalization

If, after calibration, you find that OpenPTrack's world coordinate system does not match what is needed for your visualization or interactive system, the coordinate system can be changed manually. We have found that using three reference points works best, with one of the points being `0,0`. To change the coordinate system:

First, launch `roslaunch detection detection_node_<sensor_id>.launch` for each sensor in your system. Once all the sensors in your network are detecting, run:

    roslaunch opt_calibration opt_define_reference_frame.launch

Now, a GUI will launch showing the video feed from one of the sensors. You can right click on the video to cycle through all the sensor's video feeds. Once you have the sensor's video feed up from which you would like to set a new coordinate, click on the spot in the video that will be a reference point for the new coordinate system, e.g., if you are going to set the new `0,0` for the coordinate system, and that `0,0` is visible in the video feed, left click the `0,0` spot. 

In the terminal window that `roslaunch opt_calibration opt_define_reference_frame.launch` was executed, there will now be prompts asking for the X and Y coordinates. Enter them into the prompt and follow the commands.

Repeat this process until you have entered all the coordinates to re-orient OpenPTrack's world space. Use the middle click on your mouse to save, after you have set all the required points to save the new world coordinate system.

The last step of the process is to distribute the new coordinates to the rest of the machines in your OpenPTrack system. To do this:

Run the following on the master PC:

    roslaunch opt_calibration calibration_initializer.launch

And run the following on every PC (including the master):

    roslaunch opt_calibration listener.launch

The `roslaunch opt_calibration calibration_initializer.launch` terminal will confirm the file was distributed and the initializer and the listener terminals can all be closed.

**N.B.:** The launcher in the master PC must be run first. Otherwise, the listeners will raise an error.

**N.B.2:** The user-defined reference frame must adhere to the convention that the Z axis should point upwards.
Thus, be aware to choose X and Y directions so that Z points upwards according to the [right hand rule](http://en.wikipedia.org/wiki/Right-hand_rule).
