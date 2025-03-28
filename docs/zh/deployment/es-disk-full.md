### 解决方案一：扩容

可以选择水平或者垂直进行扩容。

水平扩容：增加集群的数据节点

垂直扩容：对数据节点的数据盘进行扩容

### 解决方案二：清理数据

1、首先使用 `df -h` 命令来查看对应es的磁盘空间，确定是否打满

2、使用以下命令来查看索引存储

```shell
$ kubectl exec -ti -n middleware <es_pod_name> -- curl -XGET -u <user>:<password> 127.0.0.1:9200/_cat/indices?v

health status index                                                                                 uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000002                                 v8EAVH4FR32gSGIeMGKtSw   1   0          0            0       60.0gb           60.0gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000001                                 blKeVx7mT1edx-EJFf0PBA   1   0          0            0       60.1gb           60.1gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000003                                 XGDzVakRT4yLx3KdgJpl6Q   1   0          0            0       59.9gb           59.9gb
green  open   wksp_4bcd96fc753e4a87a7f035717e3492f4_logging-000004                                 dXaJwIuKQMKj1W-sGQMgYA   1   0          8            0     53.6kb         53.6kb
green  open   .monitoring-es-7-2023.05.31                                                           hWN-pIKWSpyxHGLAuyrR-w   1   0    3342741      1023346      1.3gb          1.3gb
green  open   .monitoring-es-7-2023.05.30                                                           06VnZgosSuCZR4mUXewBxg   1   0    3386407       931888      1.3gb          1.3gb
green  open   wksp_ae656f5d29764fdd904707a2564b7517_keyevent-000002                                 PecXZi1sTGOvFgEhpbXifA   1   0          0            0       208b           208b
green  open   .monitoring-es-7-2023.06.01                                                           obPVFxemQeGVQC2flCtUiA   1   0    3466792       519395      1.4gb          1.4gb
green  open   .monitoring-es-7-2023.06.02                                                           HcxlyaH1R7-R7Wh1jF12bw   1   0     390356       151592    292.7mb        292.7mb
green  open   .infini_activities-00001                                                              f8f6rb1wTCe7IZDEECrKmQ   1   0        460            0    252.1kb        252.1kb
```

3、如上所示，每个索引都有它的大小和编号，我们优先删除编号小的索引，这样就能清理数据了。

> **index 名称解释**：index 索引是由 工作空间 ID + 数据类型 + 编号所组成的。

> 注意：要按照 **相同的工作空间和数据类型加上不同的编号** 来**按照从小到大的顺序**去删除索引，**但不能删除最大编号的索引**。数据编号越小，代表着数据越早。一般来说，编号最大的索引是正在写入数据的索引。

以上面查询的结果为例，可以看到 `wksp_4bcd96fc753e4a87a7f035717e3492f4_logging` 带有四个编号的索引000001、000002、000003、000004，这时候最多可按照顺序删除000001、000002和000003。

删除命令：

```shell
$ kubectl exec -ti -n middleware <es_pod_name> -- curl -XDELETE -u <user>:<password> 127.0.0.1:9200/<index>
```
