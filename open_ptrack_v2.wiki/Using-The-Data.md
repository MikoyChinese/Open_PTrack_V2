## UDP track data format 

When OpenPTrack is detecting and tracking people, objects, or poses it produces JSON `tracks` and distributes them via UDP to the port and IP address listed in the configuration file `opt_utils/conf/json_udp.yaml`. In addition to unicast behavior, broadcast or multicast can be configured in [json_udp.yaml](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/opt_utils/conf/json_udp.yaml).   Note that this file **must** be configured for your network for UDP output to be received on your client machine(s).  (Also note that using multicast is not recommended unless you are familiar with how to configure and troubleshoot it.) 

### Person Tracking Data Format
Each track update is published in a single UDP message with three possible payloads. One for person tracking, one for object tracking, and one for pose annotations. The following example is of a person tracking JSON message:

```json 
{
    "header": {
        "seq": 71251,
        "stamp": {
            "sec": 1415305737,
            "nsec": 110138944
        },
        "frame_id": "world"
    },
    "tracks": [{
        "id": 387,
        "x": -0.89131,
        "y": 2.41851,
        "height": 1.55837,
        "age": 29.471,
        "confidence": 0.0500193
    }]
}
```

 - Units for x, y, and height are meters, which is true across all three JSON message types. 
 - ID is the unique identification associated with the track.
 - Age is how long that ID has been active for.
 - Confidence represents the system's calculation of how reliable the track is.


### Object Tracking Data Format
This is an example of object tracking's data format:

```json
{
    "header": {
        "seq": 71251,
        "stamp": {
            "sec": 1415305737,
            "nsec": 110138944
        },
        "frame_id": "world"
    },
    "object_tracks": [{
        "id": 387,
        "object_name": "ball_red",
        "x": -0.89131,
        "y": 2.41851,
        "height": 1.55837,
        "age": 29.471,
        "confidence": 0.0500193
    }]
}
``` 

 - ID is again the unique identifier for this specific track.
 - Object name represents the name associated to the object being tracking by the user in the MOT GUI.
 - Units for x, y, and height are meters, which is true across all three JSON message types.
 - Confidence represents the system's calculation of how reliable the track is.

### Pose Annotation Data Format
Lastly, this is an example of the pose annotation's data format: 

```json
{
   "header":{
      "seq":71251,
      "stamp":{
         "sec":1415305737,
         "nsec":110138944
      },
      "frame_id":"world"
   },
   "persons":
   [
      {
         "id": 3,
         "height":1.50029,
         "orientation":2.4570,
         "age":29.471,
         "predicted_pose_name":"RIGHT_ARM_UP",
         "predicted_pose_id": 2,
         "prediction_score":0.988,
         "poses":
         [
            {
               "pose_name": "RIGHT_ARM_UP", 
               "pose_id": 2, 
               "prediction_score": 0.988 
            },
            {
               "prediction": "ARMS_UP", 
               "class_id": 1,
               "confidence": 0.7 
            }
         ],
         "joints":
         {
            "model":"rtpose_MPI",
            "HEAD":{
               "x":0.112,
               "y":0.112,
               "z":0.112,
               "confidence":0.8971
            },
            "NECK":{
 
            },
            "RSHOULDER":{
 
            },
            "RELBOW":{
 
            },
            "RWRIST":{
 
            },
            "LSHOULDER":{
 
            },
            "LELBOW":{
 
            },
            "LWRIST":{
 
            },
            "RHIP":{
 
            },
            "RKNEE":{
 
            },
            "RANKLE":{
 
            },
            "LHIP":{
 
            },
            "LKNEE":{
 
            },
            "LANKLE":{
 
            },
            "CHEST":{
 
            }
         }
      }]
} 
```

 - ID is again the unique identifier for this specific track.
 - Orientation is an estimation of where the person being tracked is facing in relation to OpenPTrack's 0,0 coordinate. 
 - predicted_pose_name and pose_name represent the name associated to the object being tracking by the user during pose training.
 - Units for x, y, z, and height are meters, which is true across all three JSON message types.
 - predicted_pose_id and pose_id is the index number of the pose. This number is calculated starting at 0, which is the first training pose. Each new trained pose will be ordinal. 
 - prediction_score represent the system's calculation of how confident it is that the person being tracked is making the prose represented in pose_name and pose_id
 - Then each of the 'joint' will have an x,y, and z score which is used to determine the pose.


### If  you are trying out face recognition, see [this page](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Detection-and-Recognition-Data-Format) for more information  on the data format. 


