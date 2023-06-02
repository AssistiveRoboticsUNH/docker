#!/bin/bash

source /home/smart-home/install/setup.bash

sleep 1
ros2 launch shr_plan real_robot.launch.py &
sleep 1
## will be changed to ros2 launch pioneer_navigation navigation2.launch.py byththere is a bug so just use this for now it should work fine
##ros2 launch pioneer_navigation navigation2.launch.py &

# Wait for commands to finish
wait

