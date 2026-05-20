# Virtual Environment Configuration with Vagrant

This repository contains the Vagrantfile configuration for the automated creation and management of a Linux virtual machine based on the Ubuntu architecture.

## Technical Overview

The configuration utilizes Vagrant Version 2 and relies on VirtualBox as the virtualization provider. The objective is to provide an isolated, consistent, and easily reproducible development environment.

### Virtual Machine Specifications
* **Operating System**: Ubuntu 20.04 LTS (focal64)
* **Hardware Resources**: 
    * RAM: 1024 MB
    * CPU: 1 Core
* **Networking**: Private Network (Host-only)
* **Static IP Address**: 192.168.33.10
* **Identifier**: PrimaVm

## Prerequisites

Before proceeding, ensure the following software is installed on your host system:
1. VirtualBox (latest version)
2. Vagrant (version 2.0 or higher)

## Operational Instructions

### Starting the Machine
To initialize and boot the virtual environment, execute the following command from the project root:
```bash
vagrant up
Accessing the System

Access to the virtual machine shell is handled via the SSH protocol:

Bash
vagrant ssh
Lifecycle Management

Suspend: vagrant suspend

Halt: vagrant halt

Restart and Apply Changes: vagrant reload

Delete: vagrant destroy

Networking Notes
The static IP address 192.168.33.10 is configured on a private network. This ensures the virtual machine is accessible exclusively from the host computer, maintaining isolation from other nodes on the local network.