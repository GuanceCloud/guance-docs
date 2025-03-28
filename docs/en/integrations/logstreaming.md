---
title     : 'Log Streaming'
summary   : 'Report log data via HTTP'
tags:
  - 'LOG'
__int_icon      : 'icon/logstreaming'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Start an HTTP Server, receive the log text data and report it to <<<custom_key.brand_name>>>.

HTTP URL is fixed as: `/v1/write/logstreaming`, that is, `http://Datakit_IP:PORT/v1/write/logstreaming`

Note: If DataKit is deployed in Kubernetes as a daemonset, it can be accessed as a Service at `http://datakit-service.datakit:9529`

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and name it `logstreaming.conf`. Examples are as follows:
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Support Parameter {#args}

logstreaming supports adding parameters to the HTTP URL to manipulate log data. The list of parameters is as follows:

- `type`: Data format, currently only supports `influxdb` and `firelens`.
    - When `type` is `inflxudb` (`/v1/write/logstreaming?type=influxdb`), the data itself is in row protocol format (default precision is `s`), and only built-in Tags will be added and nothing else will be done
    - When `type` is `firelens` (`/v1/write/logstreaming?type=firelens`), the data format should be multiple logs in JSON format
    - When this value is empty, the data will be processed such as branching and Pipeline
- `source`: Identify the source of the data, that is, the measurement of the line protocol. Such as `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)
    - This value is not valid when `type` is `influxdb`
    - Default is `default`
- `service`: Add a service label field, such as (`/v1/write/logstreaming?service=nginx_service`）
    - Default to `source` parameter value.
- `pipeline`: Specify the Pipeline name required for the data, such as `nginx.p`（`/v1/write/logstreaming?pipeline=nginx.p`）
- `tags`: Add custom tags, split by `,`, such as `key1=value1` and `key2=value2`（`/v1/write/logstreaming?tags=key1=value1,key2=value2`)

#### FireLens data source types {#firelens}

The `log`, `source`, and `date` fields in this type of data will be treated specially. Data example:

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

After extracting the two logs in the list, `log` will be used as the `message` field of the data, `date` will be converted to the time of the log, and `source` will be renamed to `firelens_source`.

### Usage {#usage}

- Fluentd uses Influxdb Output [doc](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd uses HTTP Output [doc](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash uses Influxdb Output [doc](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash uses HTTP Output [doc](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Simply configure Output Host as a logstreaming URL (`http://Datakit_IP:PORT/v1/write/logstreaming`）and add corresponding parameters.

## Metric {#metric}



### `default`

Using `source` field in the config file, default is `default`.

- Tags


| Tag | Description |
|  ----  | --------|
|`ip_or_hostname`|Request IP or hostname.|
|`service`|Service name. Using the `service` parameter in the URL.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Message text, existed when default. Could use Pipeline to delete this field.|string|-|
|`status`|Log status.|string|-|


