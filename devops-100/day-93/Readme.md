```bash
vi playbook.yml
```

```bash
---
- hosts: all
  become: yes
  gather_facts: yes

  tasks:
    - name: Ensure /opt/itadmin directory exists
      file:
        path: /opt/itadmin
        state: directory
        mode: '0755'

    - name: Copy blog.txt to App Server 1
      copy:
        src: /usr/src/itadmin/blog.txt
        dest: /opt/itadmin/blog.txt
        owner: tony
        group: tony
        mode: '0655'
      when: "'stapp01' in ansible_nodename"

    - name: Copy story.txt to App Server 2
      copy:
        src: /usr/src/itadmin/story.txt
        dest: /opt/itadmin/story.txt
        owner: steve
        group: steve
        mode: '0655'
      when: "'stapp02' in ansible_nodename"

    - name: Copy media.txt to App Server 3
      copy:
        src: /usr/src/itadmin/media.txt
        dest: /opt/itadmin/media.txt
        owner: banner
        group: banner
        mode: '0655'
      when: "'stapp03' in ansible_nodename"
```

```bash
ansible-playbook -i inventory playbook.yml
```

```bash
ansible all -i inventory -m ping
```

```bash
#debug
ansible-playbook -i inventory playbook.yml -vvv
```
