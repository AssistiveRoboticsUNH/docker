# docker
All docker build, compose, and run scripts are hosted in this repository
The docker compose files require some envirmental viarbles be set:
1. `ROS_MASTER_URI`
1. `ROS_IP`
1. `ROS_DOMAIN_ID`

You should set `ROS_IP` to your computer's local IP, `ROS_MASTER_URI` to `http://$ROS_IP:11311`, and `ROS_DOMAIN_ID` to 26.

To run a container, `cd` one of the directories and run `docker compose up`
