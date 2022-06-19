
# Prometheus Exportor 数据采集
---

- DataKit 版本：1.4.2
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Prom 采集器可以获取各种 Prometheus Exporters 暴露出来的指标数据，只要配置相应的 Exporter 地址，就可以将指标数据接入。

## 前置条件

只能接入 Prometheus 形式的指标数据。

## 配置

进入 DataKit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `prom.conf`。示例如下：

```toml

[[inputs.prom]]
  # Exporter URLs
  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]

  # 忽略对 url 的请求错误
  ignore_req_err = false

  # 采集器别名
  source = "prom"

  # 采集数据输出源
  # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
  # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
  # 如果已经将 url 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
  # output = "/abs/path/to/file"

  # 采集数据大小上限，单位为字节
  # 将数据输出到本地文件时，可以设置采集数据大小上限
  # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
  # 采集数据大小上限默认设置为32MB
  # max_file_size = 0

  # 指标类型过滤, 可选值为 counter, gauge, histogram, summary, untyped
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  # 指标名称筛选：符合条件的指标将被保留下来
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行筛选，所有指标均保留
  # metric_name_filter = ["cpu"]

  # 指标集名称前缀
  # 配置此项，可以给指标集名称添加前缀
  measurement_prefix = ""

  # 指标集名称
  # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
  # 如果配置measurement_name, 则不进行指标名称的切割
  # 最终的指标集名称会添加上measurement_prefix前缀
  # measurement_name = "prom"

  # 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  # TLS 配置
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  # 过滤 tags, 可配置多个tag
  # 匹配的 tag 将被忽略，但对应的数据仍然会上报上来
  # tags_ignore = ["xxxx"]

  # 自定义认证方式，目前仅支持 Bearer Token
  # token 和 token_file: 仅需配置其中一项即可
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"

  # 自定义指标集名称
  # 可以将包含前缀 prefix 的指标归为一类指标集
  # 自定义指标集名称配置优先 measurement_name 配置项
  #[[inputs.prom.measurements]]
  #  prefix = "cpu_"
  #  name = "cpu"

  # [[inputs.prom.measurements]]
  # prefix = "mem_"
  # name = "mem"

  # 对于匹配如下 tag 相关的数据，丢弃这些数据不予采集
  [inputs.prom.ignore_tag_kv_match]
  # key1 = [ "val1.*", "val2.*"]
  # key2 = [ "val1.*", "val2.*"]

  # 重命名 prom 数据中的 tag key
  [inputs.prom.tags_rename]
    overwrite_exist_tags = false
    [inputs.prom.tags_rename.mapping]
    # tag1 = "new-name-1"
    # tag2 = "new-name-2"
    # tag3 = "new-name-3"

  # 自定义Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

### 关于 tag 重命名

> 注意：对于 [DataKit 全局 tag key](datakit-conf#update-global-tag)，此处不支持将它们重命名。

`tags_rename` 可以实现对采集到的 Prometheus Exporter 数据做 tag 名称的替换，里面的 `overwrite_exist_tags` 用于开启覆盖已有 tag 的选项。举个例子，对于已有 Prometheus Exporter 数据：

```
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

## 协议转换说明

由于 Prometheus 的数据格式跟 Influxdb 的行协议格式存在一定的差别。 对 Prometheus 而言，以下为一个 K8s 集群中一段分暴露出来的数据：

```
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

对 Influxdb 而言，上面数据的一种组织方式为

```
node_filesystem,tag-list available_bytes=1.21585664e+08,device_error=0,files=9.223372036854776e+18 time
```

其组织依据是：

- 在 Prometheus 暴露出来的指标中，如果名称前缀都是 `node_filesystem`，那么就将其规约到行协议指标集 `node_filesystem` 上
- 将切割掉前缀的原 Prometheus 指标，都放到指标集 `node_filesystem` 的指标中
- 默认情况下，Prometheus 中的所有 tags（即 `{}` 中的部分）在 Influxdb 的行协议中，都保留下来

要达到这样的切割目的，可以这样配置 `prom.conf`

```
  [[inputs.prom.measurements]]
    prefix = "node_filesystem_"
    name = "node_filesystem"
```

## 命令行调试指标集 

由于 Prometheus 暴露出来的指标非常多，大家不一定需要所有的指标，故 DataKit 提供一个简单的调试 `prom.conf` 的工具，如果不断调整 `prom.conf` 的配置，以达到如下几个目的：

- 只采集符合一定名称规则的 Prometheus 指标
- 只采集部分计量数据（`metric_types`），如 `gauge` 类指标和 `counter` 类指标

Datakit 支持命令行直接调试 prom 采集器的配置文件，从 conf.d/prom 拷贝出一份 prom.conf 模板，填写对应 Exporter 地址，即可通过 DataKit 调试这个 `prom.conf`：

执行如下命令，即可调试 `prom.conf`

```shell
datakit tool --prom-conf prom.conf
```

参数说明：

- `prom-conf`: 指定配置文件，默认在当前目录下寻找 `prom.conf` 文件，如果未找到，会去 `<datakit-install-dir>/conf.d/prom` 目录下查找相应文件。

输出示例：

```
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
