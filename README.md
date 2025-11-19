# Vitis 22 Development Container

This repository provides the configuration to create a containerized development environment for the Vitis 2022 platform. This environment runs on Ubuntu 22.04 and is managed using Podman and podman-compose.

The goal is to provide a clean, isolated, and reproducible environment for FPGA development without the need to install Vitis and its dependencies directly on the host operating system.

## Key Features

- **Isolated Environment**: Runs Vitis within a container to avoid dependency conflicts with the host system.
- **GUI Support**: Configured for X11 forwarding, allowing you to run Vitis GUI applications directly from within the container.
- **Hardware Access**: Allows access to USB devices, which is crucial for connecting JTAG programmers and FPGA development boards.
- **User Management**: Automatically matches the user and group IDs from the host into the container to prevent file permission issues when working with shared volumes.
- **File Sharing**: The `../shared` and `sys/home/$USER` directories are automatically mounted into the container for easy file transfer.

## Prerequisites

- Podman
- podman-compose
- A running X11 server on your host system.

## Directory Structure

- `Dockerfile`: The recipe for building the Ubuntu 22.04 container image with all necessary dependencies.
- `podman-compose.yml`: Defines the container service, volumes, and device configuration.
- `run.sh`: A utility script to build, start, and enter the container.
- `sys/`: Directory containing system configuration files to be mounted into the container.

## How to Use

1.  **Clone the Repository**:
    ```bash
    git clone [YOUR REPOSITORY URL]
    cd vitis22
    ```

2.  **Run the Script**:
    Simply execute the `run.sh` script. This script will handle all necessary steps automatically.
    ```bash
    ./run.sh
    ```

    This script will:
    - Build the container image if it does not already exist.
    - Start the container in the background.
    - Open an interactive `bash` shell session inside the container.

3.  **Start Working**:
    Once the script finishes, you will be inside the container's shell. From here, you can start using Vitis as if it were installed natively.

## Configuration

- **User**: You have to change the username by making the file .env with content like:

        USERNAME=yourusername

- **File Sharing**:
    - Files placed in the `../shared` directory will be available at `/opt/shared` inside the container.
    - Files in `sys/home/$USER` will appear in the user's home directory inside the container.
