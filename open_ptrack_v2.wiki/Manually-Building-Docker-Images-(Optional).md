This step is not required to run OpenPtrack as pre-built images are already available. If however you want to build the images yourself, this project contains two images: `open_ptrack-dep` and `open_ptrack`. Dockerfiles for both images are located in open_ptrack_v2/docker/. 

Clone the open_ptrack_v2 repository:

    git clone https://github.com/OpenPTrack/open_ptrack_v2.git
    cd open_ptrack_v2/docker/


* ### open_ptrack-dep
open_ptrack-dep is the base image for open_ptrack and includes all the dependencies required for open_ptrack. This image is based on nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04, contains all the installation processes for open_ptrack and it is based on the instructions [here](https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit) . 

To build the image :

    cd open_ptrack-dep
    sudo docker build -t openptrack/open_ptrack-dep .

Note : dot (.) is part of the command. It means the current directory. This build could take more than an hour. 

* ### open_ptrack
open_ptrack is based on open_ptrack-dep. This image includes open_ptrack installation.

To build the image:

     cd ~/open_ptrack_v2/docker/
     cd open_ptrack/
     sudo docker build -t openptrack/open_ptrack .
    

or to choose a specific branch

     cd ~/open_ptrack_v2/docker/
     cd open_ptrack
     sudo docker build -t openptrack/open_ptrack --build-arg branch=branch_name .

Note : dot (.) is part of the command. It means the current directory. 