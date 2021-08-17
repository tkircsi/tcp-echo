# NGINX ingress - expose TCP port

I used Docker-Destop.

## Create Docker image of tcp-echo app
  ``DOCKER_BUILDKIT=1 docker build -t (your name)/tcp-echo:v0.1 .``

## Push image to DockerHub (optional)
  ``docker push (your name)/tcp-echo:v0.1``

## Deploy nginx ingress
  ``kubectl apply -f k8s/nginx-ingress-deploy.yaml``

or

  ``kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/cloud/deploy.yaml``

## Deploy tcp-services ConfigMap
  ``kubectl apply -f k8s/ingress-cm.yaml``

## Deploy tcp-echo
Rename image to your image name in spec.containers.image!
  
  ``kubectl apply -f k8s/tcpecho-deployment.yaml``

## Path nginx ingress controller

  ``kubectl patch deployment ingress-nginx-controller -n ingress-nginx --patch-file k8s/nginx-ingress-controller-patch.yaml``

  ``kubectl patch service ingress-nginx-controller -n ingress-nginx --patch-file k8s/nginx-ingress-svc-controller-patch.yaml``

## Check nginx services
  ``kubectl get all -n ingress-nginx``

## Verify TCP port
  ``nc localhost 5000``


