```bash
kubectl apply -f mysql-pv.yaml
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-secret-root.yaml
kubectl apply -f mysql-secret-user.yaml
kubectl apply -f mysql-secret-db-url.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
```

```bash
kubectl get pv
kubectl get pvc
kubectl get secret
kubectl get deployment
kubectl get pods
```

```bash
kubectl run -it mysql-client --image=mysql:8.0 --rm -- /bin/bash
mysql -h mysql -P 3306 -u kodekloud_rin -p # pass TmPcZjtRQx
SHOW DATABASES;
```
