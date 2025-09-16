```bash
kubectl create secret generic ecommerce --from-file=/opt/ecommerce.txt
```

```bash
kubectl get secrets
kubectl describe secret ecommerce
```

```bash
cd /opt
sudo mkdir cluster
```

```bash
kubectl apply -f secret-pod.yaml
```

```bash
kubectl get pods
kubectl exec -it secret-xfusion -- bash
ls /opt/cluster
cat /opt/cluster/ecommerce.txt
```
