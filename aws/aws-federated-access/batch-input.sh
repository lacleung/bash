#!/bin/bash
profile=profile1

declare -a batch_input=(
"xxxxxx"
"xxxxxxx"
)


# loop over client names for s3 bucket arns
for i in ${batch_input[@]}
do
  ./create-user.sh $i <insert random string>
  echo "$i input finished"
done
