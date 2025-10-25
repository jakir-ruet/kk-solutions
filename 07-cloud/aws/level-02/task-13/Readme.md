### Get VPC ID's

```bash
aws ec2 describe-vpcs --output table
```

### Create a VPC Peering Connection

```bash
aws ec2 create-vpc-peering-connection \
    --vpc-id vpc-0dc13e1dd5193f601 \
    --peer-vpc-id vpc-01343d386cc0e3f22 \
    --tag-specifications 'ResourceType=vpc-peering-connection,Tags=[{Key=Name,Value=devops-vpc-peering}]'
```

### Accept the Peering Connection

```bash
aws ec2 accept-vpc-peering-connection \
    --vpc-peering-connection-id pcx-0423d6b77adc01b5a
```

### Route table ID

```bash
aws ec2 describe-route-tables \
    --query 'RouteTables[*].{
        ID: RouteTableId,
        Name: Tags[?Key==`Name`]|[0].Value,
        Category: (contains(Routes[].GatewayId, `igw-`) && `Public`) || `Private`
    }' \
    --output table
```

### Private VPC's CIDR

```bash
aws ec2 describe-vpcs \
    --filters Name=isDefault,Values=false \
    --query 'Vpcs[*].{VPC_ID:VpcId,CIDR:CidrBlock}' \
    --output table
```

### Default VPC's CIDR

```bash
aws ec2 describe-vpcs \
    --filters Name=isDefault,Values=true \
    --query 'Vpcs[*].{VPC_ID:VpcId,CIDR:CidrBlock}' \
    --output table
```

### Update Route Tables

#### Private VPC route table (devops-private-vpc)

```bash
# private-vpc-route-table-id `rtb-060bd8fa829d1f32c`
aws ec2 create-route \
    --route-table-id rtb-0a30e8f01ca706582 \
    --destination-cidr-block 172.31.0.0/16 \
    --vpc-peering-connection-id pcx-0423d6b77adc01b5a
```

#### Default/Public VPC route table

```bash
# public-vpc-route-table-id  `rtb-0f99a613a2eca8663`
aws ec2 create-route \
    --route-table-id rtb-075d42896b0ccbca5 \
    --destination-cidr-block 10.1.0.0/16 \
    --vpc-peering-connection-id pcx-0423d6b77adc01b5a
```

### Update Security Groups

```bash
# private sg `sg-0d40b6ee5901e06fd `
# default-vpc-cidr `172.31.0.0/16`
# Allow ICMP (ping)
aws ec2 authorize-security-group-ingress \
    --group-id sg-0a6cfa32aaae83b4c \
    --protocol icmp \
    --port -1 \
    --cidr 172.31.0.0/16

# Allow SSH (port 22)
aws ec2 authorize-security-group-ingress \
    --group-id sg-0a6cfa32aaae83b4c \
    --protocol tcp \
    --port 22 \
    --cidr 172.31.0.0/16
```

### Determine your public IP

```bash
curl http://checkip.amazonaws.com/
```

### Public EC2 instance security group

```bash
# public-ec2-sg-id `sg-0ea1ea00643995cf7`
# your-local-ip `3.90.2.46`
aws ec2 authorize-security-group-ingress \
    --group-id sg-0a6cfa32aaae83b4c \
    --protocol tcp \
    --port 22 \
    --cidr 3.90.2.46/32
```

### Test Connectivity

```bash
# public ip 98.81.131.36
cat ~/.ssh/ip_rsa # getting public key `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIElisJd9yotxexQdLolqkbbIuF2K5d0aFgE3/Nh1UO1L ec2-user@aws-client`
ssh ec2-user@<public_ip> "mkdir -p ~/.ssh && echo '<your-public-key>' >> ~/.ssh/authorized_keys"
ssh ec2-user@3.90.2.46
ping 10.1.1.119 # private IP of private server
```


ssh ec2-user@3.90.2.46 "mkdir -p ~/.ssh && echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDadmlJkiN43Wndob4bDf55JX4+Tb69jwuw1m3aDLL8HfDPw2l4ud89pLdenDdqgOcLcbn7nYZYh9i2iZpgxIIyNu3nDEoo/es0AqCf9zbR7xBfI4CqPQxd5eekIkZmzKeQs/KkSca3YASnASb68i7QGuWFb0jA77bluO5atXgm7MU9Aw+T5R0CSLWAcacrtc3sWCXs1dA9DP+zEQ6S0n3b/iVM9aXSP0+4Hfh0MbBwCLraF+OxPfEkej/+zrLmAeKwruBwxoTagBJE/QzsaURsdkBh7E/eLOwDme5klDFkYfjDiAyJ/9gYE+6031vqOsRNp3D/0+g5VDgJrwfi/shx root@aws-client' >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

