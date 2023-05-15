FROM unhcarl/rosbridge-noetic-humble:latest
SHELL ["/bin/bash", "-c"]

# install ros package
RUN apt-get update 
      # && apt-get install -y \
      #ros-noetic-demo-nodes-cpp \
      #ros-noetic-demo-nodes-py && \

RUN apt install git -y

# clone source
ENV ROS_WS /home/sawyer_ws
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS/src
RUN git clone -b master https://github.com/RethinkRobotics/sawyer_robot.git
RUN git clone -b master https://github.com/RethinkRobotics/intera_sdk.git
RUN git clone -b master https://github.com/RethinkRobotics/intera_common.git
RUN git clone -b main https://github.com/ros-drivers/joystick_drivers.git
WORKDIR $ROS_WS
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src -y
RUN source /opt/ros/noetic/setup.bash && \
    catkin_make
    
RUN apt install nano -y
RUN apt install vim -y
RUN apt install net-tools -y
RUN apt install tmux -y
RUN apt-get install iputils-ping -y
RUN adduser root dialout
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN rm -rf /var/lib/apt/lists/*

COPY sawyer_launch.bash /tmp/sawyer_launch.bash
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
