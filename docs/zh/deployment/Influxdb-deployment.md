# 1. 简介

InfluxDB是一个当下比较流行的时序数据库，InfluxDB使用 Go 语言编写，无需外部依赖，安装配置非常方便，适合构建大型分布式系统的监控系统。

主要特色功能：

1）基于时间序列，支持与时间有关的相关函数（如最大，最小，求和等）

2）可度量性：你可以实时对大量数据进行计算

3）基于事件：它支持任意的事件数据

# 2. 前提条件

- 已部署 Kubernetes 集群
- OpenEBS 存储插件驱动

# 3. 安装准备

由于 influxdb 比较吃资源需要独占集群资源，我们需要提前配置集群调度。



# 4. 集群标签设置

## 4.1 执行命令标记集群

```shell
# 根据集群规划，将需要部署influxdb服务k8s节点打上标签
# xxx 代表实际集群中的节点 多个节点ip中用空格分开 或者在命令行终端使用 tab 键自动补全
kubectl label nodes xxx influxdb=true
```

## 4.2 检测标记

```shell
kubectl get nodes --show-labels  | grep 'influxdb'
```

# 5. 集群污点设置

## 5.1 执行命令设置集群污点

```shell
kubectl taint node  xxxx infrastructure=middleware:NoExecute
```



# 6. 配置 StorageClass 

## 6.1 创建influxdb专用存储类



```yaml
# 将下列yaml内容复制到k8s集群保存为sc-influxdb.yaml 按照实际情况修改后部署
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/influxdb"  # 该路劲可以根据实际情况修改，请确保存储空间足够
  name: openebs-influxdb  # 名字集群内唯一，需要执行安装前同步修改部署文件/etc/kubeasz/guance/infrastructure/yaml/taos.yaml 
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> `/data/influxdb` 目录请确保磁盘容量足够。

## 6.2 配置 influxdb 数据存储空间

```shell
# 进入 /etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml 按需修改
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: influx-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi  # 按照实际需要配置空间大小
  volumeMode: Filesystem
  storageClassName: openebs-hostpath

```



# 7. 安装

```shell
# 默认管理员账号 admin
# 默认登录密码 "B8vBISUItYEH4uhk"
# 若需要自定义密码 请在安装前修改/etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml

# 创建命名空间
kubectl  create  ns middleware
# 部署influxdb 服务
kubectl  apply  -f /etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml  -n middleware
```

# 8. 验证部署

```shell
# 默认管理员账号 admin
# 默认登录密码 "B8vBISUItYEH4uhk"
[root@k8s-node01 ~]# kubectl  get pods -n middleware
NAME                        READY   STATUS    RESTARTS   AGE
influxdb-7ff9db677f-v4877   1/1     Running   0          3m42s

[root@k8s-node01 ~]# kubectl  exec -it -n middleware  influxdb-xxxx influx
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Connected to http://localhost:8086 version 1.7.8
InfluxDB shell version: 1.7.8
> auth
username: admin
password:
> show databases;
name: databases
name
----
_internal
>
```

