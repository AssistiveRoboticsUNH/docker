#!/bin/bash

source /home/smart-home/install/setup.bash

sleep 1
ros2 launch shr_plan real_robot.launch.py &

sleep 1
ros2 launch shr_plan plansys2.launch.py &

# Wait for commands to finish
wait

