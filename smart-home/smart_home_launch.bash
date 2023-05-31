#!/bin/bash

source /home/smart-home/install/setup.bash

sleep 1
ros2 launch unity_launch launch_local_pioneer.launch.py &
sleep 1
ros2 launch jackal_navigation navigation2.launch.py &

# Wait for commands to finish
wait

