### DevOps4ML_AWS_task

#### Hands On task AWS

To be more familiar with AWS resources, AWS CLI, the next task should be done by Graduate.
Description:
As a junior DevOps engineer, you need to prove to your client that it is possible to upload 500MB of file from EC2 Instance to an S3 bucket and automate this procedure.

A client wants to know:
- Which resources will be created during the procedure
- How long will it take to upload a 500MB file from EC2 t2.micro to S3 bucket
- Provide monitoring graph from AWS
  
  
What must be done:
- Automate this procedure
- Resource provision must be done by Terraform
- Instead of a file, you need to automate the uploading of the entire /var/log/ directory
- File with uploaded files list should be in S3 bucket as well
- Afterward, the instance should be terminated automatically
- IMDSv2 method must be used to retrieve instance data.
