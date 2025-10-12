### Inventory

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_python_interpreter=/usr/bin/python3 ansible_ssh_common_args='-o StrictHostKeyChecking=no'
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_python_interpreter=/usr/bin/python3 ansible_ssh_common_args='-o StrictHostKeyChecking=no'
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33n ansible_python_interpreter=/usr/bin/python3 ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

### Playbook

```bash
---
- name: Create /opt/webapp.txt on all app servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Create blank file /opt/webapp.txt with correct permissions
      file:
        path: /opt/webapp.txt
        state: touch
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: '0755'
```

### Run playbook

```bash
cd ~/playbook
ansible-playbook -i inventory playbook.yml
```
