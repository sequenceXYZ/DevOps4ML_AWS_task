variable "aws_region" {
  description = "The AWS region for the resource"
  type        = string
  default     = "eu-central-1"
}

variable "key_name" {
  description = "The name of the AWS key pair"
  type        = string
  default     = "Agnija_key"
}

variable "ami_id" {
  description = "AMI ID of the instance"
  type        = string
  default     = "ami-*"
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of the instances"
  type        = number
  default     = 1
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the instance"
  type        = string
  default     = "role-*"
}

variable "https_port" {
  description = "https server port"
  type        = number
  default     = 443
}

variable "s3_bucket_name" {
  description = "s3_bucket_name"
  type        = string
  default     = "<bucket-name>"
}

variable "cidr_blocks" {
  type = string
  default = ["private.ip"]
}

