---
title: 'CouchBase Exporter'
summary: 'The collector can gather many metrics from a CouchBase instance, such as memory and disk usage for data, current number of connections, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in CouchBase.'
__int_icon: 'icon/couchbase'
dashboard:
  - desc: 'Built-in CouchBase views by Exporter'
    path: 'dashboard/en/couchbase_prom'

monitor:
  - desc: 'CouchBase Monitor'
    path: 'monitor/en/couchbase_prom'

---


<!-- markdownlint-disable MD025 -->
# CouchBase
<!-- markdownlint-enable -->


The collector can gather many metrics from a CouchBase instance, such as memory and disk usage for data, current number of connections, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in CouchBase.

## Collector Configuration {#config}

### Prerequisites

#### Version Information

> CouchBase Version: *7.2.0*
> CouchBase Exporter Version: `blakelead/couchbase-exporter:latest`

#### Installing CouchBase Exporter

Use the CouchBase client collector CouchBase Exporter. Refer to the [documentation](https://github.com/blakelead/couchbase_exporter) for the collector.

Note: The username and password used in this document are for the CouchBase Server.

```bash
docker run -d  --name cbexporter                      --publish 9191:9191                      --env EXPORTER_LISTEN_ADDR=:9191                      --env EXPORTER_TELEMETRY_PATH=/metrics                      --env EXPORTER_SERVER_TIMEOUT=10s                      --env EXPORTER_LOG_LEVEL=debug                      --env EXPORTER_LOG_FORMAT=json                      --env EXPORTER_DB_URI=http://172.17.0.92:8091                      --env EXPORTER_DB_TIMEOUT=10s                      --env EXPORTER_DB_USER=Administrator                      --env EXPORTER_DB_PASSWORD=guance.com                      --env EXPORTER_SCRAPE_CLUSTER=true                      --env EXPORTER_SCRAPE_NODE=true                      --env EXPORTER_SCRAPE_BUCKET=true                      --env EXPORTER_SCRAPE_XDCR=false                      blakelead/couchbase-exporter:latest
```

Parameter Description:

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
| EXPORTER_LOG_LEVEL         | -log.level          | Log level: info, debug, warn, error, fatal         | error                                           |
| EXPORTER_LOG_FORMAT        | -log.format         | Log format: text, `json`                           | text                                            |
| EXPORTER_SCRAPE_CLUSTER    | -scrape.cluster     | If false, won't scrape cluster metrics             | true                                            |
| EXPORTER_SCRAPE_NODE       | -scrape.node        | If false, won't scrape node metrics                | true                                            |
| EXPORTER_SCRAPE_BUCKET     | -scrape.bucket      | If false, won't scrape bucket metrics              | true                                            |
| EXPORTER_SCRAPE_XDCR       | -scrape.xdcr        | If false, won't scrape `xdcr` metrics              | false                                           |
|                            | -help               | Command line help                                  |                                                 |
```

### Configuration Implementation

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    - Enable the DataKit Prom plugin and copy the sample file
    
    ```bash
    /usr/local/datakit/conf.d/prom
    cp prom.conf.sample couchbase-prom.conf
    ```
    
    - Modify the `couchbase-prom.conf` configuration file
    
    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = [""]
    
    ## Ignore request errors for URLs
    ignore_req_err = false
    
    ## Collector alias
    source = "zookeeper"
    
    ## Output source for collected data
    # Configure this to write collected data to a local file instead of sending it to the central server
    # You can use the `datakit --prom-conf /path/to/this/conf` command to debug locally saved Mearsurements
    # If the URL is configured as a local file path, the `--prom-conf` option will prioritize debugging the output path data
    # output = "/abs/path/to/file"
    > 
    ## Maximum size limit for collected data, in bytes
    # Set this when outputting data to a local file
    # If the collected data exceeds this limit, it will be discarded
    # Default size limit is 32MB
    # max_file_size = 0
    
    ## Filter metric types, options include counter, gauge, histogram, summary
    # By default, only counter and gauge metrics are collected
    # Leave empty to disable filtering
    metric_types = ["counter", "gauge"]
    
    ## Filter metric names
    # Supports regex, multiple patterns can be configured, matching any one is sufficient
    # Leave empty to disable filtering
    # metric_name_filter = ["cpu"]
    
    ## Prefix for Measurement names
    # Configure this to add a prefix to Measurement names
    measurement_prefix = ""
    
    ## Measurement name
    # By default, the first part of the metric name (split by "_") is used as the Measurement name, and the rest as the metric name
    # If `measurement_name` is configured, no splitting occurs
    # The final Measurement name will include the `measurement_prefix`
    # measurement_name = "prom"
    
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
    # Only configure one of token or token_file
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## Custom Measurement names
    # Metrics with the specified prefix will be grouped into a single Measurement
    # Custom Measurement name takes precedence over `measurement_name` setting
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

    > Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](datakit-daemonset-deploy.md#configmap-setting).


<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (tag value is the hostname where DataKit is installed), additional tags can be specified using `[inputs.prom.tags]`:

```toml
[inputs.prom.tags]
#some_tag = "some_value"
# more_tag = "some_other_value"
```

### Cluster Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | Bucket name                     |
| host     | Host name where nginx is installed |
| instance | Host                            |

Metrics

| name                            | description          |
| ------------------------------- | -------------------- |
| cluster_rebalance_status    | `Rebalancing` status |

Complete metrics list: [Link]( https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#cluster-metrics)

### Node Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | Bucket name                     |
| host     | Host name where nginx is installed |
| instance | Host                            |

Metrics

| name                                    | description                               |
| --------------------------------------- | ----------------------------------------- |
| node_stats_couch_docs_data_size   | Data size of CouchBase documents in the node |
| node_stats_get_hits               | Number of get hits                        |
| node_uptime_seconds               | Node uptime                               |
| node_status                      | Status of CouchBase node                  |

Complete metrics list: [Link](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#node-metrics)

### Bucket Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | Bucket name                     |
| host     | Host name where nginx is installed |
| instance | Host                            |

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

Complete metrics list: [Link](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#bucket-metrics)

### XDCR Metrics

Tags

| name     | description                     |
| -------- | ------------------------------- |
| bucket   | Bucket name                     |
| host     | Host name where nginx is installed |
| instance | Host                            |

Metrics

Complete metrics list: [Link](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#xdcr-metrics)

## Logging {#logging}

To collect logs from CouchBase, follow these steps:

- Enable the DataKit log plugin and copy the sample file

```bash
/usr/local/datakit/conf.d/log
cp logging.conf.sample couchbase-logging.conf
```

> Note: DataKit must be installed on the same host as CouchBase to collect its logs.

- Modify the `couchbase-logging.conf` configuration file

```toml
# {"version": "1.9.2", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## Required
  ## File names or a pattern to tail.
  logfiles = [
    "/opt/couchbase/var/lib/couchbase/logs/couchdb.log",
  ]

  ## glob filter
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