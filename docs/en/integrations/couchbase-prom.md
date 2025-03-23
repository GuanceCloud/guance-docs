---
title: 'CouchBase Exporter'
summary: 'The collector can obtain many metrics from CouchBase instances, such as memory and disk usage for data, the number of current connections, and various other metrics, and send them to <<< custom_key.brand_name >>> to help monitor and analyze various abnormal situations in CouchBase.'
__int_icon:'icon/couchbase'
dashboard:
  - desc: 'CouchBase built-in views by Exporter'
    path: 'dashboard/en/couchbase_prom'

monitor:
  - desc: 'CouchBase Monitor'
    path: 'monitor/en/couchbase_prom'

---


<!-- markdownlint-disable MD025 -->
# CouchBase
<!-- markdownlint-enable -->


The collector can obtain many metrics from CouchBase instances, such as memory and disk usage for data, the number of current connections, and various other metrics, and send them to <<< custom_key.brand_name >>> to help monitor and analyze various abnormal situations in CouchBase.

## Collector Configuration {#config}

### Prerequisites

#### Version Information

> CouchBase Version: *7.2.0*
> CouchBase Exporter Version: `blakelead/couchbase-exporter:latest`

#### Install CouchBase Exporter

Use CouchBase's client collector, CouchBase Exporter. Collector documentation [address](https://github.com/blakelead/couchbase_exporter)

Note: The username and password used in this article are for the CouchBase Server.

```bash
docker run -d  --name cbexporter                      --publish 9191:9191                      --env EXPORTER_LISTEN_ADDR=:9191                      --env EXPORTER_TELEMETRY_PATH=/metrics                      --env EXPORTER_SERVER_TIMEOUT=10s                      --env EXPORTER_LOG_LEVEL=debug                      --env EXPORTER_LOG_FORMAT=json                      --env EXPORTER_DB_URI=http://172.17.0.92:8091                      --env EXPORTER_DB_TIMEOUT=10s                      --env EXPORTER_DB_USER=Administrator                      --env EXPORTER_DB_PASSWORD=guance.com                      --env EXPORTER_SCRAPE_CLUSTER=true                      --env EXPORTER_SCRAPE_NODE=true                      --env EXPORTER_SCRAPE_BUCKET=true                      --env EXPORTER_SCRAPE_XDCR=false                      blakelead/couchbase-exporter:latest
```

Parameter Introduction:

```txt
|                            |                     |                                                    |                                                 |
| -------------------------- | ------------------- | -------------------------------------------------- | ----------------------------------------------- |
| environment variable       | argument            | description                                        | default                                         |
|                            | -config.file        | Configuration file to load data from               |                                                 |
| EXPORTER_LISTEN_ADDR       | -web.listen-address | Address to listen on for HTTP requests             | :9191                                           |
| EXPORTER_TELEMETRY_PATH    | -web.telemetry-path | Path under which to expose metrics                 | /metrics                                        |
| EXPORTER_SERVER_TIMEOUT    | -web.timeout        | Server read timeout in seconds                     | 10s                                             |
| EXPORTER_DB_URI            | -db.uri             | Address of CouchBase cluster                       | [http://127.0.0.1:8091](http://127.0.0.1:8091/) |
| EXPORTER_DB_TIMEOUT        | -db.timeout         | CouchBase client timeout in seconds                | 10s                                             |
| EXPORTER_TLS_ENABLED       | -tls.enabled        | If true, enable TLS communication with the cluster | false                                           |
| EXPORTER_TLS_SKIP_INSECURE | -tls.skip-insecure  | If true, certificate won't be verified             | false                                           |
| EXPORTER_TLS_CA_CERT       | -tls.ca-cert        | Root certificate of the cluster                    |                                                 |
| EXPORTER_TLS_CLIENT_CERT   | -tls.client-cert    | Client certificate                                 |                                                 |
| EXPORTER_TLS_CLIENT_KEY    | -tls.client-key     | Client private key                                 |                                                 |
| EXPORTER_DB_USER           | *not allowed*       | Administrator username                             |                                                 |
| EXPORTER_DB_PASSWORD       | *not allowed*       | Administrator password                             |                                                 |
| EXPORTER_LOG_LEVEL         | -log.level          | Log level: info,debug,warn,error,fatal             | error                                           |
| EXPORTER_LOG_FORMAT        | -log.format         | Log format: text, `json`                             | text                                            |
| EXPORTER_SCRAPE_CLUSTER    | -scrape.cluster     | If false, wont scrape cluster metrics              | true                                            |
| EXPORTER_SCRAPE_NODE       | -scrape.node        | If false, wont scrape node metrics                 | true                                            |
| EXPORTER_SCRAPE_BUCKET     | -scrape.bucket      | If false, wont scrape bucket metrics               | true                                            |
| EXPORTER_SCRAPE_XDCR       | -scrape.xdcr        | If false, wont scrape `xdcr` metrics                 | false                                           |
|                            | -help               | Command line help                                  |                                                 |
```

