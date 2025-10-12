```bash
cd /home/thor/ansible
vi inventory
```

```bash
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n
```

```bash
vi playbook.yml
```

```bash
---
- name: Install and configure Apache web server
  hosts: all
  become: yes

  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present

    - name: Ensure httpd service is started and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Ensure index.html exists
      file:
        path: /var/www/html/index.html
        state: touch
        owner: apache
        group: apache
        mode: '0777'

    - name: Add sample content to index.html using blockinfile
      blockinfile:
        path: /var/www/html/index.html
        block: |
          Welcome to XfusionCorp!

          This is  Nautilus sample file, created using Ansible!

          Please do not modify this file manually!

    - name: Ensure correct ownership and permissions
      file:
        path: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0777'
```

```bash
ansible-playbook -i inventory playbook.yml
```

```bash
ansible all -i inventory -a "sudo systemctl status httpd"
curl http://172.16.238.10
curl http://172.16.238.11
curl http://172.16.238.12
```
