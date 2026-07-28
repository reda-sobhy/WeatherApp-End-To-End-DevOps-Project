#!/bin/bash

set -e

echo "======================================"
echo "Terraform Initialization"
echo "======================================"

#terraform init

echo "======================================"
echo "Terraform Apply"
echo "======================================"

#terraform apply --auto-approve

echo "======================================"
echo "Installing NGINX Ingress Controller"
echo "======================================"

#aws eks update-kubeconfig --name my-eks
#kubectl create ns frontend
#kubectl create ns backend

#./aws_infra/ingress-controller/install-nginx-ingress.sh

echo "======================================"
echo "Installing External Secrets Operator"
echo "======================================"

./aws_infra/secret_manager/install_external_secret_operator.sh
./aws_infra/secret_manager/serviceaccount_external_secret.sh
kubectl apply -f  ./aws_infra/secret_manager/secret_manager_files/
kubectl apply -f  ./kubernetes/init-job.yaml
echo "======================================"
echo "Installing CloudWatch Addons"
echo "======================================"

chmod +x addons-cloudwathch.sh
../cloudwatch/addons-cloudwathch.sh

echo "======================================"
echo "Creating RDS CloudWatch Alarms"
echo "======================================"

chmod +x rds_alarm.sh
../cloudwatch/rds_alarm.sh

