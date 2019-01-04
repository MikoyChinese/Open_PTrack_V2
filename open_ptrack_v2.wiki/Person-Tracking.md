## 1. Perform multi-sensor people tracking.

First, **Ctrl-c** to quit all `roslaunch opt_calibration sensor_[name].launch` per node. 

**N.B.:** Repeated sensor starts can hang in memory. It is occasionally necessary to [restart all processes](https://github.com/OpenPTrack/open_ptrack/wiki/Tips-and-Tricks#quit-a-process) or simply reboot host.

Once multi-sensor calibration has been performed, multi-sensor people tracking can be launched by simply running a detection node for every sensor and a tracking node in the master PC.

In particular, in the master PC, run:

    roslaunch tracking tracking_node.launch

The above publishes calibration data, performs tracking, and opens Rviz in order to track results. And in every PC attached to a sensor, the launch file `detection_node_<sensor_id>.launch` saved previously should be run as follows:

    roslaunch detection detection_node_<sensor_id>.launch

After running the tracking node, Rviz is opened, people positions are plotted in the global reference frame (`/world`), and camera reference frames are shown. No people detection output is shown in order to avoid transmitting images over the network.

**N.B.:** While running multi-sensor tracking based on multi-sensor extrinsic calibration, the `extrinsic_calibration` flag in `tracking/conf/tracker_multisensor.yaml` must be set to true. If set to false, the camera reference frame is used as a global reference frame, and no extrinsic calibration information is used.
All parameters used for tracking are in `tracking/conf/tracker_multicamera.yaml`.

**N.B.2:** It is important that all PCs are synchronized in time. The Internet can be used to update clock information. Future work includes implementation of an alternative option for synchronization. If the PCs are not synchronized in time, an error will appear in the tracking command line, such as:

    [ERROR] [1396947072.332131826]: transform exception: Lookup would require extrapolation into the past.

## 1.1. Real Time Imager Parameter Adjustment. 

This will allow you to change the sensitivity parameters for each unique imager in your network. Best practices for this process can be found in the Deployment Guide's [Imager Settings](https://github.com/OpenPTrack/open_ptrack/wiki/Imager-Settings) page.

To enable/disable this refinement in real time via dynamic reconfigure GUI, run:

    rosrun rqt_reconfigure rqt_reconfigure

And select the tracking node.


More information on the best practices can be found in the Deployment Guide's [Imager Settings](https://github.com/OpenPTrack/open_ptrack/wiki/Imager-Settings) page.