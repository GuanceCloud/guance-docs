---
title     : 'Prometheus Exporter'
summary   : 'Collect metrics exposed by Prometheus Exporter'
__int_icon      : 'icon/prometheus'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Prometheus Exporter Data Collection
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Prom collector can obtain all kinds of metric data exposed by Prometheus Exporters, so long as the corresponding Exporter address is configured, the metric data can be accessed.

## Configuration {#config}

### Preconditions {#requirements}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
Only metric data in Prometheus form can be accessed.
=== "Host Installation"

    Go to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and name it `prom.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
    
      ## Stream Size. 
      ## The source stream segmentation size, (defaults to 1).
      ## 0 source stream undivided. 
      # stream_size = 1
    
      ## Unix Domain Socket URL. Using socket to request data when not empty.
      uds_path = ""
    
      ## Ignore URL request errors.
      ignore_req_err = false
    
      ## Collector alias.
      source = "prom"
    
      ## Collect data output.
      ## Fill this when want to collect the data to local file nor center.
      ## After filling, could use 'datakit debug --prom-conf /path/to/this/conf' to debug local storage measurement set.
      ## Using '--prom-conf' when priority debugging data in 'output' path.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      ## Only available when set output to local file.
      ## If collect data exceeded the limit, the data would be dropped.
      ## Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      ## Example: metric_types = ["counter", "gauge"], only collect 'counter' and 'gauge'.
      ## Default collect all.
      # metric_types = []
    
      ## Metrics name whitelist.
      ## Regex supported. Multi supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Metrics name blacklist.
      ## If a word both in blacklist and whitelist, blacklist priority.
      ## Regex supported. Multi supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter_ignore = ["foo","bar"]
    
      ## Measurement prefix.
      ## Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If measurement_name is not empty, using this as measurement set name.
      ## Always add 'measurement_prefix' prefix at last.
      # measurement_name = "prom"
    
      ## Keep Exist Metric Name
      ## If the keep_exist_metric_name is true, keep the raw value for field names.
      keep_exist_metric_name = false
    
      ## TLS config
      # insecure_skip_verify = true
      ## Following ca_certs/cert/cert_key are optional, if insecure_skip_verify = true.
      # ca_certs = ["/opt/tls/ca.crt"]
      # cert = "/opt/tls/client.root.crt"
      # cert_key = "/opt/tls/client.root.key"
      ## we can encode these file content in base64 format:
      # ca_certs_base64 = ["LONG_BASE64_STRING......"]
      # cert_base64 = "LONG_BASE64_STRING......"
      # cert_key_base64 = "LONG_BASE64_STRING......"
      # server_name = "your-SNI-name"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## disable setting host tag for this input
      disable_host_tag = false
    
      ## disable setting instance tag for this input
      disable_instance_tag = false
    
      ## disable info tag for this input
      disable_info_tag = false
    
      ## Ignore tags. Multi supported.
      ## The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize authentification. For now support Bearer Token only.
      ## Filling in 'token' or 'token_file' is acceptable.
      # [inputs.prom.auth]
        # type = "bearer_token"
        # token = "xxxxxxxx"
        # token_file = "/tmp/token"
    
      ## Customize measurement set name.
      ## Treat those metrics with prefix as one set.
      ## Prioritier over 'measurement_name' configuration.
      [[inputs.prom.measurements]]
        prefix = "etcd_network_"
        name = "etcd_network"
        
      [[inputs.prom.measurements]]
        prefix = "etcd_server_"
        name = "etcd_server"
    
      ## Not collecting those data when tag matched.
      # [inputs.prom.ignore_tag_kv_match]
        # key1 = [ "val1.*", "val2.*"]
        # key2 = [ "val1.*", "val2.*"]
    
      ## Add HTTP headers to data pulling (Example basic authentication).
      # [inputs.prom.http_headers]
        # Authorization = “Basic bXl0b21jYXQ="
    
      ## Rename tag key in prom data.
      [inputs.prom.tags_rename]
        overwrite_exist_tags = false
    
      # [inputs.prom.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
        # tag3 = "new-name-3"
    
      ## Send collected metrics to center as log.
      ## When 'service' field is empty, using 'service tag' as measurement set name.
      [inputs.prom.as_logging]
        enable = false
        service = "service_name"
    
      ## Customize tags.
      # [inputs.prom.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
      ## (Optional) Timeout: (defaults to "30s").
      # timeout = "30s"
    
    ```
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

