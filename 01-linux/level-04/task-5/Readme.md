### On each App Host

```bash
sudo yum install -y httpd php php-mysqlnd php-fpm
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl status httpd
```

```bash
sudo vi /etc/httpd/conf/httpd.conf
Listen 3001
```

```bash
<VirtualHost *:3001>
    DocumentRoot "/var/www/html"
    DirectoryIndex index.php index.html
</VirtualHost>
```

```bash
sudo systemctl restart httpd
```

### On DB Server

```bash
sudo yum install -y mariadb-server
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

```bash
sudo su -
mysql
```

```bash
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'RootPass@054003';
FLUSH PRIVILEGES;
```

```bash
exit
```

```bash
mysql -u root -p
RootPass@054003
```

```bash
CREATE DATABASE kodekloud_db4;
CREATE USER 'kodekloud_sam'@'%' IDENTIFIED BY 'Rc5C9EyvbU';
GRANT ALL PRIVILEGES ON kodekloud_db4.* TO 'kodekloud_sam'@'%';
FLUSH PRIVILEGES;
```

```bash
exit
```

### Let's check it will works
