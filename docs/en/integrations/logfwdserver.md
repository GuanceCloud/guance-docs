---
title     : 'Log Forward Server'
summary   : 'Collect log data in Pod through sidecar method'
tags:
  - 'KUBERNETES'
  - 'LOG'
  - 'CONTAINER'
__int_icon      : 'icon/logfwd'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:material-kubernetes:

---

## Introduction {#intro}

Logfwdserver will turn on the websocket function, which is used together with logfwd, and is responsible for receiving and processing the data sent by logfwd.

See [here](logfwd.md) for the use of logfwd.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample` and name it `logfwdserver.conf`. Examples are as follows:
    
    ```toml
        
    [inputs.logfwdserver]
      address = "0.0.0.0:9533"
    
      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->
