### Get the VPC IDs

```bash
aws ec2 describe-vpcs --query "Vpcs[*].{ID:VpcId,Name:Tags[?Key=='Name']|[0].Value,CIDR:CidrBlock}" --output table
```

### Get subnet IDs (optional, for verification)

```bash
aws ec2 describe-subnets --query "Subnets[*].{ID:SubnetId,Name:Tags[?Key=='Name']|[0].Value,VPC:VpcId}" --output table
```

### Create the VPC Peering Connection

```bash
aws ec2 create-vpc-peering-connection \
  --vpc-id vpc-0722bce46b70f227d \
  --peer-vpc-id vpc-0473065fb2324e65d \
  --tag-specifications 'ResourceType=vpc-peering-connection,Tags=[{Key=Name,Value=datacenter-vpc-peering}]'
```

### Accept the Peering

```bash
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-07dbb51dfc8c5bb06
```

### Route table details

```bash
aws ec2 describe-route-tables \
  --query "RouteTables[*].{RouteTableId:RouteTableId,VPC:VpcId,Name:Tags[?Key=='Name']|[0].Value}" \
  --output table
```

### Add route in the Private VPC’s Route Table

```bash
aws ec2 create-route \
  --route-table-id rtb-062b7e1ae4d4e11bd \
  --destination-cidr-block 172.31.0.0/16 \
  --vpc-peering-connection-id pcx-07dbb51dfc8c5bb06
```

### Add route in the Default/Public VPC’s Route Table

```bash
aws ec2 create-route \
  --route-table-id rtb-00606f36e36706005 \
  --destination-cidr-block 10.1.0.0/16 \
  --vpc-peering-connection-id pcx-07dbb51dfc8c5bb06
```

### Verify Routes

```bash
aws ec2 describe-route-tables --route-table-ids rtb-062b7e1ae4d4e11bd rtb-00606f36e36706005 --output table
```

### Update Security Group for Private EC2

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-private-ec2" \
  --query "Reservations[*].Instances[*].SecurityGroups[*].GroupId" \
  --output text
```

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-06461ba547ad39f17 \
  --protocol icmp \
  --port -1 \
  --cidr 172.31.0.0/16
```

### Get Private Instance IP

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-private-ec2" \
  --query "Reservations[*].Instances[*].PrivateIpAddress" \
  --output text
```

### public IP of `public-ec2-public-ip`

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-public-ec2" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text
```

### Find the Security Group for datacenter-public-ec2

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-public-ec2" \
  --query "Reservations[*].Instances[*].SecurityGroups[*].GroupId" \
  --output text
```

### Allow SSH (port 22) from your IP

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-08d525bbc3ffcab0d \
  --protocol tcp \
  --port 22 \
  --cidr 35.188.139.128/32
```

### Use EC2 Instance Connect (Easiest if allowed)

```bash
aws ec2-instance-connect send-ssh-public-key \
  --instance-id $(aws ec2 describe-instances --filters "Name=tag:Name,Values=datacenter-public-ec2" --query "Reservations[*].Instances[*].InstanceId" --output text) \
  --availability-zone $(aws ec2 describe-instances --filters "Name=tag:Name,Values=datacenter-public-ec2" --query "Reservations[*].Instances[*].Placement.AvailabilityZone" --output text) \
  --instance-os-user ec2-user \
  --ssh-public-key file://~/.ssh/id_rsa.pub
```

### Test

```bash
ssh -i ~/.ssh/id_rsa ec2-user@54.234.94.19
```
