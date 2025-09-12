# Health check

# list pods in the namespace (default assumed). If non-default namespace, add -n <ns>
kubectl get pods -o wide
kubectl get node -o wide
kubectl get svc
kubectl get deployment
kubectl describe deployment
kubectl get pvc,pv



sudo vi /app/test-db.php inside `httpd-php-container`

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
