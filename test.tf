# Creating main file that we will launch our AMI on AWS

# Must tell the file what to do and where we would like to create the instance

# syntax for terraform is similar to json where we use {  }


provider "aws" {
# Which  region do we have the AMI available
    region = "eu-west-1"


}


# Creating a VPC

resource "aws_vpc" "prod-vpc" {
    cidr_block = "141.22.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
      Name = "Eng67.Andrew.Terraform.VPC"
    }
}




# Creating Public subnet

# the "main" is the unique identifier of the resource which is called "aws_subnet"
resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "141.22.1.0/24"

  tags = {
    Name = "Eng67.Andrew.Terraform.Subnet-Public"
  }
}


# Creating Private subnet
resource "aws_subnet" "priv" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "141.22.2.0/24"

  tags = {
    Name = "Eng67.Andrew.Terraform.Subnet-Private"
  }
}


resource "aws_network_acl" "pub" {
  vpc_id = aws_vpc.prod-vpc.id

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Eng67.Andrew.Public.NACL.Terraform"
  }
}


resource "aws_network_acl" "priv" {
  vpc_id = aws_vpc.prod-vpc.id

  ingress {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }

    egress {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
