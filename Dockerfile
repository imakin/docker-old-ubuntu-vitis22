FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libusb-1.0-0-dev \
    libncurses5 \
    libtinfo5 \
    libgtk2.0-0 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libgl1-mesa-glx \
    libcurl4 \
    unzip \
    sudo \
    wget \
    xauth \
    x11-apps \
    dbus-x11 \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a user with the same name and ID as the host user for better file permissions
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=ubuntu

RUN groupadd -g $GROUP_ID $USERNAME && \
    useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

# Set up working directory
WORKDIR /home/$USERNAME

# Switch to the user
USER $USERNAME

# Set display for GUI applications
ENV DISPLAY=:0

# Set up a healthcheck
HEALTHCHECK --interval=5m --timeout=3s \
  CMD bash -c "echo 'Container is running'" || exit 1
