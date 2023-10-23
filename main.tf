# set AWS region
provider "aws" {
  region = var.aws_region
}

# set default VPC for the region
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# create a security group for the instance
resource "aws_security_group" "instance_sg" {
  name        = "sftp-server-sg"
  description = "Security group for the SFTP server"
  vpc_id      = aws_default_vpc.default.id

  # traffic rules
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Agnija_Instance"
    Owner       = "Agnija Vjakse"
    Project     = "DevOps4ML_AWS"
    Environment = "Dev"
  }
}


# create resource - EC2 instance 
resource "aws_instance" "Agnija_Instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  count                  = var.instance_count
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.sftp_server_sg.id]

  user_data = file("upload.sh")

  tags = {
    Name        = "Agnija_Instance"
    Owner       = "Agnija Vjakse"
    Project     = "DevOps4ML_AWS"
    Environment = "Dev"
  }
}

# Create resource - S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "agnija-bucket-devops4ml-aws"

  tags = {
    Name        = "agnija-bucket-devops4ml-aws"
    Owner       = "Agnija Vjakse"
    Project     = "DevOps4ML_AWS"
    Environment = "Dev"
  }
}

