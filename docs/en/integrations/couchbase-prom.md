---
title     : 'CouchBase Exporter'
summary   : 'The collector can take many metrics from CouchBase instance, such as the memory and disk used by the data, the number of current connections and other metrics, and collect the metrics into the observation cloud to help monitor and analyze various anomalies in CouchBase. ' 
__int_icon: 'icon/couchbase'
dashboard :
  - desc  : 'CouchBase built-in view by Exporter'
    path  : 'dashboard/zh/couchbase_prom'
monitor   :
  - desc  : 'CouchBase Monitor'
    path  : 'monitor/zh/couchbase_prom'
---


<!-- markdownlint-disable MD025 -->
# CouchBase
<!-- markdownlint-enable -->


The collector can take many metrics from the CouchBase instance, such as the memory and disk used by the data, the number of current connections, and so on, and collect the metrics to the observation cloud to help monitor and analyze various anomalies in CouchBase.

## Collector Configuration{#config}

### Preconditions

#### Version description

> CouchBase Version:*7.2.0*
> CouchBase Exporter Version: `blakelead/couchbase-exporter:latest`

#### Install CouchBase Exporter

Client collector CouchBase Exporter using CouchBase, collector document [Address](https://github.com/blakelead/couchbase_exporter)

Note: The user password used in this article is the user password of CouchBase Server

```bash
docker run -d  --name cbexporter --publish 9191:9191 --env EXPORTER_LISTEN_ADDR=:9191                      --env EXPORTER_TELEMETRY_PATH=/metrics                      --env EXPORTER_SERVER_TIMEOUT=10s                      --env EXPORTER_LOG_LEVEL=debug                      --env EXPORTER_LOG_FORMAT=json                      --env EXPORTER_DB_URI=http://172.17.0.92:8091                      --env EXPORTER_DB_TIMEOUT=10s                      --env EXPORTER_DB_USER=Administrator                      --env EXPORTER_DB_PASSWORD=guance.com                      --env EXPORTER_SCRAPE_CLUSTER=true                      --env EXPORTER_SCRAPE_NODE=true                      --env EXPORTER_SCRAPE_BUCKET=true                      --env EXPORTER_SCRAPE_XDCR=false                      blakelead/couchbase-exporter:latest
```

Parameter description:

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

### Configuration implementation

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ```bash
    /usr/local/datakit/conf.d/prom
    cp prom.conf.sample couchbase-prom.conf
    ```
    
    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = [""]
    
    ignore_req_err = false
    
    source = "zookeeper"
    
    metric_types = ["counter", "gauge"]
    
    measurement_prefix = ""
    
    interval = "10s"
    
    ```
    
    
    ```bash
    systemctl restart datakit
    ```

=== "Kubernetes"



<!-- markdownlint-enable -->

## Metric {#metric}

For all data collection below, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.prom.tags]`:

```toml
[inputs.prom.tags]
#some_tag = "some_value"
# more_tag = "some_other_value"
```

### Cluster metrics

Label

| name     |description|
| -------- | ------------------------------- |
| bucket   |bucket name|
| host     |host name which installed nginx|
| instance |host|

index

|name| description          |
| ------------------------------- | -------------------- |
|cluster_rebalance_status| `Rebalancing` status |

The complete metrics are as follows: [Address]( https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#cluster-metrics)

### Node metrics

Label

| name     |description|
| -------- | ------------------------------- |
| bucket   |bucket name|
| host     |host name which installed nginx|
| instance |host|

index

| name                                    |description|
| --------------------------------------- | ----------------------------------------- |
| node_stats_couch_docs_data_size   |CouchBase documents data size in the node|
| node_stats_get_hits               |Number of get hits|
| node_uptime_seconds               |Node uptime|
| node_status                      |Status of CouchBase node|

The complete metrics are as follows: [Address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#node-metrics)

### Bucket metrics

Label

| name     |description|
| -------- | ------------------------------- |
| bucket   |bucket name|
| host     |host name which installed nginx|
| instance |host|

index

| name                                  |description|
| ------------------------------------- | ----------------------------------------------- |
| bucket_ram_quota_percent_used  |Memory used by the bucket in percent|
| bucket_ops_per_second          |Number of operations per second|
| bucket_item_count            |Number of items in the bucket|
| bucketstats_curr_connections     |Current bucket connections|
| bucketstats_delete_hits         |Delete hits|
| bucketstats_disk_write_queue     |Disk write queue depth|
| bucketstats_ep_bg_fetched       |Disk reads per second|
| bucketstats_ep_mem_high_wat     |Memory usage high water mark for auto-evictions|

The complete metrics are as follows: [address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#bucket-metrics)

### XDCR metrics

Label

| name     |description|
| -------- | ------------------------------- |
| bucket   |bucket name|
| host     |host name which installed nginx|
| instance |host|

index

The complete metrics are as follows: [address](https://github.com/blakelead/couchbase_exporter/blob/master/resources/metrics.md#xdcr-metrics)

## Journal{#logging}

To collect a log of CouchBase, follow these steps:

- Open the DataKit log plug-in and copy the sample file

```bash
/usr/local/datakit/conf.d/log
cp logging.conf.sample couchbase-logging.conf
```

> Note: DataKit must be installed on the host of CouchBase in order to collect CouchBase logs.

- Modify `couchbase-prom.conf` Profile

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

  ## If the data sent failure, will retry forevery.
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

