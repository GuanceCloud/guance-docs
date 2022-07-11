
# SSH
---

- DataKit 版本：1.4.7
- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

监控 SSH/SFTP 服务，并把数据上报到观测云。

## 配置

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

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.ssh.tags]` 指定其它标签：

``` toml
 [inputs.ssh.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `ssh`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|the host of ssh|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`sftp_check`|sftp service status|bool|-|
|`sftp_err`|fail reason of connet sftp service|string|-|
|`sftp_response_time`|response time of sftp service|float|ms|
|`ssh_check`|ssh service status|bool|-|
|`ssh_err`|fail reason of connet ssh service|string|-|


