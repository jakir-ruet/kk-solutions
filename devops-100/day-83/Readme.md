### Update the inventory

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_python_interpreter=/usr/bin/python3
```

### Create playbook

```bash
---
- name: Test playbook on App Server 1
  hosts: app_servers
  become: yes
  tasks:
    - name: Create an empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
```

### Run playbook

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
