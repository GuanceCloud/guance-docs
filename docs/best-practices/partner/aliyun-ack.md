# 阿里云 ACK 接入观测云

---

## 简介

容器服务 Kubernetes 版（简称 ACK）提供高性能可伸缩的容器应用管理能力，支持企业级容器化应用的全生命周期管理。2021 年成为国内唯一连续三年入选 Gartner 公共云容器报告的产品，2022 年国内唯一进入 Forrester 领导者象限。其整合了阿里云虚拟化、存储、网络和安全能力，助力企业高效运行云端 Kubernetes 容器化应用。

观测云支持 ACK 集群的接入，下面是入门接入的具体步骤，如果需要接入指标、链路、日志等更多内容，请参考其它文档。

## 前置条件

- 安装 ACK，本次使用版本 1.24.6-aliyun.1 。如果没有创建，请参考[创建 Kubernetes 专有版集群](https://help.aliyun.com/document_detail/86488.htm#task-skz-qwk-qfb)和[创建 Kubernetes 托管版集群](https://help.aliyun.com/document_detail/95108.htm#task-skz-qwk-qfb)。
- 注册 [观测云账号](https://www.guance.com/)

## 操作步骤

### 1 配置 yaml 文件

#### 1.1 下载 datakit.yaml

登录「[观测云](https://console.guance.com/)」，点击「集成」模块，再点击左上角「DataKit」，选择「Kubernetes」，下载 `datakit.yaml`。本次部署的是 datakit 1.4.19 。

#### 1.2 替换 Token

登录「[观测云](https://console.guance.com/)」，进入「管理」模块，在「基本设置」里面复制 token，替换 `datakit.yaml` 文件中的 `ENV_DATAWAY` 环境变量的 value 值中的 <your-token>。

#### 1.3 增加全局 Tag

针对一个工作空间接入多个 Kubernetes 集群指标，观测云提供了使用全局 Tag 的方式来进行区分。<br />
当集群中只有一个采集对象，比如采集 **kubernetes API Server** 指标，集群中 DataKit 的数量会大于一个。为了避免指标采集重复，DataKit 开启了选举功能，这个时候区分集群的方式是增加 `ENV_GLOBAL_ELECTION_TAGS`；而针对非选举类的指标采集，比如为 Pod 增加 annotations 的方式进行指标采集，观测云提供了在 `ENV_GLOBAL_HOST_TAGS` 环境变量中增加全局 Tag 的方式。（**注意：**旧版本这个环境变量名称是 ENV_GLOBAL_TAGS。）

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=aliyun-ack
```

根据上面的说明，下面修改 yaml 文件。 <br />
在 `datakit.yaml` 文件中的 `ENV_GLOBAL_TAGS` 环境变量值最后增加 `cluster_name_k8s=aliyun-ack`； <br />
再增加环境变量 `ENV_GLOBAL_ELECTION_TAGS`，这样测试环境的集群就是 aliyun-ack； <br />
增加环境变量 `ENV_NAMESPACE` 值是 aliyun-ack。

```yaml
- name: ENV_NAMESPACE
  value: aliyun-ack
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=aliyun-ack
```

![image.png](../images/aliyun-ack-1.png)

### 2 部署 DataKit

修改完成 yaml 文件后，下面开始部署 DataKit。 

（1）登录阿里云[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)。 <br/>
（2）在控制台左侧导航栏中，单击「集群」。 <br/>
（3）在「集群列表」页面中，单击目标集群名称或者目标集群右侧「操作」列下的「详情」。 <br/>

![image.png](../images/aliyun-ack-2.png)

（4）在集群管理页左侧导航栏单击「工作负载」 - 「自定义资源」，然后在右侧页面单击「使用 YAML 创建」。

- 选择相应的命名空间。选择**所有名称空间**。
- 在示例模板中，选择**自定义**。把 yaml 的内容贴入模板中， 点击「创建」。

![image.png](../images/aliyun-ack-3.png)

在守护进程集下面可以查看到 DataKit 运行情况。

![image.png](../images/aliyun-ack-4.png)

### 3 卸载 DataKit

DataKit 部署默认使用了 datakit 命名空间，卸载只需要删除守护进程集中的 datakit、datakit 命名空间下的资源及名为 datakit 的 ClusterRoleBinding。卸载的方式比较多，这里提供一种通过阿里云容器服务管理控制台卸载的方式。

#### 3.1 删除 DaemonSet

在阿里云的容器管理控制台进入「工作负载」 - 「守护进程集」，找到 datakit，点击右边的「删除」。

![image.png](../images/aliyun-ack-5.png)

#### 3.2 删除命名空间

进入「节点管理」- 「命名空间与配额」，找到 datakit，点击右边的「删除」。

![image.png](../images/aliyun-ack-6.png)


#### 3.3 删除 Cluster Role

进入 「安全管理」 - 「角色」，在 Cluster Role 下面找到 datakit，点击右边的「删除」。

![image.png](../images/aliyun-ack-7.png)

#### 3.4 异常处理

如果在下次部署的时候提示如下错误，是因为阿里云控制台显示删除了，实际资源还存在的情况。

![image.png](../images/aliyun-ack-8.png)

这时只需要把 `datakit.yaml` 文件中的如下部分删除即可重新部署。

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datakit
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datakit
subjects:
  - kind: ServiceAccount
    name: datakit
    namespace: datakit
```

或者使用命令把 `ClusterRoleBinding` 删除，再部署 DataKit。

```yaml
kubectl delete clusterrolebindings datakit
```