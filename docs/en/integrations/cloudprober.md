---
title     : 'Cloudprober'
summary   : 'Receive Cloudprober data'
__int_icon      : 'icon/cloudprober'
dashboard :
  - desc  : 'None available'
    path  : '-'
monitor   :
  - desc  : 'None available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

---

Cloudprober is an open-source tracing and monitoring application. DataKit can easily integrate with the datasets collected by Cloudprober through simple configuration.

## Configuration {#config}

### Prerequisites {#requirements}

Cloudprober installation:

Using Ubuntu `cloudprober-v0.11.2` as an example, download as follows. For other versions or systems, refer to the [download page](https://github.com/google/cloudprober/releases){:target="_blank"}:

```shell
curl -O https://github.com/google/cloudprober/releases/download/v0.11.2/cloudprober-v0.11.2-ubuntu-x86_64.zip
```

Unzip

```shell
unzip cloudprober-v0.11.2-ubuntu-x86_64.zip
```

For probing Baidu, create a `cloudprober.cfg` file and write the following content:

``` conf
probe {
  name: "baidu_homepage"
  type: HTTP
  targets {
    host_names: "www.baidu.com"
  }
  interval_msec: 5000  # 5s
  timeout_msec: 1000   # 1s
}
```

Run Cloudprober:

```shell
./cloudprober --config_file /your_path/cloudprober.cfg
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/cloudprober` directory under the DataKit installation directory, copy `cloudprober.conf.sample` and rename it to `cloudprober.conf`. An example is as follows:
    
    ```toml
    [[inputs.cloudprober]]
        # Default metrics route for Cloudprober (Prometheus format)
        url = "http://localhost:9313/metrics" 
    
        # ##(optional) collection interval, default is 5s
        # interval = "5s"
    
        ## Optional TLS Config
        # tls_ca = "/xxx/ca.pem"
        # tls_cert = "/xxx/cert.cer"
        # tls_key = "/xxx/key.key"
    
        ## Use TLS but skip chain & host verification
        insecure_skip_verify = false
    
        [inputs.cloudprober.tags]
          # a = "b"`
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->