#!/bin/bash

if [[ $# -ne 4 ]] ; then
    echo 'Usage: ./create-user.sh [username] [password] [group] [creator]'
    exit 0
fi

aws iam create-user --user-name $1
aws iam create-login-profile --user-name $1 --password $2 --password-reset-required
aws iam tag-user --user-name $1 --tags '[{"Key": "Creator", "Value": "'$4'"}, {"Key": "Client", "Value": "Allvue"}]'
aws iam create-access-key --user-name $1 > /tmp/user.json
aws iam add-user-to-group --user-name $1 --group-name $3
aws iam add-user-to-group --user-name $1 --group-name ForceAccountMFA

AWS_ACCESS_KEY_ID=`cat /tmp/user.json | jq -r '.AccessKey.AccessKeyId'`
AWS_SECRET_ACCESS_KEY=`cat /tmp/user.json | jq -r '.AccessKey.SecretAccessKey'`

cat << EOF >> lastpass

IAM Username: $1
Temporary Password: $2
Access Key ID: $AWS_ACCESS_KEY_ID
Secrect Access Key: $AWS_SECRET_ACCESS_KEY

EOF

cat << EOF > keynote

### AWS CREDENTIALS ###
IAM Username: $1
Temporary Password: $2
Access Key ID: $AWS_ACCESS_KEY_ID
Secrect Access Key: $AWS_SECRET_ACCESS_KEY

Please follow the instructions below to set up your account or follow the steps here: https://url-to-instructions.com
Please login at https://<auth-account>.signin.aws.amazon.com/console

Create a new password. This AWS account uses a password policy:

Minimum password length is 12 characters
Require at least one uppercase letter from Latin alphabet (A-Z)
Require at least one lowercase letter from Latin alphabet (a-Z)
Require at least one number
Require at least one non-alphanumeric character

You must set your MFA before being authenticated to assume roles. Set your MFA by going to the drop down menu on the top right of the window next to "Region" and "Support". It should say "Username @ <auth-account>".
Select "My Security Credentials" and then find "Assign MFA device" to set up your MFA.
Once MFA is set up please log out and log back in with your MFA device. (Yes unfortunately this is required.)

When you have authenticated switch into your role by going to the following urls and clicking switch roles (or view the existing links in the provided lift article):

For Cloud Acct:
https://signin.aws.amazon.com/switchrole?account=<cloud>&roleName=<role_name>@Cloud

You will be able to switch between accounts after the first time you assume the roles. This will be located at the same drop down menu at the top right corner of the window where you selected My Security Credentials.

EOF


