---
title     : 'Prometheus Exporter'
summary   : '采集 Prometheus Exporter 暴露的指标数据'
tags:
  - '外部数据接入'
  - 'PROMETHEUS'
__int_icon: 'icon/prometheus'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Prom 采集器可以获取各种 Prometheus Exporters 暴露出来的指标数据，只要配置相应的 Exporter 地址，就可以将指标数据接入。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `prom.conf`。示例如下：
    
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
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

???+ attention "interval 的配置"

    Prometheus 的指标采集会对目标服务造成一定的开销（HTTP 请求），为防止意外的配置，采集间隔目前默认为 30s，且配置项没有在 conf 中明显放出来。如果一定要配置采集间隔，可在 conf 中增加该配置：

    ``` toml hl_lines="2"
    [[inputs.prom]]
        interval = "10s"
    ```
<!-- markdownlint-enable -->

### 配置额外的 header {#extra-header}

Prom 采集器支持在数据拉取的 HTTP 请求中配置额外的请求头，（例如 Basic 认证）：

```toml
  [inputs.prom.http_headers]
    Authorization = “Basic bXl0b21jYXQ="
```

### Tag 重命名 {#tag-rename}

> 注意：对于 [DataKit 全局 tag key](../datakit/datakit-conf.md#update-global-tag)，此处不支持将它们重命名。

`tags_rename` 可以实现对采集到的 Prometheus Exporter 数据做 tag 名称的替换，里面的 `overwrite_exist_tags` 用于开启覆盖已有 tag 的选项。举个例子，对于已有 Prometheus Exporter 数据：

```not-set
http_request_duration_seconds_bucket{le="0.003",status_code="404",tag_exists="yes", method="GET"} 1
```

假定这里的 `tags_rename` 配置如下：

```toml
[inputs.prom.tags_rename]
  overwrite_exist_tags = true
  [inputs.prom.tags_rename.mapping]
    status_code = "StatusCode",
    method      = "tag_exists", // 将 `method` 这个 tag 重命名为一个已存在的 tag
```

那么最终的行协议数据会变成（忽略时间戳）：

```shell
# 注意，这里的 tag_exists 被殃及，其值为原 method 的值
http,StatusCode=404,le=0.003,tag_exists=GET request_duration_seconds_bucket=1
```

如果 `overwrite_exist_tags` 禁用，则最终数据为：

```shell
# tag_exists 和 method 这两个 tag 均未发生变化
http,StatusCode=404,le=0.003,method=GET,tag_exists=yes request_duration_seconds_bucket=1
```

注意，这里的 tag 名称是大小写敏感的，可以用下面的调试工具测试一下数据情况，以决定 tag 名称如何替换。

## 指标 {#metric}

Prometheus Exporter 暴露的指标多种多样，以实际采集到的指标为准。

## 协议转换说明 {#proto-transfer}

由于 Prometheus 的数据格式跟 Influxdb 的行协议格式存在一定的差别。 对 Prometheus 而言，以下为一个 K8s 集群中一段分暴露出来的数据：

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

对 Influxdb 而言，上面数据的一种组织方式为

```not-set
node_filesystem,tag-list available_bytes=1.21585664e+08,device_error=0,files=9.223372036854776e+18 time
```

其组织依据是：

- 在 Prometheus 暴露出来的指标中，如果名称前缀都是 `node_filesystem`，那么就将其规约到行协议指标集 `node_filesystem` 上
- 将切割掉前缀的原 Prometheus 指标，都放到指标集 `node_filesystem` 的指标中
- 默认情况下，Prometheus 中的所有 tags（即 `{}` 中的部分）在 Influxdb 的行协议中，都保留下来

要达到这样的切割目的，可以这样配置 `prom.conf`

```toml
  [[inputs.prom.measurements]]
    prefix = "node_filesystem_"
    name = "node_filesystem"
```

## 命令行调试 {#debug}

由于 Prometheus 暴露出来的指标非常多，大家不一定需要所有的指标，故 DataKit 提供一个简单的调试 `prom.conf` 的工具，如果不断调整 `prom.conf` 的配置，以达到如下几个目的：

- 只采集符合一定名称规则的 Prometheus 指标
- 只采集部分计量数据（`metric_types`），如 `gauge` 类指标和 `counter` 类指标

Datakit 支持命令行直接调试 prom 采集器的配置文件，从 conf.d/prom 拷贝出一份 prom.conf 模板，填写对应 Exporter 地址，即可通过 DataKit 调试这个 `prom.conf`：

执行如下命令，即可调试 `prom.conf`

```shell
datakit debug --prom-conf prom.conf
```

参数说明：

- `prom-conf`: 指定配置文件，默认在当前目录下寻找 `prom.conf` 文件，如果未找到，会去 *<datakit-install-dir\>/conf.d/prom* 目录下查找相应文件。

输出示例：

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

输出说明：

- Line Protocol Points： 产生的行协议点
- Summary： 汇总结果
    - Total time series: 时间线数量
    - Total line protocol points: 行协议点数
    - Total measurements: 指标集个数及其名称。
