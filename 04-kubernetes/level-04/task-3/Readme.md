```bash
kubectl apply -f nginx-phpfpm-service.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f nginx-phpfpm-pod.yaml
```

```bash
kubectl cp /opt/index.php nginx-phpfpm:/var/www/html/index.php -c nginx-container
kubectl get pods
kubectl get svc nginx-phpfpm-service
```

```bash
https://30012-port-sxtktyikc2e2ez6c.labs.kodekloud.com
```
