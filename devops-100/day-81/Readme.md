### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `Pipeline`, `Git`, & `SSH Pipeline Steps` > Hit `Install` Button.
- Restart

#### Create Jenkins Credentials

- For Git Access
  - Go to `Manage Jenkins` > `Credentials` > `(global)` > `Add Credentials`
  - Type: `Username with password`
  - ID: `GIT_CREDS`
  - Username: `sarah`
  - Password: `Sarah_pass123`

  - Go to `Manage Jenkins` > `Credentials` > `(global)` > `Add Credentials`
  - Type: `Username with password`
  - ID: `SSH_CREDS`
  - Username: `natasha`
  - Password: `Bl@kW`

#### Run on thor server - Manual Test
```bash
curl http://stapp01:8080
curl http://stapp02:8080
curl http://stapp03:8080
```

```bash
ssh natasha@ststor01 # Bl@kW
cd /home/natasha
git clone http://git.stratos.xfusioncorp.com/sarah/web.git
cd web
vi index.html # Add line: Welcome to xFusionCorp Industries
git add index.html
git commit -m "Just update"
git push origin master
# If Need Username > `sarah`
# If Need Password > `Sarah_pass123`
```

```bash
cd /var/www/html
ls -la # see `index.html`
cat index.html # see 'Welcome'
```

- Create a Pipeline Job
  - Go to Jenkins `Dashboard`
  - Click `New Item`
  - Name: `deploy-job`
  - Type: `Pipeline (Not multibranch)`
  - Click `OK`

- Jenkinsfile (Pipeline Script)
  - Pipeline Script

```bash
def remote = [:]
remote.name = 'ststor01'
remote.host = 'ststor01.stratos.xfusioncorp.com'
remote.allowAnyHosts = true

pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                echo '🔄 Pulling latest code on ststor01 and deploying to /var/www/html...'
                withCredentials([usernamePassword(credentialsId: 'SSH_CREDS', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        remote.user = USER
                        remote.password = PASS
                        sshCommand remote: remote, command: '''
                            set -e
                            echo "➡️ Navigating to existing repo..."
                            cd /home/natasha/web

                            echo "➡️ Pulling latest code from origin..."
                            git pull origin master

                            echo "➡️ Syncing code to /var/www/html..."
                            sudo rsync -a --delete /home/natasha/web/ /var/www/html/

                            echo "✅ Code successfully deployed to /var/www/html"
                        '''
                    }
                }
            }
        }
        stage('Test') {
            environment {
                INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
            }
            steps {
                echo '🔍 Testing website via Load Balancer (http://stlb01:8091)...'
                sh '''
                RESPONSE=$(curl -s http://stlb01:8091)
                if echo "$RESPONSE" | grep -F "$INDEX_CONTENT"; then
                    echo "✅ Website test passed. Content found."
                else
                    echo "❌ Website test failed. Expected content not found!"
                    exit 1
                fi
                '''
            }
        }
    }
}
```

- Hit `Apply` & `Save`
- Build Now

```bash
cd /var/www/html
ls -la
cat index.html # Should show: Welcome to xFusionCorp Industries
```

```bash
curl http://stlb01:8091
```

- 'deploy-job' pipeline job does not have 'Deploy' or 'Test' Stages
