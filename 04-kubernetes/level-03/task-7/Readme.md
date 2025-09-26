```bash
kubectl create secret generic mysql-root-pass \
  --from-literal=password=R00t
```

```bash
kubectl create secret generic mysql-user-pass \
  --from-literal=username=kodekloud_aim \
  --from-literal=password=ksH85UJjhb
```

```bash
kubectl create secret generic mysql-db-url \
  --from-literal=database=kodekloud_db10
```

```bash
kubectl create secret generic mysql-host \
  --from-literal=host=mysql-service
```

```bash
kubectl create configmap php-config \
  --from-literal=variables_order="EGPCS"
```

```bash
kubectl apply -f lemp-deployment.yaml
```

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: lemp-service
spec:
  type: NodePort
  selector:
    app: lemp
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
EOF
```

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: lemp
  ports:
    - port: 3306
      targetPort: 3306
EOF
```

```bash
sudo vi /tmp/index.php
```

```bash
<?php
$servername = getenv('MYSQL_HOST');
$username = getenv('MYSQL_USER');
$password = getenv('MYSQL_PASSWORD');
$dbname = getenv('MYSQL_DATABASE');

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?>
```


```bash
POD_NAME=$(kubectl get pods -l app=lemp -o jsonpath='{.items[0].metadata.name}')
kubectl cp /tmp/index.php $POD_NAME:/app/index.php -c nginx-php-container
```

```bash
kubectl get pods
kubectl get svc
```

```bash
https://30008-port-lrmud4gyhkgovhtw.labs.kodekloud.com
```
