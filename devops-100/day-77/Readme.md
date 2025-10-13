#### Update all plugin & install below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `Pipeline`, `Pipeline Groovy` & `SSH Build Agents` > Hit `Install` Button.
- Restart

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `GIT_CREDS`
- Description: `leave`
- Hit `Create` Button,

- Go `Dashboard` > `Manage Jenkins` > `System`
- Go `SSH remote hosts` Section
- Hostname: `ststor01`
- Port: `22`
- Credentials: Select `natasha`
- Check Connection `>` Hit `Apply` and `Save`

#### Java Install

```bash
ssh natasha@ststor01
sudo yum install java -y
java -version
```

#### Create a node

- Name `Storage Server`
- Description `leave`
- Number of executors `1`
- Remote root directory `/var/www/html`
- Labels `ststor01`
- Launch method: `Use SSH`
  - Host `ststor01` or `172.16.238.15`
  - Select Credentials `natasha`
- Host Key Verification Strategy
  - Non-verifying Verification Strategy
- Hit `Save`

#### Create Jenkins Pipeline Job

- Go to `Jenkins Dashboard` > `New Item`.
- Name: `devops-webapp-job`
- Select: `Pipeline`
- Click `OK`.

##### Configure Pipeline Job

- Name `devops-webapp-job`
- Description: `leave`
- Pipeline > Pipeline script > `script` > paste below code.

```bash
pipeline {
    agent { label 'ststor01' }
    stages {
        stage('Deploy') {
            steps {
                // Clone or pull latest from the Gitea repo
                dir('/var/www/html') {
                    script {
                        if (fileExists('.git')) {
                            sh 'git pull'
                        } else {
                            sh 'git clone http://sarah:Sarah_pass123@git.stratos.xfusioncorp.com/sarah/web_app.git .'
                        }
                    }
                }
            }
        }
    }
}
```

- Hit `Apply` and `Save`

```bash
cd /var/www/html
cat index.html
```

```bash
Welcome to xFusionCorp Industries! # should show
```
