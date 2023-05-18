FROM unhcarl/rosbridge-noetic-humble:latest
SHELL ["/bin/bash", "-c"]

RUN apt update

# ros2 intera messages
WORKDIR /root/ros2_humble/src
RUN git clone https://github.com/AssistiveRoboticsUNH/sawyer_robot_ros2.git
WORKDIR /root/ros2_humble
RUN source /root/ros2_humble/install/setup.bash  \
    && colcon build --symlink-install --packages-select intera_core_msgs --cmake-args -DBUILD_TESTING=OFF


# clone source
ENV ROS1_WS /home/sawyer_ws
RUN mkdir -p $ROS1_WS/src
WORKDIR $ROS1_WS/src
RUN git clone -b master https://github.com/RethinkRobotics/sawyer_robot.git
RUN git clone -b master https://github.com/RethinkRobotics/intera_sdk.git
RUN git clone -b master https://github.com/RethinkRobotics/intera_common.git
RUN git clone -b main https://github.com/ros-drivers/joystick_drivers.git
WORKDIR $ROS1_WS
RUN source /opt/ros/noetic/setup.bash && rosdep update
RUN source /opt/ros/noetic/setup.bash && rosdep install --from-paths src --ignore-src -y
RUN source /opt/ros/noetic/setup.bash && \
    catkin_make

# rebuild ros1_bridge
WORKDIR /root/ros2_humble
RUN rm -r build/ros1_bridge
RUN rm -r install/ros1_bridge
RUN source $ROS1_WS/devel/setup.bash  \
    && source /root/ros2_humble/install/setup.bash  \
    && colcon build --symlink-install --packages-select ros1_bridge --cmake-args -DBUILD_TESTING=OFF
    
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
