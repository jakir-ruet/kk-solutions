### Find a suitable Ubuntu AMI ID

```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" \
            "Name=state,Values=available" \
  --query "Images | sort_by(@, &CreationDate)[-1].ImageId" \
  --output text \
  --region us-east-1
```

### Create the EC2 instance

```bash
aws ec2 run-instances \
    --image-id ami-0fb0b230890ccd1e6 \
    --count 1 \
    --instance-type t2.micro \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=nautilus-ec2}]' \
    --query 'Instances[0].InstanceId' \
    --output text
```

### Allocate a new Elastic IP and tag it as `nautilus-eip`

```bash
aws ec2 describe-addresses \
  --allocation-ids eipalloc-0b6a3380a50f9e835 \
  --query "Addresses[0].PublicIp" \
  --output text
```

```bash
aws ec2 describe-instances \
  --instance-ids i-04c492b924428bb67 \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

```bash
aws ec2 describe-addresses
```
