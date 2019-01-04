This guide explains how to calibrate a camera network composed of Microsoft Kinect v1 (Xbox version), Kinect v2, and Mesa Swiss Rangers (type SR4500), and how to perform people tracking in a distributed configuration.

_Before calibrating, make sure that the clocks of all OpenPTrack nodes are [synchronized using NTP](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization)._

Hint:

     ntpq -p

Or: 

     ntpq --p


**N.B.:** For person tracking with a single imager, please see the [Intrinsic Calibration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Intrinsic-Calibration) page (for example, single Kinect). Otherwise, instructions for multi-sensor detection follow.

There are two existing models of the Kinect for Xbox:

1414: Old firmware: Open source drivers can read its serial number.

1473: New firmware: Open source drivers cannot read its serial number and return a list of zeros.

**N.B.:** On any one CPU, we have found that it is best practice to connect only **one Kinect** and **one Swiss Ranger** for best performance.

**Let's start!**

The entire procedure can be summed up with the following steps:

1. Connect every PC to the network and configure them.
1. Create files for multi-sensor calibration.
1. Perform multi-sensor calibration.
1. Create files for multi-sensor people tracking.
1. Perform multi-sensor calibration refinement based on people detection (optional).
1. Perform multi-sensor people tracking.

It is also important to ensure time synchronization between hosts [(instructions)](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization).

Now that you have updated the `camera_network.yaml` and the `.bashrc` file per the [pre-calibration configuration guide](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Pre-Calibration-File-Configuration), the `camera_network.yaml` can be distributed to all the nodes, so the network can be calibrated. 

To create launch files needed for calibration, run the following on the master PC:

    roslaunch opt_calibration calibration_initializer.launch

And run the following on every PC (including the master):

    roslaunch opt_calibration listener.launch

**N.B.:** The launcher in the master PC must be run first. Otherwise, the listeners will raise an error.

Additionally, a launch file with the name `detection_node_<sensor_id>.launch` is created for every sensor in the `detection/launch` folder of the PCs. 

**We are ready to calibrate!**

## 1. Perform multi-sensor calibration.

The calibration initialization described above creates a main launch file for calibration (`opt_calibration_master.launch`) to be run on the master PC and a launch file for every sensor (`sensor_<sensor_id>.launch`), which launches the driver for the sensor with `id: "<sensor_id>"`. The `sensor_id` is set per machine in the `camera_network.yaml`.

To perform the multi-sensor calibration, run (on the master PC):

    roslaunch opt_calibration opt_calibration_master.launch

Then, for every sensor, run (on the PC attached to that sensor):

    roslaunch opt_calibration sensor_<sensor_id>.launch

When two cameras see the checkerboard, the transformation between the two is estimated. Every sensor is then extrinsically calibrated with respect to another sensor, composing a tree of transformations which describe the whole network. Every time a camera is calibrated with respect to another camera, a link appears between the two in Rviz. An output is provided in the console, such as: 

    /<sensor_id> added to the tree.

To start the calibration process, first show the checkerboard to any one of the imagers in the network. Once the imager is added to the tree, this is when ` /<sensor_id> added to the tree.` is printed in the terminal, and you can calibrate the next sensor. The checkerboard needs to be shown to the imager that was previously added to the tree and, at the same time, the next closest imager, to allow the second imager to be calibrated. Once the second imager is added to the tree, either of the two imagers that were previously added to the tree can be used to calibrate the remaining imagers in the network. Thus, as an imager is added to the tree, it can be used to calibrate any remaining imagers in the network, by showing the checkerboard to the calibrated imager(s) and any of the remaining uncalibrated imager(s). Calibration best practices can be found in the OpenPTrack Deployment Guide [Calibration in Practice](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Calibration-in-Practice) page.

When all cameras are calibrated, another output appears:

    All cameras added to the tree. Now calibrate the global reference frame and save!

**N.B.:** When this message appears, the calibration process **will continue capturing images**. At this point, OpenPTrack is only alerting the user that they can save the global reference frame. The operator can either continue collecting images to improve calibration, or move onto saving the global reference frame. 

It will be requested for the user to put the checkerboard on the ground in the position and orientation which define the global reference frame to be used for people tracking, so that, at minimum, one of the sensors can see the checkerboard. Then, all calibration data can be saved by running:

    rostopic pub /opt_calibration/action std_msgs/String "save" -1

After this command is run, in the terminal window running the following:

    roslaunch opt_calibration opt_calibration_master.launch

there will be text stating:

    ~/open_ptrack/opt_calibration/conf/camera_poses.yaml created!

This indicates to the operator that the calibration has been saved, and can move on to distributing the file.

The origin of the global (`/world`) reference frame is set at the top-right square intersection, as illustrated in the figure below. The `/world` reference frame saved for tracking will have the x-axis pointing towards left and the y-axis pointing towards down. The “top” of the checkerboard can be determined by counting the black checkers on each edge of the checkerboard. The edge of the checkerboard with the largest number of black squares is the “top”, and the origin point (0,0) is the right most intersection of the (2) black and (2) white checkers. 

![](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/images/CheckerBoard_Origion.JPG?raw=true)

