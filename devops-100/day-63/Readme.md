```bash
kubectl apply -f iron-namespace.yaml
kubectl apply -f iron-db-deployment.yaml
kubectl apply -f iron-db-service.yaml
kubectl apply -f iron-gallery-deployment.yaml
kubectl apply -f iron-gallery-service.yaml
```

```bash
kubectl get ns
kubectl get deployments -n iron-namespace-devops
kubectl get pods -n iron-namespace-devops
kubectl get svc -n iron-namespace-devops
```
