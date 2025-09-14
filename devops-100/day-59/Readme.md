```bash
kubectl get deployment redis-deployment
kubectl describe deployment redis-deployment
kubectl get pods -l app=redis -o wide
kubectl get pod
kubectl describe pod redis-deployment-54cdf4f76d-jp9dq
kubectl logs redis-deployment-54cdf4f76d-jp9dq
```

```bash
kubectl set image deployment/redis-deployment redis-container=redis:alpine
```

### Issue here

```bash

- configMap:
          defaultMode: 420
          name: redis-conig # it should be `redis-config`
        name: config
```

```bash
kubectl edit deployment redis-deployment
```

```bash
kubectl get pods -l app=redis
kubectl describe pod redis-deployment-7c8d4f6ddf-57dwl
```
