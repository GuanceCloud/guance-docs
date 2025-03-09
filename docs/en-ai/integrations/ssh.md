---
title: 'SSH'
summary: 'Collect metrics data from SSH'
tags:
  - 'Host'
__int_icon: 'icon/ssh'
dashboard:
  - desc: 'SSH'
    path: 'dashboard/en/ssh'
monitor:
  - desc: 'SSH'
    path: 'monitor/en/ssh'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Monitor SSH/SFTP services and report data to Guance.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/ssh` directory under the DataKit installation directory, copy `ssh.conf.sample` and rename it to `ssh.conf`. An example is shown below:
    
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
    
    After configuring, restart DataKit to apply changes.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify other tags in the configuration using `[inputs.ssh.tags]`:

```toml
 [inputs.ssh.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### `ssh`

- Tags

| Tag | Description |
| ---- | --------|
|`host`|The host of SSH|

- Metric List

| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`sftp_check`|SFTP service status|bool|-|
|`sftp_err`|Fail reason of connecting SFTP service|string|-|
|`sftp_response_time`|Response time of SFTP service|float|ms|
|`ssh_check`|SSH service status|bool|-|
|`ssh_err`|Fail reason of connecting SSH service|string|-|