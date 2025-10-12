### Create the Inventory File

```bash
sudo vi /home/thor/playbook/inventory
```

```bash
[appserver]
stapp02 ansible_host=stapp02.stratos.xfusioncorp.com ansible_user=steve ansible_password=Am3ric@ ansible_become=true
```

### Run the Playbook

```bash
cd /home/thor/playbook/
ansible-playbook -i inventory playbook.yml
```
