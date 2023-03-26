#!/bin/bash

if [[ $# -ne 1 ]] ; then
	echo 'Usage: ./create-group.sh [group]'
	exit 0
fi

aws iam create-group --group-name $1
