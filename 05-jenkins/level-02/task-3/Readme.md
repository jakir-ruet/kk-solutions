### Login

#### Jenkins Server

- User Name: `admin`
- Password: `Adm!n321`

#### Gitea

- User Name: `sarah`
- Password: `Sarah_pass123`

#### Install Required Plugins in Jenkins

- Go to `Jenkins Dashboard` > `Manage Jenkins` > `Manage Plugins` > `Available Tab`
- Update all plugin
- Install `Git`. `Gitea`, `SSH` & `Publish over SSH`, `Parameterized Build`, `Matrix Authorization Strategy` plugins
- Restart

#### Add Gitea Credentials to Jenkins

- Go to `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Add > `Add Credentials`.
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `sarah`
- Description: `Skip`
- Click `Create`.

#### Configure Publish Over SSH

- Passphrase: `Bl@kW`
- Go to `Dashboard` > `Manage Jenkins` > `System` > `SSH Servers`
- Name: `ststor01`
- Hostname: `ststor01`
- Username: `natasha`
- Remote Directory: `/var/www/html`
- Test Configuration: `Success`

#### Login on storage server & Verify Permissions for /var/www/html directory

```bash
ssh natasha@ststor01 # Bl@kW
sudo su - # Bl@kW
sudo mkdir -p /var/www/html # if not available
sudo chmod 755 /var/www/html
ls -ld /var/www/html
```

#### Create the Jenkins Job `app-job`

- Go to Jenkins `Dashboard` > `New Item`.
- Name the job `app-job` and select `Freestyle` project,
- Then click `OK`.
- Configure the Job
  - General Tab
  - Select `This project is parameterized`
  - Click `Add Parameter` and choose `Choice Parameter`.
  - Name the parameter: `Branch`
  - In Choices, add the following branches:
    - version1
    - version2
    - version3
 - Description: `Skip`
 - Go to `Advanced` > `Use custom workspace`
- Scroll down to` Advanced Project` Options and enable `Use custom workspace`
- Set the Workspace path to `/var/lib/jenkins/${Branch}`

#### Source Code Management

- Select Git.
- In the `Repository URL` field, enter:
- `http://git.stratos.xfusioncorp.com/sarah/web_app.git`
- Credentials: Select `sarah`
- Branch Specifier (blank for 'any'): `*/${Branch}`

#### Environment

- Check `Send files or execute commands over SSH after the build runs`?
- Name: `ststor01`
- Transfer Set > Source File: `**/*` # for multiple file

#### Build & Run the Job

#### Build by selecting three version

- Select `version1` and press `Build Now`
- Select `version2` and press `Build Now`
- Select `version3` and press `Build Now`

#### Verify the Application

- This is app version 1
- This is app version 2
- This is app version 3
