

## Setting up our orchestration tool

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



Note that when we first ran terraform in or OS, we had to add ENV variables, to do this
in my controller all we must do is export the variable with the key

```
export AWS_ACCESS_KEY=your_key
export AWS_SECRET_KEY=your_key
```


we want to destroy all our VPCs and instances before we run them again,
this can be done by running

```
terraform destroy
```
We can then run terraform apply and all our of resources will be created on AWS


## Setting up our configuration management tool

- add steps to download ansible here -


- Since we have added the IP's of our
