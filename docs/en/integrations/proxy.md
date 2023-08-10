
# Proxy

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Proxy collector used to proxy HTTP request.

## Config {#config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/proxy` directory under the DataKit installation directory, copy `proxy.conf.sample` and name it `proxy.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.proxy]]
      ## default bind ip address
      bind = "0.0.0.0"
      ## default bind port
      port = 9530
    
    ```
    
    After configuration, [restart Datakit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

There is no metrics output for the collector.
