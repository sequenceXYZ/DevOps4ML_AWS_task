#!/bin/bash

# Set the S3 bucket name
S3_BUCKET_NAME=agnija-bucket-devops4ml-aws

# Upload the /var/log/ directory to the S3 bucket
aws s3 cp /var/log s3://agnija-bucket-devops4ml-aws/logs

# To create a file with the list of uploaded files and save it to the S3 bucket:
aws s3 cp <(ls /var/log) s3://agnija-bucket-devops4ml-aws/logs/uploaded_files.txt

# use the IMDSv2 method to retrieve the instance ID of the EC2 instance
instance_id=`curl -X GET http://169.254.169.254/latest/meta-data/instance-id`

# Terminate the EC2 instance
aws ec2 terminate-instances --instance-ids $(ec2-metadata --instance-id)
aws ec2 terminate-instances --instance-ids $instance_id
