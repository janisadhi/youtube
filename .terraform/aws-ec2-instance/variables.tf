variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"  # You can change this to your desired AWS region
}

variable "ami_id" {
  description = "Enter the AMI ID"
  type        = string
  default     = "ami-09a9858973b288bdd"  # You can change this as needed  
}

variable "instance_type" {
  description = "Enter the instance type"
  type        = string
  default     = "t3.micro"  # You can change this as needed
}

variable "key_name" {
  description = "Enter the key pair name"
  type        = string
  default = "sibersegment"
}

variable "instance_name" {
  description = "Enter the name of the EC2 instance"
  type        = string
  default = "my-ec2-instance"
}
