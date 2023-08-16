---
title     : 'Apollo'
summary   : '采集 Apollo 相关指标信息'
__int_icon: 'icon/apollo'
dashboard :
  - desc  : 'Apollo 监控视图'
    path  : 'dashboard/zh/apollo'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Apollo
<!-- markdownlint-enable -->

采集 Apollo 相关指标信息。

## 安装配置 {#config}

- [x] Apollo >= 1.5.0

### Apollo 指标

Apollo 默认暴露指标端口为：`8070`，可通过浏览器查看指标相关信息：`http://clientIP:8070/prometheus`。

### DataKit 采集器配置

由于`Apollo`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

```toml

  urls = ["http://clientIP:8070/prometheus"]

  source = "apollo"

  [inputs.prom.tags]
    component="apollo"
  interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`prometheus`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

<!-- markdownlint-enable -->
### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### Tags

| Tags | 描述 |
| -- | -- |
| component | 组件名称`apollo` |


### 指标集 `jvm`

| Metrics | 描述 |
| -- | -- |
| threads_states_threads | 线程状态 |
| memory_used_bytes | 内存使用情况 |


### 指标集 `jdbc`

| Metrics | 描述 |
| -- | -- |
| connections_idle | 空闲链接 |
| connections_active | 活跃链接 |
| connections_max | 活跃链接 |
| connections_min | 活跃链接 |

### 指标集 `process`

| Metrics | 描述 |
| -- | -- |
| uptime_seconds | jvm 启动时长 |

### 指标集 `system`

| Metrics | 描述 |
| -- | -- |
| cpu_usage | cpu 使用率 |
| cpu_count | cpu 可用数 |

### 指标集 `http`

| Metrics | 描述 |
| -- | -- |
| server_requests_seconds_count | 服务每秒请求数 |
| cpu_count | cpu 可用数 |


