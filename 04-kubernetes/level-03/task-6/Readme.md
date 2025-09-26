```bash
kubectl apply -f envars-pod.yaml
```

```bash
kubectl get pods
kubectl exec -it envars -- /bin/bash
printenv NODE_NAME POD_NAME POD_IP POD_SERVICE_ACCOUNT
``
