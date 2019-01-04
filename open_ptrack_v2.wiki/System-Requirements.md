## Overview of an OpenPTrack System's Components

When setting up an OpenPTrack system, you will need, at a minimum, an imager and a computer to connect to this imager. However, to take full advantage of OpenPTrack's features, multiple imagers with Nvidia CUDA graphics cards are needed, as is consumer-grade networking equipment. For example, the hardware required for an OpenPTrack system with three Kinect V2s that can run **person tracking, object tracking, and pose annotation, and can utilize YOLO**:

* (3) - Computers with i7 Intel processors;
* (3) - Nvidia 1070 or 1080 graphic processors (for pose annotation), or other NVidia GPUs for Kinect V2 integration;
* (3) - Microsoft Kinect V2;
* (1) - Router;
* (1) - Networking Switch (if needed).

This is in addition to any interconnects needed such as Cat 5e/6 cables, power cabling, etc. 

A person and object tracking system would be similar to the system outlined above, but the GPU requirements are less constrained. Any Nvidia GPU with an architecture of **870** or above will suffice for person and object tracking. 