#!/bin/bash

# Upload the /var/log/ directory to the S3 bucket
aws s3 cp -R /var/log s3://<bucket-name>/logs

# To create a file with the list of uploaded files and save it to the S3 bucket:
ls -l /var/log > /var/log/all_files.txt
aws s3 cp /var/log/all_files.txt s3://,bucket-name>/logs/all_files.txt

# use the IMDSv2 method to retrieve the instance ID of the EC2 instance
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` 
instance_id=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id)

# Terminate the EC2 instance
# aws ec2 terminate-instances --instance-ids $(ec2-metadata --instance-id)
aws ec2 terminate-instances --instance-ids $instance_id


-------------------------------------------------------
# another option
# use the IMDSv2 method to retrieve the instance ID of the EC2 instance
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
