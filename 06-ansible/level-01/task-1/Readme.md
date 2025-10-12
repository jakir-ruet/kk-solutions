### Update Inventory File on `jump_host`

```bash
sudo vi /home/thor/ansible/inventory
```

```bash
[webservers]
stapp02.stratos.xfusioncorp.com ansible_user=steve ansible_password=Am3ric@ ansible_become=true
```

### Playbook File `jump_host`

```bash
sudo vi /home/thor/ansible/playbook.yaml
```

```bash
---
- name: Create a file on App Server 2
  hosts: webservers
  become: yes
  tasks:
    - name: Create an empty file at /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
```

### Run the Playbook

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yaml
```

### Optional (Avoid Password in Inventory)

```bash
ansible-playbook -i inventory playbook.yml --ask-pass --ask-become-pass
```
