# 如何采集 Pod 对象
---

## 简介

观测云支持采集当前主机上 Kubelet Pod 指标和对象，并上报到观测云中。在工作空间「基础设施」-「容器」-「Pods」，您可以快速查看和分析 pod 的数据信息。采集 Pod 对象数据可以在 Kubernetes 中通过 DaemonSet 方式安装 DataKit。

## 前置条件

您需要先创建一个[观测云账号](https://www.guance.com/)。

## 方法/步骤

在 Kubernetes 中通过 DaemonSet 方式安装 DataKit 有两种方法：

- Helm 安装
- Yaml 安装

### Helm 安装

#### 前提条件

- Kubernetes >= 1.14
- Helm >= 3.0+

#### Step1：添加 DataKit Helm 仓库

使用 Helm 安装 DataKit 采集 Kubernetes 资源，需要先在服务器上 [安装 Helm](https://helm.sh/zh/docs/intro/install/) 。Helm 安装完成后，即可添加 DataKit Helm 仓库。

注意：添加完 DataKit Helm 仓库后，必须执行升级操作 `helm repo update` 。

```
$ helm repo add datakit  https://pubrepo.guance.com/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step2：Helm 安装 DataKit

修改 Helm 安装 DataKit 执行代码中 `datakit.dataway_url` 的 token 数据。

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" --create-namespace 
```

token 可以在观测云工作空间的「管理」-「基本设置」获取。

![](img/1.contrainer_2.png)

token 替换后，执行 Helm 安装 DataKit 代码。

![](img/2.helm_2.png)



#### Step3：查看部署状态

DataKit 安装完成后，即可通过 `$ helm -n datakit list` 查看部署状态。

![](img/2.helm_3.png)



#### Step4：在观测云工作空间查看和分析采集的 Pod 数据

DataKit 部署状态正常，即可在观测云工作空间「基础设施」-「容器」查看和分析采集的 K8S 数据。

![](img/3.yaml_7.png)

### Yaml 安装

#### Step1：下载 yaml 文件

开启 Kubernetes 资源采集前，需要使用终端工具登录到服务器执行下面的脚本命令来下载 yaml 文件。

```
wget https://static.guance.com/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step2：修改 datakit.yaml 文件

编辑 datakit.yaml 文件中数据网关 dataway 的配置，把 token 替换成工作空间的 token。

```
	- name: ENV_DATAWAY
		value: https://openway.guance.com?token=<your-token> # 此处填上你工作空间的 token
```

token 可以在观测云工作空间的「管理」-「基本设置」获取。

![](img/1.contrainer_2.png)

token 替换后，保存 datakit.yaml 文件。

![](img/3.yaml_2.png)

#### Step3：安装 yaml 文件

datakit.yaml 文件的数据网关修改完成后，使用命令`kubectl apply -f datakit.yaml`安装 yaml 文件，其中`datakit.yaml`为文件名，以您保存的文件名为准。

![](img/3.yaml_4.png)

#### Step4：查看 datakit 运行状态

yaml 文件安装完后，会创建一个 datakit 的 DaemonSet 部署，可通过命令`kubectl get pod -n datakit`查看 datakit 的运行状态。

![](img/3.yaml_5.png)

#### Step5：在观测云工作空间查看和分析采集的K8S数据

datakit 运行状态正常，即可在观测云工作空间「基础设施」-「容器」查看和分析采集的 K8S 数据。

![](img/3.yaml_7.png)



## 其他

Pod 对象数据采集上来以后，指标数据采集默认关闭，采集 Pod 指标数据，可查看 [容器](../datakit/container.md) 。
