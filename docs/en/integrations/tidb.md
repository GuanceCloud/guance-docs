---
title     : 'TiDB'
summary   : 'Collect TiDB cluster, TiDB, Etcd, Region and other related component metric information'
__int_icon: 'icon/tidb'
dashboard :
  - desc  : 'TiDB Monitoring View
    path  : 'dashboard/zh/tidb'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# TiDB
<!-- markdownlint-enable -->

TiDB view display, including overview (such as start-up time, storage information, node information, etc.), cluster (cluster-related information), TiDB, Etcd, Region, and other related metric information.


## Configuration {#config}

### Version support

Version support depends on TiDB's own system support

Description: Example TiDB version 6.3+

(Linux / Windows environment is the same)

To install TiDB, refer to the documentation [TiDB Deployment Local Test Cluster](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4)

The following collection processes were carried out as [TiDB Deployment Local Test Cluster](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4)deployment.


### Metric Collection Configuration

Each TiDB component (a total of four components) has been exposed `metrics` under the HTTP protocol


| Component  |Metrics port|
| --- | --- |
| TiDB | 10080 |
| pd  | 2379 |
| TiKV | 20180 |
| TiFlash | 8234 <br/> 20292 |


These are the `metrics` ports associated with single-node cluster component deployment, and ports behave similarly if they are multi-node clusters

#### Open DataKit Collector

<!-- markdownlint-disable MD046 MD038 MD010-->
=== "TiDB Metric Collection"
    1. Copy sample file
    ```bash hl_lines="2"
      cd /usr/local/datakit/conf.d/prom/
      cp prom.conf.sample tidb_prom.conf
    ```

    2. Adjust `tidb_prom.conf`

    ??? Info' `tidb_prom.conf` '
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

=== "pd metric collection"

    1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_pd_prom.conf
	```

    2. Adjust `tidb_pd_prom.conf`

    ??? Info' `tidb_pd_prom.conf` '
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

=== "TiKV Metric Collection"

    1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tikv_prom.conf
	```

    2. Adjust `tidb_tikv_prom.conf`

    ???+ Info' `tidb_tikv_prom.conf` '
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

=== "TiFlash Metric Collection"

    1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tiflash_prom.conf
	```

    2. Adjust `tidb_tiflash_prom.conf`

    ???+ Info' `tidb_tiflash_prom.conf` '
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

<font color="red">*Note that the marker needs to be adjusted*</font>


Description of main parameters:

- urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- source: Collector alias, recommended to distinguish
- interval: collection interval
- measurement_prefix: Metric set prefix for easy management of classification
- tls_open:TLS Configuration
- metric_types: Metric type, not filled in, represents the collection of all metrics, recommended to fill in as needed, involving timeline
- tags_ignore: ignore unnecessary Tags
- [inputs.prom.tags_rename.mapping]:<font color="red"> tag rename, if tag and filed rename are encountered, tag needs to be renamed, otherwise the whole index cannot be collected.</font>
- [inputs.prom.tags]: Set tags to apply to all metrics currently in use
<!-- markdownlint-enable -->

### Restart DataKit

```shell
systemctl restart datakit
```

