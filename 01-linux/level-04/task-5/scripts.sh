sudo vi /var/www/html/index.php

<?php
$servername = "172.16.239.10";   // Replace with DB server private IP/hostname
$username = "kodekloud_sam";
$password = "Rc5C9EyvbU";
$dbname = "kodekloud_db4";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "App is able to connect to the database using user kodekloud_sam";
$conn->close();
?>

######### if it not working then ###################
sudo tee /var/www/html/index.php > /dev/null <<'EOF'
<?php
$servername = "172.16.239.10";   // replace with actual DB server private IP
$username = "kodekloud_sam";
$password = "Rc5C9EyvbU";
$dbname = "kodekloud_db4";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "App is able to connect to the database using user kodekloud_sam";
$conn->close();
?>
EOF
