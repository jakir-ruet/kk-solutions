#### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `Git`, `Gitea`, `Build Authorization Token Root` & `publish over SSH` > Hit `Install` Button.
- Restart

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `sarah`
- Description: `leave`
- Hit `Create` Button,

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

- Username: `banner`
- Password: `BigGr33n`
- ID: `banner`
- Description: `leave`
- Hit `Create` Button,

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `stapp01`
- Port: `22`
- Credentials: Select `tony`
- Check Connection `>` Hit `Apply` and `Save`

- Hostname: `stapp02`
- Port: `22`
- Credentials: Select `steve`
- Check Connection `>` Hit `Apply` and `Save`

- Hostname: `stapp03`
- Port: `22`
- Credentials: Select `banner`
- Check Connection `>` Hit `Apply` and `Save`

#### Configure Publish Over SSH for storage server

- Check `Use password authtication or use a different key`
- Passphrase/Password `Bl@kW`
- Name `ststor01`
- Hostname `ststor01`
- Username `natasha`
- Remote Directory `/var/www/html`
- `Apply` & `Save`

#### Create job

- Name `nautilus-app-deployment`
- `Freestyle` Project
- `Ok`

#### Build the Job & check the Console output for successful completion

#### Now Create a new Job as per the task

- Name `nautilus-app-deployment`
- Type `Freestyle project`
- Hit `Ok`
- Source Code Management
  - Check `Git`
  - Repository URL `http://git.stratos.xfusioncorp.com/sarah/web.git`
  - Credentials `sarah`
  - Branch Specifier (blank for any) `*/master`
- Build Triggers
  - Check `Trigger builds remotely`
    - Authentication Token `KODEKLOUDENGINEER`
- Build Environment
  - Send files or execute commands over SSH after the build runs
  - SSH Server Name `ststor01`
  - Transfer Set > Source files `**/*`
- Hit `Save` & `Apply`
- Hit `Build Now` for taking `target URL`.
- You should get `Finished: UNSTABLE`

#### Build

- `Execute shell script on remote host using ssh`
- Select `tony@stapp01`

```bash
echo Ir0nM@n | sudo -S yum install -y httpd
echo Ir0nM@n | sudo -S sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
echo Ir0nM@n | sudo -S systemctl start httpd
echo Ir0nM@n | sudo -S systemctl enable httpd
```

- `Execute shell script on remote host using ssh`
- Select `steve@stapp02`

```bash
echo Am3ric@ | sudo -S yum install -y httpd
echo Am3ric@ | sudo -S sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
echo Am3ric@ | sudo -S systemctl start httpd
echo Am3ric@ | sudo -S systemctl enable httpd
```

- `Execute shell script on remote host using ssh`
- Select `banner@stapp03`

```bash
echo BigGr33n | sudo -S yum install -y httpd
echo BigGr33n | sudo -S sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
echo BigGr33n | sudo -S systemctl start httpd
echo BigGr33n | sudo -S systemctl enable httpd
```

#### Create Webhook in `Gitea`
- Go to `Webhooks`
- Target URL `http://jenkins.stratos.xfusioncorp.com:8080/git/notifyCommit?url=http://git.stratos.xfusioncorp.com/sarah/web.git`
- Check `Trigger on`
- Branch filter `*`
- Check `Active`
- Press `Test Delivery`

#### Make a commit, push & give permission

```bash
ssh natasha@ststor01 # Bl@kW
sudo -i
su - sarah # Sarah_pass123
sudo chmod -R 777 /var/www/html # should show `-rwxrwxrwx`
sudo chown -R sarah:sarah /var/www/html
cd /home/sarah/web
cat index.html
vi index.html #  Welcome to the xFusionCorp Industries
cat index.html
```

```bash
git add index.html
git commit -m "webhook test"
git push origin master
```

#### Build Now Again
