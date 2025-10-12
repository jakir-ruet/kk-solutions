### Create Inventory

```bash
vi /home/thor/playbook/inventory
```

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_python_interpreter=/usr/bin/python3
```

### Run playbook

```bash
cd /home/thor/playbook
ansible-playbook -i inventory playbook.yml
```
