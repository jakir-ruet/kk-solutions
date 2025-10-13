#### Login

- User Name: `admin`
- Password: `Adm!n321`

#### Update all plugin & install below plugins
- Go > `Dashboard` >` Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` >` Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH` > Check `SSH`, `SSH Credentials` and `SSH Builds Agents` > Hit `Install` Button.
- Restart

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `natasha`
- Password: `Bl@kW`
- ID: `storage`
- Description: `none`
- Hit `Create` Button



#### Add SSH Hosts in Jenkins

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `ststor01.stratos.xfusioncorp.com`
- Port: `22`
- Credentials: Select `natasha` > Hit `Apply` and `Save`

#### Create the Build Job

- Go `Dashboard` > `All` > `New Item`
- Name: `install-packages`
- Select `Freestyle Project`
- Click `Ok`
- Go `Dashboard` > `install-packages` > `Configuration`
- Check `This project is parameterized?`
- From `Add Parameter` Select `String Parameter`
- named `PACKAGE`
- Default Value: `httpd`
- Description: `none`
- Hit `Apply` & `Save`

#### Under Build add a Build

- Go `Dashboard` > `install-packages` > `Configuration`
- Go `Build Steps` & Check `Execute shell script on remote host using ssh`
- Select `natasha@ststor01.stratos.xfusioncorp.com`
- Paste `echo 'Bl@kW' | sudo -S yum install -y $PACKAGE`
- Hit `Apply` & `Save`
- Hit `Build with Parameters` & `Build`
- Hit `https://8080-port-crj3uwxlornpfonj.labs.kodekloud.com/`
