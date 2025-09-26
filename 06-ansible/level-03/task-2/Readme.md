```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Create files with ACL on Stratos DC app servers
  hosts: all
  become: yes
  tasks:

    - name: Ensure /opt/dba directory exists
      file:
        path: /opt/dba
        state: directory
        owner: root
        group: root
        mode: '0755'

    - name: Create blog.txt on app server 1
      file:
        path: /opt/dba/blog.txt
        state: touch
        owner: root
        group: root
        mode: '0644'
      when: inventory_hostname == "stapp01"

    - name: Set ACL for blog.txt for group tony
      acl:
        path: /opt/dba/blog.txt
        entity: tony
        etype: group
        permissions: r
        state: present
      when: inventory_hostname == "stapp01"

    - name: Create story.txt on app server 2
      file:
        path: /opt/dba/story.txt
        state: touch
        owner: root
        group: root
        mode: '0644'
      when: inventory_hostname == "stapp02"

    - name: Set ACL for story.txt for user steve
      acl:
        path: /opt/dba/story.txt
        entity: steve
        etype: user
        permissions: rw
        state: present
      when: inventory_hostname == "stapp02"

    - name: Create media.txt on app server 3
      file:
        path: /opt/dba/media.txt
        state: touch
        owner: root
        group: root
        mode: '0644'
      when: inventory_hostname == "stapp03"

    - name: Set ACL for media.txt for group banner
      acl:
        path: /opt/dba/media.txt
        entity: banner
        etype: group
        permissions: rw
        state: present
      when: inventory_hostname == "stapp03"
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
