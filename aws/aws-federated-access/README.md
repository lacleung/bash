# aws-federated-access

This is a loose group of scripts used to created the IAM federated access across multiple AWS accounts. You can read more about AWS concept of identity federation [here](https://aws.amazon.com/identity/federation/). These script set up a IAM user group, target role to be assumed, and IAM user credentials. There is also a bit of email templating to provide verbage to the user receiving the new access. These scripts should only be used as a skeleton for the framework of IAM federation and not as operation scripts. This is mainly commited to the repository as a reminder on the necessary components to a working IAM federation setup.

---

### Requirements

The following components are require for the script to run:
  - awscli
  - jq

### Instructions

Read through the scripts for a general idea on how to setup federated access, do not use as is. 