#!/bin/bash

    docker rm -f sasso
    docker run -d --name sasso ealen/echo-server
    sleep 60
    docker rm -f sasso

# script all'interno delle VM