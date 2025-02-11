---
title: 'Prometheus Exporter'
summary: 'Collect metrics data exposed by Prometheus Exporters'
tags:
  - 'External Data Integration'
  - 'PROMETHEUS'
__int_icon: 'icon/prometheus'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Prom collector can obtain various metrics data exposed by Prometheus Exporters. As long as the corresponding Exporter address is configured, the metrics data can be integrated.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and rename it to `prom.conf`. An example is as follows:
    
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
      ## Fill this when want to collect the data to local file or center.
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
    
      ## Customize authentication. For now support Bearer Token only.
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
        # Authorization = "Basic bXl0b21jYXQ="
    
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

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

???+ attention "interval Configuration"

    Collecting metrics from Prometheus can impose some overhead on the target service (HTTP requests). To prevent accidental configurations, the default collection interval is currently set to 30 seconds, and the configuration option is not prominently displayed in the conf file. If you must configure the collection interval, you can add this configuration to the conf:

    ``` toml hl_lines="2"
    [[inputs.prom]]
        interval = "10s"
    ```
<!-- markdownlint-enable -->

### Configure Additional Headers {#extra-header}

The Prom collector supports configuring additional request headers in the HTTP requests for data retrieval (e.g., Basic Authentication):

```toml
  [inputs.prom.http_headers]
    Authorization = “Basic bXl0b21jYXQ="
```

### Tag Renaming {#tag-rename}

> Note: For [global DataKit tag keys](../datakit/datakit-conf.md#update-global-tag), renaming them here is not supported.

`tags_rename` allows renaming tag names in the collected Prometheus Exporter data. The `overwrite_exist_tags` option enables overwriting existing tags. For example, given the following Prometheus Exporter data:

```not-set
http_request_duration_seconds_bucket{le="0.003",status_code="404",tag_exists="yes", method="GET"} 1
```

Assuming the `tags_rename` configuration is as follows:

```toml
[inputs.prom.tags_rename]
  overwrite_exist_tags = true
  [inputs.prom.tags_rename.mapping]
    status_code = "StatusCode",
    method      = "tag_exists", // Rename the `method` tag to an existing tag
```

The final line protocol data will become (ignoring timestamps):

```shell
# Note that `tag_exists` is overwritten with the original `method` value
http,StatusCode=404,le=0.003,tag_exists=GET request_duration_seconds_bucket=1
```

If `overwrite_exist_tags` is disabled, the final data will be:

```shell
# Both `tag_exists` and `method` tags remain unchanged
http,StatusCode=404,le=0.003,method=GET,tag_exists=yes request_duration_seconds_bucket=1
```

Note that tag names are case-sensitive. Use the debugging tool to test data scenarios and decide how to rename tags.

## Metrics {#metric}

Prometheus Exporter exposes a variety of metrics, which should be verified based on actual collected data.

## Protocol Conversion Explanation {#proto-transfer}

Prometheus data format differs from InfluxDB's line protocol format. For example, a segment of data exposed by a K8s cluster in Prometheus format:

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
node_filesystem_files{device="map auto_home",fstype="autof}
```

For InfluxDB, this data can be organized as:

```not-set
node_filesystem,tag-list available_bytes=1.21585664e+08,device_error=0,files=9.223372036854776e+18 time
```

The organization principles are:

- If the metric names in Prometheus start with `node_filesystem`, they are grouped into the `node_filesystem` measurement.
- The original Prometheus metrics, excluding the prefix, are placed into the `node_filesystem` measurement.
- By default, all Prometheus tags (within `{}`) are retained in the InfluxDB line protocol.

To achieve this grouping, configure `prom.conf` as follows:

```toml
  [[inputs.prom.measurements]]
    prefix = "node_filesystem_"
    name = "node_filesystem"
```

## Command Line Debugging {#debug}

Prometheus exposes many metrics, so you may not need all of them. DataKit provides a simple tool to debug `prom.conf` to achieve the following goals:

- Collect only Prometheus metrics that match certain naming rules.
- Collect only specific metric types (`metric_types`), such as `gauge` and `counter`.

To debug `prom.conf`, copy a `prom.conf` template from `conf.d/prom`, fill in the corresponding Exporter address, and run the following command:

```shell
datakit debug --prom-conf prom.conf
```

Parameter description:

- `prom-conf`: Specifies the configuration file. Defaults to searching for `prom.conf` in the current directory; if not found, it looks in *<datakit-install-dir\>/conf.d/prom*.

Output example:

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

Output explanation:

- Line Protocol Points: Generated line protocol points.
- Summary: Summary results
    - Total time series: Number of time series
    - Total line protocol points: Number of line protocol points
    - Total measurements: Number and names of measurements.