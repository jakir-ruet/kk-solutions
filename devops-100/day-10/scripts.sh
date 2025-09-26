### Step by Step Solution

#### On App Server 2

##### Create file, directories, give permission and ownership etc.

```bash
ssh steve@stapp02 # here app server 2 password needed
mkdir -p /scripts # if not available
sudo sudo vi /scripts/blog_backup.sh
sudo chown steve:steve /scripts/ # give ownership to steve
sudo chown steve:steve /scripts/blog_backup.sh # give ownership to steve
sudo chmod +x /scripts/blog_backup.sh # give execute permission & just copy paste
sudo mkdir -p /var/www/html/blog # if not available
sudo chown steve:steve /var/www/html/blog # give ownership to steve
sudo chmod -R 755 /var/www/html/blog # give permission to steve
```

##### Make connection to backup server with app server 2

```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id clint@stbkp01
```

#### On Backup Server

```bash
cd /
ls -la
sudo chown clint:clint /backup/ # here backup server password needed
```

#### Again, on App Server 2

##### Execute the script

```bash
sudo /scripts/blog_backup.sh
```

##### We may run CronJob (If needed)

```bash
crontab -e
0 2 * * * /scripts/blog_backup.sh
sudo systemctl status cron
sudo systemctl start cron
grep CRON /var/log/syslog
```
