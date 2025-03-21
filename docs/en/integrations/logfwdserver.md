---
title     : 'Log Forward'
summary   : 'Collect log data inside Pod via sidecar method'
tags:
  - 'KUBERNETES'
  - 'LOGS'
  - 'CONTAINERS'
__int_icon      : 'icon/logfwd'
dashboard :
  - desc  : 'Not available yet'
    path  : '-'
monitor   :
  - desc  : 'Not available yet'
    path  : '-'
---

:material-kubernetes:

---

logfwdserver will enable the websocket function, used in conjunction with logfwd, responsible for receiving and processing the data sent by logfwd.

For using logfwd, refer to [this](logfwd.md).

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample` and rename it to `logfwdserver.conf`. An example is as follows:
    
    ```toml
        
    [inputs.logfwdserver]
      address = "0.0.0.0:9533"
    
      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration through the [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->