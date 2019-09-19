# Create VPC/ Public-Private Subnets/ Security Group
provider "aws" {
		profile    = "default"
        region     = "${var.region}"
} # end provider

# create the VPC
resource "aws_vpc" "Shaheryar_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames = "${var.dnsHostNames}"
  tags = {
    Name = "Shaheryar VPC"
  }
} # end resource

# create the Public Subnet 1
resource "aws_subnet" "Shaheryar_VPC_Public_Subnet_1" {
  vpc_id                  = "${aws_vpc.Shaheryar_VPC.id}"
  cidr_block              = "${var.PublicSubnetCIDRblock1}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  tags = {
   Name = "Shaheryar VPC Public Subnet 1"
  }
} # end resource

# create the Public Subnet 2
resource "aws_subnet" "Shaheryar_VPC_Public_Subnet_2" {
  vpc_id                  = "${aws_vpc.Shaheryar_VPC.id}"
  cidr_block              = "${var.PublicSubnetCIDRblock2}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  tags = {
   Name = "Shaheryar VPC Public Subnet 2"
  }
} # end resource

# create the Private Subnet 1
resource "aws_subnet" "Shaheryar_VPC_Private_Subnet_1" {
  vpc_id                  = "${aws_vpc.Shaheryar_VPC.id}"
  cidr_block              = "${var.PrivateSubnetCIDRblock1}"
  availability_zone       = "${var.availabilityZone}"
  tags = {
   Name = "Shaheryar VPC Private Subnet 1"
  }
} # end resource

# create the Private Subnet 2
resource "aws_subnet" "Shaheryar_VPC_Private_Subnet_2" {
  vpc_id                  = "${aws_vpc.Shaheryar_VPC.id}"
  cidr_block              = "${var.PrivateSubnetCIDRblock2}"
  availability_zone       = "${var.availabilityZone}"
  tags = {
   Name = "Shaheryar VPC Private Subnet 2"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "Shaheryar_VPC_Security_Group" {
  vpc_id       = "${aws_vpc.Shaheryar_VPC.id}"
  name         = "Shaheryar VPC Security Group"
  description  = "Shaheryar VPC Security Group"
  tags = {
        Name = "Shaheryar VPC Security Group"
  }
} # end resource