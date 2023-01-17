
# logstreaming
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Start an HTTP Server, receive the log text data and report it to Guance Cloud.

HTTP URL is fixed as: `/v1/write/logstreaming`, that is, `http://Datakit_IP:PORT/v1/write/logstreaming`

Note: If DataKit is deployed in Kubernetes as a daemonset, it can be accessed as a Service at `http://datakit-service.datakit:9529`

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and name it `logstreaming.conf`. Examples are as follows:
    
    ```toml
        
    [inputs.logstreaming]
      ignore_url_tags = true
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.logstreaming.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.logstreaming.storage]
        # path = "./log_storage"
        # capacity = 5120
    
    ```

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

### Support Parameter {#args}

logstreaming supports adding parameters to the HTTP URL to manipulate log data. The list of parameters is as follows:

- `type`: Data format, currently only `influxdb` is supported.
  - When `type` is `inflxudb` (`/v1/write/logstreaming?type=influxdb`), the data itself is in row protocol format (default precision is `s`), and only built-in Tags will be added and nothing else will be done
- `source`: Identify the source of the data, that is, the measurement of the line protocol. Such as `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)
  - This value is not valid when `type` is `influxdb`
  - Default is `default`
- `service`: Add a service label field, such as (`/v1/write/logstreaming?service=nginx_service`）
  - Default to `source` parameter value.
- `pipeline`: Specify the pipeline name required for the data, such as `nginx.p`（`/v1/write/logstreaming?pipeline=nginx.p`）
- `tags`: Add custom tags, split by `,`, such as `key1=value1` and `key2=value2`（`/v1/write/logstreaming?tags=key1=value1,key2=value2`)

### Usage {#usage}

- Fluentd uses Influxdb Output [doc](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd uses HTTP Output [doc](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash uses Influxdb Output [doc](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash uses HTTP Output [doc](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Simply configure Output Host as a logstreaming URL (`http://Datakit_IP:PORT/v1/write/logstreaming`）and add corresponding parameters.

## Measurement {#measurement}



### `logstreaming log receive`

For non-line protocol data format, the `source` parameter in the URL is used, and if the value is null, the default is `default`.

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`ip_or_hostname`|request IP or hostname|
|`service`|service name, corresponding to `service` parameter in URL|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`message`|Log body, which exists by default. You can delete this field by pipeline|string|-|

 
