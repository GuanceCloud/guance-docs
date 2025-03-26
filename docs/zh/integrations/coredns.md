---
title     : 'CoreDNS'
summary   : '采集 CoreDNS 的指标数据'
tags:
  - '中间件'
__int_icon      : 'icon/coredns'
dashboard :
  - desc  : 'CoreDNS'
    path  : 'dashboard/zh/coredns'
monitor   :
  - desc  : '暂无'
    path  : 'monitor/zh/coredns'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

CoreDNS 采集器用于采集 CoreDNS 相关的指标数据。

## 配置 {#config}

### 前置条件 {#requirements}

- CoreDNS [配置](https://coredns.io/plugins/metrics/){:target="_blank"}启用 `prometheus` 插件

### 采集器配置 {#input-config}

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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    通过 DataKit 来开启[ `kubernetesprometheus` 采集器(https://docs.<<<custom_key.brand_main_domain>>>/integrations/kubernetesprometheus/)。

    ```yaml
    [inputs.kubernetesprometheus]
      [[inputs.kubernetesprometheus.instances]]
          role       = "pod"
          namespaces = ["kube-system"]
          selector   = "k8s-app=kube-dns"
          port     = "__kubernetes_pod_container_coredns_port_metrics_number"
        [inputs.kubernetesprometheus.instances.custom]
          [inputs.kubernetesprometheus.instances.custom.tags]
            cluster = "demo"
    ```
<!-- markdownlint-enable -->

## 指标 {#metric}



### `coredns_acl`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|
|`server`|Server responsible for the request.|
|`zone`|Zone name used for the request/response.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`allowed_requests_total`|Counter of DNS requests being allowed|float|count|
|`blocked_requests_total`|Counter of DNS requests being blocked|float|count|
|`dropped_requests_total`|Counter of DNS requests being dropped|float|count|
|`filtered_requests_total`|Counter of DNS requests being filtered|float|count|



### `coredns_cache`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|
|`server`|Server responsible for the request|
|`type`|Cache type|
|`zones`|Zone name used for the request/response|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`drops_total`|The number responses that are not cached, because the reply is malformed|float|count|
|`entries`|The number of elements in the cache|float|count|
|`evictions_total`|The count of cache evictions|float|count|
|`hits_total`|The count of cache hits|float|count|
|`misses_total`|The count of cache misses. Deprecated, derive misses from cache hits/requests counters|float|count|
|`prefetch_total`|The number of times the cache has prefetched a cached item.|float|count|
|`requests_total`|The count of cache requests|float|count|
|`served_stale_total`|The number of requests served from stale cache entries|float|count|



### `coredns_dnssec`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|
|`server`|Server responsible for the request|
|`type`|signature|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_entries`|The number of elements in the dnssec cache|float|count|
|`cache_hits_total`|The count of cache hits|float|count|
|`cache_misses_total`|The count of cache misses|float|count|



### `coredns_forward`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|
|`proto`|Transport protocol like `udp`, `tcp`, `tcp-tls`|
|`rcode`|Upstream returned `RCODE`|
|`to`|Upstream server|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`conn_cache_hits_total`|Counter of connection cache hits per upstream and protocol|float|count|
|`conn_cache_misses_total`|Counter of connection cache misses per upstream and protocol|float|count|
|`healthcheck_broken_total`|Counter of the number of complete failures of the health checks|float|count|
|`healthcheck_failures_total`|Counter of the number of failed health checks|float|count|
|`max_concurrent_rejects_total`|Counter of the number of queries rejected because the concurrent queries were at maximum|float|count|
|`request_duration_seconds`|Histogram of the time each request took|float|s|
|`requests_total`|Counter of requests made per upstream|float|count|
|`responses_total`|Counter of responses received per upstream|float|count|



### `coredns_grpc`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|
|`rcode`|Upstream returned `RCODE`|
|`to`|Upstream server|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`request_duration_seconds`|Histogram of the time each request took|float|s|
|`requests_total`|Counter of requests made per upstream|float|count|
|`responses_total`|Counter of requests made per upstream|float|count|



### `coredns_hosts`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`entries`|The combined number of entries in hosts and Corefile|float|count|
|`reload_timestamp_seconds`|The timestamp of the last reload of hosts file|float|sec|



### `coredns_template`

- 标签


| Tag | Description |
|  ----  | --------|
|`class`|The query class (usually `IN`)|
|`host`|Host name|
|`instance`|Instance endpoint|
|`section`|Section label|
|`server`|Server responsible for the request|
|`template`|Template label|
|`type`|The RR type requested (e.g. `PTR`|
|`view`|View name|
|`zone`|Zone name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`failures_total`|Counter of go template failures|float|count|
|`matches_total`|Counter of template regex matches|float|count|
|`rr_failures_total`|Counter of mis-templated RRs|float|count|



### `coredns`

- 标签


| Tag | Description |
|  ----  | --------|
|`goversion`|Golang version|
|`hash`|Is `sha512`|
|`host`|Host name|
|`instance`|Instance endpoint|
|`name`|Handler name|
|`plugin`|The name of the plugin that made the write to the client|
|`proto`|Transport protocol like `udp`, `tcp`, `tcp-tls`|
|`rcode`|Upstream returned `RCODE`|
|`revision`|Gitcommit contains the commit where we built CoreDNS from|
|`server`|Server responsible for the request|
|`service_kind`|Service kind|
|`status`|HTTPs status code|
|`value`|The returned hash value|
|`version`|CoreDNS version|
|`view`|View name|
|`zone`|Zone name used for the request/response|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`autopath_success_total`|Counter of requests that did auto path|float|count|
|`build_info`|A metric with a constant '1' value labeled by version, revision, and Go version from which CoreDNS was built|float|bool|
|`dns64_requests_translated_total`|Counter of DNS requests translated by dns64|float|count|
|`dns_do_requests_total`|Counter of DNS requests with DO bit set per zone|float|count|
|`dns_https_responses_total`|Counter of DoH responses per server and http status code|float|count|
|`dns_panics_total`|A metrics that counts the number of panics|float|count|
|`dns_plugin_enabled`|A metric that indicates whether a plugin is enabled on per server and zone basis|float|bool|
|`dns_request_duration_seconds`|Histogram of the time (in seconds) each request took per zone|float|s|
|`dns_request_size_bytes`|Size of the `EDNS0` UDP buffer in bytes (64K for TCP) per zone and protocol|float|B|
|`dns_requests_total`|Counter of DNS requests made per zone, protocol and family|float|count|
|`dns_response_size_bytes`|Size of the returned response in bytes|float|B|
|`dns_responses_total`|Counter of response status codes|float|count|
|`health_request_duration_seconds`|Histogram of the time (in seconds) each request took|float|s|
|`health_request_failures_total`|The number of times the health checks failed|float|count|
|`kubernetes_dns_programming_duration_seconds`|Histogram of the time (in seconds) it took to program a dns instance|float|s|
|`local_localhost_requests_total`|Counter of localhost. `domain` requests|float|count|
|`reload_failed_total`|Counter of the number of failed reload attempts|float|count|
|`reload_version_info`|A metric with a constant '1' value labeled by hash, and value which type of hash generated|float|bool|


