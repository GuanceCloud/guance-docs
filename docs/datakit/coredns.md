
# CoreDNS
---

- DataKit 版本：1.4.0
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

CoreDNS 采集器用于采集 CoreDNS 相关的指标数据。

## 前置条件 {#requirements}

- CoreDNS [配置](https://coredns.io/plugins/metrics/)启用 `prometheus` 插件

## 配置 {#input-config}

进入 DataKit 安装目录下的 `conf.d/coredns` 目录，复制 `coredns.conf.sample` 到 `conf.d/coredns` 并命名为 `coredns.conf`。示例如下：

```toml

[[inputs.prom]]
## Exporter 地址
# 此处修改成CoreDNS的prom监听地址
url = "http://127.0.0.1:9153/metrics"

## 采集器别名
source = "coredns"

## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
# 默认只采集 counter 和 gauge 类型的指标
# 如果为空，则不进行过滤
metric_types = ["counter", "gauge"]

## 指标名称过滤
# 支持正则，可以配置多个，即满足其中之一即可
# 如果为空，则不进行过滤
# CoreDNS的prom默认提供大量Go运行时的指标，这里忽略
metric_name_filter = ["^coredns_(acl|cache|dnssec|forward|grpc|hosts|template|dns)_([a-z_]+)$"]

## 指标集名称前缀
# 配置此项，可以给指标集名称添加前缀
# measurement_prefix = ""

## 指标集名称
# 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
# 如果配置measurement_name, 则不进行指标名称的切割
# 最终的指标集名称会添加上measurement_prefix前缀
# measurement_name = "prom"

## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
interval = "10s"

## 过滤tags, 可配置多个tag
# 匹配的tag将被忽略
# tags_ignore = [""]

## TLS 配置
tls_open = false
# tls_ca = "/tmp/ca.crt"
# tls_cert = "/tmp/peer.crt"
# tls_key = "/tmp/peer.key"

## 自定义指标集名称
# 可以将包含前缀prefix的指标归为一类指标集
# 自定义指标集名称配置优先measurement_name配置项

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

配置好后，重启 DataKit 即可。

## 指标集 {#metrics}



### `coredns_acl`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`server`|监听服务地址|
|`zone`|请求所属区域|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`acl_allowed_requests_total`|被放行的DNS请求个数|int|-|
|`acl_blocked_requests_total`|被拦截的DNS请求个数|int|-|



### `coredns_cache`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`server`|监听服务地址|
|`type`|缓存类型|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cache_drops_total`|被排除在缓存外的响应个数|int|-|
|`cache_entries`|缓存总数|int|-|
|`cache_hits_total`|缓存命中个数|int|-|
|`cache_misses_total`|缓存miss个数|int|-|
|`cache_prefetch_total`|缓存预读取个数|int|-|
|`cache_served_stale_total`|提供过时缓存的请求个数|int|-|



### `coredns_dnssec`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`server`|监听服务地址|
|`type`|签名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`dnssec_cache_entries`|dnssec缓存总数|int|-|
|`dnssec_cache_hits_total`|dnssec缓存命中个数|int|-|
|`dnssec_cache_misses_total`|dnssec缓存miss个数|int|-|



### `coredns_forward`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`proto`|传输协议|
|`rcode`|上游返回的RCODE|
|`to`|上游服务器|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`forward_healthcheck_broken_total`|所有上游均不健康次数|int|-|
|`forward_healthcheck_failures_total`|每个上游健康检查失败个数|int|-|
|`forward_max_concurrent_rejects_total`|由于并发达到峰值而被拒绝的查询个数|int|-|
|`forward_request_duration_seconds`|请求时长|float|s|
|`forward_requests_total`|转发给每个上游的请求个数|int|-|
|`forward_responses_total`|从每个上游得到的RCODE响应个数|int|-|



### `coredns_grpc`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`rcode`|上游返回的RCODE|
|`to`|上游服务器|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`grpc_request_duration_seconds`|grpc与上游交互时长|float|s|
|`grpc_requests_total`|grpc在每个上游查询个数|int|-|
|`grpc_responses_total`|grpc在每个上游得到的RCODE响应个数|int|-|



### `coredns_hosts`

- 标签

暂无

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`hosts_entries`|hosts总条数|int|-|
|`hosts_reload_timestamp_seconds`|最后一次重载hosts文件的时间戳|float|sec|



### `coredns_template`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`regex`|正则表达式|
|`section`|所属板块|
|`server`|监听服务地址|
|`template`|模板|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`template_failures_total`|Go模板失败次数|int|-|
|`template_matches_total`|正则匹配的请求总数|int|-|
|`template_rr_failures_total`|因模板资源记录无效而无法处理的次数|int|-|



### `coredns`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`family`|IP地址家族|
|`proto`|传输协议|
|`rcode`|上游返回的RCODE|
|`server`|监听服务地址|
|`type`|查询类型|
|`zone`|请求所属区域|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`dns_request_duration_seconds`|处理每个查询的时长|float|s|
|`dns_request_size_bytes`|请求大小(以byte计)|int|B|
|`dns_requests_total`|查询总数|int|-|
|`dns_response_size_bytes`|响应大小(以byte计)|int|B|
|`dns_responses_total`|对每个zone和RCODE的响应总数|int|-|


