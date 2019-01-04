For a Multi-Sensor configuration, take the following steps to get face detection and recognition running:

* Run the person tracking and detection nodes.  

* For every sensor, launch the face detection and feature extraction nodes:

   `roslaunch recognition face_detection_and_feature_extraction.launch sensor_name:="<sensor>"`

* Then, start the face recognition node on the master PC.

   `rosrun recognition face_recognition_node`

* To visualize, run recognition_visualization_node:

   `rosrun recognition recognition_visualization_node.py`

![](https://github.com/OpenPTrack/open_ptrack_v2/blob/docker/images/image.png)