All extrinsic calibration data are saved to the `opt_calibration_results.launch` file in the `opt_calibration/launch` folder. 
Moreover, a text file with all camera poses (`camera_poses.txt`) and a launch file (`detection_node_<sensor_id>.launch`) for every sensor are created in the `detection/launch` folder of the master PC. These `detection_node` files can be used directly to perform distributed people detection after they have been moved to the `detection/launch` folder of the computer attached to the sensor with `<sensor_id>` name. 

**N.B.:** The calibration is completely redone. Only the transformation `world`-`fixed_sensor_id` is maintained.

## 2. Create files for multi-sensor people tracking.

If not done already, perform:

* Ctrl-c to exit `roslaunch opt_calibration detection_initializer.launch` before continuing.
* Ctrl-c to exit all `roslaunch opt_calibration listener.launch` on all hosts before continuing.

To copy the `detection/launch/camera_poses.txt` file to the `detection/launch` folder of every PC, run:

    roslaunch opt_calibration detection_initializer.launch 

And on every PC (including the master), run:

    roslaunch opt_calibration listener.launch



## 3. Perform Multi-Imager Calibration Refinement(Person-based) - _Optional_ 

_While this step is optional, we have found that in OpenPtrack networks with five imagers or more, it is needed to resolve the splitting of a single track._

After performing multi-imager calibration with the checkerboard as described above, it is possible to perform a refinement of the calibration by exploiting the output of the detection nodes.

This procedure requires one person to move throughout the entire area where tracking is to be performed.

In particular, in every PC attached to a sensor, the previously-saved launch file `detection_node_<sensor_id>.launch` should be run as follows:

    roslaunch detection detection_node_<sensor_id>.launch

Then, in the master PC, run:

    roslaunch opt_calibration opt_calibration_refinement.launch

At this point, it is requested that one person (**only one!**) move throughout the tracking area, performing different trajectories. People detections should appear in the visualizer. 

**N.B.:** If people detections are not seen, try to zoom out in the visualizer.

When the entire area has been covered (more than once), to start the calibration refinement algorithm, run:

    rostopic pub /opt_calibration/action std_msgs/String "save" -1

The optimization will start, and the refinement matrices will be saved in `registration_<sensor_id>.txt` files in the `opt_calibration/conf` folder. Moreover, a visualizer showing people detections before and after the refinement process should be displayed.

In order to use this refinement at tracking time, be sure that the `calibration_refinement` flag in the `tracking/conf` folder is set to `true`.

See the Deployment Guide [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Calibration-Refinement-(Person-Based)) for additional information. 

Experts can find instructions for manual calibration refinement [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Multi-Imager-Calibration-Refinement-(Manual))


## 4. Check Calibration Refinement - _Optional_

This node is particularly useful for you to check the calibration refinement ([person-based](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration#3-perform-multi-imager-calibration-refinementperson-based---optional) or [manual](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Multi-Imager-Calibration-Refinement-(Manual))). 

    <start OPTv2 (tracker and detection_nodes)>
    roslaunch opt_utils cloud_refinement.launch
    Open RViz and displays the clouds (you should display the <cloud_name>_refined ones)

## 5. Maintain Ground Plane - _Optional_ 

*Perform a new calibration maintaining the previously estimated floor.*

Once a multi-sensor calibration has been performed, a new one can be performed keeping the previously estimated floor as the world reference frame. (There is no need to put the checkerboard on the floor again.) To perform the calibration while keeping the previously estimated floor, do not run:

    roslaunch opt_calibration opt_calibration_master.launch

Instead, on the master PC, run:

    roslaunch opt_calibration opt_calibration_master.launch lock_world_frame:=true fixed_sensor_id:=<sensor_id>

Here `lock_world_frame:=true` informs the calibration procedure to read the previously estimated camera poses, while `fixed_sensor_id:=<sensor_id>` defines the sensor that has not been moved since the previous calibration.

**N.B.:** At least one sensor, `fixed_sensor_id`, must be kept fixed. All the others can be moved or removed, and new sensors can be added.
 
## 6. Define new reference frame for tracking - _Optional_

When performing the calibration of an OpenPTrack network, the tracking reference frame (`world`) is set based on the last position where the checkerboard is seen.
If you want to specify a different reference frame to which tracks should refer, after the standard calibration procedure, you should launch all the sensors with:

    roslaunch opt_calibration sensor_<sensor_id>.launch

And then, on the master node:

    roslaunch opt_calibration opt_define_reference_frame.launch

A GUI (image) appears, where you have to select two reference points and provide their X and Y coordinates in the NEW reference frame. You can follow the instructions in the console output.

In particular:

- _left click_: select a reference point (then you will be asked to input X and Y coordinates from the console [press ENTER after every input])

- _right click_: change image (you can change image until you find the image where you see the reference point you want to insert)

- _middle click_: compute the new reference frame and save. Do this only after you inserted two (or more) reference points. There is no need to select both reference points from the same image.

After this procedure, you need (as usual) to run the `detection_initializer.launch`, as described [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration#2-create-files-for-multi-sensor-people-tracking).
Then, you can do tracking in the new reference frame.

**N.B.:** The user-defined reference frame must adhere to the convention that the Z axis should point upwards.
Thus, be aware to choose X and Y directions so that Z points upwards according to the [right-hand rule](http://en.wikipedia.org/wiki/Right-hand_rule).