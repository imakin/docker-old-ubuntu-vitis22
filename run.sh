#!/bin/bash

# ensure x11 forwarding
xhost +local:

# Source environment variables and create user-specific directory
if [ -f .env ]; then
    source .env
fi
mkdir -p ./sys/home/${USERNAME}

# match user id inside container
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# using podman compose:
echo "Building and starting the container..."
podman-compose build
podman-compose up -d

podman ps
echo "Container is running. Entering shell in 3 seconds..."
sleep 3

podman exec -it vitis22 bash
