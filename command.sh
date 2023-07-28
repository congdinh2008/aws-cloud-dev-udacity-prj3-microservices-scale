
aws configure
aws configure set aws_session_token

source set_env.sh
docker-compose -f docker-compose-build.yaml build --parallel
docker-compose down
docker image prune --all  
docker-compose up
docker-compose up

# To create your kubeconfig file with the AWS CLI
aws eks update-kubeconfig --region us-east-1 --name udacity-prj3-eks

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

kubectl expose deployment udagram-frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy  


# Convert string to base64
base64 <<< testing

# Redeploy 
kubectl set image deployment backend-user backend-user=congdinh2012/udagram-api-user:latest
kubectl set image deployment backend-feed backend-feed=congdinh2012/udagram-api-feed:latest
kubectl set image deployment reverseproxy reverseproxy=congdinh2012/reverseproxy:latest 
kubectl set image deployment udagram-frontend udagram-frontend=congdinh2012/udagram-frontend:latest


