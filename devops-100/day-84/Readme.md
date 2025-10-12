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
- name: Copy index.html to all app servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Ensure /opt/data directory exists
      file:
        path: /opt/data
        state: directory
        mode: '0755'

    - name: Copy index.html to /opt/data on app servers
      copy:
        src: /usr/src/data/index.html
        dest: /opt/data/index.html
        owner: root
        group: root
        mode: '0644'
```

### Run playbook

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
