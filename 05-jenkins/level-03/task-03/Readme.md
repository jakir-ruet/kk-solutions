### Install Required Plugins in Jenkins

- Go to `Jenkins Dashboard` > `Manage Jenkins` > `Manage Plugins` > `Available Tab`
- Update all plugin
- Install `Git`, `Gitea`, `Pipeline` & `Docker Pipeline` plugins
- Restart

### Java install for Node

```bash
sudo su -
sudo yum install -y java
```

### Configure Jenkins Node (Agent) for `stapp01`

- Go to `Manage Jenkins` > `Nodes` > `New Node`
- Name: `stapp01`
- Type: `Permanent Agent`
- Remote root directory: `/home/tony/jenkins`
- Labels: `stapp01`
- Launch method: `SSH`
- Host: `stapp01`
- Select Credentials: `tony`
- Click `Save` and `Launch Agent`

### Create Jenkins Pipeline Job

- Create `New Item`
- Name: `nginx-container`
- Type: `Pipeline`
- Click `OK`
- Label: `stapp01`
- Under `Pipeline` > `Pipeline script`

```bash
pipeline {
    agent { label 'stapp01' }
    stages {
        stage('Build') {
            steps {
                script {
                    git url: 'http://git.stratos.xfusioncorp.com/sarah/web.git'
                    sh '''
                        docker build -t stregi01.stratos.xfusioncorp.com:5000/nginx:latest .
                        docker push stregi01.stratos.xfusioncorp.com:5000/nginx:latest
                    '''
                }
            }
        }
    }
}
```

### Click Build Now

- onitor the Console Output
- It should:
  - Clone the repo
  - Build the Docker image
  - Push to `stregi01.stratos.xfusioncorp.com:5000/nginx:latest`

### Verify Docker Image > SSH to stapp01 and run

```bash
curl http://stregi01.stratos.xfusioncorp.com:5000/v2/nginx/tags/list
```

```bash
# should see
{"name":"nginx","tags":["latest"]}
```
