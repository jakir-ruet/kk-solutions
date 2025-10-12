```bash
sudo vi /home/thor/ansible/inventory
```

```bash
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Archive /usr/src/sysops and copy to /opt/sysops
  hosts: all
  become: yes
  vars:
    src_dir: /usr/src/sysops
    dest_dir: /opt/sysops
    archive_name: beta.tar.gz

  tasks:
    - name: Ensure destination directory exists
      file:
        path: "{{ dest_dir }}"
        state: directory
        mode: '0755'

    - name: Create archive of /usr/src/sysops
      archive:
        path: "{{ src_dir }}"
        dest: "{{ dest_dir }}/{{ archive_name }}"
        format: gz
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
```

```bash
cd /home/thor/ansible/
ansible-playbook -i inventory playbook.yml
```
