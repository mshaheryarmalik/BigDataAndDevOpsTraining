variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

provider "aws" {
  profile    = "default"
  region     = var.region
}


resource "aws_s3_bucket" "shaheryar-malik-devops-terraform-bucket" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "shaheryar-malik-devops-terraform-bucket"
  acl    = "private"
}

resource "aws_instance" "shaheryar_ec2" {
  ami =  var.amis[var.region]
  instance_type = "t2.micro"
  tags = {
    Name = "Shaheryar-EC2-Terraform"
  }
  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = [aws_s3_bucket.shaheryar-malik-devops-terraform-bucket]
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.shaheryar_ec2.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.shaheryar_ec2.id
}

resource "aws_instance" "another-ec2-shaheryar" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  tags = {
    Name = "Shaheryar-Another-EC2-Terraform"
  }
}


output "ip" {
  value = aws_eip.ip.public_ip
}