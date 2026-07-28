set -e

NAMESPACE="backend"
SERVICE_ACCOUNT="weather-app-sa"
ROLE_NAME="weather-db-v4-role"


echo "Getting AWS Account ID..."

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)


ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${ROLE_NAME}"


echo "Using Role ARN:"
echo $ROLE_ARN


echo "Creating namespace..."

kubectl create namespace $NAMESPACE \
--dry-run=client -o yaml | kubectl apply -f -


echo "Creating service account..."

kubectl create serviceaccount $SERVICE_ACCOUNT \
-n $NAMESPACE \
--dry-run=client -o yaml | kubectl apply -f -


echo "Annotating service account with IAM Role..."

kubectl annotate serviceaccount \
$SERVICE_ACCOUNT \
-n $NAMESPACE \
eks.amazonaws.com/role-arn=$ROLE_ARN \
--overwrite


echo "Checking result..."

kubectl describe serviceaccount \
$SERVICE_ACCOUNT \
-n $NAMESPACE  


aws iam update-assume-role-policy \
--role-name weather-db-v2-role \
--policy-document file://trust-policy.json
