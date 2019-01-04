# NOT FOR PUBLIC CONSUMPTION CURRENTLY VERY ROUGH DRAFT :)

## ROS TOPICS TO GET STARTED

To add **any** topic to Rviz start by clicking the add button on the bottom left of the Rviz screen:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-46-10.png?raw=true)

Then in the window that appears, select the **By Topic** tab:

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/master/images/Screenshot%20from%202017-09-26%2021-46-19.png)

These first two steps are the same for the rest of the topics that follow:

### Skeletons (/tracker/skeleton_marker_array):

In the By Topic Tab, scroll down and look for the header **tracker** and the sub-group **skeletons_marker_array**. Now select the MarkerArray under this header. Lastly select Okay to add this topic to Rviz:

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