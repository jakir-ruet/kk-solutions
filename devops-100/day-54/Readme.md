### Create the YAML manifest and apply

```bash
kubectl apply -f volume-share-xfusion.yaml
kubectl get pods
```

### Exec into the first container and create the file

```bash
kubectl exec -it volume-share-xfusion -c volume-container-xfusion-1 -- /bin/bash
echo "Shared content" > /tmp/beta/beta.txt
exit
```

### Verify the file from the second container

```bash
kubectl exec -it volume-share-xfusion -c volume-container-xfusion-2 -- /bin/bash
cat /tmp/apps/beta.txt # should show `Shared content`
```
