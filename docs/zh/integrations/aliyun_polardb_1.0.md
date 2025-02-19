---
title: '阿里云 PolarDB 分布式1.0'
tags: 
  - 阿里云
summary: '阿里云 PolarDB 分布式1.0展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS。'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: '阿里云 PolarDB 分布式1.0 内置视图'
    path: 'dashboard/zh/aliyun_polardb_1.0/'

monitor:
  - desc: '阿里云 PolarDB 分布式1.0 监控器'
    path: 'monitor/zh/aliyun_polardb_1.0/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 PolarDB 分布式1.0
<!-- markdownlint-enable -->

阿里云 PolarDB 分布式1.0展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 PolarDB 分布式1.0 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-PolarDB-X 1.0采集）」(ID：`guance_aliyun_polardbx_1`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云 PolarDB 分布式1.0 后,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_drds/drds){:target="_blank"}


| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`LogicQPS`| 平均每秒逻辑请求数|         Average         |    count     |
|`PhysicsQPS`| 平均每秒物理请求数|         Average         |    count     |
|`NetworkInputTraffic`| 网络输入量|         Average         |    bit/s     |
|`NetworkOutputTraffic`| 网络输出量|         Average         |    bit/s     |
|`ConnectionCount`| 连接数|     Average,Maximum     |    count     |
|`MemoryUtilization`| 内存使用率      |         Average         |      %       |
|`CPUUtilization`| CPU使用率                    |     Average,Maximum     |      %       |
|`cpu_usage`| 私有RDS_MySQL CPU利用率                   |     Average,Maximum     |      %       |
|`disk_usage`| 私有RDS_MySQL磁盘使用率                   |     Average,Maximum     |      %       |
|`mem_usage`| 私有RDS_MySQL内存利用率|     Average,Maximum     |      %       |
|`iops_usage`| 私有RDS_MySQL IOPS利用率|         Average         |      %       |
|`input_traffic_ps`| 私有RDS_MySQL网络流入带宽 |         Average         |    bits/s    |
|`output_traffic_ps`| 私有RDS_MySQL网络流出带宽|    Average              |  bits/s      |


## 对象 {#object}
采集到的阿里云 PolarDB 分布式1.0 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "aliyun_polardbx_1",
  "tags": {
    "account_name"                     : "Aliyun",
    "class"                            : "aliyun_polardbx_1",
    "Description"                      : "xxxxx",
    "DrdsInstanceId"                   : "xxxxx",
    "RegionId"                         : "cn-hangzhou",
    "name"                             : "xxxxx",
    "NetworkType"                      : "CLASSIC",
    "OrderInstanceId"                  : "xxxxx",
    "ProductVersion"                   : "V1",
    "Status"                           : "RUN",
    "Type"                             : "PRIVATE",
  }
}
```

