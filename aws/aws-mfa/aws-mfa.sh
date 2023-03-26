#!/bin/bash

### READ ME #####
# Requirements: JQ + config.example template 
# This script will automatically set your mfa credentials for AWS CLI given that you have installed jq and have formatted your config/credential files to the example templates
# Set an alias to call on this script for better functionality.
#################

if [[ $# -ne 1 ]] ; then
    echo 'Usage: ./aws-mfa.sh [mfa-token]'
    exit 0
fi

mfa=$1

aws sts get-session-token --serial-number arn:aws:iam::1234567890:mfa/username --token-code $mfa --profile auth > /root/.aws/tempcred.json

AWS_ACCESS_KEY_ID=`cat /root/.aws/tempcred.json | jq -r '.Credentials.AccessKeyId'`
AWS_SECRET_ACCESS_KEY=`cat /root/.aws/tempcred.json | jq -r '.Credentials.SecretAccessKey'`
AWS_SESSION_TOKEN=`cat /root/.aws/tempcred.json | jq -r '.Credentials.SessionToken'`

sed -i.bak '/###TEMPORARY MFA CREDENTIALS###/,+6d' /root/.aws/credentials

cat << EOF >> /root/.aws/credentials
###TEMPORARY MFA CREDENTIALS###
[default]
output = json
region = us-east-1
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
aws_session_token = $AWS_SESSION_TOKEN
EOF

