The following instructions will get you a copy of OpenPTrack running using Docker. 

## Prerequisites

Please see [Supported Hardware](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Supported-Hardware). You need at least 30 GB of space on each machine to run the Docker installation. If you have an existing OpenPTrack Installation and need a Docker installation; it is possible to install set up a Docker installation and run it in parallel with your current installation. 

Docker, nvidia-384, nvidia-docker 2 are required to use Open_PTrack docker images and this page guides you through the installation process.

### Installation
Clone the open_ptrack_docker_config repository:

    git clone https://github.com/OpenPTrack/open_ptrack_docker_config.git
    cd open_ptrack_docker_config

If you have nvidia-docker 1.0 installed, you need to remove it and all existing GPU containers. Run the following to do this:

    sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f`

    sudo apt-get purge -y nvidia-docker


If you have not yet installed docker and nvidia-docker 2 and nvidia-384 execute the following:

    chmod +x setup_host
    ./setup_host

After successfully executing `setup_host`, reboot your system. After rebooting your system test nvidia-docker 2 by running

`sudo docker run --runtime=nvidia --rm nvidia/cuda:8.0-devel nvidia-smi`

You should see an output similar to this:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 384.130                Driver Version: 384.130                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 750 Ti  Off  | 00000000:01:00.0  On |                  N/A |
| 40%   31C    P8     1W /  38W |    188MiB /  1998MiB |      1%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

## Manually Building  Docker Images (Optional)
This step is not required to run OpenPtrack as pre-built images are already available. If however you want to build the images yourself, the information is available [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Manually-Building-Docker-Images-(Optional)).

## Running containers
After installing the [prerequisites](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Docker-Images#prerequisites), simply start a single_camera_tracking or multi_camera_tracking container depending on your need. 
 
### single_camera_tracking 

**Instructions:**

```
cd ~/open_ptrack_docker_config/single_camera_tracking
chmod +x run_single_camera
./run_single_camera
```
To remove the container run : `./run_single_camera -r`

To stop the container run: `./run_single_camera -s`

### multi_camera_tracking 

**Instructions:**

```
cd ~/open_ptrack_docker_config/multi_camera_tracking
```

Edit ros_network.env inside multi_camera_tracking to match your system network configuration and then run:

```
chmod +x run_multi_camera
./run_multi_camera
```
To remove the container run : `./run_multi_camera -r`

To stop the container run: `./run_multi_camera -s`
 
in order to run the script from any directory please use the following:
```
sudo ln -s /home/$USER/open_ptrack_docker_config/single_camera_tracking/run_single_camera /usr/local/bin/run_single_camera
sudo ln -s /home/$USER/open_ptrack_docker_config/multi_camera_tracking/run_multi_camera /usr/local/bin/run_multi_camera
```
Once your container is running, follow Time Synchronization on the wiki [here](https://github.com/OpenPTrack/open_ptrack_v2/wiki/Time-Synchronization) and then continue with the rest of the calibration.

## Deployment
To create a new terminal for a running container for example during calibration or multi camera tracking or face recognition, simply open a new terminal and follow the same procedure as above. 