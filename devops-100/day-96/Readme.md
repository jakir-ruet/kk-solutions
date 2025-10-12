```bash
terraform init
terraform plan
mkdir -p ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
terraform apply
yes
terraform show
```
