```bash
kubectl apply -f mysql-pv.yaml
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-root-pass-secret.yaml
kubectl apply -f mysql-user-pass-secret.yaml
kubectl apply -f mysql-db-url-secret.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
```

```bash
kubectl get pv
kubectl get pvc
kubectl get pods
kubectl get svc
kubectl describe pod -l app=mysql
```

```bash
kubectl run -it mysql-client --image=mysql:8.0 --rm -- /bin/bash
mysql -h mysql -P 3306 -u kodekloud_sam -p # B4zNgHA7Ya
SHOW DATABASES;
```
