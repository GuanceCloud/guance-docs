
# SSH
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Monitor SSH/SFTP services and report data to Guance Cloud.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/ssh` directory under the DataKit installation directory, copy `ssh.conf.sample` and name it `ssh.conf`. Examples are as follows:
    
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

    The collector can now be turned on by [configMap injection collector configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.ssh.tags]`:

``` toml
 [inputs.ssh.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `ssh`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|the host of ssh|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`sftp_check`|sftp service status|bool|-|
|`sftp_err`|fail reason of connect sftp service|string|-|
|`sftp_response_time`|response time of sftp service|float|ms|
|`ssh_check`|ssh service status|bool|-|
|`ssh_err`|fail reason of connect ssh service|string|-|

