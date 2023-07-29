
aws configure
aws configure set aws_session_token

source ../set_env.sh
docker-compose -f docker-compose-build.yaml build --parallel
docker-compose down
docker image prune --all  
docker-compose up
docker-compose up

# To create your kubeconfig file with the AWS CLI
aws eks update-kubeconfig --region us-east-1 --name udacity-prj3-eks

## Use a combination of head/tail command to identify lines you want to convert to base64
## You just need two correct lines: a right pair of aws_access_key_id and aws_secret_access_key
cat ~/.aws/credentials | tail -n 5 | head -n 2
## Convert 
cat ~/.aws/credentials | tail -n 5 | head -n 2 | base64

# Variables
kubectl apply -f aws-secret.yaml                                                           
kubectl apply -f env-secret.yaml
kubectl apply -f env-configmap.yaml

kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f backend-feed-deployment.yaml
kubectl apply -f backend-feed-service.yaml
kubectl apply -f backend-user-deployment.yaml
kubectl apply -f backend-user-service.yaml
kubectl apply -f reverseproxy-deployment.yaml
kubectl apply -f reverseproxy-service.yaml

# Logging
kubectl logs -p backend-feed-545b8757d6-pmtnj
kubectl delete pod reverseproxy-794bc8dc7c-r8nv2
kubectl delete deployment reverseproxy
kubectl delete pods --all -A
kubectl delete deployments --all -A

# Checking
kubectl get deployments 
kubectl get services
kubectl get svc
kubectl get pods
kubectl get endpoints    

kubectl expose deployment udagram-frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy  


# Convert string to base64
base64 <<< testing

# Redeploy 
kubectl set image deployment backend-user backend-user=congdinh2012/udagram-api-user:v3
kubectl set image deployment backend-feed backend-feed=congdinh2012/udagram-api-feed:v3
kubectl set image deployment reverseproxy reverseproxy=congdinh2012/reverseproxy:v3
kubectl set image deployment udagram-frontend udagram-frontend=congdinh2012/udagram-frontend:v3

kubectl autoscale deployment backend-feed --cpu-percent=50 --min=1 --max=2
kubectl autoscale deployment backend-user --cpu-percent=50 --min=1 --max=2
kubectl autoscale deployment udagram-frontend --cpu-percent=50 --min=1 --max=2

kubectl describe pod [pod-name]

kubectl logs -p [pod-name]
## Once you increase the memory, check the updated deployment as:
kubectl get pod [pod-name] --output=yaml
## You can autoscale, if required, as
kubectl autoscale deployment backend-user --cpu-percent=70 --min=3 --max=5

## Assuming "backend-feed-68d5c9fdd6-dkg8c" is a pod
kubectl exec --stdin --tty podname -- /bin/bash
## See what values are set for environment variables in the container
printenv | grep POST
## Or, you can try "curl <cluster-IP-of-backend>:8080/api/v0/feed " to check if services are running.
## This is helpful to see is backend is working by opening a bash into the frontend container

printenv | grep POST

## Kubernetes pods are deployed properly
kubectl get pods 
## Kubernetes services are set up properly
kubectl describe services
## You have horizontal scaling set against CPU usage
kubectl describe hpa

kubectl delete pods -l app=backend-feed
kubectl delete pods -l app=backend-user
kubectl delete pods -l app=reverseproxy
kubectl delete pods -l app=udagram-frontend