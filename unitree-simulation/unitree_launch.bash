#!/bin/bash

source /home/unitree/catkin_ws/devel/setup.bash

roslaunch laikago_description laikago_rviz.launch &
sleep 1
roslaunch unitree_gazebo normal.launch rname:=go1 wname:=stairs &
sleep 1
rosrun unitree_controller unitree_servo &
#sleep 1
#rosrun unitree_controller unitree_external_force &
wait

