FROM registry.cn-hangzhou.aliyuncs.com/mikoychinese/open_ptrack-dep:v1.0
LABEL maintainer "Mikoy Chinese"

ARG branch=realsense

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE \
    && add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u \
    && rm -f /etc/apt/sources.list.d/realsense-public.list \
    && apt-get update \
    && apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
	&& git clone https://github.com/intel-ros/realsense.git ~/workspace/ros/src/realsense\
    && apt-get install ros-kinetic-rgbd-launch"

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
    && git clone https://github.com/MikoyChinese/open_ptrack_v2 ~/workspace/ros/src/open_ptrack \
    && cd ~/workspace/ros/src/open_ptrack \
    && git checkout $branch \
    && cd ../..  \
    && export LD_LIBRARY_PATH=/root/workspace/ros/devel/lib:/opt/ros/kinetic/lib:/opt/ros/kinetic/lib/x86_64-linux-gnu:/usr/local/lib/x86_64-linux-gnu:/usr/local/lib/i386-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu:/usr/local/cuda/lib64:/usr/local/opencv3/lib \
    && catkin_make"

RUN /bin/bash -c "source /root/workspace/ros/devel/setup.bash \
    && roscd yolo_detector/darknet_opt \
    && wget -O coco.weights https://dev.tencent.com/api/share/download/6ceed3c3-b51f-41bc-9fa4-1e868c1a9a7a"


RUN ln -s /root/workspace/ros/src/open_ptrack /root/open_ptrack

WORKDIR /root
