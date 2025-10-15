### Create a VPC

```bash
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=xfusion-pub-vpc}]'
```

### Enable DNS hostnames (so instances get public DNS)

```bash
aws ec2 modify-vpc-attribute \
  --vpc-id vpc-0e370c4483934b06d \
  --enable-dns-support "{\"Value\":true}"

aws ec2 modify-vpc-attribute \
  --vpc-id vpc-0e370c4483934b06d \
  --enable-dns-hostnames "{\"Value\":true}"
```

### Create a Public Subnet

```bash
aws ec2 create-subnet \
  --vpc-id vpc-0e370c4483934b06d \
  --cidr-block 10.0.1.0/24 \
  --availability-zone us-east-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=xfusion-pub-subnet}]'
```

### Subnets list under that VPC

```bash
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-0e370c4483934b06d" \
  --query "Subnets[*].{SubnetId:SubnetId, CidrBlock:CidrBlock, MapPublicIpOnLaunch:MapPublicIpOnLaunch, AvailabilityZone:AvailabilityZone}" \
  --output table
```

### Enable Auto-Assign Public IPs for the Subnet

```bash
aws ec2 modify-subnet-attribute \
  --subnet-id subnet-04e284f9833df4e25 \
  --map-public-ip-on-launch
```

### Check IGW ID list

```bash
aws ec2 describe-internet-gateways \
  --query "InternetGateways[*].{IGW_ID:InternetGatewayId,VPC_ID:Attachments[0].VpcId,State:Attachments[0].State,Tags:Tags}" \
  --output table
```

### Create and Attach an Internet Gateway

```bash
aws ec2 create-internet-gateway \
  --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=xfusion-pub-igw}]'

aws ec2 attach-internet-gateway \
  --vpc-id vpc-0e370c4483934b06d \
  --internet-gateway-id igw-08301e65419d1e880
```

### Create a Route Table and Add a Public Route

```bash
aws ec2 create-route \
  --route-table-id rtb-08c2a706e983bc3d9 \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-08301e65419d1e880
```

### List all route tables in your VPC

```bash
aws ec2 describe-route-tables \
  --filters "Name=vpc-id,Values=vpc-0e370c4483934b06d" \
  --query "RouteTables[*].{RouteTableId:RouteTableId,Main:Associations[0].Main,Tags:Tags}" \
  --output table
```

### Add a route to the internet

```bash
aws ec2 create-route \
  --route-table-id rtb-08c2a706e983bc3d9 \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-08301e65419d1e880
```

### Associate the route table with your subnet (if not associated yet)

```bash
aws ec2 associate-route-table \
  --subnet-id subnet-04e284f9833df4e25 \
  --route-table-id rtb-08c2a706e983bc3d9
```

### Enable auto-assign public IP on your subnet

```bash
aws ec2 describe-subnets \
  --subnet-ids subnet-04e284f9833df4e25 \
  --query "Subnets[*].MapPublicIpOnLaunch"
```

```bash
aws ec2 modify-subnet-attribute \
  --subnet-id subnet-04e284f9833df4e25 \
  --map-public-ip-on-launch
```

### Create security group

```bash
aws ec2 create-security-group \
  --group-name xfusion-pub-sg \
  --description "Public SSH access" \
  --vpc-id vpc-0e370c4483934b06d
```

### List all security groups in your VPC

```bash
aws ec2 describe-security-groups \
  --filters "Name=vpc-id,Values=vpc-0e370c4483934b06d" \
  --query "SecurityGroups[*].{GroupId:GroupId,GroupName:GroupName,Description:Description,Tags:Tags}" \
  --output table
```

### Allow inbound SSH

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-0e3c9d75343d58c9b \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

### List the latest Amazon Linux 2 AMI (most common)

```bash
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
  --query "sort_by(Images, &CreationDate)[-1].{Name:Name,ImageId:ImageId}" \
  --output table
```

### Create a new key pair

```bash
aws ec2 create-key-pair \
  --key-name my-keypair \
  --query "KeyMaterial" \
  --output text > my-keypair.pem
```

### Launch an EC2 Instance

```bash
aws ec2 run-instances \
  --image-id ami-057a9f77fd28e08c5 \
  --instance-type t2.micro \
  --key-name my-keypair \
  --subnet-id subnet-04e284f9833df4e25 \
  --security-group-ids sg-0e3c9d75343d58c9b \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-pub-ec2}]'
```

### Confirm Your Instance Is Running

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-pub-ec2" \
  --query "Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,PublicIP:PublicIpAddress,KeyName:KeyName}" \
  --output table
```

### Check Public IP

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-pub-ec2" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text
```

### Login

```bash
chmod 400 my-keypair.pem
ssh -i my-keypair.pem ec2-user@44.223.61.243
```
