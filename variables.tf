# Creating reusable variables to use in main.tf

# using vpc_id in main.tf



variable "vpc_id" {
    type = string
    default = "vpc-07e47e9d90d2076da"
}

variable "name" {
    type = string
    default = "Eng67.Andrew.Terraform.Webapp"
}

variable "app_ami_id" {
    type = string
    default = "ami-07728cccf10589b2c"
}
