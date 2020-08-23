# Creating main file that we will launch our AMI on AWS

# Must tell the file what to do and where we would like to create the instance

# syntax for terraform is similar to json where we use {  }




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


## Creating IGW
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Eng67.Andrew.Terraform.IGW"
  }
}

# Creating a public route table

resource "aws_route_table" "pub-r" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }


  tags = {
    Name = "Eng67.Andrew.Terraform.Pub"
  }
}


# Creating a private route table

resource "aws_route_table" "priv_r" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "141.22.0.0/16"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Eng67.Andrew.Terraform.Priv"
  }
}


# Creating a Subnet

# the "main" is the unique identifier of the resource which is called "aws_subnet"
resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "141.22.1.0/24"

  tags = {
    Name = "Eng67.Andrew.Terraform.Subnet-Public"
  }
}

resource "aws_subnet" "priv" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "141.22.2.0/24"

  tags = {
    Name = "Eng67.Andrew.Terraform.Subnet-Private"
  }
}


## App security group

resource "aws_security_group" "allow_tls" {
  name        = "Eng67.Andrew.Public-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # here we are allowing anyone to enter our app at port 80, thus the 'http'
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # here we are allowing anyone to enter our app at port 80, thus the 'http'
    cidr_blocks = ["77.98.125.189/32"]
  }

# the -1 for protocol refers to
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Eng67.Andrew.Public-SG"
  }
}

## Database security group

resource "aws_security_group" "allow_tls" {
  name        = "Eng67.Andrew.Private-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


  ingress {
    description = "SSH from port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # here we are allowing anyone to enter our app at port 80, thus the 'http'
    cidr_blocks = ["77.98.125.189/32"]
  }

# the -1 for protocol refers to
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Eng67.Andrew.Private-SG"
  }
}


## Bastion security group

resource "aws_security_group" "allow_tls" {
  name        = "Eng67.Andrew.Private-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


  ingress {
    description = "SSH from port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # here we are allowing anyone to enter our app at port 80, thus the 'http'
    cidr_blocks = ["77.98.125.189/32"]
  }

# the -1 for protocol refers to
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Eng67.Andrew.Private-SG"
  }
}


provider "aws" {
# Which  region do we have the AMI available
    region = "eu-west-1"


}

# Create and instance - launch an instance from the AMI

resource "aws_instance" "app_instance" {
          ami          = var.app_ami_id

# What tpye of ec2 instance we want to create?
          instance_type = "t2.micro"

# Assign public ip?
          associate_public_ip_address = true


# Linking security group to instance
          vpc_security_group_ids = [aws_security_group.allow_tls.id]
          subnet_id = aws_subnet.pub.id

          tags = {
              Name = var.name
          }
}


resource "aws_instance" "db_instance" {
          ami          = "ami-0b18bc5452acec332"

# What type of ec2 instance we want to create?
          instance_type = "t2.micro"

# Assign public ip?
          associate_public_ip_address = true


# Linking security group to instance
          vpc_security_group_ids = aws_security_group.allow_tls.id
          subnet_id = aws_subnet.priv.id

          tags = {
              Name = "Eng67.Andrew.Terraform.Database"
          }
}

resource "aws_instance" "bastion_instance" {
          ami          = "ami-0a1f79888065a97f5"

# What type of ec2 instance we want to create?
          instance_type = "t2.micro"

# Assign public ip?
          associate_public_ip_address = true


# Linking security group to instance
          vpc_security_group_ids = [aws_security_group.allow_tls.id]
          subnet_id = aws_subnet.pub.id

          tags = {
              Name = "Eng67.Andrew.Terraform.Bastion"
          }
}


# create a subnet block of code
# attach this subnet to devopsstudent vpc
# create a security group and attach to VPC
# protocol tcp
# create ingress block of code to allow port 80 and 0.0.0.0/0
# create egress block of code to allow all
