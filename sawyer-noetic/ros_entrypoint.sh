#!/bin/bash
set -e

# setup ros environment
source "/home/sawyer_ws/devel/setup.bash"
exec "$@"
