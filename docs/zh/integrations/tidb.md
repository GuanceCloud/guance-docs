---
title     : 'TiDB'
summary   : '采集 TiDB cluster、TiDB、Etcd、Region 等相关组件指标信息'
__int_icon: 'icon/tidb'
dashboard :
  - desc  : 'TiDB 监控视图'
    path  : 'dashboard/zh/tidb'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# TiDB
<!-- markdownlint-enable -->

TiDB 视图展示，包括概览（如：启动时间、存储信息、节点信息等）、cluster(集群相关信息)、TiDB、Etcd、Region 等相关指标信息。


## 安装配置 {#config}

### 版本支持

版本支持取决于 TiDB 自身系统支持

说明：示例 TiDB 版本为 6.3+

(Linux / Windows 环境相同)

如需安装 TiDB，可参考文档 [TiDB 部署本地测试集群](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4)

以下采集流程，均按照 [TiDB 部署本地测试集群](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4) 部署方式进行采集。


### 指标采集配置

TiDB 各组件（共 4 个组件）均已暴露 `metrics` ,协议为 http


| 组件  | metrics 端口 |
| --- | --- |
| TiDB | 10080 |
| pd  | 2379 |
| TiKV | 20180 |
| TiFlash | 8234 <br/> 20292 |


以上是单节点集群组件部署相关 `metrics` 端口，如果是多节点集群，端口方式类似

#### 开启 DataKit 采集器

<!-- markdownlint-disable MD046 MD038 MD010-->
=== "TiDB 指标采集"
    1. 复制 sample 文件
    ```bash hl_lines="2"
      cd /usr/local/datakit/conf.d/prom/
      cp prom.conf.sample tidb_prom.conf
    ```

    2. 调整 `tidb_prom.conf`

	??? info "`tidb_prom.conf`"	
		```toml hl_lines="4 12 17 21 80"
		[[inputs.prom]]
		  # Exporter URLs.
		  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
		  urls = ["http://0.0.0.0:10080/metrics"]
		  # Unix Domain Socket URL. Using socket to request data when not empty.
		  uds_path = ""

		  # Ignore URL request errors.
		  ignore_req_err = false

		  ## Collector alias.
		  source = "tidb_prom"

		  ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
		  # Default only collect 'counter' and 'gauge'.
		  # Collect all if empty.
		  metric_types = ["counter", "gauge","histogram"]

		  ## Measurement prefix.
		  # Add prefix to measurement set name.
		  measurement_prefix = "tidb_"

		  ## TLS configuration.
		  tls_open = false
		  # tls_ca = "/tmp/ca.crt"
		  # tls_cert = "/tmp/peer.crt"
		  # tls_key = "/tmp/peer.key"

		  ## Set to 'true' to enable election.
		  election = true

		  # Ignore tags. Multi supported.
		  # The matched tags would be dropped, but the item would still be sent.
		  # tags_ignore = ["xxxx"]

		  ## Customize authentification. For now support Bearer Token only.
		  # Filling in 'token' or 'token_file' is acceptable.
		  # [inputs.prom.auth]
		  # type = "bearer_token"
		  # token = "xxxxxxxx"
		  # token_file = "/tmp/token"

		  ## Customize measurement set name.
		  # Treat those metrics with prefix as one set.
		  # Prioritier over 'measurement_name' configuration.
		  #[[inputs.prom.measurements]]
		  #  prefix = "cpu_"
		  #  name = "cpu"

		  # [[inputs.prom.measurements]]
		  # prefix = "mem_"
		  # name = "mem"

		  # Not collecting those data when tag matched.
		  [inputs.prom.ignore_tag_kv_match]
		  # key1 = [ "val1.*", "val2.*"]
		  # key2 = [ "val1.*", "val2.*"]

		  # Add HTTP headers to data pulling.
		  [inputs.prom.http_headers]
		  # Root = "passwd"
		  # Michael = "1234"

		  # Rename tag key in prom data.
		  [inputs.prom.tags_rename]
			overwrite_exist_tags = false
			[inputs.prom.tags_rename.mapping]
			# tag1 = "new-name-1"
			# tag2 = "new-name-2"
			# tag3 = "new-name-3"

		  # Send collected metrics to center as log.
		  # When 'service' field is empty, using 'service tag' as measurement set name.
		  [inputs.prom.as_logging]
			enable = false
			service = "service_name"

		  ## Customize tags.
		  [inputs.prom.tags]
			tidb_cluster="test"
		
		```

