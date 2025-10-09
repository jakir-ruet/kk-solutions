```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=xfusion-ec2" --query "Reservations[*].Instances[*].InstanceId" --output text
```

```bash
aws ec2 create-image --instance-id i-052e3dc59ab455aef --name "xfusion-ec2-ami" --no-reboot --query 'ImageId' --output text
```

```bash
aws ec2 run-instances --image-id ami-096a994aa3384c64c --count 1 --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-ec2-new}]'
```
