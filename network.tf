
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

resource "aws_route_table" "priv-r" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Eng67.Andrew.Terraform.Priv"
  }
}



## Route Table Associations

resource "aws_route_table_association" "prod-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.pub.id}"
    route_table_id = "${aws_route_table.pub-r.id}"
}

resource "aws_route_table_association" "prod-crta-private-subnet-1"{
    subnet_id = "${aws_subnet.priv.id}"
    route_table_id = "${aws_route_table.priv-r.id}"
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
