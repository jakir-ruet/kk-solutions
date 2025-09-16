kubectl apply -f pv-devops.yaml
kubectl apply -f pvc-devops.yaml
kubectl apply -f pod-devops.yaml
kubectl apply -f web-devops.yaml

kubectl get pv
kubectl get pvc
kubectl get pod
kubectl get svc
