# kodo-inner 配置查询并发数


## 简介 {#info}

本文介绍了一种优化方法，当观测云在底座资源充足，且 Doris 机器的 CPU、内存、磁盘 IO 等无瓶颈的情况下，查询日志等数据仍然响应缓慢时，可通过调整 **kodo-inner** 服务的并发数来提升查询速度。

## 修改配置

### 方式一

launcher 上对 右上角菜单 --> 修改应用配置 --> 命名空间： forethought-kodo --> kodoInner（ Kodo Inner ），添加以下内容

``` shell
# 层级同 global
dql:
    metric_query_workers: 64 # DQL 指标数据查询 worker 数量
    log_query_workers: 64 # DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量
    general_query_workers: 64 # 非 metric 或者 log 查询 worker 数量
```

添加完成后勾选 **修改配置后自动重启相关服务**，点击 **确定修改配置**

### 方式二

通过命令行方式添加参数

``` shell
kubectl edit deployment -n forethought-kodo kodo-inner
```

添加

``` shell
# 层级同 global
dql:
    metric_query_workers: 64 # DQL 指标数据查询 worker 数量
    log_query_workers: 64 # DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量
    general_query_workers: 64 # 非 metric 或者 log 查询 worker 数量
```

添加完成后重启服务

```
kubectl rollout restart deployment -n forethought-kodo kodo-inner
```

> 其他配置参考：[应用服务配置项手册](application-configuration-guide.md)