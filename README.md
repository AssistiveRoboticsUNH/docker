# docker
All docker build, compose, and run scripts are hosted in this repository
The docker compose files require some envirmental viarbles be set:
1. `ROS_MASTER_URI`
1. `ROS_IP`
1. `ROS_DOMAIN_ID`

You should set `ROS_IP` to your computer's local IP, `ROS_MASTER_URI` to `http://$ROS_IP:11311`, and `ROS_DOMAIN_ID` to 26.

To run a container, `cd` one of the directories and run `docker compose up`

# how to use smart_home docker to run protocols.

1) set all the environment variables in you .bashrc
2) clone the repository and cd to smart_home directory
3) enable docker gpu with the follwoing commands 

```sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo systemctl restart docker ```

5) run ``` docker build . -t unhcarl/smart_home:latest --no-cache```, only use the --no-cache argumernt when you need it.
7) Unity is very slow in the docker for that yuou will need to run unity on your machine outside the docker.for that run in one terminal ``` ros2 run unity_binary downlaod_and_run``` and in onther termainal cd to smart_home directory in the docker folder and run docker compose up. make sure you have the unity running before you run the docker.



