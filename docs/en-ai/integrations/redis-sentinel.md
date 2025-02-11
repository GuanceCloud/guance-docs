---
title     : 'Redis Sentinel'
summary   : 'Collect metrics and log information from Redis Sentinel clusters'
__int_icon: 'icon/redis'
dashboard :
  - desc  : 'Redis-sentinel monitoring view'
    path  : 'dashboard/en/redis_sentinel'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Redis Sentinel
<!-- markdownlint-enable -->

Display of Redis-sentinel metrics, including Redis cluster, Slaves, node distribution information, etc.

## Installation and Deployment {#config}

### Download the redis-sentinel-exporter Metrics Collector

Download address [https://github.com/lrwh/redis-sentinel-exporter/releases](https://github.com/lrwh/redis-sentinel-exporter/releases)

### Start redis-sentinel-exporter

```bash
java -Xmx64m -jar redis-sentinel-exporter-0.2.jar --spring.redis.sentinel.master=mymaster --spring.redis.sentinel.nodes="127.0.0.1:26379,127.0.0.1:26380,127.0.0.1:26381"
```

Parameter description:
- `spring.redis.sentinel.master`: Cluster name
- `spring.redis.sentinel.nodes`: Sentinel node addresses

### Collector Configuration

#### Metrics Collection

- Enable the DataKit prom plugin and copy the sample file

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample redis-sentinel-prom.conf
```

- Modify the `redis-sentinel-prom.conf` configuration file

??? quote "`redis-sentinel-prom.conf`"
<!-- markdownlint-disable MD046 -->
    ```toml
    # {"version": "1.2.12", "desc": "do NOT edit this line"}

    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://localhost:6390/metrics"]

    ## Ignore request errors for URLs
    ignore_req_err = false

    ## Collector alias
    source = "redis_sentinel"

    ## Output source for collected data
    # Configuring this can write collected data to a local file instead of sending it to the center
    # You can then use the command `datakit --prom-conf /path/to/this/conf` to debug locally saved Mearsurement sets
    # If the URL is configured as a local file path, the `--prom-conf` command will prioritize debugging the data in the output path
    # output = "/abs/path/to/file"

    ## Maximum size limit for collected data, in bytes
    # When outputting data to a local file, you can set a maximum size limit for the collected data
    # If the size of the collected data exceeds this limit, the data will be discarded
    # The default maximum size limit is set to 32MB
    # max_file_size = 0

    ## Metric type filter, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If left empty, no filtering is performed
    metric_types = []

    ## Metric name filter
    # Supports regex, multiple configurations can be made, i.e., matching any one of them is sufficient
    # If left empty, no filtering is performed
    # metric_name_filter = ["cpu"]

    ## Prefix for Mearsurement names
    # Configuring this can add a prefix to the Mearsurement names
    # measurement_prefix = "redis_sentinel_"

    ## Mearsurement name
    # By default, the metric name will be split by underscores "_", with the first segment becoming the Mearsurement name and the remaining segments becoming the current metric name
    # If `measurement_name` is configured, the metric name will not be split
    # The final Mearsurement name will include the `measurement_prefix` prefix
    measurement_name = "redis_sentinel"

    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"

    ## Filter tags, multiple tags can be configured
    # Matching tags will be ignored
    # tags_ignore = ["xxxx"]

    ## TLS configuration
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"

    ## Custom authentication method, currently only supports Bearer Token
    # Only one of `token` or `token_file` needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## Custom Mearsurement names
    # Metrics containing the prefix `prefix` can be grouped into one Mearsurement set
    # Custom Mearsurement name configuration takes precedence over the `measurement_name` option
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"

    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"

    ## Custom Tags
    [inputs.prom.tags]
    # some_tag = "some_value"
      # more_tag = "some_other_value"

    ```
<!-- markdownlint-enable -->
Key parameter descriptions:

- `urls`: Prometheus metrics address, fill in the URL exposed by redis-sentinel-exporter
- `source`: Collector alias
- `interval`: Collection interval
- `measurement_prefix`: Metric prefix for easier classification and querying
- `tls_open`: TLS configuration
- `metric_types`: Metric types, leaving it empty means collecting all metrics
- `[inputs.prom.tags]`: Additional defined tags

- Restart DataKit (if you need to enable logging, configure log collection before restarting)

```bash
systemctl restart datakit
```

## Log Collection {#logging}

### Configure the Collector

- Modify the `redis.conf` configuration file

```toml

[[inputs.logging]]
  ## required
  logfiles = [
    "D:/software_installer/Redis-x64-3.2.100/log/sentinel_*_log.log",
  ]

  ## glob filter
  ignore = [""]

  ## Your logging source, if it's empty, use 'default'
  source = "redis-sentinel"

  ## Add service tag, if it's empty, use `$source`.
  service = "redis-sentinel"

  ## Grok pipeline script name
  pipeline = ""

  ## Optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## Optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## Datakit reads text from files or sockets, default max_textline is 32k
  ## If your log text line exceeds 32Kb, please configure the length of your text,
  ## but the maximum length cannot exceed 32Mb
  # maximum_length = 32766

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## Removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

  ## If a file is inactive, it is ignored
  ## Time units are "ms", "s", "m", "h"
  # ignore_dead_log = "1h"

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

Parameter descriptions:

```txt
- `files`: Log file paths (usually access logs and error logs)
- `ignore`: Files to filter out
- `pipeline`: Log splitting file
- `character_encoding`: Log encoding format
- `match`: Enable multi-line log collection
```

- Restart DataKit (if you need to enable custom tags, configure plugin tags before restarting)

```bash
systemctl restart datakit
```

### Configure Pipeline

Log Pipeline functionality for field splitting

General Redis log splitting

- Original log:

```txt
[11412] 05 May 10:17:31.329 # Creating Server TCP listening socket *:26380: bind: No such file or directory
```

- Split fields list:

| Field Name | Field Value | Description |
| --- | --- | --- |
| `pid` | `122` | Process ID |
| `role` | `M` | Role |
| `service` | `*` | Service |
| `status` | `notice` | Log level |
| `message` | `Creating Server TCP listening socket *:26380: bind: No such file or directory` | Log content |
| `time` | `1557861100164000000` | Nanosecond timestamp (as line protocol time) |

Restart DataKit

```bash
systemctl restart datakit
```

## Metric Details {#metric}

| Metric | Meaning | Type |
| --- | --- | --- |
| `redis_sentinel_known_sentinels` | Number of sentinel instances | Gauge |
| `redis_sentinel_known_slaves` | Number of cluster slave instances | Gauge |
| `redis_sentinel_cluster_type` | Cluster node type | Gauge |
| `redis_sentinel_link_pending_commands` | Number of pending commands on sentinels | Gauge |
| `redis_sentinel_odown_slaves` | Objectively down slaves | Gauge |
| `redis_sentinel_sdown_slaves` | Subjectively down slaves | Gauge |
| `redis_sentinel_ok_slaves` | Number of running slaves | Gauge |
| `redis_sentinel_ping_latency` | Latency of sentinel pings in milliseconds | Gauge |
| `redis_sentinel_last_ok_ping_latency` | Seconds since last successful sentinel ping | Gauge |
| `redis_sentinel_node_state` | Redis node state | Gauge |