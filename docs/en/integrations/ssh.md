---
title     : 'SSH'
summary   : 'Collect metrics data for SSH'
tags:
  - 'HOST'
__int_icon      : 'icon/ssh'
dashboard :
  - desc  : 'SSH'
    path  : 'dashboard/en/ssh'
monitor   :
  - desc  : 'SSH'
    path  : 'monitor/en/ssh'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Monitor the SSH/SFTP service and report data to Guance.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/ssh` directory under the DataKit installation directory, copy `ssh.conf.sample` and rename it to `ssh.conf`. Example as follows:
    
    ```toml
        ### You need to configure an [[inputs.ssh]] for each ssh/sftp to be monitored.
    ### host: ssh/sftp service ip:port, if "127.0.0.1", default port is 22.
    ### interval: monitor interval, the default value is "60s".
    ### username: the user name of ssh/sftp.
    ### password: the password of ssh/sftp. optional
    ### sftpCheck: whether to monitor sftp.
    ### privateKeyFile: rsa file path.
    ### metricsName: the name of metric, default is "ssh"
    
    [[inputs.ssh]]
      interval = "60s"
      host     = "127.0.0.1:22"
      username = "<your_username>"
      password = "<your_password>"
      sftpCheck      = false
      privateKeyFile = ""
    
      [inputs.ssh.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

All the following data collection will append a global tag named `host` (tag value is the hostname where DataKit resides) by default. You can also specify other tags in the configuration through `[inputs.ssh.tags]`:

``` toml
 [inputs.ssh.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `ssh`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|The host of ssh|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`sftp_check`|SFTP service status|bool|-|
|`sftp_err`|Fail reason of connecting to SFTP service|string|-|
|`sftp_response_time`|Response time of SFTP service|float|ms|
|`ssh_check`|SSH service status|bool|-|
|`ssh_err`|Fail reason of connecting to SSH service|string|-|