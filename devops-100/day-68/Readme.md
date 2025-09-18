```bash
ssh root@jenkins # S3curePass
```

```bash
sudo dnf install -y java-17-openjdk java-17-openjdk-devel
```

```bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' | sudo tee /etc/profile.d/java.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile.d/java.sh
source /etc/profile.d/java.sh
```

```bash
java -version
```

```bash
sudo dnf install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
```

```bash
sudo dnf install -y jenkins
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable jenkins --now
sudo systemctl status jenkins
```

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
