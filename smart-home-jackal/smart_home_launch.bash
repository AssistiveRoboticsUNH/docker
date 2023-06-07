#!/bin/bash

source /home/smart_home_ws/install/setup.bash

sleep 1
ros2 launch shr_plan real_robot.launch.py &

sleep 1
ros2 launch shr_plan plansys2.launch.py &

# Wait for commands to finish
wait

