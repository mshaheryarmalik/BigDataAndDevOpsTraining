# variables.tf
variable "region" {
 default = "us-east-1"
}

variable "publicSubnetId" {
	default = "subnet-04db63619dffc549c"
}

variable "privateSubnetId" {
	default = "subnet-0956834b320606ab7"
}

variable "securityGroupId" {
	default = "sg-0b5e689c4762cbd5f"
}

variable "vpc_id" {
	default = "vpc-0f0e4986e8eb44c7c"
}
# end of variables.tf