# Creating main file that we will launch our AMI on AWS

# Must tell the file what to do and where we would like to create the instance

# syntax for terraform is similar to json where we use {  }



provider "aws" {
# Which  region do we have the AMI available
    region = "eu-west-1"


}





# Create an instance - launch an instance from the AMI

resource "aws_instance" "app_instance" {
          ami          = "ami-0f6c07744b6402c0d"
          key_name = "DevOpsStudents"

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


output "public_ip_app" {
  value = aws_instance.app_instance.public_ip
}


resource "aws_instance" "db_instance" {
          ami          = "ami-0b18bc5452acec332"
          key_name = "DevOpsStudents"

# What type of ec2 instance we want to create?
          instance_type = "t2.micro"

# Assign public ip?
          associate_public_ip_address = true


# Linking security group to instance
          vpc_security_group_ids = [aws_security_group.database.id]
          subnet_id = aws_subnet.priv.id

          tags = {
              Name = "Eng67.Andrew.Terraform.Database"
          }

}
