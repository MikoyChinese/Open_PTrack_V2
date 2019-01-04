**This Module is an Early Adopter Version. Development is ongoing!**

This module performs face recognition-based person re-identification to keep track of people's identities even if they move out from the camera's field of view once.

Face detection and recognition is used primarily for ID stability, and also to identify when particular actors are in a scene. Firstly, this is done by assigning ANY face a stable_id and annotating tracks with it. Applications can check for stable_id and use that instead of id to get more reliable tracking of the same individual over time. This provides stability in one session. 

Furthermore using the drag and drop tool discussed [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Parameters), it is possible to train the module with templates of existing faces. Therefore, if a face is recognized to match an existing template, the track will also be labeled with a user-provided face_name, enabling the consumer to “know who” is being  tracked.  This *will* work across sessions. 

1. [Single Camera](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Single-Camera)
2. [Setting Parameters](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Parameters)
3. [Multi Sensor Face Detection and Recognition](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Multi-Sensor-Face-Detection-and-Recognition)
4. [Face Detection and Recognition Data Format](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Face-Detection-and-Recognition-Data-Format)

In order to use this module, in addition to the [basic OpenPTrack package](https://github.com/OpenPTrack/open_ptrack_v2/wiki/OpenPTrack-v2-Modules#base), you must have the following dependencies:

- [OpenFace](https://cmusatyalab.github.io/openface/) >= 0.2.1
- [dlib](http://dlib.net/) >= 19.4
- [torch7](http://torch.ch/)

A script to manually install these dependencies is found [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/OpenPTrack-v2-Modules#openface-dependencies) in the installation section. The script installs OpenFace and dlib on your python environment, installs torch to ~/torch, and downloads face model files from OpenFace and dlib projects.

**N.B.** If you installed OpenPTrack using the [Docker Images](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images), OpenFace dependencies are already preinstalled. 