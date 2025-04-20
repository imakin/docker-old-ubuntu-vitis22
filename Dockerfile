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
    locales


#install any other package that i need
RUN apt install -y \
    openssh-server \
    tmux \
    ncdu \
    pcmanfm \
    vim

# clean up apt
RUN rm -rf /var/lib/apt/lists/*


# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a user with the same name and ID as the host user for better file permissions
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=makin

RUN groupadd -g $GROUP_ID $USERNAME && \
    useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

# Set up working directory
WORKDIR /home/$USERNAME

# Switch to the user
USER $USERNAME

# Set display for GUI applications
ENV DISPLAY=:0

# Add udev rules for FPGA devices (example for Xilinx devices)
# RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="0666"' | sudo tee /etc/udev/rules.d/99-xilinx.rules && \
#     echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0007", MODE="0666"' | sudo tee -a /etc/udev/rules.d/99-xilinx.rules && \
#     echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0009", MODE="0666"' | sudo tee -a /etc/udev/rules.d/99-xilinx.rules

# Set up a healthcheck
HEALTHCHECK --interval=5m --timeout=3s \
  CMD bash -c "echo 'Container is running'" || exit 1
