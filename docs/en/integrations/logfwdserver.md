---
title: 'Log Forward'
summary: 'Collect log data within Pods via sidecar method'
tags:
  - 'KUBERNETES'
  - 'Logs'
  - 'Containers'
__int_icon: 'icon/logfwd'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:material-kubernetes:

---

logfwdserver will enable the websocket function and work with logfwd to receive and process the data sent by logfwd.

For the usage of logfwd, refer to [this link](logfwd.md).

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample` and rename it to `logfwdserver.conf`. An example is as follows:
    
    ```toml
        
    [inputs.logfwdserver]
      address = "0.0.0.0:9533"
    
      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration through [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->