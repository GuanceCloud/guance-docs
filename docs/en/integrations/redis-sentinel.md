---
title     : 'Redis Sentinel'
summary   : 'Collect Redis Sentinel Cluster Metrics, Log Information'
__int_icon: 'icon/redis'
dashboard :
  - desc  : 'Redis Sentinel'
    path  : 'dashboard/en/redis_sentinel'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# Redis Sentinel
<!-- markdownlint-enable -->

Redis-sentinel metrics display, including Redis clusters, Slaves, node distribution information, and so on.


## Configuration {#config}


### Download redis-sentinel-exporter metric collector

Download address [https://github.com/lrwh/redis-sentinel-exporter/releases](https://github.com/lrwh/redis-sentinel-exporter/releases)


### Start redis-sentinel-exporter

```bash
java -Xmx64m -jar redis-sentinel-exporter-0.2.jar --spring.redis.sentinel.master=mymaster --spring.redis.sentinel.nodes="127.0.0.1:26379,127.0.0.1:26380,127.0.0.1:26381"
```

Parameter description spring.redis.sentinel.master: Cluster name spring.redis.sentinel.nodes: Sentry node address

### Collector Configuration

#### Metric Collection

- Open the DataKit Prom plug-in and copy the sample file

```bash
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample redis-sentinel-prom.conf
```

- Modify `redis-sentinel-prom.conf` Profile

??? Quote' `redis-sentinel-prom.conf` '
<!-- markdownlint-disable MD046 -->
    ```toml
    # {"version": "1.2.12", "desc": "do NOT edit this line"}

    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://localhost:6390/metrics"]

    ignore_req_err = false

    source = "redis_sentinel"

    metric_types = []

    measurement_name = "redis_sentinel"
    interval = "10s"

    ```
<!-- markdownlint-enable -->


- Restart DataKit (configure log collection to restart if log needs to be turned on)

```bash
systemctl restart datakit
```


## Logging {#logging}

### Configure Collector

- Modify `redis.conf` Profile

```toml

[[inputs.logging]]
  ## required
  logfiles = [
    "D:/software_installer/Redis-x64-3.2.100/log/sentinel_*_log.log",
  ]

  ## glob filteer
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

- Restart DataKit (If you need to turn on custom tags, configure plug-in tags to restart)

```bash
systemctl restart datakit
```

### Configure Pipeline

Log Pipeline Function Cut Field Description

Redis Universal Log Cutting

- The original log is:

```txt
[11412] 05 May 10:17:31.329 # Creating Server TCP listening socket *:26380: bind: No such file or directory
```

- The list of cut fields is as follows:

|Field name| Field value | Description |
| --- | --- | --- |
| `pid`| `122` | process id |
| `role`| `M` | role |
| `service`| `*` | service name |
| `status`| `notice` | log level |
| `message` | `Creating Server TCP listening socket *:26380: bind: No such file or directory`| log content |
| `time` | `1557861100164000000` | Nanosecond timestamp (as line protocol time) |


Restart DataKit

```bash
systemctl restart datakit
```


## Metric {#metric}

|Metric| Description | Data type |
| --- | --- | --- |
|redis_sentinel_known_sentinels| sentinel instance count | Gauge |
|redis_sentinel_known_slaves| cluster slaves instance count | Gauge |
|redis_sentinel_cluster_type| cluster node type  | Gauge |
|redis_sentinel_link_pending_commands| sentinel pending command count | Gauge |
|redis_sentinel_odown_slaves| slave down count | Gauge |
|redis_sentinel_sdown_slaves| slave master down count | Gauge |
|redis_sentinel_ok_slaves|  running slaves | Gauge |
|redis_sentinel_ping_latency| sentinel ping latency | Gauge |
|redis_sentinel_last_ok_ping_latency| sentinel ping ok latency  | Gauge |
| redis_sentinel_node_state  | redis node state     | Gauge |
