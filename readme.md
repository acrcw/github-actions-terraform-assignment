# Terraform Pipeline for AWS Lambda Function Triggered by S3 Events and logging in Dynamo db

This repository contains the implementation of a Terraform pipeline for deploying an AWS Lambda function triggered by events on an S3 bucket. The Lambda function logs information about the items in the bucket to a DynamoDB table.

## Overview

The Terraform templates in this repository create the following AWS resources:
- AWS Lambda function
- S3 bucket
- DynamoDB table

The workflow is designed to perform the following tasks:
1. Verify the syntax of the Terraform templates.
2. Apply the Terraform plan to create the AWS resources.
3. Destroy the AWS resources created by Terraform.

## AWS Resources

### AWS Lambda Function
The Lambda function is triggered by events (put or delete) on the S3 bucket. It accesses the DynamoDB table to log information about the files added or deleted.

### S3 Bucket
The S3 bucket is created by Terraform and serves as the event source for the Lambda function.

### DynamoDB Table
The DynamoDB table stores information about the items in the S3 bucket. The Lambda function accesses this table to log file additions and deletions.



