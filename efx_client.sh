#!/bin/bash

HOST_NAME="vicharak"
HOST_IP="192.168.29.12"
SSH_ID="$HOST_NAME@$HOST_IP"
PROJECT_NAME="$1"

scp $PROJECT_NAME.xml *.v $SSH_ID:/tmp/$PROJECT_NAME
ssh $SSH_ID /home/$HOST_NAME/.local/bin/efx_serv.sh $PROJECT_NAME
scp $SSH_ID:/tmp/$PROJECT_NAME/$PROJECT_NAME.tar.gz ./
if [ $? -ne 0 ]; then
    echo "failed"
    exit 1
fi
tar -xzf $PROJECT_NAME.tar.gz
