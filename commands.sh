# Create environment:
	terraform init	
# Validate code terraform
	terraform validate
# Plan create resource
	terraform plan -out solution.plan
# Apply plan to create resource
	terraform apply solution.plan
# Destroy resource
    terraform destroy

# Create eks cluster mat nhieu time => 20p de tao resource hoac destroy resource

# Command kubectl
    # Check version kubectl
	kubectl version --short
    # Config kubectl with eks
    aws eks --region region-name update-kubeconfig --name cluster_name
    # Check config kubectl
    kubectl config view
    # Check node
    kubectl get nodes
    # Check pod
    kubectl get pods
    # Check service => Get external ip to access api - thay the vao fe environment
    kubectl get svc
    # Check deployment
    kubectl get deployment
    # Check ingress
    kubectl get ingress
    # Access to pod terminal
    kubectl exec -it pod_name -- /bin/bash
    # Set new image to deployment
    kubectl set image deployment/deployment_name container_name=image_name