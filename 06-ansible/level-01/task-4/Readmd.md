```bash
sudo vi /home/thor/ansible/inventory
```

```bash
[app_servers]
[app_servers]
stapp01.stratos.xfusioncorp.com ansible_user=tony ansible_password='Ir0nM@n'
stapp02.stratos.xfusioncorp.com ansible_user=steve ansible_password='Am3ric@'
stapp03.stratos.xfusioncorp.com ansible_user=banner ansible_password='BigGr33n'

```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Copy index.html to all application servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Ensure /opt/sysops directory exists
      file:
        path: /opt/sysops
        state: directory
        mode: '0755'

    - name: Copy index.html to /opt/sysops
      copy:
        src: /usr/src/sysops/index.html
        dest: /opt/sysops/index.html
        owner: root
        group: root
        mode: '0644'
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
