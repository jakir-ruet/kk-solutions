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
---
- name: Install and configure vsftpd on all app servers
  hosts: all
  become: yes

  tasks:
    - name: Install vsftpd package
      yum:
        name: vsftpd
        state: present

    - name: Ensure vsftpd service is started and enabled
      service:
        name: vsftpd
        state: started
        enabled: yes
```

```bash
ansible all -i inventory -m ping # ping test
ansible-playbook -i inventory playbook.yml # run
```

```bash
# test
ansible all -i inventory -m shell -a "systemctl status vsftpd | grep Active" # or
ansible all -i inventory -a "systemctl is-active vsftpd"
```
