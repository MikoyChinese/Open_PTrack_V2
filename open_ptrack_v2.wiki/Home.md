# About OpenPTrack v2

[OpenPTrack](http://openptrack.org/) is an open source project launched in 2013 to create a scalable, multi-camera solution for person tracking, to support applications in _education, art and culture_.

**This wiki refers to the v2 "Gnocchi release".**

Our objective is to enable “creative coders” to create body-based interfaces for large groups of people&mdash;for classrooms, art projects and beyond.

Based on the widely used, open source Robot Operating System ([ROS](http://www.ros.org/)), OpenPTrack provides:
* user-friendly camera network **calibration**;
* **person detection** from RGB/infrared/depth images;
* efficient **multi-person tracking**;
* object tracking from RGB and depth images;
* reliable **multiple-object tracking**; and
* multi-camera and **multi-person** pose annotation. 
* UDP and [NDN](http://named-data.net/) streaming of tracking data in JSON format.

With the advent of commercially available consumer depth sensors, and continued efforts in computer vision research to improve multi-modal image and point cloud processing, robust person tracking with the stability and responsiveness necessary to drive interactive applications is now possible at low cost. But the results of the research are not easy to use for application developers.

**We believe that a disruptive project is needed for artists, creators and educators to work with robust real-time person tracking in real-world projects.** OpenPTrack aims to support those in the arts and cultural and education sectors who wish to experiment with real-time person & object tracking along with pose annotation, as an input for their applications. The project contains numerous state-of-the-art algorithms for RGB and/or depth tracking, and has been created on top of a modular **node-based** architecture, to support the addition and removal of different sensor streams online.

OpenPTrack is led by [UCLA REMAP](http://remap.ucla.edu/) and [Open Perception](http://www.openperception.org/). Key collaborators include the [University of Padova](http://robotics.dei.unipd.it), [Electroland](http://www.electroland.net/), and [Indiana University Bloomington](http://www.iub.edu/). Code is available under a BSD license. Portions of the work are supported by the National Science Foundation (IIS-1323767).

Follow us on Twitter: [@openptrack](https://twitter.com/openptrack). 

# Guides

For further documentation, please see the navigation bar to the right. 

# Contributing to OpenPTrack

OpenPTrack is an open source project. If you discover optimizations, or if there is a feature you'd like to contribute, please make a branch for your feature and submit a pull request. 