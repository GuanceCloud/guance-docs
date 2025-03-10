---
title     : 'Log Streaming'
summary   : 'Submit log data via HTTP'
tags:
  - 'Logs'
__int_icon      : 'icon/logstreaming'
dashboard :
  - desc  : 'None'
    path  : '-'
monitor   :
  - desc  : 'None'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Start an HTTP Server to receive log text data and submit it to Guance. The HTTP URL is fixed at `/v1/write/logstreaming`, i.e., `http://Datakit_IP:PORT/v1/write/logstreaming`.

> Note: If DataKit is deployed as a DaemonSet in Kubernetes, you can access it using the Service method, with the address being `http://datakit-service.datakit:9529`

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`. An example configuration is as follows:
    
    ```toml
        
    [inputs.logstreaming]
      ignore_url_tags = false
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.logstreaming.threads]
      #   buffer = 100
      #   threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.logstreaming.storage]
      #   path = "./log_storage"
      #   capacity = 5120
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Supported Parameters {#args}

Log-Streaming supports adding parameters to the HTTP URL to manipulate log data. The parameter list is as follows:

- `type`: Data format, currently supports `influxdb` and `firelens`.
    - When `type` is `influxdb` (e.g., `/v1/write/logstreaming?type=influxdb`), this indicates that the data is in line protocol format (default precision is `s`). Only built-in Tags will be added; no other operations will be performed.
    - When `type` is `firelens` (`/v1/write/logstreaming?type=firelens`), the data should be in JSON format, containing multiple log entries.
    - If this value is empty, the data will be processed for splitting lines and Pipeline operations.
- `source`: Identifies the data source, which corresponds to the measurement in the line protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`).
    - This parameter is ignored when `type` is `influxdb`.
    - Defaults to `default`.
- `service`: Adds a service tag field, e.g., (`/v1/write/logstreaming?service=nginx_service`).
    - Defaults to the value of the `source` parameter.
- `pipeline`: Specifies the pipeline name to be used for processing the data, e.g., `nginx.p` (`/v1/write/logstreaming?pipeline=nginx.p`).
- `tags`: Adds custom tags, separated by commas `,`, e.g., `key1=value1` and `key2=value2` (`/v1/write/logstreaming?tags=key1=value1,key2=value2`).

#### FireLens Data Source Type {#firelens}

For this type of data, the `log`, `source`, and `date` fields are specially handled. Data example:

```json
[
  {
    "date": 1705485197.93957,
    "container_id": "xxxxxxxxxxx-xxxxxxx",
    "container_name": "nginx_demo",
    "source": "stdout",
    "log": "127.0.0.1 - - [19/Jan/2024:11:49:48 +0800] \"GET / HTTP/1.1\" 403 162 \"-\" \"curl/7.81.0\"",
    "ecs_cluster": "Cluster_demo"
  },
  {
    "date": 1705485197.943546,
    "container_id": "f68a9aeb3d64493595e89f8821fa3f86-4093234565",
    "container_name": "javatest",
    "source": "stdout",
    "log": "2024/01/19 11:49:48 [error] 1316#1316: *1 directory index of \"/var/www/html/\" is forbidden, client: 127.0.0.1, server: _, request: \"GET / HTTP/1.1\", host: \"localhost\"",
    "ecs_cluster": "Cluster_Demo"
  }
]
```

After extracting the two log entries from the list, the `log` field will become the `message` field of the data, the `date` will be converted to the log's timestamp, and the `source` will be renamed to `firelens_source`.

### Usage {#usage}

- Fluentd using Influxdb Output [documentation](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd using HTTP Output [documentation](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash using Influxdb Output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash using HTTP Output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Simply configure the Output Host to the Log-Streaming URL (`http://Datakit_IP:PORT/v1/write/logstreaming`) and add the corresponding parameters.

## Logging {#logging}

### `default`

Using the `source` field in the config file, default is `default`.

- Tags


| Tag | Description |
|  ----  | --------|
|`ip_or_hostname`|Request IP or hostname.|
|`service`|Service name. Using the `service` parameter in the URL.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Message text, exists when default. Can use Pipeline to delete this field.|string|-|
|`status`|Log status.|string|-|