
## 1 GuanceDB storage组件扩容
问题描述：因为指标数据接入增加，需要扩容GuanceDB storage组件。

问题解决： 

扩容storage组件
```shell
# 根据实际情况更改副本数
kubectl -n middleware scale sts guancedb-cluster-guance-storage --replicas=2
```

修改inert和select容器配置
```shell
# 修改insert 和 select 配置
kubectl -n middleware edit deploy guancedb-cluster-guance-select
kubectl -n middleware edit deploy guancedb-cluster-guance-insert
# 将增加的pod添加到启动参数中
- --storageNode=guancedb-cluster-guance-storage-1.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
- --storageNode=guancedb-cluster-guance-storage-2.guancedb-cluster-guance-storage.middleware.svc.cluster.local:8401
```

## 2 容器里部署GuanceDB报错
问题描述： 在容器里部署GuanceDB的时候，服务启动报错，报错信息：报错信息：This program can only be run on AMD64 processors with v3 microarchitecture support.

问题解决：提供的服务器CPU架构不支持，提供支持V3架构的服务器。

