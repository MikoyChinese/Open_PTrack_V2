### Drag and Drop Tool for Face Recognition
The Face Detection and Recognition module comes with a drag-and-drop people registration tool for predefined people recognition. To use this tool run:

`rosrun recognition drag_and_drop.py`



### Topics
The following topics are available: 

  /face_recognition/people_tracks                                                                                                                                                                
  /face_recognition/people_names

people_tracks contains tracked people. The data are same as /tracker/people_tracks except that people IDs are replaced according to face recognition results. If a person ID is larger than 10000, it means that his/her face has not been recognized by the system yet.

people_names is the result of predefined people recognition. It contains associations between people IDs and predefined people names.

See [here next](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Multi-Sensor-Face-Detection-and-Recognition) for guidelines on running Face Detection and Recognition in a Multi-Sensor configuration