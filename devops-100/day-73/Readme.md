#### Update all plugin & install below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH` > Hit `Install` Button.
- Restart

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `natasha`
- Password: `Bl@kW`
- ID: `natasha`
- Description: `leave`
- Hit `Create` Button

**And**

- Username: `steve`
- Password: `Am3ric@`
- ID: `steve`
- Description: `leave`
- Hit `Create` Button

#### Add SSH Hosts in Jenkins

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `ststor01`
- Port: `22`
- Credentials: Select `natasha`
- Check Connection `>` Hit `Apply` and `Save`

**And**

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `stapp02`
- Port: `22`
- Credentials: Select `steve`
- Check Connection `>` Hit `Apply` and `Save`

#### Create the Build Job

- Go `Dashboard` > `All` > `New Item`
- Name: `copy-logs`
- Select `Freestyle Project`
- Click `Ok`

- Check `Build Periodically`
- `*/6 * * * *`

- Check `Execute shell script on remote host using ssh`
- Select `steve@stapp02`
- Paste

```bash
sudo yum install sshpass -y
sshpass -p "Bl@kW" scp -o StrictHostKeyChecking=no -r /etc/httpd/logs/access_log natasha@ststor01:/usr/src/dba
sshpass -p "Bl@kW" scp -o StrictHostKeyChecking=no -r /etc/httpd/logs/error_log natasha@ststor01:/usr/src/dba
```

#### Finally hit `Build Now`
