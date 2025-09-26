```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Install and start vsftpd on Nautilus app servers
  hosts: all
  become: yes
  tasks:

    - name: Install vsftpd package
      package:
        name: vsftpd
        state: present

    - name: Ensure vsftpd service is started and enabled
      service:
        name: vsftpd
        state: started
        enabled: yes
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
