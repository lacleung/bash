# aws-mfa

To properly use awscli with mfa, a new set of credentials need to be generated per authenticated session. This can be a laborious process due to the need to generate a new set of keys as well as editing the configuration file or environment variables locally. This script seeks to automate the process by generating the session credentials and  updating the existing credentials file with the new values. 

---

### Requirements

The following components are require for the script to run:
  - awscli
  - jq
  - aws credentials and config file in `~/.aws` directory
    - .example files are templates to be filled with account/user specific infromation
  - IAM user with mfa set up and valid Access Key and Secret in config setup

### Instructions

Replace the following values in `aws_mfa.sh`:
  - arn of mfa resource for desired IAM user
  - `auth` profile name with profile name of IAM user credentials
    - Neither profile name should be `default`