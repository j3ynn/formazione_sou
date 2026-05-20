#!/bin/bash

apt-get update
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker Ping
usermod -aG docker Pong