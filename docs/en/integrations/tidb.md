---
title     : 'TiDB'
summary   : 'Collect related component Metrics information of TiDB cluster, TiDB, Etcd, Region, etc.'
__int_icon: 'icon/tidb'
dashboard :
  - desc  : 'TiDB'
    path  : 'dashboard/en/tidb'
monitor   :
  - desc  : 'TiDB'
    path  : 'monitor/en/tidb'
---

<!-- markdownlint-disable MD025 -->
# TiDB
<!-- markdownlint-enable -->

The TiDB view displays the relevant Metrics information, including the Summary (such as: start time, storage information, node information, etc.), cluster (related cluster information), TiDB, Etcd, Region, etc.


## Installation and Configuration {#config}

### Version Support

Version support depends on the support of the TiDB system itself.

Note: The example TiDB version is 6.3+

(Linux / Windows environments are the same)

If you need to install TiDB, refer to the document [Deploy a Local Test Cluster for TiDB](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4)

The following collection process is based on the deployment method described in [Deploy a Local Test Cluster for TiDB](https://docs.pingcap.com/zh/tidb/stable/quick-start-with-tidb#%E9%83%A8%E7%BD%B2%E6%9C%AC%E5%9C%B0%E6%B5%8B%E8%AF%95%E9%9B%86%E7%BE%A4) for collection.


### Metrics Collection Configuration

Each component of TiDB (a total of 4 components) has exposed `metrics`, with the protocol being http


| Component | metrics port |
| --- | --- |
| TiDB | 10080 |
| pd  | 2379 |
| TiKV | 20180 |
| TiFlash | 8234 <br/> 20292 |


The above are the `metrics` ports for single-node cluster component deployments; if it's a multi-node cluster, the port configuration is similar.

#### Enable DataKit Collector

<!-- markdownlint-disable MD046 MD038 MD010-->
=== "TiDB Metrics Collection"
    1. Copy the sample file
    ```bash hl_lines="2"
      cd /usr/local/datakit/conf.d/prom/
      cp prom.conf.sample tidb_prom.conf
    ```

    2. Adjust `tidb_prom.conf`

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

		  ## Customize authentication. For now supports Bearer Token only.
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

=== "pd Metrics Collection"

	1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_pd_prom.conf
	```

	2. Adjust `tidb_pd_prom.conf`

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

		  ## Customize authentication. For now supports Bearer Token only.
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

=== "TiKV Metrics Collection"

	1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tikv_prom.conf
	```

	2. Adjust `tidb_tikv_prom.conf`

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

		  ## Customize authentication. For now supports Bearer Token only.
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

=== "TiFlash Metrics Collection"  

	1. Copy the sample file
	```shell hl_lines="2"
	cd /usr/local/datakit/conf.d/prom/
	cp prom.conf.sample tidb_tiflash_prom.conf
	```

	2. Adjust `tidb_tiflash_prom.conf`

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

		  ## Customize authentication. For now supports Bearer Token only.
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
<font color="red">*Note that adjustments are required for marked places* </font>


Main parameter explanations:

- urls: `prometheus` Metrics address, fill in the corresponding component exposed Metrics url here
- source: Collector alias, recommended to differentiate
- interval: Collection interval
- measurement_prefix: Metrics set prefix, convenient for management and classification
- tls_open: TLS configuration
- metric_types: Metrics types, leaving it blank means collecting all Metrics, it's recommended to fill it according to needs, involving Time Series
- tags_ignore: Ignore unnecessary tags
- [inputs.prom.tags_rename.mapping]: <font color="red">Tag renaming, if there's a conflict between a tag and a field, the tag should be renamed; otherwise, the entire Metrics cannot be collected.</font>
- [inputs.prom.tags] : Set tags, applied to all Metrics of the current Metrics
<!-- markdownlint-enable -->

### Restart DataKit

```shell
systemctl restart datakit
```