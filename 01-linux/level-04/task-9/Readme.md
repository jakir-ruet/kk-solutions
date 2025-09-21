### php install

```bash
ssh steve@stapp02 # password: Am3ric@
sudo -i
sudo dnf install -y epel-release yum-utils
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module reset -y php
sudo dnf module enable -y php:remi-8.1
sudo dnf install -y php php-fpm php-mysqlnd
php -v
```

### PHP-FPM to listen on port 9000

```bash
sudo vi /etc/php-fpm.d/www.conf
listen = /var/run/php-fpm/default.sock
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
user = nginx
group = nginx
```

```bash
sudo mkdir -p /var/run/php-fpm
sudo chown nginx:nginx /var/run/php-fpm
```

```bash
sudo systemctl restart php-fpm
```

```bash
sudo dnf install -y nginx
sudo systemctl restart nginx
sudo systemctl enable nginx
sudo systemctl status nginx
nginx -v
```

```bash
sudo vi /etc/nginx/nginx.conf # paste from `server.conf`
```

```bash
sudo nginx -t
sudo systemctl restart nginx

```

```bash
sudo systemctl restart php-fpm
sudo systemctl enable php-fpm
sudo systemctl status php-fpm
```

```bash
ls -l /var/run/php-fpm/default.sock
# srw-rw----+ 1 root root 0 Sep 19 16:52 /var/run/php-fpm/default.sock
```

```bash
# Its optional
# if not available on `/var/www/html/index.php`, then
echo "Welcome to xFusionCorp Industries!" | sudo tee /var/www/html/index.php # or
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
```

```bash
systemctl restart php-fpm
systemctl status php-fpm
```

```bash
systemctl restart nginx
systemctl status nginx
```

```bash
exit
```

```bash
curl http://stapp02:8091/index.php # or
curl http://stapp02:8091/info.php # or
curl http://stapp02.stratos.xfusioncorp.com:8091/index.php
# should show `Welcome to xFusionCorp Industries!`
```
