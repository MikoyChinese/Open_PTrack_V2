
This describes how to install required dependencies (including [ROS](http://www.ros.org/) [Kinetic](http://wiki.ros.org/kinetic)), softwares, drivers and the [OpenPTrack](http://openptrack.org/) v2 “Gnocchi release” on a PC.

We currently offer two approaches to installing OpenPTrack V2. Due to the large number of dependencies and extensive build process, if you just want to run OpenPTrack, we suggest trying the Docker approach first. 

### 1. Docker Images (Recommended for Beginners)
This approach uses pre-built Docker images to run OPT. You can download images of the dependencies and our latest source branch via Docker.  This is especially good if you are an OPT beginner, are not too familiar with or are not interested in customization options for dependencies and drivers. Instructions are found [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images).

### 2. Manual Build and Installation
This approach takes you step by step through the installation process. It starts with the dependencies, then CUDA and other softwares, and finally the OpenPTrack v2 modules. Users of this approach are able to customize the steps based on their understanding of their machine requirements and their knowledge. This approach can easily be used by intermediate and advanced users. Instructions can be found [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Manual-Build-and-Installation). 
