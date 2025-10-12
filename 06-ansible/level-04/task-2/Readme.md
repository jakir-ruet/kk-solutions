```bash
ls -la /home/thor/playbooks/
cat /home/thor/playbooks/ansible.cfg
cat /home/thor/playbooks/inventory
cat /home/thor/playbooks/data/users.yml
cat /home/thor/playbooks/secrets/vault.txt
```

```bash
sudo vi ansible.cfg
```

```bash
[defaults]
host_key_checking = False
inventory = ./inventory
vault_password_file = ./secrets/vault.txt
```

```bash
sudo vi /secrets/plain_passwords.yml
```

```bash
developers_password: 8FmzjvFU6S
admins_password: GyQkFRVNr3
```

```bash
ansible-vault encrypt ~/playbooks/secrets/plain_passwords.yml --output ~/playbooks/secrets/encrypted_passwords.yml --vault-password-file ~/playbooks/secrets/vault.txt
```

```bash
rm ~/playbooks/secrets/plain_passwords.yml
```

```bash
sudo vi /playbooks/add_users.yml
```

```bash
---
- name: Add users on App Server 2
  hosts: stapp02
  become: yes
  vars_files:
    - ./data/users.yml
    - ./secrets/encrypted_passwords.yml

  tasks:

    - name: Ensure groups exist
      group:
        name: "{{ item }}"
        state: present
      loop:
        - developers
        - admins

    - name: Add developer users
      user:
        name: "{{ item }}"
        group: developers
        home: "/var/www/{{ item }}"
        password: "{{ developers_password | password_hash('sha512') }}"
        state: present
        shell: /bin/bash
        create_home: yes
      loop: "{{ developers }}"

    - name: Add admin users
      user:
        name: "{{ item }}"
        groups:
          - admins
          - wheel
        password: "{{ admins_password | password_hash('sha512') }}"
        state: present
        shell: /bin/bash
        create_home: yes
      loop: "{{ admins }}"
```

```bash
cd ~/playbooks
ansible-playbook add_users.yml
```
