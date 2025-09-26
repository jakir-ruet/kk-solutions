```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Install and configure httpd with sample web page
  hosts: all
  become: yes

  tasks:

    - name: Install httpd package
      package:
        name: httpd
        state: present

    - name: Ensure httpd service is started and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Create /var/www/html/index.html with initial content
      copy:
        dest: /var/www/html/index.html
        content: "This is a Nautilus sample file, created using Ansible!\n"
        owner: apache
        group: apache
        mode: '0644'

    - name: Add welcome line at the top of index.html
      lineinfile:
        path: /var/www/html/index.html
        line: "Welcome to xFusionCorp Industries!"
        insertafter: BOF
        owner: apache
        group: apache
        mode: '0644'
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
