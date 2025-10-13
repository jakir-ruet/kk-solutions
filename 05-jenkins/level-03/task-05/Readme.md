
#### Update all plugin & install below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `Git`, `SSH`, `SSH Build Agents`, `Pipeline`, & `Pipeline Groovy`  > Hit `Install` Button.
- Restart

#### Create SSH credentials in Jenkins

- `Dashboard` > `Manage Jenkins` > `Credentials` > `System` > `Global credentials (unrestricted)`
- Username: `sarah`
- Password: `Sarah_pass123`
- ID: `GIT_CREDS`
- Description: `leave`
- Hit `Create` Button,

- Username: `natasha`
- Password: `Bl@kW`
- ID: `SSH_CREDS`
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
ssh natasha@ststor01 # Bl@kW
sudo su - # Bl@kW
sudo yum install java -y
java -version
sudo chown -R natasha:natasha /var/www/html
sudo chown -R natasha:natasha /var/www
sudo chmod -R 755 /var/www
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
- Name: `xfusion-webapp-job`
- Select: `Pipeline`
- Click `OK`.

##### Configure Pipeline Job

- Name `xfusion-webapp-job`
- Description: `leave`
- Check `This project is parameterized?`
- Select `String Parameter`
- Name `BRANCH`
- Default Value `master`
- Pipeline > Pipeline script > `script` > paste below code.

```bash
pipeline {
    agent { label 'ststor01' }
    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Branch to deploy (master or feature)')
    }
    stages {
        stage('Deploy') {
            steps {
                dir('/var/www/html') {
                    script {
                        if (fileExists('.git')) {
                            sh """
                                git fetch origin
                                git reset --hard origin/${params.BRANCH}
                                git clean -fd
                                git checkout ${params.BRANCH}
                            """
                        } else {
                            checkout([$class: 'GitSCM',
                                      branches: [[name: "refs/heads/${params.BRANCH}"]],
                                      userRemoteConfigs: [[
                                        url: 'http://git.stratos.xfusioncorp.com/sarah/web_app.git',
                                        credentialsId: 'GIT_CREDS'
                                      ]]
                            ])
                        }
                    }
                }
            }
        }
    }
}

```

- Hit `Apply` and `Save`

#### Build Now

- Build with Parameters > Select BRANCH > `master` Press `Build`
- Build with Parameters > Select BRANCH > `feature` Press `Build`

```bash
cat /var/www/html/index.html
```

```bash
# for master branch
Welcome to xFusionCorp Industries! # should show
```

```bash
# for feature branch
Welcome to xFusionCorp Industries! # should show
```

#### How to Verify It's Working Correctly

- Go to `Jenkins Dashboard`> `devops-webapp-job` > `Build with Parameters`

- Select: `BRANCH` = `master` > Click `Build`
- Confirm build succeeds and `/var/www/html/index.html` shows content from master branch.

- Repeat with:
- Select: `BRANCH` = `feature` > Click `Build`
- Confirm it now shows content from feature branch instead.

- Lastly, open your browser and go to:
- https://<LBR-URL>
- The correct page content should load based on the branch deployed.

- Seems like website is not working.
