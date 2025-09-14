```bash
kubectl apply -f pv-devops.yaml
kubectl apply -f pvc-devops.yaml
kubectl apply -f pod-devops.yaml
kubectl apply -f svc-devops.yaml
```

```bash
kubectl get pv
kubectl get pvc
kubectl get pod
kubectl get svc
```

```bash
kubectl exec -it pod-devops -- /bin/bash
ls -la /usr/local/apache2/htdocs
cat /usr/local/apache2/htdocs/index.html
```

```bash
curl https://30008-port-b7mqr4sntmvbih4j.labs.kodekloud.com/
```

```bash
<h1>Welcome to DevOps App</h1> # Should show
```
