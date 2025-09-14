```bash
kubectl apply -f ic-deploy-datacenter.yaml
kubectl get deployment
kubectl get pods
kubectl get pods -l app=ic-datacenter
kubectl logs -f ic-deploy-datacenter-c4d8cd757-2vc8k
```

```bash
Init Done - Welcome to xFusionCorp Industries # should see
```

```bash
kubectl exec -it ic-deploy-datacenter-c4d8cd757-2vc8k -- /bin/bash
```
