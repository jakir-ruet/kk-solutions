# Health check

# list pods in the namespace (default assumed). If non-default namespace, add -n <ns>
kubectl get pods -o wide
kubectl get node -o wide
kubectl get svc
kubectl get deployment
kubectl describe deployment
kubectl get pvc,pv

kubectl get pod

# Go to `/app/index.php` inside `httpd-php-container`
kubectl exec -it lamp-wp-56c7c454fc-rmmc7 -c httpd-php-container -- /bin/bash
cd /app/ # Should show something like `index.php`

sudo vi /app/index.php

<?php
    // Fetch environment variables
    $dbname = $_ENV['MYSQL_DATABASE'];
    $dbuser = $_ENV['MYSQL_USER'];
    $dbpass = $_ENV['MYSQL_PASSWORD'];
    $dbhost = $_ENV['MYSQL_HOST'];

    // Connect to database
    $connect = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

    // Check connection
    if (!$connect) {
        die("Connection failed: " . mysqli_connect_error());
    }

    echo "Connected successfully\n";

    // Test query
    $test_query = "SHOW TABLES FROM $dbname";
    $result = mysqli_query($connect, $test_query);

    if (!$result) {
        die("Query failed: " . mysqli_error($connect));
    }

    // Display tables
    while ($row = mysqli_fetch_row($result)) {
        echo "Table: {$row[0]}\n";
    }

    // Close connection
    mysqli_close($connect);
?>

chown apache:apache index.php
chmod 644 index.php
php /app/index.php # Should show something like 'Connected successfully'

kubectl get svc lamp-service
# Should show something like 80:30008/TCP

kubectl get svc lamp-service # check node port
curl http://172.17.0.2:30008/ # 172.17.0.2 is CLUSTER-IP

# if okay then done
# if not okay, then

kubectl exec -it lamp-wp-56c7c454fc-vt2dd -c httpd-php-container -- netstat -tlnp | grep httpd

# # Should show something like
# tcp        0      0 :::443                  :::*                    LISTEN      114/httpd
# tcp        0      0 :::80                   :::*                    LISTEN      114/httpd

kubectl get svc lamp-service -o yaml
kubectl edit svc lamp-service
# Now hit 'App' button right conner of panel, it will works.
# Should show something like 'Connected successfully'

# Optional
kubectl get svc lamp-service -o yaml > lamp-service-backup.yaml
kubectl apply -f lamp-service-backup.yaml






