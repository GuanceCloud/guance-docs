# 线下环境部署手册
---

## 1 前言
### 1.1 本文档说明
本文档主要以在线下部署（包括但不限于物理服务器、IDC机房），介绍从资源规划、配置开始，到部署<<< custom_key.brand_name >>>、运行的完整步骤。

**说明：**

- 本文档以 **dataflux.cn** 为主域名示例，实际部署替换为相应的域名。

### 1.2 关键词
| **词条** | **说明** |
| --- | --- |
| Launcher | 用于部署安装 <<< custom_key.brand_name >>> 的 WEB 应用，根据 Launcher 服务的引导步骤来完成 <<< custom_key.brand_name >>> 的安装与升级 |
| 运维操作机 | 安装了 kubectl，与目标 Kubernetes 集群在同一网络的运维机器 |
| 部署操作机 | 在浏览器访问 launcher 服务来完成 <<< custom_key.brand_name >>> 引导、安装、调试的机器 |
| kubectl | Kubernetes 的命令行客户端工具，安装在运维操作机上 |

### 1.3 部署步骤架构
![](img/23.install-step.png)

## 2 资源准备
[线下环境资源清单](offline-required.md#list)



## 3 基础设施部署

### 3.1 步骤一 创建 Kubernetes 集群
[Kubernetes 集群部署](infra-kubernetes.md)

### 3.2 步骤二 Kubernetes Ingress  组件

[Kubernetes Ingress 组件部署](ingress-nginx-install.md)

### 3.3 步骤三 代理部署

[访问代理](proxy-install.md)

### 3.4 步骤四 NFS 部署

[NFS部署](nfs-install.md)

### 3.5 步骤五 Kubernetes Storage 组件

[Kubernetes Storage 组件部署](nfs-provisioner.md)

### 3.6 步骤六 Redis 部署

[Redis 部署](infra-redis.md)

### 3.7 步骤七 时序引擎部署

[时序引擎部署](infra-metric.md)

### 3.8 步骤八 日志引擎部署

[日志引擎部署](infra-logengine.md)

### 3.9 步骤九 MySQL部署

[MySQL 部署](infra-mysql.md)



## 4 kubectl 安装及配置
### 4.1 安装 kubectl
kubectl 是一个 kubernetes 的一个命令行客户端工具，可以通过此命令行工具去部署应用、检查和管理集群资源等。
我们的 Launcher 就是基于此命令行工具，去部署应用的，具体安装方式可以看官方文档：

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 4.2 配置 kube config
kubectl 要获得管理集群的能力，需要将集群的 kubeconfig 利用kubeadm部署的集群完成后  kubeconfig 文件魔默认文件为 /etc/kubernetes/admin.conf   需将文件内容写入到客户端用户路劲  **$HOME/.kube/config** 文件内。

## 5 开始安装 <<< custom_key.brand_name >>>

操作完成后，可以参考手册 [开始安装](launcher-install.md)
