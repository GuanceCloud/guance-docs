
# etcd
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

The tcd collector can take many metrics from the etcd instance, such as the status of the etcd server and network, and collect the metrics to DataFlux to help you monitor and analyze various abnormal situations of etcd.

## Preconditions {#requirements}

- etcd version  >=3

- Open etcd, the default metrics interface is http://localhost:2379/metrics, or you can modify it in your configuration file.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/etcd` directory under the DataKit installation directory, copy `etcd.conf.sample` and name it `etcd.conf`. Examples are as follows:


​    
    ```toml
        
    [[inputs.prom]]
      ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
      ## 文件路径各个操作系统下不同
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "http://127.0.0.1:2379/metrics"
    
    	## 采集器别名
    	source = "etcd"
    
      ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
      # 默认只采集 counter 和 gauge 类型的指标
      # 如果为空，则不进行过滤
      metric_types = ["counter", "gauge"]
    
      ## 指标名称过滤
      # 支持正则，可以配置多个，即满足其中之一即可
      # 如果为空，则不进行过滤
      metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]
    
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
    
      ## 自定义指标集名称
      # 可以将包含前缀prefix的指标归为一类指标集
      # 自定义指标集名称配置优先measurement_name配置项
      [[inputs.prom.measurements]]
        prefix = "etcd_"
        name = "etcd"
    
      ## 自定义认证方式，目前仅支持 Bearer Token
      # [inputs.prom.auth]
      # type = "bearer_token"
      # token = "xxxxxxxx"
      # token_file = "/tmp/token"
    
      ## 自定义Tags
    
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}



### `etcd_network`

- tag


| Tag | Descrition |
|  ----  | --------|
|`host`|主机名称|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`network_client_grpc_received_bytes_total`|接收到 grpc 客户端的总字节数|int|count|
|`network_client_grpc_sent_bytes_total`|发送到 grpc 客户端的总字节数|int|count|



### `etcd_server`

- tag


| Tag | Descrition |
|  ----  | --------|
|`host`|主机名称|
|`server_has_leader`|领导者是否存在。1是存在。0是不存在|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`server_leader_changes_seen_total`|解释到的领导者变更次数|int|count|
|`server_proposals_applied_total`|已应用的共识提案总数|int|count|
|`server_proposals_committed_total`|提交的共识提案总数|int|count|
|`server_proposals_failed_total`|看到的失败提案总数|int|count|
|`server_proposals_pending`|当前待处理提案的数量|int|count|


