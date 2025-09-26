### Generate SSH key on the jump host

```bash
ssh-keygen -t ed25519 -C "thor@jumphost"
ssh-copy-id steve@stapp02.stratos.xfusioncorp.com
```

### Test password-less SSH

```bash
ssh steve@stapp02.stratos.xfusioncorp.com
```

```bash
sudo vi /home/thor/ansible/inventory
```

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass='Ir0nM@n'
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass='Am3ric@'
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass='BigGr33n'
```

### Test ping using group

```bash
ansible -i /home/thor/ansible/inventory app_servers -m ping
```
