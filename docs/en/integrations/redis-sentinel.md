---
title     : 'Redis Sentinel'
summary   : 'Collect Redis Sentinel cluster Metrics and log information'
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

Redis-sentinel Metrics display, including Redis cluster, Slaves, node distribution information, etc.


## Installation and Deployment {#config}

### Download redis-sentinel-exporter Metrics collector

Download address [https://github.com/lrwh/redis-sentinel-exporter/releases](https://github.com/lrwh/redis-sentinel-exporter/releases)


### Start redis-sentinel-exporter

```bash
java -Xmx64m -jar redis-sentinel-exporter-0.2.jar --spring.redis.sentinel.master=mymaster --spring.redis.sentinel.nodes="127.0.0.1:26379,127.0.0.1:26380,127.0.0.1:26381"
```

Parameter explanation
spring.redis.sentinel.master ： Cluster name
spring.redis.sentinel.nodes ： Sentinel node addresses

### Collector Configuration

#### Metrics Collection

- Enable DataKit prom plugin, copy sample file

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample redis-sentinel-prom.conf
```

- Modify `redis-sentinel-prom.conf` configuration file

??? quote "`redis-sentinel-prom.conf`"
<!-- markdownlint-disable MD046 -->
    ```toml
    # {"version": "1.2.12", "desc": "do NOT edit this line"}

    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://localhost:6390/metrics"]

    ## Ignore request errors for the url
    ignore_req_err = false

    ## Collector alias
    source = "redis_sentinel"

    ## Output source for collected data
    # Configuring this item can write the collected data to a local file instead of sending it to the center
    # Afterwards, you can directly use the datakit --prom-conf /path/to/this/conf command to debug the locally saved Measurements
    # If the url has already been configured as a local file path, then the --prom-conf will prioritize debugging the output path data
    # output = "/abs/path/to/file"

    ## Upper limit for the size of the collected data, in bytes
    # When outputting data to a local file, you can set an upper limit for the size of the collected data
    # If the size of the collected data exceeds this upper limit, the collected data will be discarded
    # The default upper limit for the size of the collected data is set to 32MB
    # max_file_size = 0

    ## Metrics type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If left blank, no filtering will occur
    metric_types = []

    ## Metrics name filtering
    # Supports regular expressions, you can configure multiple entries, meaning any one match suffices
    # If left blank, no filtering will occur
    # metric_name_filter = ["cpu"]

    ## Measurement name prefix
    # Configuring this item can add a prefix to the Measurement name
    # measurement_prefix = "redis_sentinel_"

    ## Measurement name
    # By default, the metric name will be split by underscores "_", with the first field after the split becoming the Measurement name and the remaining fields becoming the current metric name
    # If measurement_name is configured, the metric name will not be split
    # The final Measurement name will have the measurement_prefix prefix added
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
    # token and token_file: only one needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## Custom Measurement names
    # Can group metrics containing the prefix prefix into one category of Measurements
    # Custom Measurement name configuration takes precedence over the measurement_name configuration item
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
Main parameter explanations

- urls: `prometheus` Metrics address, fill in the Metrics url exposed by redis-sentinel-exporter here
- source: Collector alias
- interval: Collection interval
- measurement_prefix: Metric prefix, convenient for metric classification queries
- tls_open: TLS configuration
- metric_types: Metric types, leave blank to collect all metrics
- [inputs.prom.tags]: Additional defined tags

- Restart DataKit (if you need to enable logs, configure log collection before restarting)

```bash
systemctl restart datakit
```


## Log Collection {#logging}

### Configure Collector

- Modify `redis.conf` configuration file

```toml

[[inputs.logging]]
  ## required
  logfiles = [
    "D:/software_installer/Redis-x64-3.2.100/log/sentinel_*_log.log",
  ]

  ## glob filter
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "redis-sentinel"

  ## add service tag, if it's empty, use $source.
  service = "redis-sentinel"

  ## grok pipeline script name
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## datakit read text from Files or Socket , default max_textline is 32k
  ## If your log text line exceeds 32Kb, please configure the length of your text, 
  ## but the maximum length cannot exceed 32Mb 
  # maximum_length = 32766

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

  ## if file is inactive, it is ignored
  ## time units are "ms", "s", "m", "h"
  # ignore_dead_log = "1h"

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

Parameter Explanation

```txt
- files: Log file paths (usually access logs and error logs)
- ignore: Filenames to filter out
- pipeline: Log cutting file
- character_encoding: Log encoding format
- match: Enable multi-line log collection
```

- Restart DataKit (if you need to enable custom tags, configure plugin tags before restarting)

```bash
systemctl restart datakit
```

### Configure Pipeline

Log Pipeline function cuts fields explanation

General Redis log cutting

- Original log:

```txt
[11412] 05 May 10:17:31.329 # Creating Server TCP listening socket *:26380: bind: No such file or directory
```

- Field list after cutting:

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


## Metrics Details {#metric}

| Metric | Meaning | Type |
| --- | --- | --- |
| redis_sentinel_known_sentinels | Number of sentinel instances | Gauge |
| redis_sentinel_known_slaves | Number of cluster slave instances | Gauge |
| redis_sentinel_cluster_type | Cluster node type | Gauge |
| redis_sentinel_link_pending_commands | Number of pending commands in sentinel | Gauge |
| redis_sentinel_odown_slaves | Slave objective downtime | Gauge |
| redis_sentinel_sdown_slaves | Slave subjective downtime | Gauge |
| redis_sentinel_ok_slaves | Number of running slaves | Gauge |
| redis_sentinel_ping_latency | Sentinel ping delay shown in milliseconds | Gauge |
| redis_sentinel_last_ok_ping_latency | Seconds since last successful sentinel ping | Gauge |
| redis_sentinel_node_state  | Redis node state     | Gauge |