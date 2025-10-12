### On App Server 3

```bash
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl status httpd
```

```bash
sudo vi /etc/httpd/conf/httpd.conf
```

```bash
sudo systemctl restart httpd
```

### On Jump Server

```bash
scp -r /home/thor/beta /home/thor/games banner@stapp03:/tmp/
sudo mv /tmp/beta /var/www/html/
sudo mv /tmp/games /var/www/html/
```

### On App Server (Test)

```bash
curl http://localhost:6000/beta/
curl http://localhost:6000/games/
```
