
# etcd
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The tcd collector can take many metrics from the etcd instance, such as the status of the etcd server and network, and collect the metrics to DataFlux to help you monitor and analyze various abnormal situations of etcd.

## Preconditions {#requirements}

etcd version >= 3, Already tested version:

- [x] 3.5.7
- [x] 3.4.24
- [x] 3.3.27

Open etcd, the default metrics interface is `http://localhost:2379/metrics`, or you can modify it in your configuration file.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/etcd` directory under the DataKit installation directory, copy `etcd.conf.sample` and name it `etcd.conf`. Examples are as follows:

    ```toml
        
    [[inputs.etcd]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:2379/metrics"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Ignore tags. Multi supported.
      ## The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize tags.
      [inputs.etcd.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

