#!/bin/bash

if [ ! -d /opt/deployment ]
then
    sudo mkdir -p /opt/deployment
else
    sudo rm -rf /opt/deployment
    sudo mkdir -p /opt/deployment
fi
