
# CoreDNS
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

CoreDNS 采集器用于采集 CoreDNS 相关的指标数据。

## 前置条件 {#requirements}

- CoreDNS [配置](https://coredns.io/plugins/metrics/){:target="_blank"}启用 `prometheus` 插件

## 配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/coredns` 目录，复制 `coredns.conf.sample` 并命名为 `coredns.conf`。示例如下：
    
    ```toml
        
    [[inputs.prom]]
    url = "http://127.0.0.1:9153/metrics"
    source = "coredns"
    metric_types = ["counter", "gauge"]
    
    ## filter metrics by names
    metric_name_filter = ["^coredns_(acl|cache|dnssec|forward|grpc|hosts|template|dns)_([a-z_]+)$"]
    
    # measurement_prefix = ""
    # measurement_name = "prom"
    
    interval = "10s"
    
    # tags_ignore = [""]
    
    ## TLS config
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"
    
    ## customize metrics
    [[inputs.prom.measurements]]
    prefix = "coredns_acl_"
    name = "coredns_acl"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_cache_"
    name = "coredns_cache"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_dnssec_"
    name = "coredns_dnssec"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_forward_"
    name = "coredns_forward"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_grpc_"
    name = "coredns_grpc"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_hosts_"
    name = "coredns_hosts"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_template_"
    name = "coredns_template"
    
    [[inputs.prom.measurements]]
    prefix = "coredns_dns_"
    name = "coredns"
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标集 {#metrics}



### `coredns_acl`

- 标签


| Tag | Description |
|  ----  | --------|
|`server`|监听服务地址|
|`zone`|请求所属区域|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`acl_allowed_requests_total`|被放行的 DNS 请求个数|int|-|
|`acl_blocked_requests_total`|被拦截的 DNS 请求个数|int|-|



### `coredns_cache`

- 标签


| Tag | Description |
|  ----  | --------|
|`server`|监听服务地址|
|`type`|缓存类型|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_drops_total`|被排除在缓存外的响应个数|int|-|
|`cache_entries`|缓存总数|int|-|
|`cache_hits_total`|缓存命中个数|int|-|
|`cache_misses_total`|缓存 miss 个数|int|-|
|`cache_prefetch_total`|缓存预读取个数|int|-|
|`cache_served_stale_total`|提供过时缓存的请求个数|int|-|



### `coredns_dnssec`

- 标签


| Tag | Description |
|  ----  | --------|
|`server`|监听服务地址|
|`type`|签名|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`dnssec_cache_entries`|dnssec 缓存总数|int|-|
|`dnssec_cache_hits_total`|dnssec 缓存命中个数|int|-|
|`dnssec_cache_misses_total`|dnssec 缓存 miss 个数|int|-|



### `coredns_forward`

- 标签


| Tag | Description |
|  ----  | --------|
|`proto`|传输协议|
|`rcode`|上游返回的 `RCODE`|
|`to`|上游服务器|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`forward_healthcheck_broken_total`|所有上游均不健康次数|int|-|
|`forward_healthcheck_failures_total`|每个上游健康检查失败个数|int|-|
|`forward_max_concurrent_rejects_total`|由于并发达到峰值而被拒绝的查询个数|int|-|
|`forward_request_duration_seconds`|请求时长|float|s|
|`forward_requests_total`|转发给每个上游的请求个数|int|-|
|`forward_responses_total`|从每个上游得到的 `RCODE` 响应个数|int|-|



### `coredns_grpc`

- 标签


| Tag | Description |
|  ----  | --------|
|`rcode`|上游返回的 `RCODE`|
|`to`|上游服务器|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`grpc_request_duration_seconds`|grpc 与上游交互时长|float|s|
|`grpc_requests_total`|grpc 在每个上游查询个数|int|-|
|`grpc_responses_total`|grpc 在每个上游得到的 `RCODE` 响应个数|int|-|



### `coredns_hosts`

- 标签

NA

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hosts_entries`|hosts 总条数|int|-|
|`hosts_reload_timestamp_seconds`|最后一次重载 hosts 文件的时间戳|float|sec|



### `coredns_template`

- 标签


| Tag | Description |
|  ----  | --------|
|`regex`|正则表达式|
|`section`|所属板块|
|`server`|监听服务地址|
|`template`|模板|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`template_failures_total`|Go 模板失败次数|int|-|
|`template_matches_total`|正则匹配的请求总数|int|-|
|`template_rr_failures_total`|因模板资源记录无效而无法处理的次数|int|-|



### `coredns`

- 标签


| Tag | Description |
|  ----  | --------|
|`family`|IP 地址家族|
|`host`|主机|
|`proto`|传输协议|
|`rcode`|上游返回的 `RCODE`|
|`server`|监听服务地址|
|`type`|查询类型|
|`zone`|请求所属区域|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`dns_request_duration_seconds`|处理每个查询的时长|float|s|
|`dns_request_size_bytes`|请求大小(以 byte 计)|int|B|
|`dns_requests_total`|查询总数|int|-|
|`dns_response_size_bytes`|响应大小(以 byte 计)|int|B|
|`dns_responses_total`|对每个 zone 和 `RCODE` 的响应总数|int|-|
|`forward_healthcheck_broken_total`|健康检查完全失败次数|int|B|
|`forward_max_concurrent_rejects_total`|由于并发查询达到最大值而被拒绝的查询数|int|B|
|`hosts_reload_timestamp_seconds`|上次重新加载主机文件的时间戳|int|B|