### Configuration Implementation

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    - Enable the DataKit Prom plugin, copy the sample file
    
    ```bash
    /usr/local/datakit/conf.d/prom
    cp prom.conf.sample couchbase-prom.conf
    ```
    
    - Modify the `couchbase-prom.conf` configuration file
    
    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = [""]
    
    ## Ignore request errors for url
    ignore_req_err = false
    
    ## Collector alias
    source = "zookeeper"
    
    ## Data collection output source
    # Configure this item to write the collected data to a local file instead of sending it to the center
    # Then you can directly use the `datakit --prom-conf /path/to/this/conf` command to debug the locally saved Metrics
    # If the url is already configured as a local file path, then `--prom-conf` will prioritize debugging the data in the output path
    # output = "/abs/path/to/file"
    > 
    ## Upper limit for the size of collected data, in bytes
    # When outputting data to a local file, you can set an upper limit for the size of the collected data
    # If the size of the collected data exceeds this limit, the collected data will be discarded
    # The default upper limit for the size of the collected data is set to 32MB
    # max_file_size = 0
    
    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering is performed
    metric_types = ["counter", "gauge"]
    
    ## Metric name filtering
    # Supports regular expressions, multiple configurations can be made, i.e., satisfying any one of them is sufficient
    # If empty, no filtering is performed
    # metric_name_filter = ["cpu"]
    
    ## Prefix for Measurement names
    # Configure this item to add a prefix to the Measurement names
    measurement_prefix = ""
    
    ## Measurement name
    # By default, the metric name will be split using underscores "_", with the first field after the split being used as the Measurement name, and the remaining fields as the current metric name
    # If `measurement_name` is configured, the metric name will not be split
    # The final Measurement name will have the `measurement_prefix` added as a prefix
    # measurement_name = "prom"
    
    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"
    
    ## Filter tags, multiple tags can be configured
    # Matching tags will be ignored
    # tags_ignore = ["xxxx"]
    
    ## TLS Configuration
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
    # Metrics containing the prefix `prefix` can be grouped into one Measurement
    # Custom Measurement name configuration takes precedence over `measurement_name`
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"
    
    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"
    
    ## Custom Tags
    [inputs.prom.tags]
    #some_tag = "some_value"
    # more_tag = "some_other_value"
    ```
    
    - Restart DataKit
    
    ```bash
    systemctl restart datakit
    ```

=== "Kubernetes"

    > You can currently enable the collector by injecting its configuration via [ConfigMap](datakit-daemonset-deploy.md#configmap-setting).

<!-- markdownlint-enable -->

## Metrics {#metric}

All data collected below will append a global tag named `host` by default (the tag value is the hostname where DataKit is located), or you can specify other tags through `[inputs.prom.tags]` in the configuration:

```toml
[inputs.prom.tags]
#some_tag = "some_value"
# more_tag = "some_other_value"
```

### Cluster Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

Metrics

| name                            | description          |
| ------------------------------- | -------------------- |
| cluster_rebalance_status    | `Rebalancing` status |

Full list of metrics: [address]( https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#cluster-metrics)

### Node Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

Metrics

| name                                    | description                               |
| --------------------------------------- | ----------------------------------------- |
| node_stats_couch_docs_data_size   | CouchBase documents data size in the node |
| node_stats_get_hits               | Number of get hits                        |
| node_uptime_seconds               | Node uptime                               |
| node_status                      | Status of CouchBase node                  |

Full list of metrics: [address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#node-metrics)

### Bucket Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

Metrics

| name                                  | description                                     |
| ------------------------------------- | ----------------------------------------------- |
| bucket_ram_quota_percent_used  | Memory used by the bucket in percent            |
| bucket_ops_per_second          | Number of operations per second                 |
| bucket_item_count            | Number of items in the bucket                   |
| bucketstats_curr_connections     | Current bucket connections                      |
| bucketstats_delete_hits         | Delete hits                                     |
| bucketstats_disk_write_queue     | Disk write queue depth                          |
| bucketstats_ep_bg_fetched       | Disk reads per second                           |
| bucketstats_ep_mem_high_wat     | Memory usage high water mark for auto-evictions |

Full list of metrics: [address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#bucket-metrics)

### XDCR Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | bucket name                     |
| host     | host name which installed nginx |
| instance | host                            |

Metrics

Full list of metrics: [address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#xdcr-metrics)

## Logs {#logging}

To collect CouchBase logs, follow these steps:

- Enable the DataKit log plugin, copy the sample file

```bash
/usr/local/datakit/conf.d/log
cp logging.conf.sample couchbase-logging.conf
```

> Note: DataKit must be installed on the same host as CouchBase to collect CouchBase logs.

- Modify the `couchbase-prom.conf` configuration file

```toml
# {"version": "1.9.2", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## Required
  ## File names or a pattern to tail.
  logfiles = [
    "/opt/couchbase/var/lib/couchbase/logs/couchdb.log",
  ]

  ## glob filteer
  ignore = [""]

  ## Your logging source, if it's empty, use 'default'.
  source = "couchdb"

  ## Add service tag, if it's empty, use $source.
  service = "couchdb"

  ## Grok pipeline script name.
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''.
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  auto_multiline_detection = true
  auto_multiline_extra_patterns = []

  ## Removes ANSI escape codes from text strings.
  remove_ansi_escape_codes = false

  ## If the data sent failure, will retry forever.
  blocking_mode = true

  ## If file is inactive, it is ignored.
  ## time units are "ms", "s", "m", "h"
  ignore_dead_log = "1h"

  ## Read file from beginning.
  from_beginning = false

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```