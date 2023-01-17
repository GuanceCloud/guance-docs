
# etcd
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

The tcd collector can take many metrics from the etcd instance, such as the status of the etcd server and network, and collect the metrics to DataFlux to help you monitor and analyze various abnormal situations of etcd.

## Preconditions {#requirements}

- etcd version  >=3

- Open etcd, the default metrics interface is http://localhost:2379/metrics, or you can modify it in your configuration file.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/etcd` directory under the DataKit installation directory, copy `etcd.conf.sample` and name it `etcd.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Exporter address or file path (Exporter address plus network protocol http or https)
      ## File path varies from operating system to operating system
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "http://127.0.0.1:2379/metrics"
    
    	## Collector alias
    	source = "etcd"
    
      ## Metrics type filtering, optional values are counter, gauge, histogram and summary
      # Only counter and gauge metrics are collected by default
      # If empty, no filtering is performed
      metric_types = ["counter", "gauge"]
    
      ## Metrics name filtering
      # Support regular can configure more than one, that is, satisfy one of them
      # If empty, no filtering is performed
      metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]
    
      ## Measurement name prefix
      # Configure this to prefix the measurement name
      measurement_prefix = ""
    
      ## Measurement name
      # By default, the metric name will be cut with an underscore "_". The first field after cutting will be the measurement name, and the remaining fields will be the current metric name
      # If measurement_name is configured, the metric name is not cut
      # The final measurement name is prefixed with measurement_prefix
      # measurement_name = "prom"
    
      ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "10s"
    
      ## Filter tags, configurable multiple tags
      # Matching tags will be ignored
      # tags_ignore = ["xxxx"]
    
      ## TLS Configuration
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Custom measurement name
      # You can group metrics that contain the prefix into one measurement
      # Custom measurement name configuration priority measurement_name configuration items
      [[inputs.prom.measurements]]
        prefix = "etcd_"
        name = "etcd"
    
      ## Custom authentication method, currently only supports Bearer Token
      # [inputs.prom.auth]
      # type = "bearer_token"
      # token = "xxxxxxxx"
      # token_file = "/tmp/token"
    
      ## Custom Tags
    
    
    ```

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}



### `etcd_network`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|hostname|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`network_client_grpc_received_bytes_total`|Total number of bytes received from grpc clients|int|count|
|`network_client_grpc_sent_bytes_total`|Total number of bytes sent to grpc client int|count|



### `etcd_server`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|hostname|
|`server_has_leader`|Whether leaders exist. 1 is existence. 0 does not exist|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`server_leader_changes_seen_total`|Number of leader changes explained|int|count|
|`server_proposals_applied_total`|Total number of consensus proposals applied|int|count|
|`server_proposals_committed_total`|Total number of consensus proposals submitted|int|count|
|`server_proposals_failed_total`|Total number of failed proposals seen|int|count|
|`server_proposals_pending`|Current number of pending proposals|int|count|


