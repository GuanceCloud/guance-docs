---
title     : 'Logstash'
summary   : 'Collect log information via Logstash'
__int_icon: 'icon/logstash'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# Logstash
<!-- markdownlint-enable -->

Collect log information via Logstash.

## Installation and Deployment {#config}

### Enable the `logstreaming` Collector in DataKit

- Enable the `logstreaming` collector

Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample`, and rename it to `logstreaming.conf`.

```toml
[inputs.logstreaming]
  ignore_url_tags = true
```

For a detailed introduction to the `logstreaming` collector, refer to the [official documentation](logstreaming.md)

- Restart DataKit

    [Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Adjust Logstash Configuration

DataKit uses the `logstreaming` collector to collect log information reported by Logstash, so Logstash needs to point its `output` address to the receiving address of the `logstreaming` collector.

```yaml
    ....
## Send collected data to DataKit
output {  
    http {
        http_method => "post"
        format => "json"
        url => "http://127.0.0.1:9529/v1/write/logstreaming?source=nginx"
    }
}
```

- `url`: The address should be the DataKit collector address, adjust according to actual conditions.
- `source`: Identifies the data source, i.e., the `measurement` of the line protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)

For a detailed introduction to the parameters of the `logstreaming` collector, refer to the [official documentation](logstreaming.md#args)

After making adjustments, restart Logstash to apply the configuration changes.