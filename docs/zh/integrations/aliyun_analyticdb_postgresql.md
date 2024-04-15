---
title: '阿里云 AnalyticDB PostgreSQL'
summary: '阿里云 AnalyticDB PostgreSQL 指标展示，包括cpu、内存、磁盘、协调节点、实例查询等。'
__int_icon: 'icon/aliyun_analyticdb_postgresql'
dashboard:
  - desc: '阿里云 AnalyticDB PostgreSQL 内置视图'
    path: 'dashboard/zh/aliyun_analyticdb_postgresql/'
monitor:
  - desc: '阿里云 AnalyticDB PostgreSQL 监控器'
    path: 'monitor/zh/aliyun_analyticdb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云  AnalyticDB PostgreSQL
<!-- markdownlint-enable -->


阿里云  AnalyticDB PostgreSQL 指标展示，包括cpu、内存、磁盘、协调节点、实例查询等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 阿里云  AnalyticDB PostgreSQL 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-AnalyticDB PostgreSQL采集）」(ID：`guance_aliyun_analyticdb_postgresql`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-analyticdb-postgresql/){:target="_blank"}




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云 AnalyticDB PostgreSQL ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_hybriddb/gpdb?spm=a2c4g.11186623.0.0.5da976abPs9zNS){:target="_blank"}

| MetricName                   |         MetricCategory         | MetricDescribe                          | Dimensions                                    | Statistics              | Unit  | MinPeriods |
| ---- | :----: | ---- | ---- | ---- | ---- | ---- |
| node_cpu_used_percent        |              `gpdb`              | 【存储弹性&Serverless】节点CPU使用率    | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s       |
| node_mem_used_percent        |              `gpdb`              | 【存储弹性&Serverless】节点内存使用率   | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s    |
| node_disk_used_percent       |              `gpdb`              | 【存储弹性&Serverless】节点磁盘使用率   | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s        |
| `adbpg_conn_count`             |              `gpdb`              | 【存储弹性&Serverless】协调节点总连接数 | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | count | 60 s        |
| `adbpg_master_cnt_unhealth`    |              `gpdb`              | 【存储弹性&Serverless】协调节点异常个数 | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_blocked`          |              `gpdb`              | 【存储弹性&Serverless】实例阻塞查询个数 | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_queued`           |              `gpdb`              | 【存储弹性&Serverless】实例排队查询个数 | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |



## 对象 {#object}

采集到的阿里云 AnalyticDB PostgreSQL  对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_analyticdb_postgresql",
  "tags": {
    "DBInstanceCategory"        : "Basic",
    "DBInstanceId"              : "gp-bp17993xt44lmgyga",
    "DBInstanceMode"            : "StorageElastic",
    "DBInstanceNetType"         : "2",
    "DBInstanceStatus"          : "CREATING",
    "Engine"                    : "gpdb",
    "EngineVersion"             : "6.0",
    "InstanceDeployType"        : "cluster",
    "InstanceNetworkType"       : "VPC",
    "LockMode"                  : "Unlock",
    "LockReason"                : "0",
    "PayType"                   : "Postpaid",
    "RegionId"                  : "cn-hangzhou",
    "ResourceGroupId"           : "rg-acfmv3ro3xnfwaa",
    "StorageType"               : "cloud_essd",
    "VSwitchId"                 : "vsw-bp1k8o6a4cb1pnq6ximgb",
    "VpcId"                     : "vpc-bp1pftfpllxna4t75e73v",
    "ZoneId"                    : "cn-hangzhou-j",
    "name"                      : "gp-bp17993xt44lmgyga"
  },
  "fields": {
    "CreateTime"            : "2023-08-16T03:07:45Z",
    "DBInstanceDescription" : "gp-bp17993xt44lmgyga",
    "ExpireTime"            : "2999-09-08T16:00:00Z",
    "MasterNodeNum"         : 1,
    "SegNodeNum"            : "2",
    "StorageSize"           : "50",
    "message"               : "{实例 json 数据}}",
  }
}

```
