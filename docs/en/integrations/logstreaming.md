---
title     : 'Log Streaming'
summary   : 'Reporting log data via HTTP'
tags:
  - 'LOGS'
__int_icon      : 'icon/logstreaming'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Start an HTTP Server to receive log text data and report it to Guance. The HTTP URL is fixed as: `/v1/write/logstreaming`, i.e., `http://Datakit_IP:PORT/v1/write/logstreaming`

> Note: If DataKit is deployed in Kubernetes as a DaemonSet, you can access it via Service. The address would be `http://datakit-service.datakit:9529`

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`. Example:
    
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, the collector configuration can be enabled through [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Supported Parameters {#args}

Log-Streaming supports adding parameters in the HTTP URL to manipulate log data. The parameter list is as follows:

- `type`: Data format, currently only supports `influxdb` and `firelens`.
    - When `type` is `inflxudb` (`/v1/write/logstreaming?type=influxdb`), this indicates that the data itself is line protocol format (default precision is `s`). It will only add built-in Tags and no other operations will be performed.
    - When `type` is `firelens` (`/v1/write/logstreaming?type=firelens`), the data format should be multiple JSON logs.
    - If this value is empty, the data will be processed with line splitting and Pipeline.
- `source`: Identifies the data source, i.e., the measurement in the line protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)
    - This value is invalid when `type` is `influxdb`
    - Default is `default`
- `service`: Adds a service tag field, for example (`/v1/write/logstreaming?service=nginx_service`)
    - Defaults to the value of the `source` parameter.
- `pipeline`: Specifies the name of the pipeline to be used for the data, for example `nginx.p` (`/v1/write/logstreaming?pipeline=nginx.p`)
- `tags`: Adds custom tags, separated by English commas `,`, for example `key1=value1` and `key2=value2` (`/v1/write/logstreaming?tags=key1=value1,key2=value2`)

#### FireLens Data Source Type {#firelens}

The `log`, `source`, and `date` fields in this type of data will be specially handled. Data example:

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

After extracting the two logs from the list, the `log` will serve as the `message` field of the data, `date` will be converted into the log's timestamp, and `source` will be renamed to `firelens_source`.

### Usage {#usage}

- Fluentd using Influxdb Output [Documentation](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd using HTTP Output [Documentation](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash using Influxdb Output [Documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash using HTTP Output [Documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Simply configure the Output Host as the Log-Streaming URL (`http://Datakit_IP:PORT/v1/write/logstreaming`) and add the corresponding parameters.

## Logs {#logging}



### `default`

Using the `source` field in the configuration file, default is `default`.

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


</example>