=== "pd 指标采集"

	1. 复制 sample 文件
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_pd_prom.conf
	```

	2. 调整 `tidb_pd_prom.conf`

	??? info "`tidb_pd_prom.conf`"	
		``` toml hl_lines="4 12 21 29 91 92 93 94 95 108"
		[[inputs.prom]]
		  # Exporter URLs.
		  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
		  urls = ["http://0.0.0.0:2379/metrics"]
		  # Unix Domain Socket URL. Using socket to request data when not empty.
		  uds_path = ""

		  # Ignore URL request errors.
		  ignore_req_err = false

		  ## Collector alias.
		  source = "tidb_pd_prom"

		  ## Collect data output.
		  # Fill this when want to collect the data to local file nor center.
		  # After filling, could use 'datakit --prom-conf /path/to/this/conf' to debug local storage measurement set.
		  # Using '--prom-conf' when priority debugging data in 'output' path.
		  # output = "/abs/path/to/file"

		  ## Collect data upper limit as bytes.
		  # Only available when set output to local file.
		  # If collect data exceeded the limit, the data would be dropped.
		  # Default is 32MB.
		  # max_file_size = 0

		  ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
		  # Default only collect 'counter' and 'gauge'.
		  # Collect all if empty.
		  metric_types = ["counter", "gauge"]

		  ## Metrics name whitelist.
		  # Regex supported. Multi supported, conditions met when one matched.
		  # Collect all if empty.
		  # metric_name_filter = ["cpu"]

		  ## Measurement prefix.
		  # Add prefix to measurement set name.
		  measurement_prefix = "tidb_pd_"

		  ## Measurement name.
		  # If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
		  # If measurement_name is not empty, using this as measurement set name.
		  # Always add 'measurement_prefix' prefix at last.
		  # measurement_name = "prom"

		  ## TLS configuration.
		  tls_open = false
		  # tls_ca = "/tmp/ca.crt"
		  # tls_cert = "/tmp/peer.crt"
		  # tls_key = "/tmp/peer.key"

		  ## Set to 'true' to enable election.
		  election = true

		  # Ignore tags. Multi supported.
		  # The matched tags would be dropped, but the item would still be sent.
		  # tags_ignore = ["xxxx"]

		  ## Customize authentification. For now support Bearer Token only.
		  # Filling in 'token' or 'token_file' is acceptable.
		  # [inputs.prom.auth]
		  # type = "bearer_token"
		  # token = "xxxxxxxx"
		  # token_file = "/tmp/token"

		  ## Customize measurement set name.
		  # Treat those metrics with prefix as one set.
		  # Prioritier over 'measurement_name' configuration.
		  #[[inputs.prom.measurements]]
		  #  prefix = "cpu_"
		  #  name = "cpu"

		  # [[inputs.prom.measurements]]
		  # prefix = "mem_"
		  # name = "mem"

		  # Not collecting those data when tag matched.
		  [inputs.prom.ignore_tag_kv_match]
		  # key1 = [ "val1.*", "val2.*"]
		  # key2 = [ "val1.*", "val2.*"]

		  # Add HTTP headers to data pulling.
		  [inputs.prom.http_headers]
		  # Root = "passwd"
		  # Michael = "1234"

		  # Rename tag key in prom data.
		  [inputs.prom.tags_rename]
			#overwrite_exist_tags = false
			overwrite_exist_tags = false
			[inputs.prom.tags_rename.mapping]
			  cluster_version = "version"
			  server_id = "s_id"
			  server_version = "version"
			  server_go_version = "version"
			# tag1 = "new-name-1"
			# tag2 = "new-name-2"
			# tag3 = "new-name-3"

		  # Send collected metrics to center as log.
		  # When 'service' field is empty, using 'service tag' as measurement set name.
		  [inputs.prom.as_logging]
			enable = false
			service = "service_name"

		  ## Customize tags.
		  [inputs.prom.tags]
			tidb_cluster="test"

		
		```

=== "TiKV 指标采集"

	1. 复制 sample 文件
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tikv_prom.conf
	```

	2. 调整 `tidb_tikv_prom.conf`

	??? info "`tidb_tikv_prom.conf`"	
		``` toml hl_lines="4 12 29 38 103"
		[[inputs.prom]]
		  # Exporter URLs.
		  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
		  urls = ["http://0.0.0.0:20180/metrics"]
		  # Unix Domain Socket URL. Using socket to request data when not empty.
		  uds_path = ""

		  # Ignore URL request errors.
		  ignore_req_err = false

		  ## Collector alias.
		  source = "tidb_tikv_prom"

		  ## Collect data output.
		  # Fill this when want to collect the data to local file nor center.
		  # After filling, could use 'datakit --prom-conf /path/to/this/conf' to debug local storage measurement set.
		  # Using '--prom-conf' when priority debugging data in 'output' path.
		  # output = "/abs/path/to/file"

		  ## Collect data upper limit as bytes.
		  # Only available when set output to local file.
		  # If collect data exceeded the limit, the data would be dropped.
		  # Default is 32MB.
		  # max_file_size = 0

		  ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
		  # Default only collect 'counter' and 'gauge'.
		  # Collect all if empty.
		  metric_types = ["counter", "gauge"]

		  ## Metrics name whitelist.
		  # Regex supported. Multi supported, conditions met when one matched.
		  # Collect all if empty.
		  # metric_name_filter = ["cpu"]

		  ## Measurement prefix.
		  # Add prefix to measurement set name.
		  measurement_prefix = "tidb_tikv_"

		  ## Measurement name.
		  # If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
		  # If measurement_name is not empty, using this as measurement set name.
		  # Always add 'measurement_prefix' prefix at last.
		  # measurement_name = "prom"

		  ## TLS configuration.
		  tls_open = false
		  # tls_ca = "/tmp/ca.crt"
		  # tls_cert = "/tmp/peer.crt"
		  # tls_key = "/tmp/peer.key"

		  ## Set to 'true' to enable election.
		  election = true

		  # Ignore tags. Multi supported.
		  # The matched tags would be dropped, but the item would still be sent.
		  # tags_ignore = ["xxxx"]

		  ## Customize authentification. For now support Bearer Token only.
		  # Filling in 'token' or 'token_file' is acceptable.
		  # [inputs.prom.auth]
		  # type = "bearer_token"
		  # token = "xxxxxxxx"
		  # token_file = "/tmp/token"

		  ## Customize measurement set name.
		  # Treat those metrics with prefix as one set.
		  # Prioritier over 'measurement_name' configuration.
		  #[[inputs.prom.measurements]]
		  #  prefix = "cpu_"
		  #  name = "cpu"

		  # [[inputs.prom.measurements]]
		  # prefix = "mem_"
		  # name = "mem"

		  # Not collecting those data when tag matched.
		  [inputs.prom.ignore_tag_kv_match]
		  # key1 = [ "val1.*", "val2.*"]
		  # key2 = [ "val1.*", "val2.*"]

		  # Add HTTP headers to data pulling.
		  [inputs.prom.http_headers]
		  # Root = "passwd"
		  # Michael = "1234"

		  # Rename tag key in prom data.
		  [inputs.prom.tags_rename]
			overwrite_exist_tags = false
			[inputs.prom.tags_rename.mapping]
			# tag1 = "new-name-1"
			# tag2 = "new-name-2"
			# tag3 = "new-name-3"

		  # Send collected metrics to center as log.
		  # When 'service' field is empty, using 'service tag' as measurement set name.
		  [inputs.prom.as_logging]
			enable = false
			service = "service_name"

		  ## Customize tags.
		  [inputs.prom.tags]
			tidb_cluster="test"

		
		```

