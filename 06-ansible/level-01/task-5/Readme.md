```bash
sudo vi ~/playbook/inventory
```

```bash
[app_servers]
stapp01.stratos.xfusioncorp.com ansible_user=tony ansible_password='Ir0nM@n'
stapp02.stratos.xfusioncorp.com ansible_user=steve ansible_password='Am3ric@'
stapp03.stratos.xfusioncorp.com ansible_user=banner ansible_password='BigGr33n'
```

```bash
sudo vi ~/playbook/playbook.yml
```

```bash
---
- name: Create blank file /tmp/appdata.txt on app servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Create /tmp/appdata.txt with correct owner, group, and permissions
      file:
        path: /tmp/appdata.txt
        state: touch
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
        mode: '0644'
```

```bash
cd ~/playbook
ansible-playbook -i inventory playbook.yml --ask-pass # mjolnir123
ansible-playbook -i inventory playbook.yml --ask-pass # Ir0nM@n
ansible-playbook -i inventory playbook.yml --ask-pass # Am3ric@
ansible-playbook -i inventory playbook.yml --ask-pass # BigGr33n
```
