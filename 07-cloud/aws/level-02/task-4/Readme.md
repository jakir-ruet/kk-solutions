### Client

```bash
cd ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
```

```bash
aws ec2 create-key-pair \
  --key-name my-key \
  --query 'KeyMaterial' \
  --output text > my-key.pem
```

```bash
chmod 400 my-key.pem
```

```bash
aws ec2 create-security-group \
  --group-name my-sg \
  --description "Allow SSH access on port 22" \
  --vpc-id vpc-0f427fd308718b528
```

```bash
aws ec2 authorize-security-group-ingress \
  --group-name my-sg \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

```bash
aws ssm get-parameter \
  --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 \
  --region us-east-1 \
  --query 'Parameter.Value' \
  --output text
```

```bash
ami-091d7d61336a4c68f
```

```bash
aws ec2 run-instances \
--image-id ami-091d7d61336a4c68f \
--instance-type t2.micro \
--key-name my-key \
--security-groups my-sg \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=datacenter-ec2}]'
```

```bash
cat ~/.ssh/id_rsa.pub
```

```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBG2r3wuqprk8xs+mgJK/EF5hUBf5EvIvyFWabzHbhtkKAykT/FSDNOO1ySTajKKfydjIduNtdlYaPqJXW1gC46o8DFEu9qI8cCi8+N80fzRDfiSovupUchkuWqsou2ui5RZmqPFo0+2GZTu/7K7VcAXI8stFpXkq5XnKBXvpdzJzSDJkp/j1dXwtVkl9VjaTXq56rSvqsmLZerct4MWGyEHjqEGboozxNePNDdiFGbhNxGtzYZh42V2iZZgGPT6DmVgzJfG0ODBnMV5LI6BT0Q+MFdO8dkYpYqa82w7sBXu0BXcT2FYGeRYHj6MCJGCd+d7kqFie6Y9OIeBlaC2YB
```

```bash
ssh -i ~/.ssh/my-key.pem ec2-user@98.90.202.182
sudo su -
```

### On the EC2 instance

```bash
mkdir -p /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBG2r3wuqprk8xs+mgJK/EF5hUBf5EvIvyFWabzHbhtkKAykT/FSDNOO1ySTajKKfydjIduNtdlYaPqJXW1gC46o8DFEu9qI8cCi8+N80fzRDfiSovupUchkuWqsou2ui5RZmqPFo0+2GZTu/7K7VcAXI8stFpXkq5XnKBXvpdzJzSDJkp/j1dXwtVkl9VjaTXq56rSvqsmLZerct4MWGyEHjqEGboozxNePNDdiFGbhNxGtzYZh42V2iZZgGPT6DmVgzJfG0ODBnMV5LI6BT0Q+MFdO8dkYpYqa82w7sBXu0BXcT2FYGeRYHj6MCJGCd+d7kqFie6Y9OIeBlaC2YB" >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
chmod 700 /root/.ssh
```

```bash
vi /etc/ssh/sshd_config
PermitRootLogin yes
PasswordAuthentication no
systemctl restart sshd
```

### Again aws-client

```bash
ssh root@98.90.202.182
```
