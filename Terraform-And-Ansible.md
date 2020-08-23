

## Downloading Ansible on our Virtual Machine

- All these dependencies are necessary to use Ansible

```


```


## Downloading Terraform on our Virtual Machine

```
mkdir ~/bin
```

```
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
```

```
unzip terraform_0.12.24_linux_amd64.zip
```

```
mv terraform ~/bin
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
