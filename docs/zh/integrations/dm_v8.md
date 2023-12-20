---
title     : '达梦数据库（DM8）'
summary   : '采集达梦数据库运行指标信息'
__int_icon: 'icon/dm'
dashboard :
  - desc  : '达梦数据库（DM8）监控视图'
    path  : 'dashboard/zh/dm_v8'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# 达梦数据库（DM8）
<!-- markdownlint-enable -->

## 安装配置 {#config}

### 前提条件

- [x] 安装 DM8
- [x] 安装 DEM

**DEM** 全称为 `Dameng Enterprise Manager`，是达梦提供的、基于 `java` 编写的、用于监控达梦数据库的 web 工具。

目录为`$DM_HOME/web`，当前目录存放 DEM 安装手册(`DEM.pdf`)和运行程序`dem.war`，按照手册进行部署即可。

### 指标暴露

DEM 默认暴露指标端口为：`8090`，可通过浏览器查看指标相关信息：`http://clientIP:8090/dem/metrics`。如果访问不通，则说明没有开通指标暴露能力，可以按照以下步骤操作。

- 添加数据库

默认情况下，DEM 安装成功后并不直接监控数据库，需要进行配置后才数据库才会被监控。

1. 点击菜单 **智能运维** -> **资源监控**，底部切换 Tab 为**数据库**，
2. 点击`添加`**单实例/集群**，填写被监控的数据库信息。


- 配置 Prometheus

1. 点击菜单 **系统管理** -> **系统设置**，在**其他功能**模块选择`prometheus_metric_nodes`，
2. 勾选需要被监控的数据库。点击**确定**按钮，完成配置。

- 验证

通过浏览器查看指标相关信息：`http://clientIP:8090/dem/metrics`。端口为 DEM 访问端口，可能有差异，以实际端口为准即可。


### DataKit 采集器配置

由于`DEM`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

```toml

urls = ["http://clientIP:8090/dem/metrics"]
source = "dm"
interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

- urls：`prometheus`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

### 重启 DataKit

```shell
systemctl restart datakit
```

## 指标 {#metric}

| 指标 | 描述 |
| -- | -- |
| `global_status_sessions` | 会话数 |
| `global_status_threads` | 线程 |
| `global_status_tps` | TPS |
| `global_status_qps` | QPS |
| `global_status_ddlps` | `ddlps` |
| `global_status_ips` | 每秒 `instert` 数 |
| `global_status_ups` | 每秒 `update` 数 |
| `global_status_dps` | 每秒 `delete` 数 |
| `mf_status_memory_mem_used_bytes` | 已使用内存大小 |
| `mf_status_memory_mem_total_bytes` | 总内存大小 |
| `mf_status_disk_used_bytes` | 已使用磁盘大小 |
| `mf_status_disk_total_bytes` | 总共磁盘大小 |
| `mf_status_disk_read_speed_bytes` | 磁盘读取速率 |
| `mf_status_disk_write_speed_bytes` | 写入速率 |
| `mf_status_network_receive_speed_bytes` | 接收速率 |
| `mf_status_network_transmit_speed_bytes` | 发送速率 |

