#!/bin/bash
set -e

# setup ros environment
source "/root/ros2_humble/install/setup.bash"

exec "$@"
