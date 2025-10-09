- Get the Instance ID of datacenter-ec2
```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=datacenter-ec2" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
```

```bash
i-0ad234c6973e8f405
```

```bash
aws ec2 describe-volumes \
  --filters Name=attachment.instance-id,Values=i-0ad234c6973e8f405 \
  --query "Volumes[*].{ID:VolumeId,Size:Size,State:State}" \
  --output table
```

```bash
aws ec2 modify-volume \
  --volume-id vol-08747d09af10aa959 \
  --size 12
```

```bash
cd /root
chmod 400 "datacenter-keypair.pem"
ssh -i /root/datacenter-keypair.pem ec2-user@34.229.203.141
```

```bash
lsblk
sudo growpart /dev/xvda 1
lsblk
```

```bash
[ec2-user@ip-172-31-29-25 ~]$ lsblk
NAME      MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
xvda      202:0    0  12G  0 disk
├─xvda1   202:1    0   8G  0 part /
├─xvda127 259:0    0   1M  0 part
└─xvda128 259:1    0  10M  0 part /boot/efi
[ec2-user@ip-172-31-29-25 ~]$ sudo growpart /dev/xvda 1
CHANGED: partition=1 start=24576 old: size=16752607 end=16777183 new: size=25141215 end=25165791
[ec2-user@ip-172-31-29-25 ~]$ lsblk
NAME      MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
xvda      202:0    0  12G  0 disk
├─xvda1   202:1    0  12G  0 part /
├─xvda127 259:0    0   1M  0 part
└─xvda128 259:1    0  10M  0 part /boot/efi
```

```bash
df -T /
sudo xfs_growfs / # for xfs
sudo resize2fs /dev/xvda1 # for ext4
df -h /
```

```bash
lsblk
```
