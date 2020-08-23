

## Downloading Ansible on our Virtual Machine

- All these dependencies are necessary to use Ansible

```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

```

- And all the EC2 dependencies...

```
sudo apt install python

sudo apt install python-pip -y

sudo pip install --upgrade pip

sudo pip install boto

sudo pip install boto3
```

## Downloading Terraform on our Virtual Machine

```
wget -q -O - https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
sudo echo 'deb [arch=amd64] https://tjend.github.io/repo_terraform stable main' >> /etc/apt/sources.list.d/terraform.list
sudo apt-get update
sudo apt-get install terraform
```

## Adding IP's of EC2 to allow provisioning

- We can enter the hosts file for Ansible by running

```
sudo nano /etc/ansible/hosts

```
- Then add the correct IP of your instances
```
[web]
ubuntu@54.170.222.163

[db]
ubuntu@18.203.172.245

```


## Adding DevOps Key to allow EC2 provisioning

- To set up SSH agent to avoid retyping passwords, you can do:

```
$ ssh-agent bash
$ ssh-add ~/.ssh/DevOpsStudents.pem
```
- This allows us to run our ansible playbook freely


## Adding AWS keys as environment variables

Note that when we first ran terraform in or OS, we had to add ENV variables, to do this
in my controller all we must do is export the variable with the key

```
export AWS_ACCESS_KEY=your_key
export AWS_SECRET_KEY=your_key
```

## Automating the Process

- We will create a bash script that runs terraform apply and then runs our ansible playbook
that will provision our instances and run our application on a web browser

## Future Iteration

- The next step would be to implement a CI/CD pipeline
- Whenever code is pushed to a dev branch, the code is tested and if passed pushed to our master branch
- This will then trigger a CD build that will run an execute shell to SSH into our controller and run our script
that will reboot our EC2's and provision our infrastructure, displaying the changes made when our app is run on
the web browser
