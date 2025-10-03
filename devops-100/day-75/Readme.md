#### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH` & `SSH Build Agents` > Hit `Install` Button.
- Restart

#### Go to Nodes

- Create node `App_server_1`
- Check `Permanent Agent`
- Hit `Ok`

- Create node `App_server_2`
- Check `Permanent Agent`
- Hit `Ok`

- Create node `App_server_3`
- Check `Permanent Agent`
- Hit `Ok`

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `tony`
- Password: `Ir0nM@n`
- ID: `tony`
- Description: `leave`
- Hit `Create` Button,

- Username: `steve`
- Password: `Am3ric@`
- ID: `steve`
- Description: `leave`
- Hit `Create` Button,

**And**

- Username: `banner`
- Password: `BigGr33n`
- ID: `banner`
- Description: `leave`
- Hit `Create` Button,

#### Again go to nodes to update

- Go `App_server_1`
- Remote root directory `/home/tony/jenkins`
- Host `stapp01`
- Select Credentials `tony`
- Host Key Verification Strategy `Non verifying Verification Strategy`,

- Go `App_server_2`
- Remote root directory `/home/steve/jenkins`
- Host `stapp02`
- Select Credentials `steve`
- Host Key Verification Strategy `Non verifying Verification Strategy`

**And**

- Go `App_server_3`
- Remote root directory `/home/banner/jenkins`
- Host `stapp03`
- Select Credentials `banner`
- Host Key Verification Strategy `Non verifying Verification Strategy`

#### Create SSH remote hosts

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `stapp01`
- Port: `22`
- Credentials: Select `tony`
- Check Connection `>` Hit `Apply` and `Save`,

- Hostname: `stapp02`
- Port: `22`
- Credentials: Select `steve`
- Check Connection `>` Hit `Apply` and `Save`

**And**

- Hostname: `stapp03`
- Port: `22`
- Credentials: Select `banner`
- Check Connection `>` Hit `Apply` and `Save`

#### Create the Build Job

- Go `Dashboard` > `All` > `New Item`
- Name: `java`
- Select `Freestyle Project`
- Click `Ok`

##### Execute shell script on remote host using ssh

```bash
echo Ir0nM@n | sudo -S sudo yum install -y java
echo Am3ric@ | sudo -S sudo yum install -y java
echo BigGr33n | sudo -S sudo yum install -y java
```

#### Build Now
