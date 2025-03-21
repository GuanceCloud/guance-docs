---
title     : 'Kong'
summary   : 'Collect Kong metrics and log information'
__int_icon: 'icon/kong'
dashboard :
  - desc  : 'Kong overview'
    path  : 'dashboard/en/kong'
  - desc  : 'Kong API overview'
    path  : 'dashboard/en/kong_api'
monitor   :
  - desc  : 'Kong'
    path  : 'monitor/en/kong'
---

### Collect Kong Metrics and Log Information

<!-- markdownlint-disable MD046 MD010 MD024-->
## Metrics {#metrics}

### 1. Kong Configuration

To collect metrics from Kong, the Prometheus plugin must be enabled. It is recommended to configure it globally. Refer to the [official Kong documentation](https://docs.konghq.com/gateway/latest/production/monitoring/prometheus/) for details.

#### Through Kong Manager

Log in to `Kong Manager`, click on the `Plugins` menu, and add `Prometheus`.

#### Through Kong API

```shell
curl -X POST http://localhost:8001/plugins \
    --header "accept: application/json" \
    --header "Content-Type: application/json" \
    --data '
    {
  "name": "prometheus",
  "config": {
    "per_consumer": true,
    "status_code_metrics" : true,
    "bandwidth_metrics": true
  }
}'
```

### 2. DataKit Configuration

- Navigate to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and rename it to `kong.conf`

> cp prom.conf.sample kong.conf

- Modify `kong.conf`

Only adjust the following two parameters; keep the rest unchanged:

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:10249/metrics"]
  keep_exist_metric_name = true
```

- Restart DataKit

Run the following command:

```shell
datakit service -R
```

### 3. Kong Metrics Set

| Metric Name | Unit | Description |
| --- | --- | --- |
| kong_bandwidth_bytes | bytes | Bandwidth usage of Kong, in bytes |
| kong_datastore_reachable | - | Status metric indicating if the datastore is reachable |
| kong_http_requests_total | count | Total number of HTTP requests |
| kong_kong_latency_ms_bucket | ms | Histogram bucket for Kong's own latency, in milliseconds |
| kong_kong_latency_ms_count | count | Count for Kong's own latency |
| kong_kong_latency_ms_sum | ms | Sum of Kong's own latency, in milliseconds |
| kong_latency_ms_bucket | ms | Histogram bucket for request latency, in milliseconds |
| kong_latency_ms_count | count | Count for request latency |
| kong_latency_ms_sum | ms | Sum of request latency, in milliseconds |
| kong_memory_lua_shared_dict_bytes | bytes | Memory used by Lua shared dictionaries, in bytes |
| kong_memory_lua_shared_dict_total_bytes | bytes | Total memory of Lua shared dictionaries, in bytes |
| kong_memory_workers_lua_vms_bytes | bytes | Memory used by Lua VMs in worker processes, in bytes |
| kong_nginx_connections_total | count | Total number of Nginx connections |
| kong_nginx_metric_errors_total | count | Total number of Nginx metric errors |
| kong_nginx_requests_total | count | Total number of Nginx requests |
| kong_node_info | - | Node information |
| kong_request_latency_ms_bucket | ms | Histogram bucket for request latency, in milliseconds |
| kong_request_latency_ms_count | count | Count for request latency |
| kong_request_latency_ms_sum | ms | Sum of request latency, in milliseconds |
| kong_upstream_latency_ms_bucket | ms | Histogram bucket for upstream latency, in milliseconds |
| kong_upstream_latency_ms_count | count | Count for upstream latency |
| kong_upstream_latency_ms_sum | ms | Sum of upstream latency, in milliseconds |

## Logs {#Logging}

### 1. Kong Configuration

To collect log data from Kong, the `TCP Log` plugin must be enabled.

#### Through Kong Manager

Log in to `Kong Manager`, click on the `Plugins` menu, and add `TCP Log`.

Parameter descriptions:

- host: DataKit host
- port: DataKit log socket port

#### Through Kong API

```shell
curl -X POST http://localhost:8001/plugins \
    --header "accept: application/json" \
    --header "Content-Type: application/json" \
    --data '
    {
  "name": "tcp-log",
  "config": {
    "port": 9580,
    "host" : "<datakit-host>"
  }
}'
```

### 2. DataKit Configuration

- Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and rename it to `kong-socket.conf`

> cp logging.conf.sample kong-socket.conf

- Modify `kong-socket.conf`

You can replace the entire content with the following:


```toml
# {"version": "1.22.0", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## Required
  ## File names or a pattern to tail.

  # Only two protocols are supported:TCP and UDP.
  sockets = [
  	 "tcp://0.0.0.0:9580",
  #	 "udp://0.0.0.0:9531",
  ]
  ## glob filteer
  ignore = [""]

  ## Your logging source, if it's empty, use 'default'.
  source = "kong_tcp_log"

  ## Add service tag, if it's empty, use $source.
  service = ""

  ## Grok pipeline script name.
  pipeline = ""

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16be", "gbk", "gb18030" or ""
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

- Restart DataKit

Run the following command:

```shell
datakit service -R
```

<!-- markdownlint-enable -->

### Pipeline

The Pipeline can be used to extract fields from logs. Kong reports JSON-formatted logs via `tcp-log`. The rules are as follows:


```python

kong_log_json = load_json(_)

add_key("url", kong_log_json["request"]["url"])
add_key("uri", kong_log_json["request"]["uri"])
add_key("method", kong_log_json["request"]["method"])
add_key("code", kong_log_json["response"]["status"])

add_key("kong_route", kong_log_json["route"]["name"])
add_key("kong_service", kong_log_json["service"]["name"])
add_key("client_ip", kong_log_json["client_ip"])
add_key("trace_id", kong_log_json["request"]["headers"]["traceparent"])
grok(trace_id, "%{DATA}-%{DATA:trace_id}-%{DATA}") 

add_key("status", "ok")

```

Adjustments can be made according to actual requirements.
