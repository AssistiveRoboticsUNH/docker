#!/bin/bash

source /home/smart-home/install/setup.bash

sleep 1
ros2 launch unity_launch launch_pioneer.launch.py &
sleep 1
ros2 launch pioneer_navigation2 navigation2.launch.py &

# Wait for commands to finish
wait

