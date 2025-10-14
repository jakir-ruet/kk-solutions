###

```bash
aws ec2 describe-vpcs --query "Vpcs[*].{ID:VpcId,Name:Tags[?Key=='Name']|[0].Value}" --output table
```

### private security group

```bash
aws ec2 create-security-group \
  --group-name nautilus-private-sg \
  --description "Private SG for Nautilus RDS" \
  --vpc-id vpc-047a176010f35f830
```

### Add an inbound rule for MySQL (3306)

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-0abcd1234efgh5678 \
  --protocol tcp \
  --port 3306 \
  --cidr 10.0.0.0/16
```

```bash
aws ec2 describe-security-groups \
  --filters "Name=vpc-id,Values=047a176010f35f830" \
  --query "SecurityGroups[*].{ID:GroupId,Name:GroupName,Description:Description}" \
  --output table
```

```bash
aws ec2 describe-subnets \
  --filters "Name=vpc-id,Values=vpc-047a176010f35f830" \
  --query "Subnets[*].{SubnetId:SubnetId,AZ:AvailabilityZone,CIDR:CidrBlock,PublicIPAutoAssign:MapPublicIpOnLaunch}" \
  --output table
```

### disable public IP assignment on both:

```bash
aws ec2 modify-subnet-attribute \
  --subnet-id subnet-07dd91e464282a720 \
  --no-map-public-ip-on-launch

aws ec2 modify-subnet-attribute \
  --subnet-id subnet-0a00a13c5a97fd6d8 \
  --no-map-public-ip-on-launch
```

### Create the RDS Subnet Group (if not already existing)

```bash
aws rds create-db-subnet-group \
  --db-subnet-group-name sandbox \
  --db-subnet-group-description "Private subnet group for Nautilus RDS" \
  --subnet-ids subnet-07dd91e464282a720 subnet-0a00a13c5a97fd6d8
```

### Create the RDS Instance

```bash
aws rds create-db-instance \
  --db-instance-identifier nautilus-rds \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --engine-version 8.4.5 \
  --master-username admin \
  --master-user-password 'MyStrongPassword123!' \
  --allocated-storage 20 \
  --max-allocated-storage 50 \
  --storage-type gp2 \
  --db-subnet-group-name nautilus-sandbox-subnet-group \
  --vpc-security-group-ids sg-0b216bcbebfbbea22 \
  --publicly-accessible false \
  --backup-retention-period 7
```
