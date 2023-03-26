#!/bin/bash

if [[ $# -ne 2 ]] ; then
    echo 'Usage: ./tag-user.sh [username] [creator]'
    exit 0
fi

aws iam tag-user --user-name $1 --tags '[{"Key": "Creator", "Value": "'$2'"}, {"Key": "Client", "Value": "ACME"}]'
