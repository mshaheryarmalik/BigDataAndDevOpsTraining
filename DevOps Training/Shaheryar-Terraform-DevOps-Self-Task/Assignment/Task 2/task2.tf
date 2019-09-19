provider "aws" {
  profile    = "default"
  region     = var.region
}

# Bastion Host in public subnet
resource "aws_instance" "shaheryar_ec2_in_public_subnet" {
  ami =  "ami-b374d5a5"
  instance_type = "t2.micro"
  subnet_id = var.publicSubnetId
  associate_public_ip_address = "true"
  key_name = "shaheryar"
  vpc_security_group_ids = [var.securityGroupId]
  tags = {
    Name = "Shaheryar-Bastion-Host"
  }
}

# EC2 instance in private subnet
resource "aws_instance" "shaheryar_ec2_in_private_subnet" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  subnet_id = var.privateSubnetId
  tags = {
    Name = "Shaheryar-EC2-In-Private-Subnet"
  }
}