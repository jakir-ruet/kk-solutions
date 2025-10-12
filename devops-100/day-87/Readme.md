```bash
mkdir -p /home/thor/playbook
vi /home/thor/playbook/inventory
```

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n
```

```bash
vi /home/thor/playbook/playbook.yml
```

```bash
---
- name: Install samba on all app servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Install samba package
      yum:
        name: samba
        state: present
```

```bash
sudo chown -R thor:thor /home/thor/playbook
cd /home/thor/playbook
ansible-playbook -i inventory playbook.yml
```
