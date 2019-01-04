### Kinect Cannot Be Found

If your Kinect cannot be detected, try to download older versions of the drivers ([libopenni-sensor-primesense-dev](https://launchpad.net/~v-launchpad-jochen-sprickerhof-de/+archive/ubuntu/pcl/+build/5252450/+files/libopenni-sensor-primesense-dev_5.1.0.41-3%2Btrusty1_amd64.deb) and [libopenni-sensor-primesense0](https://launchpad.net/~v-launchpad-jochen-sprickerhof-de/+archive/ubuntu/pcl/+build/5252450/+files/libopenni-sensor-primesense0_5.1.0.41-3%2Btrusty1_amd64.deb)) and install them manually:

    cd ~/Downloads
    sudo dpkg -i libopenni-sensor-primesense*


If this does not fix the problem, you can try to use the `freenect` driver instead of `openni`.
Both `openni` and `freenect` are installed together with OpenPTrack, but `openni` is selected by default. If `openni` does not work (this happens in rare occasions) or neither driver can open the Kinect, it may be necessary to do the following:

Add the following lines to `/lib/udev/rules.d/40-libopenni-sensor-primesense0.rules`:

    #--avin mod--Kinect
    SUBSYSTEM=="usb", ATTR{idProduct}=="02ae", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="video" 
    SUBSYSTEM=="usb", ATTR{idProduct}=="02ad", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="audio" 
    SUBSYSTEM=="usb", ATTR{idProduct}=="02b0", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="video" 
    SUBSYSTEM=="usb", ATTR{idProduct}=="02be", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="audio" 
    SUBSYSTEM=="usb", ATTR{idProduct}=="02bf", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="video" 
    SUBSYSTEM=="usb", ATTR{idProduct}=="02c2", ATTR{idVendor}=="045e", MODE:="0666", OWNER:="root", GROUP:="video" 

Then, change the `$KINECT_DRIVER` system variable to `freenect`. To do this, open the `.bashrc` file in your home directory:

     gedit ~/.bashrc

And make sure it says `KINECT_DRIVER=freenect`

After changing the Kinect driver to `freenect`:

     source ~/.bashrc

And restart the calibration or detection process. 

### Poor Detection 

Whether there are too many spurious detections or not enough, the first step is to calibrate the thresholds for detection. This must be done per node, and recommended per class of sensor (e.g., just Kinects, then just Mesa Imagers, then just Stereo Cameras).

The most significant parameter is `min_confidence_initialization`, for both tracker and detection. In each of the following files, a specific parameter to modify if specified:

`tracking/conf/tracker_multicamera.yaml`: modify the parameter:

     min_confidence_initialization: 4.0

`detection/conf/ground_based_people_detector.yaml`: modify the parameter: 

     ground_based_people_detection_min_confidence -1.75

`detection/conf/haar_disp_ada_detector.yaml`: modify the parameter:

     haar_disp_ada_min_confidence = 2.0

**N.B.:** Each sensor may need its own thresholds based on the installation: angle, lighting, interference from other Kinects, etc. 

It may help to see each sensor’s detection individually. To inspect each sensor, in the Rviz visualization software, a `topic` can be added:

    rostopic hz /<camera_name>/ground_based_people_detector_<camera_name>/detections


### Poor Calibration

A few different issues with the checkerboard can cause poor detection:

* The checkerboard should be rigid, or transformations between cameras may be estimated incorrectly, i.e., the checkerboad can bend.
* The checkerboard should have an even number of squares in one direction and an odd number of squares in the other direction, or the checkerboard position may be flipped by the algorithm.
* The checkerboad was in motion when an imager detected it.
* The checkerboad was detected with too much of an angle to a sensor. The checkerboad should be as parallel as possible to an imager.

### Significant Splitting (Two IDs for One Person)

We are working to make this problem rare, but it can still occur. It is caused primarily by calibration error. Calibration error is itself caused by 1) error in the Kinect's depth estimation, which can be reduced by limiting the usable range and performing calibration refinement, or 2) significant clock drift across machines, most easily seen as large sync offsets across peers reported by [NTP](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization). In the Kinect 1, the error in depth estimation increases quadratically with the distance from the sensor (as for stereo cameras). Thus, doubling occurs when detections are far from one (or more) of the cameras. There are three ways to mitigate this.

### 1. Time Synchronization: 
The most likely culprit of "splitting" is the NTP `offset` being more than 10ms +/- off across the system or on a peer or peers. If this is the case, first verify you have followed the [Time Synchronization](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization) instructions. If you have verified these settings are correct, restart NTP and allow the system times to converge below 10ms offset by:

     sudo service NTP restart

Then, after a few minutes, check the `offset` until is has converged:

     ntpq -p

### 2. Imager Sensing Distance:

One can simply clip the offending sensor, and then not let it detect past the range of good detections, by reducing the `max_distance` in one of the `open_ptrack/detection/conf` files, such as in [ground_based_people_detector_kinect2.yaml](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/detection/conf/ground_based_people_detector_kinect2.yaml).

Kinect v1's `max_distance` should not be greater than 5.0.
SwissRanger's  `max_distance` should not be greater than 8.0.
Kinect v2's `max_distance` should not be greater than 10.0.

To clip a problem sensor, reduce the `max_distance` until the splitting has been resolved. 

### 3. Kalman Filer:

The third (and least effective) way to reduce splitting is by tuning the Kalman filter. This will assist OpenPTrack take detections belonging to the same person per imager, even if the detections are not in the same location, and merge them to a single person. In the `tracking/conf/tracker_multicamera.yaml`:
 
* Increase `acceleration_variance` to something between 200 or 500.
* Decrease `gate_distance_probability` to something around 0.9.

These values depend on your particular scenario. Thus, it is difficult to tell the best value. Also, changing these parameters this way could have a side effect, that people close to each other are merged to the same track. Hopefully, you won't have to do this! But just in case... 

### Mesa SwissRanger 

The SwissRangers often "forget" their IP adress, or lock up and cannot be detected by the OpenPTrack system. If you don’t know the IP of the SwissRanger, but you do know the subnet, try scanning the subnet to find the correct IP address:

    sudo nmap -v -sP 192.168.1.0/24

And you’ll see something similar to:

    Nmap scan report for 192.168.1.40 [host down]
    Nmap scan report for 192.168.1.41 [host down]
    Nmap scan report for 192.168.1.42
    Host is up (0.00028s latency).
    MAC Address: 00:1C:8D:00:0B:53 (Mesa Imaging)

This means that your SwissRanger is now on the IP address `192.168.1.42`.

If the SwissRanger cannot be found by scanning the subnet, reset your SwissRanger to the default IP address `192.168.1.42`. 

    unplug power
    unplug ethernet
    plug in power
    wait 45 seconds
    plug in ethernet

Your SwissRanger should now be set to an IP of `192.168.1.42`. Verify this by `pinging` your SwissRanger:

     ping 192.168.1.42

