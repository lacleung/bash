#!/bin/bash

if [[ $# -ne 3 ]] ; then
    echo 'Usage: ./create-target-role.sh [corp|hosting|devops|...] [role] [profile]'
    exit 0
fi

# Insert Account ID 
hosting=xxxxxxxxxxxxxxxx
devops=xxxxxxxxxxxxxxxx
corp=xxxxxxxxxxxxxxxx
infra=xxxxxxxxxxxxxxxx
lp=xxxxxxxxxxxxxxxx

acct=$1
eval account=\$$acct
role=$2
profile=$3


# create temp trustpolicy json file: replace xxxxxxxxxxxxxxxx with auth account id
cat << EOF > /tmp/trustpolicy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::xxxxxxxxxxxxxxxx:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF

aws iam create-role --role-name $role --assume-role-policy-document file:///tmp/trustpolicy.json --profile $profile > /dev/null

cat << EOF > /tmp/grouprolepolicy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": [
        "arn:aws:iam::$account:role/$role"
      ],
      "Condition": {
                "StringEquals": {
                    "aws:PrincipalTag/Client": "Allvue"
                }
            }
    }
  ]
}
EOF

#  replace xxxxxxxxxxxxxxxx with auth account id
aws iam create-policy --policy-name $role@$acct --policy-document file:///tmp/grouprolepolicy.json > /dev/null
aws iam attach-group-policy --policy-arn arn:aws:iam::xxxxxxxxxxxxxxxx:policy/$role@$acct --group-name $role
