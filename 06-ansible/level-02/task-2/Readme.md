```bash
sudo vi /home/thor/playbook/inventory
```

```bash
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_user=banner
```

```bash
sudo vi /home/thor/playbook/playbook.yml
```

```bash
---
- name: Install wget on all app servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Ensure wget is installed
      yum:
        name: wget
        state: present
```

```bash
ssh-keygen -t ed25519 -C "thor@jumphost"
ssh-copy-id tony@stapp01.stratos.xfusioncorp.com
ssh-copy-id steve@stapp02.stratos.xfusioncorp.com
ssh-copy-id banner@stapp03.stratos.xfusioncorp.com
```

```bash
cd /home/thor/playbook
ansible-playbook -i inventory playbook.yml
```

