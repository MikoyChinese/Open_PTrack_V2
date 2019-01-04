The ROS Tool RViz makes it easy to view a variety of different internal data available in OpenPTrack.   

# Using RViz

Review the RViz manual here for information on its basic operation: http://wiki.ros.org/rviz/UserGuide 

To add topics using the most appropriate visual display, click on Add > By Topic and then select the topic desired. 

## GETTING STARTED WITH VIEWING

To add **any** topic to Rviz start by clicking the add button on the bottom left of the Rviz screen:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-46-10.png?raw=true)

Then in the window that appears, select the **By Topic** tab:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-46-19.png)

These first two steps are the same for the rest of the topics that follow:

### Skeletons (/tracker/skeleton_markers_array):

In the By Topic Tab, scroll down and look for the header **tracker** and the sub-group **skeleton_markers_array**. Now select the MarkerArray under this header. Lastly select Okay to add this topic to Rviz:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-50-43.png)

### Object/Props Identification (/tracker/object_markers_array_smoothed) [i.e. seeing the object marker with its name defined in the object training GUI]

In the By Topic Tab, scroll down and look for the header **tracker** and the sub-group **object_markers_array_smoothed**. Now select the MarkerArray under this header. Lastly select Okay to add this topic to Rviz:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-51-39.png?raw=true)

### Object/Props History (/tracker/object_history ) [this is the line that shows were an object was]

In the By Topic Tab, scroll down and look for the header **tracker** and the sub-group **object_history**. Now select the PointCloud2 under this header. Lastly select Okay to add this topic to Rviz:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/object%20tracking.png?raw=true)


### Trained Poses (/recognizer/markers)

In the By Topic Tab, scroll down and look for the header **recognizer** and the sub-group **markers**. Now select the MarkerArray under this header. Lastly select Okay to add this topic to Rviz:

I made a mistake, and did not take the correct screenshot for this, but if you have gotten this far you should be able to find this topic :) 

# Visualizing the World
* **/opt_calibration/markers** - Calibration markers (camera position?)
* origin? 

# Visualizing Imager Data (Kinect 2) 
* **/<sensor_name>/depth_ir/points** - Point cloud per image
* RGB image? 
* camera position? 

# Visualizing Person Tracking Data
* **/tracker/tracks_smoothed** - Person tracks, smoothed (as reported in UDB)
* **/tracker/alive_ids** - IDs of tracks considered alive
* **/tracker/history_smoothed** - Historical trail of person tracks
* **/tracker/markers_array_smoothed** - ??
* **/detector/detections** - Raw detections (per detection node)
* **/tracker/markers** - See below 

# Visualizing Object Tracking Data
* **/tracker/object_markers_array_smoothed** - Object tracks, smoothed (as reported in UDP)
* **/tracker/object_history** - Path history of objects
* Object ids? 

# Visualizing Pose Recognition Data
* **/tracker/skeleton_markers_array** - Raw skeletons
* **/recognizer/markers** - Recognized poses
* Pose id? 

# Visualizing Detections (per-camera)
Eventually should be part of the section above on person tracking
1. Select: Add (bottom left of Rviz)
2. Under the “By display type tab” in the popup window, select “MarkerArray”
3. Then within the topic (where it is shown on the left hand side in Rviz), make sure the topic is expanded and open the dropdown “Marker Topic”
4. Within this dropdown select “/tracker/markers_array_smoothed”
5. Then have someone walk around the space
    1. while this is happening under the MarkerArray topic, expand the dropdown Namespace
    2. within this you should see each of the cameras that has tracker during the entire time Rviz has been running, not only the cameras that are currently tracking.
    3. while the person is walking around the space you should see multiple balls representing the person in rviz. 
    4. within the Namespaces you can toggle each camera on and off. By toggling the different cameras on and off you can determine what cameras are tacking a person
 
This is a slow tedious process.

