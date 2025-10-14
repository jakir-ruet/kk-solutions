### Create a Key Pair

```bash
aws ec2 create-key-pair \
  --key-name datacenter-key \
  --query 'KeyMaterial' \
  --output text > datacenter-key.pem
```

```bash
chmod 400 datacenter-key.pem
```

```bash
aws ec2 describe-key-pairs \
  --query "KeyPairs[].KeyName"
```

### Launch EC2 Instance

```bash
aws ec2 run-instances \
  --image-id ami-07a3add10195338ad \
  --count 1 \
  --instance-type t2.micro \
  --key-name datacenter-key \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=datacenter-ec2}]'
```

### Get the Instance ID

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-ec2" \
  --query "Reservations[].Instances[].{ID:InstanceId,State:State.Name}" \
  --output table
```

### Create CloudWatch Alarm

```bash
aws cloudwatch put-metric-alarm \
  --alarm-name datacenter-alarm \
  --alarm-description "Trigger if CPU >= 90% for 5 minutes" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 90 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --dimensions Name=InstanceId,Value=i-0a12b3c4d5e6f7890 \
  --evaluation-periods 1 \
  --alarm-actions arn:aws:sns:us-east-1:136553899129:datacenter-sns-topic \
  --unit Percent
```

### Test with CLI

```bash
aws cloudwatch describe-alarms --output table
```

### Test in Management Console

- Go `Cloud Watch`
