#!/bin/bash

# ensure x11 forwarding
xhost +local:

#start existing container
podman-compose start

# match user id inside container
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# using podman compose:
podman-compose build
# podman build --tag vitis22img -f Dockerfile

podman-compose up -d

podman ps
echo "sudah, habis ini bash"
sleep 3

podman exec -it vitis22 bash
# podman-compose run -d --rm \
#   -e DISPLAY=$DISPLAY \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v $HOME/.Xauthority:/home/makin/.Xauthority:ro \
#   vitis bash







# Get the current user ID and group ID
# USER_ID=$(id -u)
# GROUP_ID=$(id -g)

# Create the container with GUI support, volume mounts, and device access
# podman run -it --rm \
#   --name vitis-dev \
#   --userns=keep-id \
#   -e DISPLAY=$DISPLAY \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v $HOME/.Xauthority:/home/makin/.Xauthority:ro \
#   -v ./sys/opt/shared:/opt/shared \
#   -v ./sys/opt/master:/opt/master \
#   -v ./sys/home/makin:/home/makin \
#   --device /dev/bus/usb:/dev/bus/usb \
#   --security-opt label=type:container_runtime_t \
#   vitis20img \
#   bash
