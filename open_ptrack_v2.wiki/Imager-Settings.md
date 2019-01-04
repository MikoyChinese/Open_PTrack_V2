# Imager Settings

This section covers basic real-time parameter changes that we have found to be the most effective in resolving spurious tracks, making a single imager more sensitive, or making an entire OpenPTrack system more sensitive to detecting and tracking people. 

Now that your camera network is calibrated, all sensors share the same coordinate space. You can now focus on configuring each camera's detection process, in order for them to contribute robust detections to the tracking process. First, you can tune the parameters as needed.
 
The default detection parameters will almost always work well enough to get detection and tracking working, yet for OpenPTrack to work as well as possible, the parameters will require customization for your space and network.

Each camera has a range of parameters in both of the following: 

    $ROSHOME/open_ptrack/detection/conf/ground_based_people_detector*.yaml. 

and

    haar_disp_ada_detector.yaml. 

While there are a lot of parameters, two make the largest difference in changing the sensitivity of detection and tracking. First, for the original Kinect, as seen in: 

    ground_based_people_detector_kinect1.yaml

And, for the Kinect v2, as seen in:

    ground_based_people_detector_kinect2.yaml

is the parameter found in the above files:

    ground_based_people_detection_min_confidence: -1.75

Making it smaller (-2, 0, 1, etc) makes it more sensitive to people. If it is too small, it will create false detections.

The correct setting is one that generates dense/consistent detections when someone is in the space and no detections whatsoever when the space is unoccupied. 

The second parameter that changes the sensitivity of detection is in the file `tracker_multicamera.yam`, which can be found in `\open_ptrack\tracking\conf`. Changing the parameter:

    min_confidence_initialization: 4.0  

will make the system overall more sensitive. The lower the value the more sensitive the detection will be.

Rather than having to change the config file and restart the sensor to see the result, to ‘explore’ and change these parameters in real time:
 
    rosrun rqt_reconfigure rqt_reconfigure

In this way, you can change the detection settings interactively, while someone is walking in the space. Typically, someone will walk in a sensor’s field of view, as another person is watching for detections while altering the parameter. 

**N.B.:** Changes in this GUI are not saved; they must be manually updated in the appropriate file per host and sensor.

## Kinect v2 Notes

**Background Subtraction**

When using background subtraction with a Kinect v2 in the `ground_based_people_detector_kinect2.yaml`, the noise filtering setting also needs to be set to true:

    # Denoising flag. If true, a statistical filter is applied to the point cloud to remove noise:
    apply_denoising: true

This allows the background subtraction process to utilize the noise filtering process. It will remove any "flying pixels" in the space, thus allowing background subtraction to function without reducing detection and tracking sensitivity.