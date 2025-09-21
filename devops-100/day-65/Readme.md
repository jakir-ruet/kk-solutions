```bash
kubectl apply -f redis-config.yaml
kubectl apply -f redis-deployment.yaml
```

```bash
kubectl get pods
kubectl describe pod -l app=redis
kubectl logs -l app=redis
```

```bash
kubectl exec -it redis-deployment-68fbd4467-tzbvt -- redis-cli
set testkey "HelloRedis"
get testkey
```
