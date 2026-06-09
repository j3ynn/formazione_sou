# Step 1 - Infrastructure as Code with Vagrant, Ansible and Docker

## Overview

This project provisions a Rocky Linux 9 virtual machine using Vagrant and configures it entirely through Ansible. The goal is to automate the installation of Docker, the configuration of a Docker network, and the deployment of a Jenkins Master/Agent architecture using containers with static IP addresses.

This setup is intended for Intel processors only and is not compatible with Apple Silicon (ARM).

## Prerequisites

- macOS or Linux host machine with an Intel processor
- VirtualBox
- Vagrant
- Ansible

## Project Structure

```
.
├── Vagrantfile       # VM configuration
└── Playbook.yml      # Ansible playbook
```

## What the Vagrantfile does

- Provisions a Rocky Linux 9 VM using the `bento/rockylinux-9` box
- Allocates 2 GB of RAM and 2 CPU cores
- Forwards port 8080 (Jenkins UI) and port 50000 (Jenkins Master/Agent communication) from the guest to the host
- Uses Ansible as the provisioner, pointing to `Playbook.yml`

## What the Ansible Playbook does

The playbook runs the following tasks in order:

1. Updates all system packages using `dnf`
2. Imports the official Docker GPG key to verify package integrity
3. Downloads the official Docker repository for RHEL/Rocky Linux
4. Installs `docker-ce`, `docker-ce-cli` and `containerd.io`
5. Starts the Docker service and enables it on boot
6. Creates a Docker bridge network named `rete` with subnet `192.168.100.0/24`
7. Deploys a Jenkins Master container (`jenkins/jenkins:lts`) with static IP `192.168.100.10`
8. Deploys a Jenkins Agent container (`jenkins/inbound-agent:latest`) with static IP `192.168.100.11`, connected to the Master

## Usage

```bash
vagrant up
```

This single command will create the VM and run the full Ansible provisioning automatically.

To re-run the provisioning on an existing VM:

```bash
vagrant provision
```

To destroy the VM:

```bash
vagrant destroy
```

## Network Configuration

| Container | Image | IP Address | Port |
|---|---|---|---|
| ContainerJenkins (Master) | jenkins/jenkins:lts | 192.168.100.10 | 8080, 50000 |
| ContainerAgent (Agent) | jenkins/inbound-agent:latest | 192.168.100.11 | - |

## Notes

- The Jenkins Agent secret (`JENKINS_SECRET`) must be generated from the Jenkins Master UI after the first boot and added manually to the playbook.
- The Docker network uses the `192.168.100.0/24` subnet to avoid conflicts with Docker's default bridge network (`172.17.0.0/16`).