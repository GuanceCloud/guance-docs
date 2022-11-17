# ACK 集群

---

## 简介

容器服务 Kubernetes 版（简称 ACK）提供高性能可伸缩的容器应用管理能力，支持企业级容器化应用的全生命周期管理，其整合了阿里云虚拟化、存储、网络和安全能力，助力企业高效运行云端 Kubernetes 容器化应用。

## 视图预览

![image.png](../../imgs/aliyun-ack-10.png)

## 前置条件

- 注册 [观测云账号](https://www.guance.com/)
- 安装 ACK 
> 若没有创建，请参考[创建 Kubernetes 专有版集群](https://help.aliyun.com/document_detail/86488.htm#task-skz-qwk-qfb)和[创建 Kubernetes 托管版集群](https://help.aliyun.com/document_detail/95108.htm#task-skz-qwk-qfb)。

## 安装配置

???+ attention

    示例 ACK 版本为：1.24.6-aliyun.1
    
    示例 DataKit版本为：1.4.19

### 1 配置 yaml 文件

#### 1.1 下载 datakit.yaml

登录「[观测云](https://console.guance.com/)」控制台，点击「集成」 - 「DataKit」 - 「Kubernetes」，下载 `datakit.yaml`。

#### 1.2 替换 Token

进入「管理」模块，在「基本设置」里面复制 `token`，替换 `datakit.yaml` 文件中的 `ENV_DATAWAY` 环境变量的 value 值中的 <your-token>。

#### 1.3 增加全局 Tag

针对一个工作空间接入多个 Kubernetes 集群指标，观测云提供了使用全局 Tag 的方式来进行区分。<br />
当集群中只有一个采集对象，比如采集 **kubernetes API Server** 指标，集群中 DataKit 的数量会大于一个。

- 为了避免指标采集重复，DataKit 开启了**选举**功能，这个时候区分集群的方式是增加 `ENV_GLOBAL_ELECTION_TAGS`；
- 而针对非选举类的指标采集，比如为 Pod 增加 Annotations 的方式进行指标采集，观测云提供了在 `ENV_GLOBAL_HOST_TAGS` 环境变量中增加全局 Tag 的方式。
> **注意：**旧版本这个环境变量名称是 `ENV_GLOBAL_TAGS`

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=aliyun-ack
```

根据上面的说明，下面修改 yaml 文件。

- 在 `datakit.yaml` 文件中的 `ENV_GLOBAL_TAGS` 环境变量值最后增加 `cluster_name_k8s=aliyun-ack`；
- 再增加环境变量 `ENV_GLOBAL_ELECTION_TAGS`，这样测试环境的集群就是 aliyun-ack；
- 增加环境变量 `ENV_NAMESPACE` 值是 aliyun-ack。

```yaml
- name: ENV_NAMESPACE
  value: aliyun-ack
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=aliyun-ack
```

![image.png](../../imgs/aliyun-ack-1.png)

### 2 部署 DataKit

修改完成 yaml 文件后，下面开始部署 DataKit。 

（1） 登录阿里云[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)。 <br/>
（2） 在控制台左侧导航栏中，点击「集群」。 <br/>
（3） 在「集群列表」页面中，点击目标集群名称或者目标集群右侧「操作」列下的「详情」。 <br/>

![image.png](../../imgs/aliyun-ack-2.png)

（4） 在集群管理页左侧导航栏单击「工作负载」 - 「自定义资源」，然后在右侧页面单击「使用 YAML 创建」。

- 选择相应的命名空间。选择「所有命名空间」，如果已创建 datakit 命名空间可选择 datakit。
- 在示例模板中，选择「自定义」，把 yaml 的内容贴入模板中， 点击「创建」。

![image.png](../../imgs/aliyun-ack-3.png)

### 3 效果展示

- 在守护进程集下面可以查看到 DataKit 运行情况。

![image.png](../../imgs/aliyun-ack-4.png)

- 登录「[观测云](https://console.guance.com/)」- 「基础设施」，查看主机、容器等信息。

![image.png](../../imgs/aliyun-ack-9.png)

![image.png](../../imgs/aliyun-ack-10.png)

### 4 卸载 DataKit

DataKit 部署默认使用了 datakit 命名空间，卸载只需要删除守护进程集中的 datakit、datakit 命名空间下的资源及名为 datakit 的 ClusterRoleBinding。

卸载的方式比较多，这里提供一种通过**阿里云容器服务管理控制台卸载**的方式。

#### 4.1 删除 DaemonSet

在阿里云的容器管理控制台进入「工作负载」 - 「守护进程集」，找到 datakit，点击右边的「删除」。

![image.png](../../imgs/aliyun-ack-5.png)

#### 4.2 删除命名空间

进入「节点管理」- 「命名空间与配额」，找到 datakit，点击右边的「删除」。

![image.png](../../imgs/aliyun-ack-6.png)


#### 4.3 删除 Cluster Role

进入 「安全管理」 - 「角色」，在 Cluster Role 下面找到 datakit，点击右边的「删除」。

![image.png](../../imgs/aliyun-ack-7.png)


## 常见问题排查

### 权限问题

Q：如果部署的过程中出现如下提示，是无权限操作 RBAC 的问题。

![image.png](../../imgs/aliyun-ack-11.png)

A：增加权限

- 登录阿里云[容器服务管理控制台](https://cs.console.aliyun.com/?spm=a2c4g.11186623.0.0.1b483e068AVz8k)，进入「授权管理」。

![image.png](../../imgs/aliyun-ack-12.png)

- 选择对应用户，点击右侧的「管理权限」。

![image.png](../../imgs/aliyun-ack-13.png)

- 增加集群所有命名空间的操作权限，点击「下一步」保存。

![image.png](../../imgs/aliyun-ack-14.png)


### 部署错误

Q：如果在下次部署的时候提示如下错误，是因为阿里云控制台显示删除了，实际资源还存在的情况。

![image.png](../../imgs/aliyun-ack-8.png)

A：重新部署 DataKit

- 这时只需要把 `datakit.yaml` 文件中的如下部分删除即可重新部署。

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

- 或者使用命令把 `ClusterRoleBinding` 删除，再部署 DataKit。

```yaml
kubectl delete clusterrolebindings datakit
```
