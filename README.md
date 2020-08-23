# Infrastructure as code with Terraform

### What is Terraform?

- There are two sides of IAC
- 1: Configuration Management
- 2: Orchestration

Ansible - Configuration Management
Terraform - Orchestration Tool
Kubernetes - Orchestration is used in containerisation  - i.e Docker, Crio, Rocket


## Why should you integrate Terraform?

- It can be ran on premise which is free of cost, we spend no money until we are ready
to push it into production

- An orchestration tool that allows for the creation of multiple cloud compute services
all through one script


## Initisialising Terraform

```
terraform init
```

![](/images/terraform-init.png)

### Terraform commands
```
  terraform init - initisialises terraform
  terraform plan - checks the steps inside the code and lists the success or failures
  terraform apply - will implement the code, deploying the infrastructure
  terraform destroy - will destroy all the cloud services that have been created
  terraform output - This will output any of the variables that have been specified
```

Note it is good practice to run terraform plan before running apply so we can see
any faults before we make those changes


if you run terraform apply after making changes, it will then reboot the instance
with the changes in place e.g. any subnets or security groups we have added



## Creating our cloud services

Our orchestration has been split into three files

- main.tf will have the name of the cloud service provider we are using as well as the
EC2 instances

- the network.tf file will have the configuration for all the network related things created

- the security.tf file contains all of the security related items for our VPC


## Creating an image using AWS

- When we run our instances we must set an AMI id in which they can build from, remember
AMI's are the blueprint which allow us to create instances

- We can create an image of one of our own EC2 images and use this ami-id to run additional EC2's
or we can use the default Ubuntu linux ami


## Terraform Output

- Terraform output allows us to see the value of a variable that we can specify in our terraform script

```
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
```

- Here we are asking for the public ip of our app instance because whenever it is created
we get a random ip
- When we run terraform output, our public ip will be shown in the terminal


## Using Ansible with Terraform

- We can use Terraform to create our servers and then Ansible to provision them,
this ensures that our development environment remains consistent and thus limiting
the bugs we would come across

- This can be done by creating a script that will run terraform apply followed by the ansible playbook
that will provision both our app and db with the required dependencies to run our app,
in this case the node application

- We can download both terraform and ansible through an on premise Virtual machine and do all the work to our
cloud computers from there
