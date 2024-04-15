---
title     : 'Active Directory'
summary   : '采集 Active Directory 相关指标信息'
__int_icon: 'icon/active_directory'
dashboard :
  - desc  : 'Active Directory 监控视图'
    path  : 'dashboard/zh/active_directory'
---

<!-- markdownlint-disable MD025 -->

# Active Directory
<!-- markdownlint-enable -->

## 安装部署 {#config}

说明：示例 [Active Directory exporter](https://github.com/prometheus-community/windows_exporter) 版本为0.24.0 (Windows)

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
    source = "active_directory"
    
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
      service = "active_directory"
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
dql > M::active_directory LIMIT 1
-----------------[ r1.active_directory.s1 ]-----------------
                              
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

| **Name**                                              | **Description**                                              | **指标含义**                                                 | **单位** | **维度** |
| ----------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | -------- |
| windows_ad_replication_pending_synchronizations       | Shows the number of directory synchronizations that are queued for this  server but not yet processed. | 显示为该服务器排队但尚未处理的目录同步次数。                 | count    | host     |
| windows_ad_replication_sync_requests_total            | Shows the number of sync requests made to neighbors.         | 显示向邻居发出的同步请求数。                                 | count    | host     |
| windows_ad_replication_sync_requests_success_total    | Shows the number of sync requests made to the neighbors that successfully  returned. | 显示向邻居发出的同步请求中成功返回的请求数。                 | count    | host     |
| windows_ad_ldap_active_threads                        | Shows the current number of threads in use by the LDAP subsystem of the  local directory service. | 显示本地目录服务 LDAP 子系统当前使用的线程数。               | count    | host     |
| windows_ad_ldap_last_bind_time_seconds                | Shows the time, in milliseconds, taken for the last successful LDAP bind. | 显示上次成功 LDAP 绑定所需的时间（毫秒）。                   | count    | host     |
| windows_ad_ldap_searches_total                        | Shows the number at which LDAP clients perform search operations. | 显示 LDAP 客户端执行搜索操作的次数。                         | count    | host     |
| windows_ad_ldap_writes_total                          | Shows the number at which LDAP clients perform write operations. | 显示 LDAP 客户端执行写操作的次数。                           | count    | host     |
| windows_ad_ldap_client_sessions                       | This is the number of sessions opened by LDAP clients at the time the  data is taken. | 这是采集数据时 LDAP 客户端打开的会话数。                     | count    | host     |
| windows_ad_replication_inbound_sync_objects_remaining | Shows the number of objects remaining before full synchronization is  complete (at setup). | 显示完全同步完成前（设置时）剩余的对象数量。                 | count    | host     |
| windows_ad_replication_inbound_objects_updated_total  | Shows the number of objects received from neighbors through inbound  replication. A neighbor is a domain controller from which the local domain  controller replicates locally. | 显示通过入站复制从邻居接收的对象数量。邻居是本地域控制器在本地复制的域控制器。 | count    | host     |
| windows_ad_replication_inbound_objects_filtered_total | Shows the number of objects received from inbound replication partners  that contained no updates that needed to be applied. | 显示从入站（inbound）复制伙伴收到的不包含需要应用的更新的对象数量。 | count    | host     |
