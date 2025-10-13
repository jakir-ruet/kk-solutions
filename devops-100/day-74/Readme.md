#### Update all plugin & install below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `SSH Credentials`, `SSH Build Agents` and `Publish over SSH`> Hit `Install` Button.
- Restart

#### Passwordless Configuration on DB server

```bash
ssh peter@stdb01
ssh-keygen -t rsa -b 4096
ssh-copy-id clint@stbkp01.stratos.xfusioncorp.com
```

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `peter`
- Password: `Sp!dy`
- ID: `peter`
- Description: `leave`
- Hit `Create` Button,

#### Add SSH Hosts in Jenkins

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `stdb01`
- Port: `22`
- Credentials: Select `peter`
- Check Connection `>` Hit `Apply` and `Save`,

#### Create the Build Job

- Go `Dashboard` > `All` > `New Item`
- Name: `database-backup`
- Select `Freestyle Project`
- Click `Ok`

- Check `Build Periodically`
- `*/10 * * * *`

- Check `Execute shell script on remote host using ssh`
- Select `peter@stdb01`
- Paste

```bash
mysqldump -u kodekloud_roy -pasdfgdsd kodekloud_db01 > db_$(date +%F).sql
scp -o StrictHostKeyChecking=no db_$(date +%F).sql clint@stbkp01:/home/clint/db_backups
```

#### Finally hit `Build Now`
