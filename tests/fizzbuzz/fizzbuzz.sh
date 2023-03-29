#!/bin/bash

if [[ "$#" != 2 ]] ; then
    read -p "Enter start of range: " start_seq
    read -p "Enter end of range: " end_seq
else
    start_seq="${1}"
    end_seq="${2}"
fi

for i in $(seq ${start_seq} ${end_seq}) ; do
    result=''
    if (( "${i}" % 3 == 0 )) ; then
        result="fizz"
    fi
    if (( "${i}" % 5 == 0 )) ; then
        result+="buzz"
    fi
    if [[ -z "${result}" ]]; then
        result="${i}"
    fi

    echo "${result}"
done
