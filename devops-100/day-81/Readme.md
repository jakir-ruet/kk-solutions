#### Update all plugin & Insatll below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `SSH`, `Git`, `Pipeline` & `Pipeline Groovy` > Hit `Install` Button.
- Restart

#### Create Jenkins Credentials

- For Git Access
  - Go to `Manage Jenkins` > `Credentials` > `(global)` > `Add Credentials`
  - Type: `Username with password`
  - ID: `GIT_CREDS`
  - Username: `sarah`
  - Password: `Sarah_pass123`

- For SSH Access
  - Add another credential:
  - Type: `Username with password`
  - ID: `SSH_CREDS`
  - Username: `natasha`
  - Password: `Bl@kW`

- Create a Pipeline Job
  - Go to Jenkins `Dashboard`
  - Click `New Item`
  - Name: `deploy-job`
  - Type: `Pipeline (Not multibranch)`
  - Click `OK`

- Jenkinsfile (Pipeline Script)
  - Pipeline Script

```bash
pipeline {
    agent any

    environment {
        INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
        LBR_URL = 'http://stlb01:8091'
    }

    stages {
        stage('Deploy') {
            steps {
                echo 'Pulling latest code on Storage Server (/var/www/html)...'
                sshagent(['SSH_CREDS']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no natasha@ststor01.stratos.xfusioncorp.com << EOF
                        cd /var/www/html
                        git pull origin master
                        EOF
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing application accessibility via Load Balancer URL...'
                sh '''
                    sleep 5
                    curl -s $LBR_URL | grep -qF "$INDEX_CONTENT"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment and test succeeded!'
        }
        failure {
            echo '❌ Deployment or test failed!'
        }
    }
}
```







Step-by-Step Solution for Jenkins Pipeline Deployment
Step 1: Prepare Jenkins Environment

Login to Jenkins

URL: Jenkins UI via top bar button

Username: admin

Password: Adm!n321

Install/Update Plugins

Go to Manage Jenkins → Manage Plugins.

Under Updates tab: Click Select All and Download now and install after restart.

Under Available tab, search & install:

Git Plugin

Pipeline

Pipeline: Groovy

SSH Agent

Restart Jenkins after plugin installation (from the update center page).

Step 2: Create Jenkins Credentials

Git Credentials for Gitea

Manage Jenkins → Manage Credentials → (global) → Add Credentials

Kind: Username with password

Username: sarah

Password: Sarah_pass123

ID: GIT_CREDS

SSH Credentials for Storage Server (ststor01)

Same place: Add new credentials

Kind: Username with password

Username: natasha

Password: Bl@kW

ID: SSH_CREDS

Step 3: Update index.html in Gitea repository

Login to Gitea (top bar → Gitea button)

Username: sarah, Password: Sarah_pass123

Navigate to repository: sarah/web

Edit index.html content to:

Welcome to xFusionCorp Industries


Commit and push changes to master branch.

Note: Repo is cloned at /var/www/html on Storage server, so your Jenkins pipeline will pull this latest update from Git directly there.

Step 4: Create Jenkins Pipeline Job

On Jenkins dashboard, click New Item.

Enter name: deploy-job

Choose: Pipeline (NOT Multibranch Pipeline)

Click OK

Step 5: Configure Jenkins Pipeline Script

Copy this Jenkinsfile content into the Pipeline Script box:

pipeline {
    agent any

    environment {
        INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
        LBR_URL = 'http://stlb01:8091'
    }

    stages {
        stage('Deploy') {
            steps {
                echo 'Pulling latest code on Storage Server (/var/www/html)...'
                sshagent(['SSH_CREDS']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no natasha@ststor01.stratos.xfusioncorp.com << EOF
                        cd /var/www/html
                        git pull origin master
                        EOF
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing application accessibility via Load Balancer URL...'
                sh '''
                    sleep 5
                    curl -s $LBR_URL | grep -qF "$INDEX_CONTENT"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment and test succeeded!'
        }
        failure {
            echo '❌ Deployment or test failed!'
        }
    }
}

Step 6: Run Pipeline

Click Build Now on deploy-job.

Monitor console output.

The Deploy stage should SSH into ststor01, go to /var/www/html, and run git pull.

The Test stage should curl the load balancer URL (http://stlb01:8091) and confirm the updated content is served.

On success, the message ✅ Deployment and test succeeded! will appear.

If the test fails, the pipeline will mark failure.

Step 7: Verify Deployment

Open browser → visit:
http://stlb01:8091

Confirm the page content shows:
Welcome to xFusionCorp Industries

Ensure no sub-directory like /web appears in URL.

Notes:

Ensure Jenkins server can SSH to ststor01 (test manually via terminal).

The Storage server's /var/www/html should be a valid Git repository cloned from the Gitea repo.

Apache is running on all app servers and /var/www/html is mounted correctly.

If Jenkins cannot ssh directly, consider setting up SSH key authentication for smoother automation.

If needed, adjust Jenkins agent settings to use a node with SSH access.

If you want, I can help you with:

Commands to test SSH connectivity.

Setting up SSH keys.

Troubleshooting pipeline errors.

Ready to try this out or want me to help with any specific step?
