---
title     : 'Promtail'
summary   : 'Collect log data reported by Promtail'
tags:
  - 'External Data Integration'
__int_icon      : 'icon/promtail'
dashboard :
  - desc  : 'None available'
    path  : '-'
monitor   :
  - desc  : 'None available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Start an HTTP endpoint to listen and receive Promtail log data, reporting it to <<< custom_key.brand_name >>>.

## Configuration {#config}

Tested versions:

1. [x] 2.8.2
1. [x] 2.0.0
1. [x] 1.5.0
1. [x] 1.0.0
1. [x] 0.1.0

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `promtail.conf.sample`, and rename it to `promtail.conf`. Example:
    
    ```toml
        
    [inputs.promtail]
      ## When processing requests with the legacy version interface,
      ## setting it to true corresponds to the Loki API endpoint /api/prom/push.
      #
      legacy = false
    
      [inputs.promtail.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting collector configurations via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### API Version {#API version}

For versions `v0.3.0` and earlier, configure `legacy = true`, i.e., use [`POST /api/prom/push`](https://grafana.com/docs/loki/latest/api/#post-apiprompush){:target="_blank"}, which uses the Legacy API to handle incoming Promtail log data.

For later versions, use the default configuration, i.e., `legacy = false`, meaning use [`POST /loki/api/v1/push`](https://grafana.com/docs/loki/latest/api/#post-lokiapiv1push){:target="_blank"}.

### Custom Tags {#custom tags}

By configuring `[inputs.promtail.tags]`, custom tags can be added to the log data. Example:

```toml
  [inputs.promtail.tags]
    some_tag = "some_value"
    more_tag = "some_other_value"
```

After configuration, restart DataKit.

### Supported Parameters {#args}

The Promtail collector supports adding parameters in the HTTP URL. The parameter list is as follows:

- `source`: Identifies the source of the data. For example, `nginx` or `redis` (`/v1/write/promtail?source=nginx`). By default, `source` is set to `default`;
- `pipeline`: Specifies the name of the pipeline the data should use, for example, `nginx.p` (`/v1/write/promtail?pipeline=nginx.p`);
- `tags`: Add custom tags, separated by commas `,`, for example, `key1=value1` and `key2=value2` (`/v1/write/promtail?tags=key1=value1,key2=value2`).

### Example {#example}

Promtail's data is originally sent to Loki, i.e., `/loki/api/v1/push`. Modify the `url` in the Promtail configuration to point to DataKit, and after enabling the Promtail collector in DataKit, Promtail will send its data to DataKit's Promtail collector.

Example Promtail configuration:

```yaml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:9529/v1/write/promtail    # Send to the endpoint listened by the promtail collector

scrape_configs:
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: varlogs
          __path__: /var/log/*log
```

## Logs {#logging}

Logs are based on those received from Promtail.