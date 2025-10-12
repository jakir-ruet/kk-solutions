```bash
sudo vi ~/ansible/playbook.yml
```

```bash
- hosts: stapp01
  become: yes
  roles:
    - httpd
```

```bash
sudo vi /home/thor/ansible/role/httpd/templates/index.html.j2
```

```bash
This file was created using Ansible on {{ inventory_hostname }}
```

```bash
cp -r /home/thor/ansible/role /home/thor/ansible/roles
```

```bash
sudo vi /home/thor/ansible/role/httpd/tasks/main.yml
```

```bash
---
- name: Install the latest version of HTTPD
  yum:
    name: httpd
    state: latest

- name: Start and enable httpd service
  service:
    name: httpd
    state: started
    enabled: yes

- name: Define sudo user mapping
  set_fact:
    sudo_user_map:
      stapp01: tony
      stapp02: steve
      stapp03: banner

- name: Copy index.html template to /var/www/html/
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: "{{ sudo_user_map[inventory_hostname] }}"
    group: "{{ sudo_user_map[inventory_hostname] }}"
    mode: '0744'
```

```bash
cd ~/ansible
ansible-playbook -i inventory playbook.yml
```
