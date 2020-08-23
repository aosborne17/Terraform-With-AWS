# Infrastructure as code with Terraform

### What is Terraform?

- There are two sides of IAC
- 1: Configuration Management
- 2: Orchestration

Ansible - Configuration Management
Terraform - Orchestration
Kubernetes - Orchestration is used in containerisation  - i.e Docker, Crio, Rocket


## Why should you integrate Terraform?

- It runs on premise which is free of cost, we spend no money until we are ready
to push it into production

-


## Initisialising Terraform

```
terraform init
```

![](/images/terraform-init.png)

We will be adding the code to create our EC2 in the `main.tf` file

### Terraform commands
```
  terraform init - initisialises terraform
  terraform plan - checks the steps inside the code and lists the success or failures
  terraform apply - will implement the code, deploying the infrastructure
```

Note it is good practice to run terraform plan before running apply so we can see
any faults before we make those changes


if you run terraform apply after making changes, it will then reboot the instance
with the changes in place e.g. any subnets or security groups we have added
