#!/bin/bash

# Install AWS CLI
sudo apt install aws-cli -y

# Upload the /var/log/ directory to the S3 bucket
aws s3 cp -R /var/log s3va://agnija-bucket.devops4ml-aws/logs

# To create a file with the list of uploaded files and save it to the S3 bucket:
ls -l /var/log > /var/log/all_files.txt
aws s3 cp /var/log/all_files.txt s3://agnija-bucket-devops4ml-aws/logs/all_files.txt

# use the IMDSv2 method to retrieve the instance ID of the EC2 instance
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Terminate the EC2 instance
aws ec2 terminate-instances --instance-ids $instance_id
