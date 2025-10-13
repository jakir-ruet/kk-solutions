### Update all plugin & install below plugins

- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Check All > Hit `Update` Button.
- Go > `Dashboard` > `Manage Jenkins` > `Plugins` > Select`Available plugins`.
- Search name `Git`, `SSH`, `SSH Agent`, `SSH Build Agents`, `Pipeline`, & `SSH Pipeline Steps` > Hit `Install` Button.
- Restart

### Connect to Jenkins server as root and run (If not available)
- `ssh jenkins@jenkins` # j@rv!s
- `sshpass -V` # check sshpass version
- `yum install sshpass -y`   # RHEL/CentOS, Or
- `apt install sshpass -y`   # Ubuntu/Debian

### Update `index.html` content before creating pipeline

#### Method - 1 (Recommended)

- Login to Gitea to Gitea UI
- Username `sarah`
- Password `Sarah_pass123`
- Navigate to `sarah/web` repository
- Update `index.html`
- Put `Welcome to xFusionCorp Industries` instead of `Welcome`
- Commit message `Update welcome message`
- `Save` & `Exit`

```bash
ssh natasha@ststor01 # Bl@kW
sudo chown natasha:natasha /var/www/html/index.html
sudo chmod 755 /var/www/html/index.html
```

#### Method - 2

```bash
ssh natasha@ststor01 # Bl@kW
cd /var/www/html
echo "Welcome to xFusionCorp Industries" | sudo tee index.html
sudo chown natasha:natasha index.html
sudo chmod 755 index.html
```

```bash
git add index.html
git commit -m "Update welcome message"
git push origin master
# Username > `sarah`
# Password > `Sarah_pass123`
```

### Create Pipeline Job

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
    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Clone the repository (no credentials needed for public repo)
                git url: 'http://git.stratos.xfusioncorp.com/sarah/web.git', branch: 'master'
                // Copy files to storage server using shell commands
                sh '''
                    echo "Deploying files to storage server..."
                    # Method 1: If Jenkins can access shared storage directly
                    if [ -d "/var/www/html" ] && [ -w "/var/www/html" ]; then
                        echo "Direct access to shared storage"
                        cp -r * /var/www/html/
                        echo "Direct copy completed"
                    else
                        # Method 2: Using SCP
                        echo "Using SCP to transfer files"
                        # First, verify what content we have locally
                        echo "DEBUG: Local index.html content:"
                        cat index.html || echo "No index.html found locally"
                        # Create correct content if needed
                        # echo "Welcome to xFusionCorp Industries" > index.html
                        # echo "DEBUG: Updated local index.html content:"
                        # cat index.html
                        # Transfer files
                        sshpass -p "Bl@kW" scp -o StrictHostKeyChecking=no -r index.html natasha@ststor01:/var/www/html/
                        # Verify content on remote server
                        echo "DEBUG: Remote index.html content:"
                        sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "cat /var/www/html/index.html"
                        # Fix permissions using echo to pass password to sudo
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chown -R apache:apache /var/www/html 2>/dev/null || true"
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chmod -R 755 /var/www/html 2>/dev/null || true"
                        echo "SCP deployment completed"
                    fi
                    echo "Deployment completed successfully"
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing deployment...'
                script {
                    def expectedContent = 'Welcome to xFusionCorp Industries'
                    // Wait a moment for deployment to propagate
                    sleep(5)
                    try {
                        // Test Load Balancer URL
                        def lbResponse = sh(script: 'curl -s http://stlb01:8091/', returnStdout: true).trim()
                        echo "DEBUG: Load balancer response: ${lbResponse}"
                        echo "DEBUG: Expected content: ${expectedContent}"
                        if (!lbResponse.contains(expectedContent)) {
                            error("Load balancer test failed. Expected content '${expectedContent}' not found in response: '${lbResponse}'")
                        }
                        echo " Load balancer test passed"
                        // Test individual app servers
                        ['stapp01:8080', 'stapp02:8080', 'stapp03:8080'].each { server ->
                            def response = sh(script: "curl -s http://${server}/", returnStdout: true).trim()
                            if (!response.contains(expectedContent)) {
                                error("App server ${server} test failed")
                            }
                            echo " ${server} test passed"
                        }
                        echo 'All tests passed successfully!'
                    } catch (Exception e) {
                        error("Test stage failed: ${e.getMessage()}")
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
```

- Hit `Apply` & `Save`
- Click `Build Now`

#### Pay attention

- Monitor console output during both the Deploy and Test stages.
- Validate the Deploy stage:
  - Confirm Git repository is cloned successfully
  - Verify SSH file transfer is completed
  - Check correct file permissions are set
- Validate the Test stage:
  - Perform load balancer functionality test
  - Verify application servers respond correctly
- Access `http://stlb01:8091` to verify deployment
- Ensure the page displays: `Welcome to xFusionCorp Industries`

#### Troubleshooting Tips - Common Issues and Solutions:

- **Git authentication failure**: Verify `GIT_CREDS` are correctly configured.
- **Missing SSH Pipeline Steps plugin**: Install and restart Jenkins if needed.
- **SSH connection failure**: Check SSH credentials (`natasha`/`Bl@kW`) and connection settings.
- **Apache not responding**: Ensure `httpd` is running and listening on port `8080`.
- **Content not updated**: Verify deployment copied all files to the correct location.
- **Test stage fails**: Ensure deployed content exactly matches expected output.
- **Strict output check**: Must be case-sensitive with no extra whitespace — `Welcome to xFusionCorp Industries`.

#### Manual Commands for Verification

- `curl -I http://stlb01:8091` # Check HTTP response headers from the load balancer
- `curl http://stlb01:8091` # Retrieve and inspect the content served by the load balancer
- Test connectivity and content from individual application servers
  - `curl http://stapp01:8080`    # App Server 1
  - `curl http://stapp02:8080`    # App Server 2
  - `curl http://stapp03:8080`    # App Server 3

#### Verify deployment > `ssh natasha@ststor01`
- `ls -la /var/www/html/`
- `cat /var/www/html/index.html`
