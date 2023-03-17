FROM osrf/ros:noetic-desktop-full
ENV ROS_DISTRO=noetic

ARG CLEARPATH_URL="https://packages.clearpathrobotics.com"
ARG DEBIAN_FRONTEND="noninteractive"

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install boilerplate utilities
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    git
    
# Add Clearpath deb package repos
RUN echo "deb ${CLEARPATH_URL}/stable/ubuntu focal main" > /etc/apt/sources.list.d/clearpath-latest.list &&\
    curl -sSL "${CLEARPATH_URL}/public.key" | apt-key add -

# Install deb packages from newly installed repos
RUN apt-get update && apt-get install --no-install-recommends -y \
    \
    # Jackal ROS Packages
    python3-catkin-tools \
    python3-osrf-pycommon \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    ros-noetic-robot \
    ros-noetic-ros-base \
    \
    # Jackal Clearpath Packages
    python-ds4drv \
    ros-noetic-jackal-base \
    ros-noetic-jackal-bringup \
    ros-noetic-jackal-simulator \ 
    ros-noetic-jackal-desktop \
    ros-noetic-jackal-navigation \
    && rm -rf /var/lib/apt/lists/*


# ====================================================================
# | Root Filesystem Configuration                                    |
# ====================================================================

# Merge system folder config files into root filesystem
COPY ./. /

# ====================================================================
# | User Configuration                                               |
# ====================================================================

# Set defaults for username and password
ARG JACKAL_USER="administrator"
ARG JACKAL_PASSWORD="clearpath"

# Add $JACKAL_USER user with group memberships and hashed password
RUN useradd -mUG "sudo" "${JACKAL_USER}" && \
    echo "${JACKAL_USER}:${JACKAL_PASSWORD}" \
    | chpasswd

# Copy home directory contents into $JACKAL_USER home dir and set ownership
RUN chown -R "${JACKAL_USER}:${JACKAL_USER}" "/home/${JACKAL_USER}"

# Switch to $JACKAL_USER user
USER "${JACKAL_USER}"

# Update rosdep as rfal user
RUN rosdep update

# Build home directory catkin workspace
WORKDIR "/home/${JACKAL_USER}/catkin_ws"
RUN source /opt/ros/noetic/setup.bash && \
    mkdir -p "/home/${JACKAL_USER}/catkin_ws/src" && \
    catkin_make

# Set working directory to user home dir
WORKDIR "/home/${JACKAL_USER}"

COPY jackel_launch.bash /tmp/jackel_launch.bash

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
