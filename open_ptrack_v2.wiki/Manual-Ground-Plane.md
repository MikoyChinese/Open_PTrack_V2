We have found that in some environments, specifically spaces with reflective or dark-colored floors, the automatic ground plane will not accurately detect the ground. This leads to sparse tracking; the tracks will not be consistent, or there will be no detection or tracks at all. To correct this, the ground plane detection needs to be changed from automatic to manual selection. To do this for each sensor, `ground_based_people_detector_kinect2.yaml` or `ground_based_people_detector_kinect2.yaml`, [change line 5](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/detection/conf/ground_based_people_detector_kinect2.yaml#L5) from:

     ground_estimation_mode: 3

to:

     ground_estimation_mode: 0

Once this change has been saved to the .yaml file, stop the detection process for the sensor, and then restart it. Once the sensor is restarted, the manual ground plane selection window (titled "Pick three points") should appear after a few moments. If you are connecting remotely via SSH and do not see the window, check that you're using the -XC flag to start SSH with X11 GUI forwarding enabled, e.g., ssh -XC 192.168.100.101. If everything is working properly, a screen like the following should appear:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Select%20Three%20Points.png)

**N.B.:** In tracking environments with dark floors, when starting a Kinect v2 camera, we have found it necessary to place a large, flat white object on the floor to create a surface from which the three points can be chosen. This is the white square in the image above.

After the screen appears, it is possible to zoom into the space from where the three points will be selected. This can be done by using the center wheel on the mouse

**N.B.:** We have found that after zooming in on the spot that will be used to select the three points, the image should be articulated in a way that verifies all pixels are in the ground plane.

Now, use the `left mouse button` to select the three points. It should look similar to this:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Three%20points%20selected.png)

Next, press the `shift` key while moving your cursor over the three points selected . This saves the `manual ground plane`. The screen then grays out and looks like this:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Grayed%20Out.png)

The screen can now be minimized, and the ground plane that was selected will be used for the sensor's detection.

N.B.: If the shift key is inadvertently pressed before the three points are selected, the detection process has to be restarted. In some cases, if the process is not done properly, the terminal window will show an error that looks like this:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/Ground%20plane%20not%20properly%20selected.png)

In  such cases restart the detection process and reselect the three points. 

After a sensor restart, to reuse the ground plane that was selected, a few changes need to be made to the `ground_based_people_detector_kinect2.yaml` or `ground_based_people_detector_kinect1.yaml`, depending on the sensor(s) being used. First change [read from ground file](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/detection/conf/ground_based_people_detector_kinect2.yaml#L9) to true:

     read_ground_from_file: true

Lastly, change [lock ground](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/detection/conf/ground_based_people_detector_kinect2.yaml#L11) to true:

     lock_ground: false

If a camera is moved, then the following:

     read_ground_from_file: true

needs to be returned to:

     read_ground_from_file: false

This will allow the ground plane to be reset manually by the user.