???+ attention "Configuration of interval"

    Prometheus' metrics collection will cause some overhead (HTTP request) to the target service. To prevent unexpected configuration, the collection interval is currently 30s by default, and the configuration items are not obviously released in conf. If you must configure the collection interval, you can add this configuration in conf:

    ``` toml hl_lines="2"
    [[inputs.prom]]
        interval = "10s"
    ```
<!-- markdownlint-enable -->
### Configure Extra header {#extra-header}

The Prom collector supports configuring additional request headers in HTTP requests for data pull, (Example basic authentication):

```toml
  [inputs.prom.http_headers]
  Root = "passwd"
  Michael = "1234"
```

### About Tag Renaming {#tag-rename}

> Note: For [DataKit global tag key](datakit-conf#update-global-tag), renaming them is not supported here.

`tags_rename` can replace the tag name of the collected Prometheus Exporter data, and `overwrite_exist_tags` is used to open the option of overwriting existing tags. For example, for existing Prometheus Exporter data:

```not-set
http_request_duration_seconds_bucket{le="0.003",status_code="404",tag_exists="yes", method="GET"} 1
```

Assume that the `tags_rename` configuration here is as follows:

```toml
[inputs.prom.tags_rename]
  overwrite_exist_tags = true
  [inputs.prom.tags_rename.mapping]
    status_code = "StatusCode",
    method      = "tag_exists", // 将 `method` 这个 tag 重命名为一个已存在的 tag
```

Then the final line protocol data will become (ignoring the timestamp):

```shell
# Note that tag_exists is affected here, and its value is the value of the original method
http,StatusCode=404,le=0.003,tag_exists=GET request_duration_seconds_bucket=1
```

If `overwrite_exist_tags` is disabled, the final data is:

```shell
# Neither tag_exists nor method has changed
http,StatusCode=404,le=0.003,method=GET,tag_exists=yes request_duration_seconds_bucket=1
```

Note that the tag name here is case-sensitive, and you can test the data with the following debugging tool to determine how to replace the tag name.

## Protocol Conversion Description {#proto-transfer}

Because the data format of Prometheus is different from the line protocol format of Influxdb. For Prometheus, the following is a piece of data exposed in a K8s cluster:

```not-set
node_filesystem_avail_bytes{device="/dev/disk1s1",fstype="apfs",mountpoint="/"} 1.21585664e+08
node_filesystem_avail_bytes{device="/dev/disk1s4",fstype="apfs",mountpoint="/private/var/vm"} 1.2623872e+08
node_filesystem_avail_bytes{device="/dev/disk3s1",fstype="apfs",mountpoint="/Volumes/PostgreSQL 13.2-2"} 3.7269504e+07
node_filesystem_avail_bytes{device="/dev/disk5s1",fstype="apfs",mountpoint="/Volumes/Git 2.15.0 Mavericks Intel Universal"} 1.2808192e+07
node_filesystem_avail_bytes{device="map -hosts",fstype="autofs",mountpoint="/net"} 0
node_filesystem_avail_bytes{device="map auto_home",fstype="autofs",mountpoint="/home"} 0
# HELP node_filesystem_device_error Whether an error occurred while getting statistics for the given device.
# TYPE node_filesystem_device_error gauge
node_filesystem_device_error{device="/dev/disk1s1",fstype="apfs",mountpoint="/"} 0
node_filesystem_device_error{device="/dev/disk1s4",fstype="apfs",mountpoint="/private/var/vm"} 0
node_filesystem_device_error{device="/dev/disk3s1",fstype="apfs",mountpoint="/Volumes/PostgreSQL 13.2-2"} 0
node_filesystem_device_error{device="/dev/disk5s1",fstype="apfs",mountpoint="/Volumes/Git 2.15.0 Mavericks Intel Universal"} 0
node_filesystem_device_error{device="map -hosts",fstype="autofs",mountpoint="/net"} 0
node_filesystem_device_error{device="map auto_home",fstype="autofs",mountpoint="/home"} 0
# HELP node_filesystem_files Filesystem total file nodes.
# TYPE node_filesystem_files gauge
node_filesystem_files{device="/dev/disk1s1",fstype="apfs",mountpoint="/"} 9.223372036854776e+18
node_filesystem_files{device="/dev/disk1s4",fstype="apfs",mountpoint="/private/var/vm"} 9.223372036854776e+18
node_filesystem_files{device="/dev/disk3s1",fstype="apfs",mountpoint="/Volumes/PostgreSQL 13.2-2"} 9.223372036854776e+18
node_filesystem_files{device="/dev/disk5s1",fstype="apfs",mountpoint="/Volumes/Git 2.15.0 Mavericks Intel Universal"} 9.223372036854776e+18
node_filesystem_files{device="map -hosts",fstype="autofs",mountpoint="/net"} 0
node_filesystem_files{device="map auto_home",fstype="autof
```

For Influxdb, one way to organize the above data is

```not-set
node_filesystem,tag-list available_bytes=1.21585664e+08,device_error=0,files=9.223372036854776e+18 time
```

Its organizational basis is:

- In Prometheus exposed metrics, if the name prefix is `node_filesystem`, then it is specified on the line protocol measurement `node_filesystem`.
- Place the original Prometheus metrics with their prefixes cut off into the metrics of the measurement `node_filesystem`.
- By default, all tags in Prometheus (that is, parts in `{}` )remain in the row protocol of Influxdb

To achieve this cutting purpose, you can configure `prom.conf` as follows

```not-set
  [[inputs.prom.measurements]]
    prefix = "node_filesystem_"
    name = "node_filesystem"
```

## Command Line Debug Measurement {#debug}

Because Prometheus exposes a lot of metrics, you don't necessarily need all of them, so DataKit provides a simple tool to debug `prom.conf` . If you constantly adjust the configuration of `prom.conf`, you can achieve the following purposes:

- Only Prometheus metrics that meet certain name rules are collected
- Collect only partial measurement data (`metric_types`), such as `gauge` type indicators and `counter` type metrics

DataKit supports debugging the configuration file of prom collector directly from the command line, copying a prom.conf template from conf.d/prom, filling in the corresponding Exporter address, and debugging this `prom.conf` through DataKit:

Debug `prom.conf` by executing the following command

```shell
datakit debug --prom-conf prom.conf
```

Parameter description:

- `prom-conf`: Specifies the configuration file. By default, it looks for the `prom.conf` file in the current directory. If it is not found, it will look for the corresponding file in the *<datakit-install-dir\>/conf.d/prom* directory.

Output sample:

```not-set
================= Line Protocol Points ==================

 prom_node,device=disk0 disk_written_sectors_total=146531.087890625 1623379432917573000
 prom_node,device=disk2 disk_written_sectors_total=0 1623379432917573000
 prom_node,device=disk4 disk_written_sectors_total=0 1623379432917573000
 prom_node memory_total_bytes=8589934592 1623379432917573000
 prom_node,device=XHC20 network_transmit_bytes_total=0 1623379432917573000
 prom_node,device=awdl0 network_transmit_bytes_total=1527808 1623379432917573000
 prom_node,device=bridge0 network_transmit_bytes_total=0 1623379432917573000
 prom_node,device=en0 network_transmit_bytes_total=2847181824 1623379432917573000
 prom_node,device=en1 network_transmit_bytes_total=0 1623379432917573000
 prom_node,device=en2 network_transmit_bytes_total=0 1623379432917573000
 prom_node,device=gif0 network_transmit_bytes_total=0 1623379432917573000
 prom_node,device=lo0 network_transmit_bytes_total=6818923520 1623379432917573000
 prom_node,device=p2p0 network_transmit_bytes_total=0 1623379432917573000
 ....
================= Summary ==================

Total time series: 58
Total line protocol points: 261
Total measurements: 3 (prom_node, prom_go, prom_promhttp)
```

Output description:

- Line Protocol Points: Generated line protocol points
- Summary: Summary results
    - Total time series: Number of timelines
    - Total line protocol points: Line protocol points
    - Total measurements: Number of measurements and their names.
