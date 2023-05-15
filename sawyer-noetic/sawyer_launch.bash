#!/bin/bash

source /home/administrator/catkin_ws/devel/setup.bash

# Launch the first "roslaunch" command in the background
# roslaunch jackal_gazebo jackal_world.launch config:=front_laser &
# sleep 1

# Wait for both "roslaunch" commands to finish
wait

