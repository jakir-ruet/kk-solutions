```bash
sudo vi /etc/ansible/ansible.cfg
```

```bash
remote_user    = rose # just put this line in /etc/ansible/ansible.cfg
```

```bash
ansible all -m ping
```
