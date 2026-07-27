#!/bin/bash

set -e

REGION="us-east-1"
DB_INSTANCE="weather-db"
ALARM_NAME="weather-rds-high-cpu"
EMAIL="redabokka@gmail.com"

echo "Creating SNS Topic..."

TOPIC_ARN=$(aws sns create-topic \
  --name rds-alerts \
  --region "$REGION" \
  --query TopicArn \
  --output text)

echo "SNS Topic created:"
echo "$TOPIC_ARN"


echo "Creating email subscription..."

aws sns subscribe \
  --topic-arn "$TOPIC_ARN" \
  --protocol email \
  --notification-endpoint "$EMAIL" \
  --region "$REGION"


echo "Email subscription created."
echo "Check your email and confirm the subscription."


echo "Creating CloudWatch Alarm..."

aws cloudwatch put-metric-alarm \
  --alarm-name "$ALARM_NAME" \
  --alarm-description "RDS CPU utilization above 80%" \
  --namespace AWS/RDS \
  --metric-name CPUUtilization \
  --dimensions Name=DBInstanceIdentifier,Value="$DB_INSTANCE" \
  --statistic Average \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --treat-missing-data notBreaching \
  --alarm-actions "$TOPIC_ARN" \
  --region "$REGION"


echo "CloudWatch Alarm created successfully."


echo "Current alarm status:"

aws cloudwatch describe-alarms \
  --alarm-names "$ALARM_NAME" \
  --region "$REGION" \
  --query "MetricAlarms[0].StateValue"
