
# etcd
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

etcd 采集器可以从 etcd 实例中采取很多指标，比如etcd服务器状态和网络的状态等多种指标，并将指标采集到 DataFlux ，帮助你监控分析 etcd 各种异常情况

## 前置条件 {#requirements}

- etcd 版本 >= 3

- 开启 etcd，默认的 metrics 接口是 `http://localhost:2379/metrics`，也可以自行在配置文件中修改。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/etcd` 目录，复制 `etcd.conf.sample` 并命名为 `etcd.conf`。示例如下：
    
    ```toml
        
    [[inputs.prom]]
      # Exporter URL or file path.
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "http://127.0.0.1:2379/metrics"
    
      ## Collector alias.
    	source = "etcd"
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      # Default only collect 'counter' and 'gauge'.
      # Collect all if empty.
      metric_types = ["counter", "gauge"]
    
      ## Metrics name whitelist.
      # Regex supported. Multi supported, conditions met when one matched.
      # Collect all if empty.
      metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]
    
      ## Measurement prefix.
      # Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      # If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      # If measurement_name is not empty, using this as measurement set name.
      # Always add 'measurement_prefix' prefix at last.
      # measurement_name = "prom"
    
      ## Collect interval, support "ns", "us" (or "µs"), "ms", "s", "m", "h".
      interval = "10s"
    
      # Ignore tags. Multi supported.
      # The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Customize measurement set name.
      # Treat those metrics with prefix as one set.
      # Prioritier over 'measurement_name' configuration.
      [[inputs.prom.measurements]]
        prefix = "etcd_"
        name = "etcd"
    
        ## Customize authentification. For now support Bearer Token only.
        # Filling in 'token' or 'token_file' is acceptable.
      # [inputs.prom.auth]
      # type = "bearer_token"
      # token = "xxxxxxxx"
      # token_file = "/tmp/token"
    
      ## Customize tags.
      # some_tag = "some_value"
    
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标集 {#measurements}



### `etcd_network`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`host`|主机名称|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`network_client_grpc_received_bytes_total`|接收到 grpc 客户端的总字节数|int|count|
|`network_client_grpc_sent_bytes_total`|发送到 grpc 客户端的总字节数|int|count|



### `etcd_server`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`host`|主机名称|
|`server_has_leader`|领导者是否存在。1是存在。0是不存在|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`server_leader_changes_seen_total`|解释到的领导者变更次数|int|count|
|`server_proposals_applied_total`|已应用的共识提案总数|int|count|
|`server_proposals_committed_total`|提交的共识提案总数|int|count|
|`server_proposals_failed_total`|看到的失败提案总数|int|count|
|`server_proposals_pending`|当前待处理提案的数量|int|count|


