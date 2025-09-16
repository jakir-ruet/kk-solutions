```bash
kubectl apply -f pv-devops.yaml
kubectl apply -f pvc-devops.yaml
kubectl apply -f configmap.yaml
kubectl apply -f pod-devops.yaml
kubectl apply -f svc-devops.yaml
```

```bash
kubectl get pv
kubectl get pvc
kubectl get configmap
kubectl get pod
kubectl get svc
```

```bash
kubectl exec -it pod-devops -- ls -l /usr/local/apache2/htdocs
kubectl exec -it pod-devops -- cat /usr/local/apache2/htdocs/index.html
```

```bash
https://30008-port-laodpfgyk7wmu7py.labs.kodekloud.com
```
