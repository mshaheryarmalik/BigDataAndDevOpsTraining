provider "aws" {
  profile    = "default"
  region     = var.region
}

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

# Create the Security Group for Public Host
resource "aws_security_group" "Shaheryar_VPC_Security_Group_Public" {
  vpc_id       = "${aws_vpc.Shaheryar_VPC.id}"
  name         = "Shaheryar VPC Security Group Public EC2"
  description  = "Shaheryar VPC Security Group Public EC2"
  tags = {
        Name = "Shaheryar VPC Security Group Public EC2"
  }
  ingress {
    cidr_blocks = "${var.ingressCIDRblock}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
	protocol = -1
	from_port = 0 
	to_port = 0 
	cidr_blocks = ["0.0.0.0/0"]
	}
} # end resource

# Create the Security Group for Private Instance
resource "aws_security_group" "Shaheryar_VPC_Security_Group_Private" {
  vpc_id       = "${aws_vpc.Shaheryar_VPC.id}"
  name         = "Shaheryar VPC Security Group Private EC2"
  description  = "Shaheryar VPC Security Group Private EC2"
  tags = {
        Name = "Shaheryar VPC Security Group Private EC2"
  }
  ingress {
    cidr_blocks = ["10.0.1.0/24"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "Shaheryar_VPC_GW" {
  vpc_id = "${aws_vpc.Shaheryar_VPC.id}"
  tags = {
        Name = "Shaheryar VPC Internet Gateway"
    }
} # end resource

# Create the Route Table
resource "aws_route_table" "Shaheryar_VPC_route_table" {
    vpc_id = "${aws_vpc.Shaheryar_VPC.id}"
  tags = {
        Name = "Shaheryar VPC Route Table"
    }
} # end resource

# Create the Internet Access
resource "aws_route" "Shaheryar_VPC_internet_access" {
  route_table_id        = "${aws_route_table.Shaheryar_VPC_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.Shaheryar_VPC_GW.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "Shaheryar_VPC_association" {
    subnet_id      = "${aws_subnet.Shaheryar_VPC_Public_Subnet_1.id}"
    route_table_id = "${aws_route_table.Shaheryar_VPC_route_table.id}"
} # end resource

# Bastion Host in public subnet
resource "aws_instance" "shaheryar_ec2_in_public_subnet" {
  ami =  "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.Shaheryar_VPC_Public_Subnet_1.id}"
  associate_public_ip_address = "true"
  key_name = "shaheryarmalik"
  vpc_security_group_ids = [ "${aws_security_group.Shaheryar_VPC_Security_Group_Public.id}" ]
  tags = {
    Name = "Shaheryar-Bastion-Host-EC2"
  }
}

# EC2 instance in private subnet
resource "aws_instance" "shaheryar_ec2_in_private_subnet" {
  ami =  "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.Shaheryar_VPC_Private_Subnet_1.id}"
  key_name = "shaheryarmalik"
  vpc_security_group_ids = [ "${aws_security_group.Shaheryar_VPC_Security_Group_Private.id}" ]
  tags = {
    Name = "Shaheryar-EC2-In-Private-Subnet"
  }
}

