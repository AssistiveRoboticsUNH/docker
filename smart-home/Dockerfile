FROM osrf/ros:humble-desktop

SHELL ["/bin/bash", "-c"]

RUN  apt-get update \
    && apt-get install -y \
        pulseaudio

# clone source
ENV ROS_WS /home/smart_home_ws

RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS/src
RUN git clone https://github.com/AssistiveRoboticsUNH/smart-home.git
WORKDIR smart-home
RUN git checkout ros_jackal
RUN vcs import < external.repos.yaml
WORKDIR $ROS_WS

# for rviz visualization
RUN apt update
RUN apt install python3-pip -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:kisak/kisak-mesa
RUN apt update
RUN apt upgrade -y
RUN apt install nano

# pip dependencies
RUN pip3 install tqdm
RUN pip3 install opencv-contrib-python

# pip dependencies for deepfake
RUN pip3 install elevenlabslib
RUN apt-get install libportaudio2
RUN pip3 install playsound
RUN pip3 install mediapipe

RUN apt-get update && apt-get install -y vlc

# get dependencies
RUN apt update
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src -y

RUN cd ${ROS_WS} \
    && . /opt/ros/humble/setup.sh \
    && colcon build \
    && source ${ROS_WS}/install/setup.bash

# copy entry pointer script
RUN apt install net-tools -y
RUN apt install tmux -y
RUN apt-get install iputils-ping -y
RUN adduser root dialout
RUN sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc
COPY ros_entrypoint.sh /
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
