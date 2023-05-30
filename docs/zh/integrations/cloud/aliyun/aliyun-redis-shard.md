# Redis 集群版

---

## 视图预览

阿里云 Redis 集群版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。

![image](../imgs/input-aliyun-redis-shard-1.png)

![image](../imgs/input-aliyun-redis-shard-2.png)

![image](../imgs/input-aliyun-redis-shard-3.png)

## 前置条件
- 服务器 [安装 DataKit](../../../datakit/datakit-install.md)
- 服务器 [安装 DataFlux Func ](https://func.guance.com/doc/quick-start/)
- [开启观测云集成](https://func.guance.com/doc/script-market-guance-integration/)
- [阿里云 Redis 对象采集](https://func.guance.com/doc/script-market-guance-aliyun-redis/)
- [阿里云 Redis 指标采集](https://func.guance.com/doc/script-market-guance-aliyun-monitor/)
- [阿里云 Redis 慢查询](https://func.guance.com/doc/script-market-guance-aliyun-redis-slowlog/)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 阿里云 Redis 集群版>

## 监控规则

<监控 - 模板新建 - 阿里云 Redis 集群版检测库>

## 指标详解

<[阿里云 Redis 集群版指标列表](https://cms.console.aliyun.com/metric-meta/acs_kvstore/kvstore_sharding?spm=a2c4g.163515.0.0.355076abP8Pznf)>