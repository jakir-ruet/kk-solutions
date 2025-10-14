### Getting vpc ID

```bash
aws ec2 describe-vpcs \
  --query "Vpcs[*].{VpcId:VpcId,IsDefault:IsDefault,CidrBlock:CidrBlock}" \
  --output table
```

### Create Security Group for ALB

```bash
aws ec2 create-security-group \
  --group-name datacenter-sg \
  --description "Security group for datacenter ALB" \
  --vpc-id vpc-0848907d7b8ebc4ec
```

### Then open port 80 to the world

```bash
aws ec2 authorize-security-group-ingress \
  --group-id sg-0b8fd064463f2edcd \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0
```

### Create Target Group

```bash
aws elbv2 create-target-group \
  --name datacenter-tg \
  --protocol HTTP \
  --port 80 \
  --target-type instance \
  --vpc-id vpc-0848907d7b8ebc4ec
```

### Get Your EC2 Instance ID

```bash
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].{InstanceId:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name}" \
  --output table
```

### Get Your Target Group ARN

```bash
aws elbv2 describe-target-groups \
  --names datacenter-tg \
  --query "TargetGroups[0].TargetGroupArn" \
  --output text
```

### Register EC2 Instance with the Target Group

```bash
aws elbv2 register-targets \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:382258128167:targetgroup/datacenter-tg/d159b67eb4dd2223 \
  --targets Id=i-0cce2bbef0ea30324
```

### Get Subnet IDs

```bash
aws ec2 describe-subnets \
  --query "Subnets[*].{SubnetId:SubnetId,AZ:AvailabilityZone,VpcId:VpcId,DefaultForAz:DefaultForAz}" \
  --output table
```

### Get the ALB Security Group ID ($ALB_SG_ID)

```bash
aws ec2 describe-security-groups \
  --filters "Name=group-name,Values=datacenter-sg" \
  --query "SecurityGroups[0].GroupId" \
  --output text
```

### Create the Application Load Balancer

```bash
aws elbv2 create-load-balancer \
  --name datacenter-alb \
  --type application \
  --scheme internet-facing \
  --subnets subnet-07a917fc9cde1d404 subnet-01a33833519393ceb \
  --security-groups sg-05639d61a71dedec5
```

### Get ALB ARN directly

```bash
aws elbv2 describe-load-balancers \
  --names datacenter-alb \
  --query "LoadBalancers[0].LoadBalancerArn" \
  --output text
```

### Set $ALB_ARN properly

```bash
ALB_ARN=$(aws elbv2 describe-load-balancers \
  --names datacenter-alb \
  --query "LoadBalancers[0].LoadBalancerArn" \
  --output text)
```

```bash
echo $ALB_ARN
```

### Run the listener creation command (correctly)

```bash
aws elbv2 create-listener \
  --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:382258128167:loadbalancer/app/datacenter-alb/abcd1234ef567890 \
  --protocol HTTP \
  --port 80 \
  --default-actions Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-east-1:382258128167:targetgroup/datacenter-tg/d159b67eb4dd2223
```

### Register your EC2 instance to the target group

```bash
aws elbv2 register-targets \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:382258128167:targetgroup/datacenter-tg/d159b67eb4dd2223 \
  --targets Id=i-0cce2bbef0ea30324
```

### Next Step

```bash
aws elbv2 describe-load-balancers \
  --names datacenter-alb \
  --query "LoadBalancers[0].DNSName" \
  --output text
```
