# PingPong

Two-node Vagrant environment where a Docker container migrates between
nodes every 60 seconds.

Only one node runs the container at a time.
Every minute, the container stops on the current node and starts on
the other one — bouncing back and forth like a ping pong ball.

---

## How it works

```text
+--------+          +--------+
|  Ping  |  <---->  |  Pong  |
|  :8080 |          |  :8081 |
+--------+          +--------+
     \                  /
      \                /
       [ealen/echo-server]
       (migrates every 60s)
```

- Ping runs on localhost:8080
- Pong runs on localhost:8081
- The container `ealen/echo-server` alternates between the two nodes
- `main.sh` orchestrates the migration from the host machine

---

## Requirements

- Vagrant
- VirtualBox
- Bash

---

## Project structure

```text
PingPong/
├── Vagrantfile       # defines Ping and Pong VMs
├── Docker.sh         # installs Docker inside each VM
├── PingPong.sh       # runs/removes the container inside the VM
└── main.sh           # orchestrates the ping pong loop
```

---

## Getting started

Clone the repository and start both VMs:

```bash
git clone <your-repo-url>
cd PingPong
vagrant up
```

This will:

- Create two Ubuntu 20.04 VMs (Ping and Pong)
- Install Docker automatically via `Docker.sh`

---

## Run the ping pong

From the `PingPong` directory on your host machine:

```bash
bash main.sh
```

The script connects to each VM via SSH and alternates the container
every 60 seconds.

---

## Verify it works

When the container is on Ping:

```bash
curl http://localhost:8080
```

When the container is on Pong:

```bash
curl http://localhost:8081
```

The echo server returns details about the incoming HTTP request.

---

## VM management

Start both VMs:

```bash
vagrant up
```

Start a single VM:

```bash
vagrant up Ping
vagrant up Pong
```

SSH into a VM:

```bash
vagrant ssh Ping
vagrant ssh Pong
```

Stop both VMs:

```bash
vagrant halt
```

Destroy both VMs:

```bash
vagrant destroy
```

---

## Port mapping

| VM   | Guest Port | Host Port |
|------|-------------|------------|
| Ping | 80          | 8080       |
| Pong | 80          | 8081       |

---

## Notes

- Each VM is provisioned with:
  - 1 CPU
  - 1 GB RAM

- Docker is installed automatically on first boot via `Docker.sh`

- Container used:

  `ealen/echo-server`

- Docker Hub:

  https://hub.docker.com/r/ealen/echo-server

- This is intentionally a simple proof of concept.
