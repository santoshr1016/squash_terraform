### Create K8S cluster using terraform
**It uses the AWS EKS modules**
```text
The structure has a vpc-k8s module, Which create the underlying networking infrastructure for the k8s cluster
```

### To Access the AWS resources

**Approach 1 Pod Authentication within K8s cluster using Service Account**
```text
Using KIAM or Kube2iam

1. pod is associated with a service account, and a credential (token) for that service account is placed into the 
filesystem each container in that pod, at `/var/run/secrets/kubernetes.io/serviceaccount/token`

2. Pods can authenticate with API server using an auto-mounted token in the default service account and 
secret that only the Kubernetes API server could validate. 

```

**Aproach 2 Pod Authorization to AWS Resources using EKS Node's Instance Profile**
```text
1. Pod runs on EKS worker nodes, which have AWS IAM instance profile attached to them.

2. kubelet agent in worker nodes get temporary IAM credentials from IAM role attached to worker nodes through 
instance metadata at `169.254.169.254/latest/meta-data/iam/security-credentials/IAM_ROLE_NAME`

```

**Aproach 3 The Most secure and Preferred one**
[IRSA](https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/)
```text
1. When you launch a pod with `kubectl apply -f`, the YAML manifest is submitted to the API server 
with the Amazon EKS Pod Identity webhook configured.

2. Because the service account `irsa-service-account` has an eks.amazonaws.com/role-arn annotation,
the webhook __injects the necessary environment variables (AWS_ROLE_ARN and AWS_WEB_IDENTITY_TOKEN_FILE)__ and 
sets up the __aws-iam-token projected volume__ (this is not IAM credentials, just JWT token) in the pod that 
the job supervises.

3. Service accoount associated with the pod authenticate to OIDC (which in turns authenticate to AWS IAM service 
on behalf of service account) and get JWT token back from OIDC and saves it in `AWS_WEB_IDENTITY_TOKEN_FILE`

4. When container executes `aws s3 ls`, the pod performs an `sts:assume-role-with-web-identity` with the 
token stored in `AWS_WEB_IDENTITY_TOKEN_FILE` path to __assume the IAM role__ (behind the scene,). 
It receives temporary credentials that it uses to complete the S3 write operation.

```

Shell into a container to verify this pod has proper S3 read permissions by assuming the IAM role
```bash
kubectl exec -it test-pod  sh

# show env
sh-4.2# env

AWS_ROLE_ARN=arn:aws:iam::xxxxxx:role/eksctl-eks-from-eksctl-addon-iamserviceaccou-Role1-1S8X0CMRPPPLY  # <--- the created IAM role ARN is injected
GUESTBOOK_PORT_3000_TCP_ADDR=10.100.53.19
HOSTNAME=irsa-iam-test-cf8d66797-kx2s2
AWS_WEB_IDENTITY_TOKEN_FILE=/var/run/secrets/eks.amazonaws.com/serviceaccount/token # <---- this is the JWT token to authenticate to OIDC, and then OIDC will assume IAM role using AWS STS

# get aws version of docker container
sh-4.2# aws --version
aws-cli/2.0.22 Python/3.7.3 Linux/4.14.181-140.257.amzn2.x86_64 botocore/2.0.0dev26

# list S3
sh-4.2# aws s3 ls
2020-06-13 16:27:43 eks-from-eksctl-elb-access-log
```

Check IAM identity of the IAM role assumed by pod
```
sh-4.2# aws sts get-caller-identity
{
    "UserId": "AROAS6KA4SFRWOLUNLZAK:botocore-session-1592141699",
    "Account": "xxxxxx",
    "Arn": "arn:aws:sts::xxxxxx:assumed-role/eksctl-eks-from-eksctl-addon-iamserviceaccou-Role1-1S8X0CMRPPPLY/botocore-session-1592141699"
}
```
