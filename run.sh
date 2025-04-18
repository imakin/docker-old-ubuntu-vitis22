#!/bin/bash

# Get the current user ID and group ID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Create the container with GUI support, volume mounts, and device access
podman run -it --rm \
  --name vitis-dev \
  --userns=keep-id \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/.Xauthority:/home/makin/.Xauthority:ro \
  -v ./sys/opt/shared:/opt/shared \
  -v ./sys/opt/master:/opt/master \
  -v ./sys/home/makin:/home/makin \
  --device /dev/bus/usb:/dev/bus/usb \
  --security-opt label=type:container_runtime_t \
  vitis-ubuntu20.04 \
  bash
