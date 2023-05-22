#!/bin/bash

source /home/smart-home/install/setup.bash
# Launch the first "roslaunch" command in the background
ros2 launch ros_tcp_endpoint endpoint.launch.py &
sleep 1
ros2 launch unity_launch launch_local.launch.py &
sleep 1
ros2 launch pioneer_navigation2 navigation2.launch.py &

# Wait for commands to finish
wait

