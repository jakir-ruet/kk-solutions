```bash
sudo vi ~/ansible/playbook.yml
```

```bash
- hosts: stapp01
  become: yes
  roles:
    - httpd

---
- hosts: stapp01
  become: yes
  become_user: root
  roles:
    - role/httpd


---
- hosts: stapp01
  become: yes
  become_user: root
  roles:
    - role/httpd
```

```bash
sudo vi /home/thor/ansible/role/httpd/templates/index.html.j2
```

```bash
<!DOCTYPE html>
<html>
	<head>
		<title>Welcome</title>
	</head>
	<body>
		<h1>This file was created using Ansible on {{ inventory_hostname }}</h1>
	</body>
</html>
```

```bash
mkdir -p /home/thor/ansible/roles/httpd/templates
cp -r /home/thor/ansible/role/httpd/templates/ /home/thor/ansible/roles/httpd/templates/
```

```bash
sudo vi /home/thor/ansible/role/httpd/tasks/main.yml
```

```bash
- name: install the latest version of HTTPD
  yum:
    name: httpd
    state: latest

- name: Start service httpd
  service:
    name: httpd
    state: started

- name: Deploy customized index.html from template
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: "{{ ansible_user }}"
    group: "{{ ansible_user }}"
    mode: '0755'
```

```bash
mkdir -p /home/thor/ansible/roles/httpd/templates/
cp -r /home/thor/ansible/role/httpd/templates/ /home/thor/ansible/roles/httpd/templates/
```

```bash
sudo vi ~/ansible/inventory
```

```bash
stapp01 ansible_host=172.16.238.10 ansible_user=banner ansible_ssh_pass=Ir0nM@n ansible_become_pass=Ir0nM@n
```

```bash
cd ~/ansible
ansible-playbook -i inventory playbook.yml
```
