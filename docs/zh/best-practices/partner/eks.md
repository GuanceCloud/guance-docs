# EKS 部署 DataKit

---

## 简介

Amazon Elastic Kubernetes Service (Amazon EKS) 是 Amazon 提供的一项 Kubernetes 托管服务，用户不需要安装、操作或维护 Kubernetes 控制面板或节点，即可实现容器化应用程序的部署。

在 EKS 上部署 DataKit 有两种方式：

- 第一种：使用 kubectl 执行 datakit.yaml
- 第二种：安装 Helm，使用 Helm 部署 DataKit

本文介绍的是在一台 EC2 上部署 kubectl 、eksctl 连接 EKS 集群，再在 EC2 上部署 Helm，使用 Helm 部署 DataKit。

## 前置条件

- 您需要先创建一个[观测云账号](https://www.guance.com/)。
- 您需要先创建一个[AWS 账号](https://www.amazonaws.cn/)。
- [安装 EKS ](https://docs.amazonaws.cn/eks/latest/userguide/create-cluster.html)集群
- 一台 EC2(Amazon Linux 2 AMI 镜像)

## 操作步骤

???+ warning

    本文示例所使用版本信息为：DataKit `1.5.2`、Kubernetes `1.24`、kubectl `v1.23.6`、Helm `v3.8.2`

### 1 安装 kubectl

执行如下命令安装 kubectl。

```
wget https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /bin/kubectl
```

查看 kubectl 版本。

```
kubectl version --client
```

![image.png](../images/eks-1.png)

### 2 连接 EKS

#### 2.1 配置 Amazon CLI

本示例使用了 AMI 镜像，默认已安装 Amazon CLI。<br/>
如果使用非 Amazon CLI 镜像，需要进行安装，请参考[ Amazon CLI 安装](https://docs.amazonaws.cn/cli/latest/userguide/getting-started-install.html)。

![image.png](../images/eks-2.png)

登录 EC2，输入 aws configure ，按照提示输入使用 AWS 创建 EKS 的账号中的 `Access Key ID`、`Access Key` 和 `region` 进行配置，Default output format 输入 **json**。

![image.png](../images/eks-3.png)

#### 2.2 安装 eksctl

执行如下命令，安装 eksctl。

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /bin
chmod +x /bin/eksctl
```

查看 eksctl 版本。

```
eksctl version
```

![image.png](../images/eks-4.png)

#### 2.3 配置 EKS 集群

进入 AWS 的 EKS，查看集群名称。

![image.png](../images/eks-5.png)

使用如下命令配置集群，其中 region 是 cn-northwest-1，name 是 EKS 集群名称。

```
aws eks --region cn-northwest-1 update-kubeconfig --name eks_liuyujie
```

![image.png](../images/eks-6.png)

使用 kubectl 命令查看集群 Pod，有结果，证明已经成功连上 EKS。

![image.png](../images/eks-7.png)

### 3 安装 Helm

登录 EC2 ，使用如下命令安装 Helm。

```
wget wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz
tar -zxvf helm-v3.8.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/helm
```

查看 Helm 版本。

```
helm version
```

![image.png](../images/eks-8.png)

### 4 部署 DataKit

#### 4.1 获取 Token

登录「[观测云](https://console.guance.com/)」- 「管理」-「设置」，找到 Token，点击右边的复制图标，Token 在下一步中会使用到。

![image.png](../images/eks-9.png)

#### 4.2 添加 Helm 仓库

使用 Helm 部署 DataKit，需要先添加 DataKit 的 Helm 仓库。

```
helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit
helm repo update
```

查看仓库是否添加成功。

```
helm repo list
```

![image.png](../images/eks-10.png)

#### 4.3 配置 DataKit

把 DataKit 包从仓库下载并解压，方便增加配置。

```
helm pull datakit/datakit --untar
cd datakit
```

编辑 `values.yaml` 文件，把获取的 token 粘贴到下图中 dataway_url 中红框的位置。<br/>
global_tags 值增加 `cluster_name_k8s=k8s-aws` 值，这是为非选举类的指标采集增加全局 Tag **cluster_name_k8s**。

```
vim values.yaml
```

![image.png](../images/eks-11.png)

设置环境变量 ENV_NAMESPACE 值是 k8s-aws，默认开启了 DataKit 选举，工作空间 + 这个命名空间只有一个 DataKit 在采集选举类的指标，避免重复采集。<br/>
再增加环境变量 ENV_GLOBAL_ELECTION_TAGS，这是为选举类指标增加全局 Tag **cluster_name_k8s**。

![image.png](../images/eks-12.png)

> **注意：**上述中的三处 k8s-aws 是可以改成其它字符串，不同集群不能相同。

如果需要开通采集器，可以在 dfconfig 下面添加配置，注释掉的是开通 mysql 采集器的示例。

![image.png](../images/eks-13.png)

#### 4.4 安装 DataKit

执行如下命令，部署 DataKit，如果 datakit 命名空间已存在，后面的 **--create-namespace** 可以去掉。

```
helm install datakit . -n datakit  -f values.yaml --create-namespace
```

![image.png](../images/eks-14.png)

部署成功后，可登录观测云「工作空间」，在「指标」 - 「指标管理」中查看 kube 开头的指标，其中存在全局标签 `cluster_name_k8s`。

![image.png](../images/eks-15.png)

#### 4.5 更新 DataKit

```
helm upgrade datakit . -n datakit -f values.yaml
```

#### 4.6 卸载 DataKit

```
helm uninstall datakit -n datakit
```
