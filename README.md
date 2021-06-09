# AWS CloudFormation templates for basic VPC setup

[![CI](https://github.com/ganto/aws-cloudformation-vpc/actions/workflows/ci.yaml/badge.svg)](https://github.com/ganto/aws-cloudformation-vpc/actions/workflows/ci.yaml)

This repository contains some [AWS CloudFormation](https://aws.amazon.com/cloudformation/) templates to setup a basic VPC with some add-ons. Check the description below for the details.

## Pre-Requisites

The CloudFormation templates can be applied via [awscli](https://aws.amazon.com/cli/) command line client. It can be installed via package manager of your choice or directly via Python:
```
pip install awscli
```

## Stack: VPC

Basic CloudFormation stack to setup a VPC that consists of a private and public subnet with the necessary NAT gateway to communicate to the Internet. The CloudFormation template was inspired by the [Creating a VPC](https://docs.okd.io/latest/installing/installing_aws/installing-aws-user-infra.html#installation-creating-aws-vpc_installing-aws-user-infra) section of the [OKD](https://okd.io) installation instructions.

### Setup, Update, Removal 

Create a new VPC based on the CloudFormation template and the properties from the `vpc-parameters.json` JSON file (adjust them if necessary):
```
aws cloudformation create-stack --stack-name My-first-VPC \
  --template-body file://vpc.yaml --parameters file://vpc-parameters.json
```

Delete VPC that was created by the CloudFormation template:
```
aws cloudformation delete-stack --stack-name My-first-VPC
```

After making adjustments on the YAML template validate it via:
```
aws cloudformation validate-template --template-body file://vpc.yaml
```

Small changes of the template can be directly applied to a instantiated stack via:
```
aws cloudformation update-stack --stack-name My-first-VPC \
  --template-body file://vpc.yaml --parameters file://vpc-parameters.json
```

### Further Reading

More information and example code for creating a VPC via CloudFormation can be found at:
* [docs.aws.amazon.com: AWS::EC2::VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc.html)
* [docs.aws.amazon.com: CodeBuild AWS CloudFormation VPC template](https://docs.aws.amazon.com/codebuild/latest/userguide/cloudformation-vpc-template.html)


## Stack: Bastion Host

AWS CloudFormation stack to deploy a Linux EC2 instance that can be used as a bastion host in a VPC where additional resources are deployed into private subnets that are not reachable directly through the Internet. The bastion host will have a public IP address and is only reachable via SSH through port 22.

### Setup, Update, Removal 

Create a new bastion host based on the CloudFormation template and the properties from the `bastion-ec2-parameters.json` JSON file (adjust them if necessary). The default AMI is a Fedora 33 cloud image of the 'eu-west-1' AWS region:
```
aws cloudformation create-stack --stack-name Bastion-Host \
  --template-body file://bastion-ec2.yaml --parameters file://bastion-ec2--parameters.json
```
After the instances has been provisioned it can be accessed via `ssh -l fedora <ip-address>`

Delete bastion host that was created by the CloudFormation template:
```
aws cloudformation delete-stack --stack-name Bastion-Host
```

After making adjustments on the YAML template validate it via:
```
aws cloudformation validate-template --template-body file://bastion-ec2.yaml
```

Small changes of the template can be directly applied to a instantiated stack via:
```
aws cloudformation update-stack --stack-name Bastion-Host \
  --template-body file://bastion-ec2.yaml --parameters file://bastion-ec2-parameters.json
```

### Further Reading

More information and example code for creating a EC2 instances via CloudFormation can be found at:
