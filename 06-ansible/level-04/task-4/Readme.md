```bash
vi httpd.yaml
```

```bash
---
- name: Setup Apache and PHP on stapp01
  hosts: stapp01
  become: yes

  tasks:

    - name: Install Apache and PHP
      yum:
        name:
          - httpd
          - php
        state: present

    - name: Ensure new document root directory exists
      file:
        path: /var/www/html/myroot
        state: directory
        owner: apache
        group: apache
        mode: '0755'

    - name: Update Apache DocumentRoot in config
      replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^DocumentRoot "\S+"'
        replace: 'DocumentRoot "/var/www/html/myroot"'
      notify: Restart Apache

    - name: Update <Directory> section to match new DocumentRoot
      replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^<Directory "\S+">'
        replace: '<Directory "/var/www/html/myroot">'
      notify: Restart Apache

    - name: Copy phpinfo.php to document root
      template:
        src: templates/phpinfo.php.j2
        dest: /var/www/html/myroot/phpinfo.php
        owner: apache
        group: apache
        mode: '0644'

    - name: Ensure httpd is started and enabled
      service:
        name: httpd
        state: started
        enabled: yes

  handlers:
    - name: Restart Apache
      service:
        name: httpd
        state: restarted
```

```bash
ansible-playbook -i inventory httpd.yml
```
