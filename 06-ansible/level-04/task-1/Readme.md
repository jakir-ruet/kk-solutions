```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/playbooks/index.yml
```

```bash
---
- name: Setup Apache and create sample page with facts
  hosts: all
  become: yes
  gather_facts: yes

  tasks:

    - name: Ensure /root/facts.txt exists
      file:
        path: /root/facts.txt
        state: touch
        owner: root
        group: root
        mode: '0644'

    - name: Add system architecture to /root/facts.txt
      blockinfile:
        path: /root/facts.txt
        block: |
          Ansible managed node architecture is {{ ansible_architecture }}

    - name: Install httpd package
      package:
        name: httpd
        state: present

    - name: Ensure httpd service is started and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Copy facts.txt to /var/www/html/index.html on remote
      copy:
        src: /root/facts.txt
        dest: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'
        remote_src: yes
```

```bash
cd /home/thor/playbooks/
ansible-playbook -i inventory index.yml
```
