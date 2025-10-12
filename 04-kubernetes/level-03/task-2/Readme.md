```bash
kubectl apply -f php-config.yaml
kubectl apply -f lamp-wp-deployment.yaml
kubectl apply -f mysql-secrets.yaml
kubectl apply -f lamp-service.yaml
kubectl apply -f mysql-service.yaml
```

```bash
kubectl get pods
kubectl cp /tmp/index.php lamp-wp-85d46cdf9b-k9xqs:/app/index.php
```

```bash
https://30008-port-3bhdz2zncbuzq2dn.labs.kodekloud.com/
```
