#!/bin/bash

set -e

echo "======================================"
echo "Terraform Initialization"
echo "======================================"

terraform init

echo "======================================"
echo "Terraform Apply"
echo "======================================"

terraform apply --auto-approve

echo "======================================"
echo "Installing NGINX Ingress Controller"
echo "======================================"

chmod +x install-nginx-ingress.sh
./install-nginx-ingress.sh

echo "======================================"
echo "Installing External Secrets Operator"
echo "======================================"

chmod +x install-external-secret-operator.sh
./install-external-secret-operator.sh

echo "======================================"
echo "Creating External Secrets Service Account"
echo "======================================"

chmod +x serviceaccount_external_secret.sh
./serviceaccount_external_secret.sh

echo "======================================"
echo "Installing CloudWatch Addons"
echo "======================================"

chmod +x addons-cloudwathch.sh
./addons-cloudwathch.sh

echo "======================================"
echo "Creating RDS CloudWatch Alarms"
echo "======================================"

chmod +x rds_alarm.sh
./rds_alarm.sh

echo "======================================"
echo "Deployment Completed Successfully!"
echo "======================================"
