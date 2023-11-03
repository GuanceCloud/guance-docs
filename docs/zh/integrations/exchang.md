---
title     : 'Exchange'
summary   : '采集 Exchange 相关指标信息'
__int_icon: 'icon/exchange'
dashboard :
  - desc  : 'exchange 监控视图'
    path  : 'dashboard/zh/exchange'
---

<!-- markdownlint-disable MD025 -->

# Exchange
<!-- markdownlint-enable -->

## 安装部署 {#config}

说明：示例 [Exchange exporter](https://github.com/prometheus-community/windows_exporter) 版本为0.24.0 (Windows)

### 开启 DataKit 采集器

- 开启 DataKit Prom 插件，复制 sample 文件

```cmd
cd C:\Program Files\datakit\conf.d\prom
# 复制 prom.conf.sample 为 prom.conf
```

- 修改 `prom.conf` 配置文件

<!-- markdownlint-disable MD046 -->

??? quote "配置如下"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://127.0.0.1:9182/metrics"]
    
    ## 忽略对 url 的请求错误
    ignore_req_err = false
    
    ## 采集器别名
    source = "exchange"
    
    ## 采集数据输出源
    # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
    # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
    # 如果已经将 url 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
    # output = "/abs/path/to/file"
    > 
    ## 采集数据大小上限，单位为字节
    # 将数据输出到本地文件时，可以设置采集数据大小上限
    # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
    # 采集数据大小上限默认设置为32MB
    # max_file_size = 0
    
    ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
    # 默认只采集 counter 和 gauge 类型的指标
    # 如果为空，则不进行过滤
    metric_types = ["counter", "gauge"]
    
    ## 指标名称过滤
    # 支持正则，可以配置多个，即满足其中之一即可
    # 如果为空，则不进行过滤
    # metric_name_filter = ["cpu"]
    
    ## 指标集名称前缀
    # 配置此项，可以给指标集名称添加前缀
    measurement_prefix = ""
    
    ## 指标集名称
    # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
    # 如果配置measurement_name, 则不进行指标名称的切割
    # 最终的指标集名称会添加上measurement_prefix前缀
    # measurement_name = "prom"
    
    ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"
    
    ## 过滤tags, 可配置多个tag
    # 匹配的tag将被忽略
    # tags_ignore = ["xxxx"]
    
    ## TLS 配置
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"
    
    ## 自定义认证方式，目前仅支持 Bearer Token
    # token 和 token_file: 仅需配置其中一项即可
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## 自定义指标集名称
    # 可以将包含前缀prefix的指标归为一类指标集
    # 自定义指标集名称配置优先measurement_name配置项
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"
    
    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"
    
    ## 自定义Tags
    [inputs.prom.tags]
      service = "exchange"
    # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->

- 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

- DQL 验证

```bash
[root@df-solution-ecs-018 prom]# datakit -Q

Flag -Q deprecated, please use datakit help to use recommend flags.

dqlcmd: &cmds.dqlCmd{json:false, autoJSON:false, verbose:false, csv:"", forceWriteCSV:false, dqlString:"", token:"tkn_9a49a7e9343c432eb0b99a297401c3bb", host:"0.0.0.0:9529", log:"", dqlcli:(*http.Client)(0xc0009a5800)}
dql > M::exchange LIMIT 1
-----------------[ r1.exchange.s1 ]-----------------
                              
                   windows_ad_atq_average_request_latency 0
                           windows_ad_atq_current_threads 44
                      windows_ad_atq_outstanding_requests 0
                          windows_ad_ldap_client_sessions '1.0'
  windows_ad_replication_inbound_properties_updated_total '0.0'
                windows_ad_replication_pending_operations '0.0'
                                  .....
                              
                                      windows_cs_hostname 2
                         windows_cs_physical_memory_bytes 0
                                                     time 2023-11-1 16:00:10 +0800 CST
                      windows_exchange_owa_requests_total 0
                          windows_exchange_rpc_user_count 0                                   
                              windows_exporter_build_info 0
                                                   uptime 2858680025
              windows_exporter_collector_duration_seconds 0
---------
1 rows, 1 series, cost 40.297037ms
```

## 指标详解 {#metric}

### General 分类

| 指标集   | 指标                                      | 含义                                                         | 指标意义                                                     |
| -------- | ----------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| exchange | windows_exchange_owa_current_unique_users | Number of unique users currently logged on to Outlook Web App | 监控使用OWA的活动用户数量                                    |
| exchange | windows_net_packets_outbound_errors_total | 主机网卡出方向的错误数                                       | 正常情况下，网卡不应该有错误package数量，这个数如果不为0，意味着网络层面有错误 |
| exchange | windows_exchange_workload_active_tasks    | Number of active tasks currently running in the background for workload management | Workload的活动任务数                                         |
| exchange | windows_exchange_workload_queued_tasks    | Number of workload management tasks that are currently queued up waiting to be processed | 显示当前正在**排队等待处理**的工作负载管理任务数。           |
| exchange | usage_total                               | CPU利用率                                                    | 反映负载                                                     |
| exchange | available                                 | 可用内存数                                                   | 反映负载                                                     |

### Web 分类

| 指标集   | 指标                                       | 含义                                                         | 监控的意义                                                   |
| -------- | ------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| exchange | windows_exchange_owa_current_unique_users  | Number of unique users currently logged on to Outlook Web App | 监控使用OWA的活动用户数量,与前面相同                         |
| exchange | windows_exchange_owa_requests_total        | Number of requests handled by Outlook Web App per second     | OWA每秒处理的请求数，反映了OWA的繁忙情况                     |
| exchange | windows_exchange_activesync_requests_total | Num HTTP requests received from the client via ASP.NET per sec. Shows Current user load | 显示每秒通过 ASP.NET 从客户端接收到的 HTTP 请求数。 确定当前的 Exchange  ActiveSync 请求速率 |

### RPC分类

| 指标集   | 指标                                  | 含义                                                  | 监控的意义                                                   |
| -------- | ------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------ |
| exchange | windows_exchange_rpc_connection_count | Total number of client connections maintained         | 显示所维护的客户端连接总数                                   |
| exchange | windows_exchange_rpc_user_count       | Number of users                                       | 显示连接到服务的用户数。                                     |
| exchange | windows_exchange_rpc_avg_latency_sec  | The latency (sec), averaged for the past 1024 packets | 显示过去 1,024 个数据包的平均延迟（毫秒）。应小于250ms。  较高的RPC响应值会影响用户体验和Outlook处理时间 |
| exchange | windows_exchange_rpc_operations_total | The rate at which RPC operations occur                | RPC操作的速率                                                |