=== "TiFlash 指标采集"  

	1. 复制 sample 文件
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tiflash_prom.conf
	```

	2. 调整 `tidb_tiflash_prom.conf`

	??? info "`tidb_tiflash_prom.conf`"	
		``` toml hl_lines="4 12 29 38 103"
		[[inputs.prom]]
		  # Exporter URLs.
		  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
		  urls = ["http://0.0.0.0:8234/metrics","http://0.0.0.0:20292/metrics"]
		  # Unix Domain Socket URL. Using socket to request data when not empty.
		  uds_path = ""

		  # Ignore URL request errors.
		  ignore_req_err = false

		  ## Collector alias.
		  source = "tidb_tiflash"

		  ## Collect data output.
		  # Fill this when want to collect the data to local file nor center.
		  # After filling, could use 'datakit --prom-conf /path/to/this/conf' to debug local storage measurement set.
		  # Using '--prom-conf' when priority debugging data in 'output' path.
		  # output = "/abs/path/to/file"

		  ## Collect data upper limit as bytes.
		  # Only available when set output to local file.
		  # If collect data exceeded the limit, the data would be dropped.
		  # Default is 32MB.
		  # max_file_size = 0

		  ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
		  # Default only collect 'counter' and 'gauge'.
		  # Collect all if empty.
		  metric_types = ["counter", "gauge"]

		  ## Metrics name whitelist.
		  # Regex supported. Multi supported, conditions met when one matched.
		  # Collect all if empty.
		  # metric_name_filter = ["cpu"]

		  ## Measurement prefix.
		  # Add prefix to measurement set name.
		  measurement_prefix = "tidb_tiflash_"

		  ## Measurement name.
		  # If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
		  # If measurement_name is not empty, using this as measurement set name.
		  # Always add 'measurement_prefix' prefix at last.
		  # measurement_name = "prom"

		  ## TLS configuration.
		  tls_open = false
		  # tls_ca = "/tmp/ca.crt"
		  # tls_cert = "/tmp/peer.crt"
		  # tls_key = "/tmp/peer.key"

		  ## Set to 'true' to enable election.
		  election = true

		  # Ignore tags. Multi supported.
		  # The matched tags would be dropped, but the item would still be sent.
		  # tags_ignore = ["xxxx"]

		  ## Customize authentification. For now support Bearer Token only.
		  # Filling in 'token' or 'token_file' is acceptable.
		  # [inputs.prom.auth]
		  # type = "bearer_token"
		  # token = "xxxxxxxx"
		  # token_file = "/tmp/token"

		  ## Customize measurement set name.
		  # Treat those metrics with prefix as one set.
		  # Prioritier over 'measurement_name' configuration.
		  #[[inputs.prom.measurements]]
		  #  prefix = "cpu_"
		  #  name = "cpu"

		  # [[inputs.prom.measurements]]
		  # prefix = "mem_"
		  # name = "mem"

		  # Not collecting those data when tag matched.
		  [inputs.prom.ignore_tag_kv_match]
		  # key1 = [ "val1.*", "val2.*"]
		  # key2 = [ "val1.*", "val2.*"]

		  # Add HTTP headers to data pulling.
		  [inputs.prom.http_headers]
		  # Root = "passwd"
		  # Michael = "1234"

		  # Rename tag key in prom data.
		  [inputs.prom.tags_rename]
			overwrite_exist_tags = false
			[inputs.prom.tags_rename.mapping]
			# tag1 = "new-name-1"
			# tag2 = "new-name-2"
			# tag3 = "new-name-3"

		  # Send collected metrics to center as log.
		  # When 'service' field is empty, using 'service tag' as measurement set name.
		  [inputs.prom.as_logging]
			enable = false
			service = "service_name"

		  ## Customize tags.
		  [inputs.prom.tags]
			tidb_cluster="test"

		```

<!-- markdownlint-disable MD033 -->
<font color="red">*注意需要对标记的地方进行调整* </font>


主要参数说明 ：

- urls：`prometheus` 指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔
- measurement_prefix: 指标集前缀，方便管理分类
- tls_open：TLS 配置
- metric_types：指标类型，不填，代表采集所有指标，建议按需填写，涉及到时间线
- tags_ignore： 忽略不需要的 tag
- [inputs.prom.tags_rename.mapping]：<font color="red">tag 重命名，如果遇到 tag 与 filed 重名，则需要重命名 tag ，否则整个指标都无法进行采集。</font>
- [inputs.prom.tags] ：设置 tag，应用于当前 metrics 的所有指标
<!-- markdownlint-enable -->

### 重启 DataKit

```shell
systemctl restart datakit
```

