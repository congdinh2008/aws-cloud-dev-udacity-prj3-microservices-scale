kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# kubectl autoscale deployment backend-feed --cpu-percent=50 --min=2 --max=5
# kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://feed; done"
# kubectl get hpa backend-feed --watch
# kubectl get deployment backend-feed
# kubectl get hpa backend-feed --watch
# kubectl get deployment backend-feed