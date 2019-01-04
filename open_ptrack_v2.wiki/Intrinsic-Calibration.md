This page reviews how to calibrate a Kinect v1, Kinect v2, or Mesa SwissRanger intrinsically. This process will allow OpenPTrack to correct for any inconsistencies that were introduced during the manufacturing process.
 
_Completing this process for each imager before moving on to [Camera Network Calibration](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Camera-Network-Calibration) is highly recommended to produce the best tracking results._

## Single Kinect v1 (Intrinsic Calibration)

This section describes how to calibrate a single Kinect v1 intrinsically. The information will be used by the OpenPTrack master to determine distortion of the Kinect v1, and this should be done to each Kinect v1 in your OpenPTrack network.

Intrinsic camera calibration of a single Kinect can be performed with [ROS](http://ros.org) package [camera_calibration](http://wiki.ros.org/camera_calibration).

Calibration requires moving a rigid checkerboard pattern in front of the camera, as suggested by the GUI, until calibration is complete. The checkerboard must be moved and inclined in all directions until all GUI bars become green. Then, intrinsic parameters are computed by pressing the **Calibrate** button. And by pressing **Commit**, all parameters are saved to the `~/.ros/camera_info/` directory in the `rgb_<serial>.yaml` file, where `<serial>` is the serial number of the camera. This file is loaded whenever the OpenNI camera driver is launched from the computer attached to that camera, in order to use the estimated intrinsic parameters.

**N.B.:** For some Kinects, the driver cannot read the serial number. Therefore, the file created during the calibration is `rgb_00000000000000.yaml`.

### Example of usage:

After launching the camera driver:

    roslaunch detection openni.launch

Or (depending on which driver your system uses):

    roslaunch detection freenect.launch

In a separate terminal, run:

    rosrun camera_calibration cameracalibrator.py --size 6x5 --square 0.080 image:=/camera/rgb/image_color camera:=/camera/rgb 

For the above, 6x5 is the number of interior vertex points of the checkerboard (not the number of squares) in the two dimensions, and 0.080 is the dimension (in meters) of the squares. More information on calculating the row and col count can be found [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Checkerboard-Initialization-and-Configuration).

For a step-by-step tutorial on performing intrinsic calibration, please refer to [camera_calibrationTutorialsMonocularCalibration](http://wiki.ros.org/camera_calibration/Tutorials/MonocularCalibration).

**N.B.:** In order to avoid singularities in the automatic estimation of checkerboard orientation, use a checkerboard with an even number of squares in one direction and an odd number of squares in the other direction. The more numerous and bigger the squares, the better the calibration.

### Move calibration files to the OpenPTrack folder:

After a successful calibration (if the Kinect has a serial number), to move the calibration file to `opt_calibration/camera_info/rgb_<serial>.yaml`, run:

    roslaunch opt_calibration save_camera_info.launch with_serial:="true" serial:=<serial>

If unsuccessful, i.e., the driver does not acquire the serial number, run:

    roslaunch opt_calibration save_camera_info.launch with_serial:="false" camera_id:=<camera_id>

This way, the calibration file will be renamed as `rgb_<camera_id>.yaml` and moved to `opt_calibration/camera_info/`.

**N.B.:** `<camera_id>` must be the ID of the sensor as reported in `camera_network.yaml`.


### People tracking test with one Kinect and without extrinsic calibration:

After intrinsic calibration (above), with a Microsoft Kinect for Xbox 360 connected, run:

    roslaunch tracking detection_and_tracking.launch

Appearing will be an RGB image with people detections surrounded by white rectangles and an ROS visualizer displaying a top view of people centroids.

## Single SwissRanger (Intrinsic Calibration)

This section describes how to calibrate a single SwissRanger 4500 intrinsically. The information will be used by the OpenPTrack master to determine distortion of this SwissRanger 4500, and this should be done to each SwissRanger 4500 in your OpenPTrack network.

Intrinsic camera calibration of a single SwissRanger can be performed with [ROS](http://ros.org) package [camera_calibration](http://wiki.ros.org/camera_calibration).

Calibration requires moving a rigid checkerboard pattern in front of the camera, as suggested by the GUI, until calibration is complete. The checkerboard must be moved and inclined in all directions until all GUI bars become green. Then, intrinsic parameters are computed by pressing the **Calibrate** button. And by pressing **Commit**, all parameters are saved to a file and loaded whenever the driver is launched, in order to use the estimated intrinsic parameters.

### Example of usage:

You can perform the calibration by running:

    roslaunch opt_calibration sr4500_calibration.launch device_ip:=192.168.1.31 size:=5x6 square:=0.12 
    camera_id:=swiss_ranger

For the above:
* `192.168.1.31` is the IP address of the Swiss Ranger.
* `5x6` is the number of interior vertex points of the checkerboard (not the number of squares) in the two dimensions.
* `0.12` is the dimension (in meters) of the squares.
* `swiss_ranger` is the ID of the sensor as reported in `camera_network.yaml`.

After a successful calibration, the calibration file created is `opt_calibration/camera_info/<camera_id>.yaml`.

**N.B.:** In order to avoid singularities in the automatic estimation of checkerboard orientation, use a checkerboard with an even number of squares in one direction and an odd number of squares in the other direction. The more numerous and bigger the squares, the better the calibration.

## Single Kinect v2 (Intrinsic Calibration)

This section describes how to calibrate a single Kinect v2 intrinsically. The information will be used by the OpenPTrack master to determine distortion of this Kinect v2, and this should be done to each Kinect v2 in your OpenPTrack network.

**N.B.** You may have to execute the following code to run the Kinect v2 commands (you may receive an error when you run this code, but it can be ignored):

     cd ~/workspace/ros/catkin/devel/lib/kinect2_bridge
     sudo ./kinect2_bridge

**1. Create temporary folder for storing calibration images:**

     mkdir ~/tmp

**2. Launch Kinect v2 Imager:**

     roslaunch kinect2_bridge kinect2_bridge.launch

**3. Color Image Capture:**
 
     rosrun kinect2_calibration kinect2_calibration record color chess6x5x0.12 -color /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**N.B:** Be sure to insert the right checkerboard parameters in the string `chess6x5x0.12` when launching the executable. The first two numbers are of the horizontal and vertical chess intersections, while the third number is the size of a square in meters. This is valid for all the operations described in this guide.

**4. Move The Checkerboard:**
Move the checkerboard to different positions, angles, and distances from the sensor, ensuring that the
checkerboard is correctly detected. The checkerboard is being detected correctly when different colored lines overlay the checkerboard's image.

**5. End Color Image Capture:** Kill the color calibration process. The files are automatically saved to the `~/tmp/` folder.

**6. Calibrate Color:**

     rosrun kinect2_calibration kinect2_calibration calibrate color chess6x5x0.12 -color
     /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**7. Infrared Image Capture:**

     rosrun kinect2_calibration kinect2_calibration record ir chess6x5x0.12 -color
     /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**8. Move The Checkerboard:**
Move the checkerboard to different positions, angles, and distances from the sensor, ensuring that the
checkerboard is correctly detected. The checkerboard is being detected correctly when different colored lines overlay the checkerboard's image.

**9. End Infrared Image capture:** Kill the color calibration process. The files are automatically saved to the `~/tmp/` folder.

**10.  Calibrate IR:**

     rosrun kinect2_calibration kinect2_calibration calibrate ir chess6x5x0.12 -color /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**11. Calibrate Poses Between IR and Color:**

     rosrun kinect2_calibration kinect2_calibration record sync chess6x5x0.12 -color /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**12. Move the Checkerboard:** Move the checkerboard to different positions, angles, and distances from the sensor, making sure that the checkerboard is correctly detected in both color and IR images (that is, in both, the colored lines overlay the checkerboard image). When the checkerboard is detected, images are automatically saved every second to the destination folder `~/tmp/`.

**13. Color-IR Calibration:**

     rosrun kinect2_calibration kinect2_calibration calibrate sync chess6x5x0.12 -color /kinect2_head/mono/image -ir /kinect2_head/ir/image -interval 1 ~/tmp/

**14. Move Calibration Files to the Correct Location:**

Create the folder that contains Kinect 2 calibration data:

     roscd kinect2_bridge
     mkdir -p data/<serial>

The `serial` is the serial number of the Kinect 2 sensor. You can read it in the console output after launching the driver:
     
     roslaunch kinect2_bridge kinect2_bridge.launch

At startup, you should see a line similar to this one:

     [Freenect2Impl] found valid Kinect v2 @4:3 with serial 500258141742

Copy calibration results from the temporary folder to this folder:

     cp ~/tmp/calib_color.yaml ~/tmp/calib_ir.yaml ~/tmp/calib_pose.yaml ~/workspace/ros/catkin/src/iai_kinect2/kinect2_bridge/data/<serial>/

**15.  Verify the Calibration:**

     rosrun rviz rivz

Now, in Rviz, change the Fixed Frame to:

     kinect2_head_rgb_optical_frame

And change the Topic to:

     /kinect2_head/depth_lowres/points

Now, the color data and the depth points (the point cloud) should be aligned. If they are not, your intrinsic calibration was **not** successful, and it will need to be redone.  