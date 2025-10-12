
```bash
cd /home/thor/ansible
vi playbook.yml
```

```bash
---
- name: Install and configure httpd web server on all app servers
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

    - name: Create /var/www/html/index.html with initial content
      copy:
        dest: /var/www/html/index.html
        content: "This is a Nautilus sample file, created using Ansible!\n"
        owner: apache
        group: apache
        mode: '0755'

    - name: Add new line at the top of /var/www/html/index.html
      lineinfile:
        path: /var/www/html/index.html
        line: "Welcome to Nautilus Group!"
        insertafter: BOF
        owner: apache
        group: apache
        mode: '0755'
```

```bash
ansible-playbook -i inventory playbook.yml
```

```bash
ansible all -i inventory -a "cat /var/www/html/index.html"
ansible all -i inventory -a "ls -l /var/www/html/index.html"
```

```bash
curl http://stapp01
curl http://stapp02
curl http://stapp03
```
