FROM osrf/ros:noetic-desktop-full

# install general tool
RUN  apt update
RUN apt install net-tools -y
RUN apt install tmux -y
RUN apt-get install iputils-ping -y

# setup timezone
RUN locale  # check for UTF-8
RUN  apt install locales  -y
RUN  locale-gen en_US en_US.UTF-8
RUN  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN  export LANG=en_US.UTF-8

#First ensure that the Ubuntu Universe repository is enabled.
RUN  apt install software-properties-common  -y
RUN  add-apt-repository universe

#Now add the ROS 2 GPG key with apt.
RUN  apt install curl  -y
RUN  curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

#Then add the repository to your sources list.
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#Install common packages.
RUN  apt install -y \
  python3-flake8-docstrings \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools

#Install packages according to your Ubuntu version.
RUN python3 -m pip install -U \
   flake8-blind-except \
   flake8-builtins \
   flake8-class-newline \
   flake8-comprehensions \
   flake8-deprecated \
   flake8-import-order \
   flake8-quotes \
   pytest-repeat \
   pytest-rerunfailures

#Create a workspace and clone all repos:
RUN mkdir -p /root/ros2_humble
RUN mkdir -p /root/ros2_humble/src
WORKDIR /root/ros2_humble
RUN vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

#Install dependencies using rosdep
RUN apt upgrade -y
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"

# build ros2
WORKDIR /root/ros2_humble/
RUN colcon build --symlink-install --cmake-args -DBUILD_TESTING=OFF
RUN chmod +777 /root/ros2_humble/install/setup.bash
RUN /root/ros2_humble/install/setup.bash

# run rosdep again
WORKDIR /root/ros2_humble
ENV RTI_NC_LICENSE_ACCEPTED=yes
ENV ROS_DISTRO=humble
RUN rosdep install -y -r -q --from-paths src --ignore-src --rosdistro humble

# build ros2 workspace again
WORKDIR /root/ros2_humble/
RUN /root/ros2_humble/install/setup.bash & colcon build --symlink-install --cmake-args -DBUILD_TESTING=OFF

# setup entrypoint
COPY ./ros_entrypoint.sh /

# extra tools/setup
RUN apt install net-tools -y
RUN apt install tmux -y
RUN apt-get install iputils-ping -y
RUN apt-get install nautilus -y
RUN apt-get install vim -y
RUN adduser root dialout

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
