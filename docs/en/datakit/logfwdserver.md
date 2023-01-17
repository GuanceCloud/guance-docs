
# logfwdserver
---

:material-kubernetes:

---

## Introduction {#intro}

Logfwdserver will turn on the websocket function, which is used together with logfwd, and is responsible for receiving and processing the data sent by logfwd.

See [here](logfwd.md) for the use of logfwd.

## Configuration {#datakit-conf}

=== "Host Installation"

    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample` and name it `logfwdserver.conf`. Examples are as follows:
    
    ```toml
        
    [inputs.logfwdserver]
      address = "0.0.0.0:9533"
    
      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).
