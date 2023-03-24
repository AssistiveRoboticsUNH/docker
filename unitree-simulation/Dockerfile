FROM osrf/ros:melodic-desktop-full
ENV ROS_DISTRO=melodic

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install boilerplate utilities
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    git


# Install deb packages from newly installed repos
RUN apt-get update && apt-get install --no-install-recommends -y \
    ros-melodic-controller-interface  \
    ros-melodic-gazebo-ros-control  \
    ros-melodic-joint-state-controller  \
    ros-melodic-effort-controllers  \
    ros-melodic-joint-trajectory-controller \
    ros-melodic-joint-state-publisher-gui \
    && rm -rf /var/lib/apt/lists/*

#sudo apt-get install xvfb


# ====================================================================
# | Root Filesystem Configuration                                    |
# ====================================================================

# Merge system folder config files into root filesystem
COPY ./. /

# ====================================================================
# | User Configuration                                               |
# ====================================================================

# Set defaults for username and password
ARG USER="unitree"
ARG PASSWORD="unitree"

# Add $USER user with group memberships and hashed password
RUN useradd -mUG "sudo" "${USER}" && \
    echo "${USER}:${PASSWORD}" \
    | chpasswd

# Copy home directory contents into $USER home dir and set ownership
RUN chown -R "${USER}:${USER}" "/home/${USER}"

# Switch to $USER user
#USER "${USER}"

# Build home directory catkin workspace
WORKDIR "/home/${USER}/catkin_ws"

# clone the repo
RUN mkdir -p "/home/${USER}/catkin_ws/src"
WORKDIR "/home/${USER}/catkin_ws/src"
RUN git clone https://github.com/unitreerobotics/unitree_ros.git
RUN git clone https://github.com/unitreerobotics/unitree_ros_to_real.git
RUN git clone https://github.com/unitreerobotics/unitree_legged_sdk.git
WORKDIR "/home/${USER}/catkin_ws"

# install dependencies
# Update rosdep as rfal user
RUN rosdep update
WORKDIR "/home/${USER}/catkin_ws"
RUN rosdep install --from-paths src --ignore-src -r -y

# build catkin
RUN source /opt/ros/melodic/setup.bash && \
    catkin_make

# Set working directory to user home dir
WORKDIR "/home/${USER}"

COPY unitree_launch.bash /tmp/unitree_launch.bash

ENTRYPOINT ["/ros_entrypoint.sh"]

# set environment variables
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

CMD ["bash"]
