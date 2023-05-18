FROM unhcarl/ros-noetic-humble-src
SHELL ["/bin/bash", "-c"]

# ros1_bridge
WORKDIR /root/ros2_humble/src
RUN git clone https://github.com/AssistiveRoboticsUNH/ros1_bridge.git
WORKDIR /root/ros2_humble
RUN source /opt/ros/noetic/setup.bash  \
    && source /root/ros2_humble/install/setup.bash  \
    && colcon build --symlink-install --packages-select ros1_bridge --cmake-args -DBUILD_TESTING=OFF

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
