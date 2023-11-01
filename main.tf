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
  name        = "instance_sg"
  description = "Security group for the instance"
  vpc_id      = aws_default_vpc.default.id

  # traffic rules
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["private.ip"]

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
  vpc_security_group_ids = [aws_security_group.instance_sg.id]


  metadata_options {    
                    http_tokens="required"    
                    http_put_response_hop_limit="3"    
                    http_endpoint="enabled"   
  }


  user_data = file("upload.sh")

  tags = {
    Name        = "Agnija_Instance"
    Owner       = "Agnija Vjakse"
    Project     = "DevOps4ML_AWS"
    Environment = "Dev"
  }
}

# Create resource - S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name        = "agnija-bucket-devops4ml-aws"
    Owner       = "Agnija Vjakse"
    Project     = "DevOps4ML_AWS"
    Environment = "Dev"
  }
}


#---------------------------------------------------------
/*
# Upload the file to the bucket
resource "aws_s3_object" "single_object" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "file.txt"
  source = "/home/user/Desktop/file.txt"

  etag = filemd5("/home/user/Desktop/file.txt")
}

# Upload the multi files to the bucket
resource "aws_s3_object" "multi_object" {
  bucket   = aws_s3_bucket.mybucket.id
  for_each = fileset("/home/user/Desktop/file", "*")
  key      = each.value
  source   = "/home/user/Desktop/file/$(each.value)"

  etag = filemd5("/home/user/Desktop/file.txt")
}
*/
