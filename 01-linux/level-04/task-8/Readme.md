```bash
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

```bash
# Enable EPEL and Remi repo
sudo yum install -y epel-release
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo yum module reset php -y
sudo yum module enable php:remi-8.3 -y
sudo yum install -y php php-cli php-fpm php-mysqlnd
```

```bash
php -v
```

```bash
sudo vi /etc/php-fpm.d/www.conf
listen = 127.0.0.1:9000
user = nginx
group = nginx
listen.owner = nginx
listen.group = nginx
```

```bash
sudo systemctl restart php-fpm
sudo ss -tulpn | grep 9000  # confirm it is listening

```

```bash
sudo vi /etc/nginx/conf.d/app.conf
server {
    listen 8094 default_server;
    server_name stapp03 172.16.238.12 _;  # _ catches all other requests
    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

```bash
grep ^listen /etc/php-fpm.d/www.conf
```

```bash
sudo nginx -t
sudo systemctl restart nginx
```

```bash
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
```

```bash
curl http://stapp03:8094/index.php
```
