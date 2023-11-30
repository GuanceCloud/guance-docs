---
title     : 'Logstash'
summary   : 'Collecting logging through Logstash'
__int_icon: 'icon/logstash'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# Logstash
<!-- markdownlint-enable -->

Collecting logging through Logstash.

## Configuration {#config}

### DataKit enable the `logstreaming` collector

- Enable `logstreaming` collector

Open the DataKit `logstreaming` plug-in and copy the sample file , Rename it `logstreaming.conf`.

```toml
[inputs.logstreaming]
  ignore_url_tags = true
```

For a detailed introduction to the `logstreaming` collector, please refer to [the official document](logstreaming.md)

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


### Logstash configuration adjustment

DataKit uses the `logstreaming` collector to collect log information reported by Logstash, so Logstash needs to point the `output` address to the receiving address of the `logstreaming` collector.


```yaml
    ....
## Send the collected data to DataKit
output {  
    http {
        http_method => "post"
        format => "json"
        url => "http://127.0.0.1:9529/v1/write/logstreaming?source=nginx"
    }
}
```

- `url` ：The address is the DataKit collector address, adjusted according to the actual situation.
- `source`：Identify the data source, which is the `measurement` of the protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)

Regarding the introduction of `logstreaming` collector parameters, please refer to [the official document](logstreaming.md#args)



After the adjustment is completed, restart Logstash to make its configuration effective.

