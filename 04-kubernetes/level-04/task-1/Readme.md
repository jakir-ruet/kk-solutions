```bash
kubectl apply -f redis-config.yaml
kubectl apply -f redis-deployment.yaml
```


```bash
kubectl get pods
kubectl describe pod -l app=redis
```
