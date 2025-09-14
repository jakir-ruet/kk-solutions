### Apply to create the pod

```bash
kubectl apply -f webserver-pod.yaml
kubectl get pods
kubectl describe pod webserver
```

### Check

```bash
kubectl port-forward pod/webserver 8080:80
kubectl logs webserver -c sidecar-container
```

```bash
curl http://localhost:8080
curl http://localhost:8080/does-not-exist
```
