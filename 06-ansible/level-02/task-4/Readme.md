```bash
Inventory already exist on the server
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Distribute and extract xfusion.zip to all app servers
  hosts: all
  become: yes
  vars:
    src_zip: /usr/src/dba/xfusion.zip
    dest_dir: /opt/dba

  tasks:
    - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0777'

    - name: Copy xfusion.zip from jump host to app server
      copy:
        src: "{{ src_zip }}"
        dest: "{{ dest_dir }}/xfusion.zip"
        mode: '0644'

    - name: Unzip xfusion.zip on app server
      unarchive:
        src: "{{ dest_dir }}/xfusion.zip"
        dest: "{{ dest_dir }}"
        remote_src: yes
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: '0777'
```

```bash
ansible-playbook -i inventory playbook.yml
```
