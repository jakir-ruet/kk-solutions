```bash
We already have an inventory file under /home/thor/ansible directory on jump host.
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Install httpd and deploy sample web page
  hosts: all
  become: yes

  tasks:
    - name: Install httpd web server
      yum:
        name: httpd
        state: present

    - name: Ensure httpd service is running and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Ensure index.html exists
      file:
        path: /var/www/html/index.html
        state: touch
        owner: apache
        group: apache
        mode: '0744'

    - name: Add sample content to index.html
      blockinfile:
        path: /var/www/html/index.html
        block: |
          Welcome to XfusionCorp!

          This is  Nautilus sample file, created using Ansible!

          Please do not modify this file manually!

    - name: Ensure correct ownership and permissions for index.html
      file:
        path: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0744'
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
