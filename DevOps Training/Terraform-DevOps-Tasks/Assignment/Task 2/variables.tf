# variables.tf

variable "region" {
 default = "us-east-1"
}
variable "availabilityZone" {
        default = "us-east-1a"
}
variable "instanceTenancy" {
 default = "default"
}
variable "dnsSupport" {
 default = true
}
variable "dnsHostNames" {
        default = true
}
variable "vpcCIDRblock" {
 default = "10.0.0.0/16"
}
variable "PublicSubnetCIDRblock1" {
        default = "10.0.1.0/24"
}
variable "PublicSubnetCIDRblock2" {
        default = "10.0.2.0/24"
}
variable "PrivateSubnetCIDRblock1" {
        default = "10.0.3.0/24"
}
variable "PrivateSubnetCIDRblock2" {
        default = "10.0.4.0/24"
}
variable "mapPublicIP" {
        default = true
}
variable "ingressCIDRblock" {
        type = "list"
        default = [ "0.0.0.0/0" ]
}

variable "destinationCIDRblock" {
        default = "0.0.0.0/0"
}

# end of variables.tf