### Tracking Data Format Tools

To view JSON tracking data on the host that is running the tracking process (generally, the master):

    roslaunch opt_utils udp_listener.launch

The published rate defaults to 30 hz, but can be customized to suit your application by editing the `rate` 
parameter in [tracking/conf/moving_average_filter.yaml](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/moving_average_filter.yaml#L5). UDP will then be published at an interval of your choosing. 

Below, we have included code samples that demonstrate how to use this in various environments. If you want more detail about track lifetime, see `track format detail` below.

If you need a *simulator* for OpenPTrack data, here is a start in Python: [docs/assets/optsimulate.py](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/optsimulate.py), as well as a simple data receiver: [docs/assets/optreceiver.py](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/optreceiver.py). Feel free to improve and submit pull requests for such samples! 

### Receiving UDP data in Python

Please see [docs/assets/udp_example.py](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/udp_example.py) for a basic example of using Python to receive and parse OpenPTrack JSON data. 

A simpler receiver example is also in [docs/assets/optreceiver.py](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/optreceiver.py).

### Receiving UDP data in Node.js

Please see [docs/assets/node-ptrack.js](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/node-ptrack.js) for a basic example of using Node.js. All parsing is done in the client. 

### Receiving UDP data in Max/MSP

Please see [docs/assets/max](https://github.com/OpenPTrack/open_ptrack/tree/master/docs/assets/max) for an example of using OpenPTrack data in Cycling 74's Max/MSP. 

### Receiving UDP data in TouchDesigner

#### Option 1 - Use the Python and/or C++ objects

See the [operators](https://github.com/OpenPTrack/OPT_TouchDesignerComponents
) released in 2017 by Ian Shelanskey.

#### Option 2 - Simple approach with a Script DAT

One can use a `Script DAT` to receive data and populate a DAT, or similarly for CHOP. 

For an example of this in a drag-and-drop solution, use the touch component in [docs/assets/openPTrack.tox](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/openPTrack.tox).

It will publish an X, Y that is the average of all tracks. This can be modified as desired. 

### Receiving UDP data in Processing

Please see [docs/assets/p5_opt_udp.pde](https://github.com/OpenPTrack/open_ptrack/blob/master/docs/assets/p5_opt_udp.pde) for a basic example of using Processing to receive, parse, and plot OpenPTrack JSON track data. 

## Publishing and Receiving Data over Named Data Networking (NDN)

Please see [Ros 2 NDN publisher](https://github.com/OpenPTrack/ndn-opt/tree/master/publisher) for a ROS plugin to publish tracking data over NDN, as well as the [consumer](https://github.com/OpenPTrack/ndn-opt/tree/master/consumer) for receiving the tracking data. ([More Information about NDN.](http://named-data.net))

## Track Format Detail (incomplete) 

ID is the `person ID`. It does not wrap, and it has a 32 bit INT, so its maximum value is 2147483647. 

### Where does the ID come from?

There is a different behavior when a track has just been created (NEW). At first, a track is defined as NEW for `sec_remain_new` seconds:
[sec_remain_new](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_multicamera.yaml#L57).

During this period, a NEW track can be validated (and become NORMAL) if it gets at least `detections_to_validate` detections in `sec_before_fake` seconds:
[detections_to_validate](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_multicamera.yaml#L59) and [sec_before_fake](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_multicamera.yaml#L55).

If a track does not become NORMAL within `sec_remain_new` seconds, it is deleted. Once a track is NORMAL, it can be removed only if no detections are associated with it for `sec_before_old" seconds`.

### Where does the ID go when a person exits the system? 

In general, an ID (track) is removed, and then no detections are associated with it for `sec_before_old` seconds.
The `sec_before_old` parameter can be changed here:
[sec_before_old](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_multicamera.yaml#L53).

### What about `tracking filter` topic ?

UDP data are also subject to the `tracking filter` node, which adds a further parameter on top, that is `track_lifetime_with_no_detections`:
[track_lifetime_with_no_detections](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/tracking/conf/tracker_filter.yaml#L7).

With this parameter, you can choose how long you want to see `not visible` tracks in the UDP data (`not visible` means with no detection associated at the current frame). If a track is not visible, what is published is its predicted position.

This parameter does not influence tracking, but only UDP data. Tracking can still continue to estimate where a person should be for `sec_before_old` seconds (hoping to find it again), but you may want to remove tracks that are not visible for more than `track_lifetime_with_no_detections` from visualization and the UDP data.