### Get the latest Ubuntu AMI ID

```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*' 'Name=state,Values=available' \
  --query 'Images | sort_by(@, &CreationDate)[-1].ImageId' \
  --output text
```

### Create a Security Group

```bash
aws ec2 create-security-group \
  --group-name xfusion-sg \
  --description "Allow HTTP and SSH access for xfusion-ec2"
```

### Now add rules

```bash
# Allow HTTP from anywhere
aws ec2 authorize-security-group-ingress \
  --group-id sg-038584906899bca3d \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

# Allow SSH from your IP (replace with your real IP)
aws ec2 authorize-security-group-ingress \
  --group-id sg-038584906899bca3d \
  --protocol tcp \
  --port 22 \
  --cidr $(curl -s ifconfig.me)/32
```

### Create a Key Pair (if you don’t have one)

```bash
aws ec2 create-key-pair \
  --key-name xfusion-key \
  --query 'KeyMaterial' \
  --output text > xfusion-key.pem
```

```bash
chmod 400 xfusion-key.pem
```

### Create a User Data Script

```bash
cat <<'EOF' > user-data.sh
#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx
EOF
```

### Launch the EC2 Instance

```bash
aws ec2 run-instances \
  --image-id ami-07a3add10195338ad \
  --instance-type t2.micro \
  --key-name xfusion-key \
  --security-group-ids sg-038584906899bca3d \
  --user-data file://user-data.sh \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-ec2}]' \
  --associate-public-ip-address
```

### Verify the Instance

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-ec2" \
  --query "Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]" \
  --output table
```

```bash
aws ec2 describe-instance-status \
  --instance-id i-09607decdda0aafe7 \
  --query "InstanceStatuses[*].InstanceStatus.Status" \
  --output text
```

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-ec2" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text
```

```bash
3.82.44.245
```

```bash
curl http://3.82.44.245
```
