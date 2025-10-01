```bash
an inventory file is already present under /home/thor/ansible directory on jump host
```

```bash
sudo vi /home/thor/ansible/playbook.yml
```

```bash
---
- name: Replace strings in data files on app servers
  hosts: all
  become: yes
  tasks:

    - name: Replace xFusionCorp with Nautilus in blog.txt on app server 1
      replace:
        path: /opt/data/blog.txt
        regexp: 'xFusionCorp'
        replace: 'Nautilus'
      when: inventory_hostname == "stapp01"

    - name: Replace Nautilus with KodeKloud in story.txt on app server 2
      replace:
        path: /opt/data/story.txt
        regexp: 'Nautilus'
        replace: 'KodeKloud'
      when: inventory_hostname == "stapp02"

    - name: Replace KodeKloud with xFusionCorp Industries in media.txt on app server 3
      replace:
        path: /opt/data/media.txt
        regexp: 'KodeKloud'
        replace: 'xFusionCorp Industries'
      when: inventory_hostname == "stapp03"
```

```bash
cd /home/thor/ansible
ansible-playbook -i inventory playbook.yml
```
