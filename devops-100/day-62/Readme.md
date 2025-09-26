```bash
kubectl create secret generic ecommerce --from-file=/opt/ecommerce.txt
```

```bash
kubectl apply -f secret-datacenter.yaml
kubectl get pods
```

```bash
kubectl exec -it secret-datacenter -- ls -l /opt/cluster
kubectl exec -it secret-datacenter -- cat /opt/cluster/ecommerce.txt
```
