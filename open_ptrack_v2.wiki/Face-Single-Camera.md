To run face detection and recognition on a single camera, take the following steps:

* Ensure person tracking and detection is running. See [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Person-Single-Camera). 

* Next, launch the face detection and feature extraction nodes:

  `roslaunch recognition face_detection_and_feature_extraction.launch sensor_name:="kinect2_head"`

* Next start the face recognition node: 

  `rosrun recognition face_recognition_node`

* To visualize, run the recognition_visualization_node:

  `rosrun recognition recognition_visualization_node.py`

See [here next](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Parameters) for some available parameters in the Face Detection and Recognition module. 