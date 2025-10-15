### Create a New VPC

```bash
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=sandbox-vpc}]'
```

### Create Private Subnets

```bash
aws ec2 create-subnet \
  --vpc-id vpc-0f33712d23ef1b8f5 \
  --cidr-block 10.0.1.0/24 \
  --availability-zone us-east-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=sandbox-private-subnet-1}]'

aws ec2 create-subnet \
  --vpc-id vpc-0f33712d23ef1b8f5 \
  --cidr-block 10.0.2.0/24 \
  --availability-zone us-east-1b \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=sandbox-private-subnet-2}]'
```

### Create Security Group

```bash
aws ec2 create-security-group \
  --group-name xfusion-rds-sg \
  --description "Security group for private RDS MySQL instance" \
  --vpc-id vpc-0f33712d23ef1b8f5
```

### Allow MySQL access only within the VPC:

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-03b259b93e4c3c9d2 \
  --protocol tcp \
  --port 3306 \
  --cidr 10.0.0.0/16
```

### Check subnets

```bash
aws ec2 describe-subnets \
  --filters "Name=vpc-id,Values=vpc-0f33712d23ef1b8f5" \
  --query 'Subnets[*].{SubnetId:SubnetId,AZ:AvailabilityZone,MapPublicIpOnLaunch:MapPublicIpOnLaunch,CidrBlock:CidrBlock,State:State,Name:Tags[?Key==`Name`].Value | [0]}' \
  --output table
```

### Create DB Subnet Group

```bash
aws rds create-db-subnet-group \
  --db-subnet-group-name sandbox-private-subnet-group \
  --db-subnet-group-description "Private subnet group for sandbox RDS" \
  --subnet-ids subnet-0fc79ba899e0c97db subnet-02290fce5226e8716
```

### Create the private RDS Instance

```bash
aws rds create-db-instance \
  --db-instance-identifier xfusion-rds \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --engine-version 8.4.5 \
  --allocated-storage 20 \
  --max-allocated-storage 50 \
  --master-username admin \
  --master-user-password MySecurePass123! \
  --vpc-security-group-ids sg-03b259b93e4c3c9d2 \
  --db-subnet-group-name sandbox-private-subnet-group \
  --no-publicly-accessible \
  --storage-type gp2 \
  --backup-retention-period 0 \
  --no-multi-az \
  --region us-east-1
```

### Check and connect

```bash
Endpoint xfusion-rds.cfi8w1vecvwo.us-east-1.rds.amazonaws.com Port 3306
```
