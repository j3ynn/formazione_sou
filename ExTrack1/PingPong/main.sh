#!/bin/bash

while [ true ]; do

    # -c esegue un comando dentro la VM senza entrarci
    vagrant ssh Ping -c "echo "Ping""
    vagrant ssh Ping -c "./Ping.sh"
    vagrant ssh Pong -c "echo "Pong""
    vagrant ssh Pong -c "./Ping.sh"
done