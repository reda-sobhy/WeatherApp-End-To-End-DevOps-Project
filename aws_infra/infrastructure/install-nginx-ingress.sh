#!/bin/bash

set -e
aws eks update-kubeconfig --region us-east-1 --name my-eks
echo "========================================="
echo "Installing NGINX Ingress Controller"
echo "========================================="

# Add ingress-nginx Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Update repositories
helm repo update

# Create namespace
kubectl create namespace ingress-nginx --dry-run=client -o yaml | kubectl apply -f -

# Install or Upgrade ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --set controller.replicaCount=2 \
    --set controller.service.type=LoadBalancer \
    --wait

echo ""
echo "========================================="
echo "Ingress Controller Installed Successfully"
echo "========================================="

kubectl get pods -n ingress-nginx

echo ""

kubectl get svc -n ingress-nginx
