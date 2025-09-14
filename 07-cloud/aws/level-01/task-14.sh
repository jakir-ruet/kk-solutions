kubectl describe pod nginx-phpfpm
# containers are php-fpm-container and nginx-container

kubectl edit configmap nginx-config

# Change the root path so it is like. Set nginx to serve files from the shared volume!
root /usr/share/nginx/html;


kubectl get pod nginx-phpfpm -o yaml > pod.yaml
vi pod.yaml

# Update the volume mount in the nginx container

  - image: nginx:latest
    imagePullPolicy: Always
    name: nginx-container
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /usr/share/nginx/html    #<- Edit to be this
      name: shared-files

kubectl replace --force -f pod.yaml

kubectl cp -c nginx-container index.php nginx-phpfpm:/usr/share/nginx/html/index.php
