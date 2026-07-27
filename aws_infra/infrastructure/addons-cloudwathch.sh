aws iam create-policy \
--policy-name CloudWatchAgentPolicy \
--policy-document file://cloudwatch-policy.json

aws iam attach-role-policy \
--role-name my-eks-node-role \
--policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy



aws eks update-cluster-config \
--name my-eks \
--logging '{"clusterLogging":[{"types":["api","audit","authenticator","controllerManager","scheduler"],"enabled":true}]}'

aws eks create-addon \
--cluster-name my-eks \
--addon-name amazon-cloudwatch-observability


kubectl get pods -n amazon-cloudwatch


aws eks describe-nodegroup \
--cluster-name my-eks \
--nodegroup-name my-eks-nodes \
--query "nodegroup.nodeRole"


