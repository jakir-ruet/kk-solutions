```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Create files and symbolic links on app servers
  hosts: all
  become: yes
  tasks:

    - name: Ensure /opt/devops directory exists
      file:
        path: /opt/devops
        state: directory

    - name: Create blog.txt on app server 1
      file:
        path: /opt/devops/blog.txt
        state: touch
        owner: tony
        group: tony
      when: inventory_hostname == "stapp01"

    - name: Create story.txt on app server 2
      file:
        path: /opt/devops/story.txt
        state: touch
        owner: steve
        group: steve
      when: inventory_hostname == "stapp02"

    - name: Create media.txt on app server 3
      file:
        path: /opt/devops/media.txt
        state: touch
        owner: banner
        group: banner
      when: inventory_hostname == "stapp03"

    - name: Create symbolic link /var/www/html -> /opt/devops
      file:
        src: /opt/devops
        dest: /var/www/html
        state: link
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
