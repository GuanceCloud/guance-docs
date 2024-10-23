# Kodo-X 拆分

???+ warning "注意"

    请仔细阅读本文章，做好备份措施和回滚方案。

## 简介 {#info}

在处理大量写入请求时，kodo-x 的资源消耗可能集中在特定类型的处理任务上，尤其是 metric 数据处理，导致其他数据无法及时消费，从而引发数据堆积问题。

解决思路：

1. 创建一个独立的 kodo-x 实例，专门用于处理 metric 数据，以减少对现有实例的资源占用。
2. 修改现有的 kodo-x 实例，不再处理 metric 数据，专注于其他任务。


## 方案架构图

拆分前：

![](img/kodo-x-split-01.png)


拆分后：

![](img/kodo-x-split-02.png)


## 前提条件

- 拥有观测云集群操作权限
- 提前规划 kodo-x 和 拆分的 kodo-x-metric 调度资源


## 实施方案

### 1、服务备份

```shell
kubectl get deploy -n forethought-kodo  kodo-x -o yaml > kodo-x-deploy.yaml
```

### 2、创建 kodo-x-metric 服务

#### 2.1 创建 kodo-x-metric configmap

```shell
kubectl get cm -n forethought-kodo kodo-x -o yaml > kodo-x-metric-cm.yaml
```


修改以下信息：
- 修改 `name` 为 kodo-x-metric
- 删除 `resourceVersion` 和 `uid` 字段

```shell
kubectl apply -f kodo-x-metric-cm.yaml
```

#### 2.2 创建 kodo-x-metric deploy

```shell
kubectl get deploy -n forethought-kodo  kodo-x -o yaml  > kodo-x-deploy.yaml
```

修改以下信息：
- 修改 「metadata」-「name」 为 kodo-x-metric
- 删除 「metadata」 下的`resourceVersion` 和 `uid` 字段
- 修改 「volumeMounts」 和 「volumes」下的 `name` 改为  kodo-x-metric

```shell
...
metadata:
  name: kodo-x-metric    ##### 改为 kodo-x-metric
  namespace: forethought-kodo 
  resourceVersion: "129925433"   ##### 删除
  uid: e4f0c541-4d91-47d4-82c8-91eec2757cb2   ##### 删除
...
        volumeMounts:
        - mountPath: /kodo/config/config.yaml
          name: kodo-x-metric  ##### 改为 kodo-x-metric
          subPath: config.yaml

      volumes:
      - configMap:
          defaultMode: 420
          name: kodo-x-metric ##### 改为 kodo-x-metric
          optional: false
        name: kodo-x-metric ##### 改为 kodo-x-metric

```

```shell
kubectl apply -f kodo-x-deploy.yaml
```

### 3、创建 kodo-x-metric 服务

#### 3.1 修改 kodo-x-metric 参数

配置文件：kodo-x-metric.yaml（其他配置与现有 kodo-x.yaml 相同）

```shell
global:
    metric_workers: 32  # 增加 metric 数据的处理能力
    object_workers: 8
    keyevent_workers: 8
    workers: 0  # 关闭默认 worker
    log_workers: 0  # 关闭日志处理
    backup_log_workers: 0  # 关闭备份日志处理
```

可以参考[应用服务配置项手册](application-configuration-guide.md)了解相关信息。

重启服务：

```shell
kubectl rollout restart -n forethought-kodo deploy kodo-x-metric
```

#### 3.2 修改 kodo-x 参数

现有的 kodo-x 实例将只处理其他非 metric 类型的任务，进一步优化资源分配。

配置文件：kodo-x.yaml

```shell
global:
    metric_workers: -1  # 禁用 metric 数据处理
    object_workers: -1  # 禁用对象处理
    keyevent_workers: -1  # 禁用关键事件处理
```

重启服务：

```shell
kubectl rollout restart -n forethought-kodo deploy kodo-x
```

### 4、验证

执行以下命令查看配置是否生效：

```
kubectl exec -ti -n forethought-kodo  deploy/kodo-x -- cat config/config.yaml | grep -15 global
kubectl exec -ti -n forethought-kodo  deploy/kodo-x-metric -- cat config/config.yaml | grep -15 global
```

