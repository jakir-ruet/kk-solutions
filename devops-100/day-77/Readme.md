#### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `SSH Pipeline` & `SSH Build Agents` > Hit `Install` Button.
- Restart

#### Install Java

```bash
ssh natasha@ststor01
sudo su -
yum install -y java
rpm -qa |grep java
```

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `sarah`
- Description: `leave`
- Hit `Create` Button,

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `ststor01`
- Port: `22`
- Credentials: Select `natasha`
- Check Connection `>` Hit `Apply` and `Save`

#### Again go to nodes to update

- Go `Storage Server`
- Remote root directory `/home/natasha/jenkins`
- Host `ststor01`
- Select Credentials `natasha`
- Host Key Verification Strategy `Non verifying Verification Strategy`

#### Create the Build Job

- Go `Dashboard` > `All` > `New Item`
- Name: `devops-webapp-job`
- Select `Pipeline`
- Give Pipeline Script

```bash
pipeline {
    agent { label 'ststor01' }
    stages {
        stage('Deploy') {
            steps {
                git branch: 'master', url: 'http://gitea.stratos.xfusioncorp.com/sarah/web_app.git'
                sh '''
                  # Ensure files are copied to /var/www/html
                  cp -r * /var/www/html/
                '''
            }
        }
    }
}
```

- Click `Ok`

#### Check

```bash
ssh sarah@ststor01
cd /home/sarah/web_app/
ll
cat index.html
curl http://stapp01:6200
git add index.html
git commit -m "update"
git push origin master
```

```bash
curl http://stapp01:6200
Welcome to Nautilus Group!
curl http://stapp02:6200
Welcome to Nautilus Group!
curl http://stapp03:6200
```
