```bash
cd /home/thor/ansible
cat inventory
```

```bash
---
- name: Create blog.txt on stapp01 and set ACL
  hosts: stapp01
  become: yes
  tasks:
    - name: Ensure /opt/finance directory exists
      file:
        path: /opt/finance
        state: directory
        owner: root
        group: root
        mode: '0755'

    - name: Create blog.txt
      file:
        path: /opt/finance/blog.txt
        state: touch
        owner: root
        group: root
        mode: '0644'

    - name: Set ACL for blog.txt (read for group tony)
      acl:
        path: /opt/finance/blog.txt
        entity: tony
        etype: group
        permissions: r
        state: present

- name: Create story.txt on stapp02 and set ACL
  hosts: stapp02
  become: yes
  tasks:
    - name: Ensure /opt/finance directory exists
      file:
        path: /opt/finance
        state: directory
        owner: root
        group: root
        mode: '0755'

    - name: Create story.txt
      file:
        path: /opt/finance/story.txt
        state: touch
        owner: root
        group: root
        mode: '0644'

    - name: Set ACL for story.txt (read/write for user steve)
      acl:
        path: /opt/finance/story.txt
        entity: steve
        etype: user
        permissions: rw
        state: present

- name: Create media.txt on stapp03 and set ACL
  hosts: stapp03
  become: yes
  tasks:
    - name: Ensure /opt/finance directory exists
      file:
        path: /opt/finance
        state: directory
        owner: root
        group: root
        mode: '0755'

    - name: Create media.txt
      file:
        path: /opt/finance/media.txt
        state: touch
        owner: root
        group: root
        mode: '0644'

    - name: Set ACL for media.txt (read/write for group banner)
      acl:
        path: /opt/finance/media.txt
        entity: banner
        etype: group
        permissions: rw
        state: present
```

```bash
ansible-playbook -i inventory playbook.yml
```

```bash
# check
ansible stapp01 -i inventory -a "getfacl /opt/finance/blog.txt"
ansible stapp02 -i inventory -a "getfacl /opt/finance/story.txt"
ansible stapp03 -i inventory -a "getfacl /opt/finance/media.txt"
```
