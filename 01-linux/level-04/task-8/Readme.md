### php install

```bash
ssh tony@stapp01 # password: Ir0nM@n
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
user = nginx # instead of `apache`
group = nginx # instead of `apache`
listen = 127.0.0.1:9000 # instead of `listen = /run/php-fpm/www.sock`
```

```bash
chown -R root:nginx /var/lib/php
```

```bash
sudo dnf install -y nginx
sudo systemctl restart nginx
sudo systemctl enable nginx
sudo systemctl status nginx
nginx -v
```

```bash
 # take from `server.conf` file
sudo vi /etc/nginx/conf.d/php-fpm.conf # `Or`
sudo vi /etc/nginx/nginx.conf
```

```bash
sudo systemctl restart php-fpm
sudo systemctl enable php-fpm
sudo systemctl status php-fpm
```

```bash
sudo nginx -t
sudo systemctl restart nginx
```

```bash
# Its optional
ls -l /var/www/html/index.php
sudo chown -R nginx:nginx /var/www/html
sudo chmod -R 755 /var/www/html
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
curl http://stapp01:8091/index.php # or
curl http://stapp01.stratos.xfusioncorp.com:8091/index.php
# should show `Welcome to xFusionCorp Industries!`
```
