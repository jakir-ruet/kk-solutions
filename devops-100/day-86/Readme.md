### Login as root and make ssh key

```bash
ssh-keygen
ssh-copy-id steve@stapp02 # Am3ric@
```

```bash
#Also root user
sudo su - # mjolnir123
ssh-keygen
ssh-copy-id steve@stapp02 # Am3ric@
```

### Update inventory

```bash
cd /home/thor/ansible
vi inventory
```

```bash
[appservers]
stapp02 ansible_host=172.16.238.11 ansible_user=steve
```

### Run module

```bash
ansible stapp02 -m ping -i inventory
```
