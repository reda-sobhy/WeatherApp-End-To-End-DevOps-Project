#!/bin/bash
set -e

CLUSTER_NAME="my-eks"
REGION="us-east-1"

NAMESPACE="backend"
SERVICE_ACCOUNT="weather-app-sa"

ROLE_NAME="weather-db-v4-role"


echo "Getting AWS Account ID..."

ACCOUNT_ID=$(aws sts get-caller-identity \
--query Account \
--output text)


ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}"


echo "Role ARN:"
echo $ROLE_ARN


echo "Getting EKS OIDC..."

OIDC_URL=$(aws eks describe-cluster \
--name $CLUSTER_NAME \
--region $REGION \
--query "cluster.identity.oidc.issuer" \
--output text)


OIDC_ID=$(echo $OIDC_URL | sed 's|https://||')


echo "OIDC:"
echo $OIDC_ID


echo "Creating trust policy..."


cat > trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/${OIDC_ID}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${OIDC_ID}:sub": "system:serviceaccount:${NAMESPACE}:${SERVICE_ACCOUNT}",
          "${OIDC_ID}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF


echo "Updating IAM Role Trust Policy..."

aws iam update-assume-role-policy \
--role-name $ROLE_NAME \
--policy-document file://trust-policy.json


echo "Creating namespace..."

kubectl create namespace $NAMESPACE \
--dry-run=client -o yaml | kubectl apply -f -


echo "Creating service account..."

kubectl create serviceaccount $SERVICE_ACCOUNT \
-n $NAMESPACE \
--dry-run=client -o yaml | kubectl apply -f -


echo "Annotating service account..."

kubectl annotate serviceaccount \
$SERVICE_ACCOUNT \
-n $NAMESPACE \
eks.amazonaws.com/role-arn=$ROLE_ARN \
--overwrite


echo "Checking Service Account..."

kubectl describe serviceaccount \
$SERVICE_ACCOUNT \
-n $NAMESPACE


echo "Checking IAM Trust Policy..."

aws iam get-role \
--role-name $ROLE_NAME \
--query Role.AssumeRolePolicyDocument \
--output json
