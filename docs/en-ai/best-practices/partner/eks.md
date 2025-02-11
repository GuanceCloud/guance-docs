# EKS Deployment of DataKit

---

## Introduction

Amazon Elastic Kubernetes Service (Amazon EKS) is an Amazon-provided managed Kubernetes service. Users can deploy containerized applications without needing to install, operate, or maintain the Kubernetes control panel or nodes.

There are two ways to deploy DataKit on EKS:

- Method One: Execute `datakit.yaml` using `kubectl`
- Method Two: Install Helm and deploy DataKit using Helm

This article describes deploying `kubectl` and `eksctl` on an EC2 instance to connect to the EKS cluster, followed by deploying Helm on the EC2 instance and using Helm to deploy DataKit.

## Prerequisites

- You need to first create a [Guance account](https://www.guance.com/).
- You need to first create an [AWS account](https://www.amazonaws.cn/).
- [Install EKS](https://docs.amazonaws.cn/eks/latest/userguide/create-cluster.html) cluster
- An EC2 instance (Amazon Linux 2 AMI image)

## Procedures

???+ warning

    The version information used in this example is: DataKit `1.5.2`, Kubernetes `1.24`, kubectl `v1.23.6`, Helm `v3.8.2`

### 1. Install kubectl

Run the following commands to install kubectl.

```
wget https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /bin/kubectl
```

Check the kubectl version.

```
kubectl version --client
```

![image.png](../images/eks-1.png)

### 2. Connect to EKS

#### 2.1 Configure Amazon CLI

This example uses an AMI image that has the Amazon CLI installed by default.<br/>
If you are not using an Amazon CLI image, you will need to install it; please refer to [Amazon CLI Installation](https://docs.amazonaws.cn/cli/latest/userguide/getting-started-install.html).

![image.png](../images/eks-2.png)

Log in to EC2, input `aws configure`, and follow the prompts to enter the `Access Key ID`, `Access Key`, and `region` from the AWS account used to create the EKS cluster. Set Default output format to **json**.

![image.png](../images/eks-3.png)

#### 2.2 Install eksctl

Run the following command to install eksctl.

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /bin
chmod +x /bin/eksctl
```

Check the eksctl version.

```
eksctl version
```

![image.png](../images/eks-4.png)

#### 2.3 Configure EKS Cluster

Navigate to the EKS section in AWS to view the cluster name.

![image.png](../images/eks-5.png)

Use the following command to configure the cluster, where the region is `cn-northwest-1` and the name is the EKS cluster name.

```
aws eks --region cn-northwest-1 update-kubeconfig --name eks_liuyujie
```

![image.png](../images/eks-6.png)

Use the kubectl command to check the cluster Pods. If there are results, it indicates a successful connection to EKS.

![image.png](../images/eks-7.png)

### 3. Install Helm

Log in to EC2 and use the following commands to install Helm.

```
wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz
tar -zxvf helm-v3.8.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/helm
```

Check the Helm version.

```
helm version
```

![image.png](../images/eks-8.png)

### 4. Deploy DataKit

#### 4.1 Obtain Token

Log in to [Guance](https://console.guance.com/) - "Management" - "Settings", find the Token, click the copy icon on the right, and use the Token in the next step.

![image.png](../images/eks-9.png)

#### 4.2 Add Helm Repository

To deploy DataKit using Helm, add the DataKit Helm repository first.

```
helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit
helm repo update
```

Verify if the repository was added successfully.

```
helm repo list
```

![image.png](../images/eks-10.png)

#### 4.3 Configure DataKit

Download and extract the DataKit package from the repository for easier configuration.

```
helm pull datakit/datakit --untar
cd datakit
```

Edit the `values.yaml` file and paste the obtained token into the red box position in the `dataway_url`. Add the value `cluster_name_k8s=k8s-aws` to `global_tags`, which adds the global Tag **cluster_name_k8s** for non-election metrics collection.

```
vim values.yaml
```

![image.png](../images/eks-11.png)

Set the environment variable `ENV_NAMESPACE` to `k8s-aws`. By default, DataKit elections are enabled, ensuring only one DataKit collects election metrics within the workspace + namespace to avoid duplicate collection.<br/>
Add the environment variable `ENV_GLOBAL_ELECTION_TAGS` to include the global Tag **cluster_name_k8s** for election metrics.

![image.png](../images/eks-12.png)

> **Note:** The three instances of `k8s-aws` mentioned above can be changed to other strings, but they must not be the same across different clusters.

If you need to enable collectors, you can add configurations under `dfconfig`. The commented-out part shows an example of enabling the MySQL collector.

![image.png](../images/eks-13.png)

#### 4.4 Install DataKit

Run the following command to deploy DataKit. If the `datakit` namespace already exists, you can omit the `--create-namespace` flag.

```
helm install datakit . -n datakit  -f values.yaml --create-namespace
```

![image.png](../images/eks-14.png)

After a successful deployment, log in to Guance's "Workspace," navigate to "Metrics" - "Metric Management" to view metrics starting with `kube`, which include the global tag `cluster_name_k8s`.

![image.png](../images/eks-15.png)

#### 4.5 Update DataKit

```
helm upgrade datakit . -n datakit -f values.yaml
```

#### 4.6 Uninstall DataKit

```
helm uninstall datakit -n datakit
```