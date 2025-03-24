# EKS Deployment of DataKit

---

## Introduction

Amazon Elastic Kubernetes Service (Amazon EKS) is an Amazon-provided Kubernetes managed service. Users can deploy containerized applications without needing to install, operate, or maintain the Kubernetes control panel or nodes.

There are two ways to deploy DataKit on EKS:

- First method: Use kubectl to execute datakit.yaml
- Second method: Install Helm and use Helm to deploy DataKit

This article describes deploying kubectl and eksctl on a single EC2 instance to connect to the EKS cluster, then deploying Helm on EC2 and using Helm to deploy DataKit.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).
- You need to first create an [AWS account](https://www.amazonaws.cn/).
- [Install EKS](https://docs.amazonaws.cn/eks/latest/userguide/create-cluster.html) cluster
- One EC2 instance (Amazon Linux 2 AMI image)

## Procedures

???+ warning

    The version information used in this example is: DataKit `1.5.2`, Kubernetes `1.24`, kubectl `v1.23.6`, Helm `v3.8.2`

### 1 Install kubectl

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

### 2 Connect to EKS

#### 2.1 Configure Amazon CLI

This example uses an AMI image with Amazon CLI pre-installed.<br/>
If you're not using an Amazon CLI image, you need to install it; please refer to [Amazon CLI Installation](https://docs.amazonaws.cn/cli/latest/userguide/getting-started-install.html).

![image.png](../images/eks-2.png)

Log into EC2 and enter `aws configure`. Follow the prompts to input the `Access Key ID`, `Access Key`, and `region` from the AWS account used to create EKS. Input **json** for Default output format.

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

Go to AWS's EKS console and check the cluster name.

![image.png](../images/eks-5.png)

Use the following command to configure the cluster, where region is cn-northwest-1 and name is the EKS cluster name.

```
aws eks --region cn-northwest-1 update-kubeconfig --name eks_liuyujie
```

![image.png](../images/eks-6.png)

Use the kubectl command to view the cluster Pods. If there are results, it means the connection to EKS has been successful.

![image.png](../images/eks-7.png)

### 3 Install Helm

Log into EC2 and use the following command to install Helm.

```
wget wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz
tar -zxvf helm-v3.8.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/helm
```

Check the Helm version.

```
helm version
```

![image.png](../images/eks-8.png)

### 4 Deploy DataKit

#### 4.1 Obtain Token

Log into 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」 - 「Manage」 - 「Settings」, find the Token, click on the copy icon on the right, which will be used in the next step.

![image.png](../images/eks-9.png)

#### 4.2 Add Helm Repository

To deploy DataKit using Helm, first add the DataKit Helm repository.

```
helm repo add datakit https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit
helm repo update
```

Check if the repository was added successfully.

```
helm repo list
```

![image.png](../images/eks-10.png)

#### 4.3 Configure DataKit

Download and extract the DataKit package from the repository to make it easier to add configurations.

```
helm pull datakit/datakit --untar
cd datakit
```

Edit the `values.yaml` file and paste the obtained token into the red box position in the dataway_url below.<br/>
Add `cluster_name_k8s=k8s-aws` to global_tags, which adds the global Tag **cluster_name_k8s** for non-election metric collection.

```
vim values.yaml
```

![image.png](../images/eks-11.png)

Set the environment variable ENV_NAMESPACE value to k8s-aws, by default enabling DataKit election, ensuring only one DataKit collects election-based metrics within the workspace + this namespace, avoiding duplicate collection.<br/>
Also add the environment variable ENV_GLOBAL_ELECTION_TAGS, which adds the global Tag **cluster_name_k8s** for election-based metrics.

![image.png](../images/eks-12.png)

> **Note:** All three instances of k8s-aws mentioned above can be changed to other strings, but they must differ across different clusters.

If you want to enable collectors, you can add configurations under dfconfig; the commented-out part is an example for enabling the mysql collector.

![image.png](../images/eks-13.png)

#### 4.4 Install DataKit

Run the following command to deploy DataKit. If the datakit namespace already exists, you can remove the **--create-namespace** option.

```
helm install datakit . -n datakit  -f values.yaml --create-namespace
```

![image.png](../images/eks-14.png)

After deployment, log into <<< custom_key.brand_name >>> 「Workspace」 and check kube-prefixed metrics in 「Metrics」 - 「Metric Management」. There should be a global tag `cluster_name_k8s`.

![image.png](../images/eks-15.png)

#### 4.5 Update DataKit

```
helm upgrade datakit . -n datakit -f values.yaml
```

#### 4.6 Uninstall DataKit

```
helm uninstall datakit -n datakit
```