### On DB Server

```bash
sudo yum install -y mariadb-server
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb
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
CREATE DATABASE kodekloud_db1;
CREATE USER 'kodekloud_gem'@'%' IDENTIFIED BY 'ksH85UJjhb';
GRANT ALL PRIVILEGES ON kodekloud_db1.* TO 'kodekloud_gem'@'%';
FLUSH PRIVILEGES;
```

```bash
exit
```
