#!/bin/bash

source /opt/ros/noetic/setup.bash
# Launch the first "roslaunch" command in the background
roslaunch jackal_gazebo jackal_world.launch config:=front_laser &
sleep 1
roslaunch jackal_navigation odom_navigation_demo.launch &
sleep 1
roslaunch jackal_viz view_robot.launch config:=navigation &

# Wait for both "roslaunch" commands to finish
wait

