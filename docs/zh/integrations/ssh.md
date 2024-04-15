---
title     : 'SSH'
summary   : '采集 SSH 的指标数据'
__int_icon      : 'icon/ssh'
dashboard :
  - desc  : 'SSH'
    path  : 'dashboard/zh/ssh'
monitor   :
  - desc  : 'SSH'
    path  : 'monitor/zh/ssh'
---

<!-- markdownlint-disable MD025 -->
# SSH
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

监控 SSH/SFTP 服务，并把数据上报到观测云。

## 配置 {#config}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/ssh` 目录，复制 `ssh.conf.sample` 并命名为 `ssh.conf`。示例如下：
    
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
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ssh.tags]` 指定其它标签：

``` toml
 [inputs.ssh.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `ssh`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|The host of ssh|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`sftp_check`|SFTP service status|bool|-|
|`sftp_err`|Fail reason of connect sftp service|string|-|
|`sftp_response_time`|Response time of sftp service|float|ms|
|`ssh_check`|SSH service status|bool|-|
|`ssh_err`|Fail reason of connect ssh service|string|-|


