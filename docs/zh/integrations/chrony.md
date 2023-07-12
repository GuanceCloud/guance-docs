---
title     : 'Chrony'
summary   : '采集 Chrony 服务器相关的指标数据'
<<<<<<< HEAD
icon      : 'icon/chrony'
=======
__int_icon      : 'icon/chrony'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Chrony
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "Election Enabled")

---

Chrony 采集器用于采集 Chrony 服务器相关的指标数据。

Chrony 采集器支持远程采集，采集器 Datakit 可以运行在多种操作系统中。

## 配置 {#config}

### 前置条件 {#requirements}

- 安装 [chrony 服务]

```shell
$ yum -y install chrony    # [On CentOS/RHEL]
...

$ apt install chrony       # [On Debian/Ubuntu]
...

$ dnf -y install chrony    # [On Fedora 22+]
...

```

- 验证是否正确安装，在命令行执行如下指令，得到类似结果：

```shell
$ chronyc -n tracking
Reference ID    : CA760151 (202.118.1.81)
Stratum         : 2
Ref time (UTC)  : Thu Jun 08 07:28:42 2023
System time     : 0.000000000 seconds slow of NTP time
Last offset     : -1.841502666 seconds
RMS offset      : 1.841502666 seconds
Frequency       : 1.606 ppm slow
Residual freq   : +651.673 ppm
Skew            : 0.360 ppm
Root delay      : 0.058808800 seconds
Root dispersion : 0.011350543 seconds
Update interval : 0.0 seconds
Leap status     : Normal
```

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/chrony` 目录，复制 `chrony.conf.sample` 并命名为 `chrony.conf`。示例如下：
    
    ```toml
        
    [[inputs.chrony]]
      ## (Optional) Collect interval, default is 30 seconds
      # interval = "30s"
    
      ## (Optional) Exec chronyc timeout, default is 8 seconds
      # timeout = "8s"
    
      ## (Optional) The binPath of chrony
      bin_path = "chronyc"
     
      ## (Optional) Remote chrony servers
      ## If use remote chrony servers, election must be true
      ## If use remote chrony servers, bin_paths should be shielded
      # remote_addrs = ["<ip>:22"]
      # remote_users = ["<remote_login_name>"]
      # remote_passwords = ["<remote_login_password>"]
      ## If use remote_rsa_path, remote_passwords should be shielded
      # remote_rsa_paths = ["/home/<your_name>/.ssh/id_rsa"]
      # remote_command = "chronyc -n tracking"
    
      ## Set true to enable election
      election = false
    
    [inputs.chrony.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    支持以环境变量的方式修改配置参数（只在 Datakit 以 K8s DaemonSet 方式运行时生效，主机部署的 Datakit 不支持此功能）：

    | 环境变量名                              | 对应的配置参数项         | 参数示例                                                     |
    | :-----------------------------          | ---                      | ---                                                    |
    | `ENV_INPUT_CHRONY_INTERVAL`             | `interval`               | `"30s"` (`"10s"` ~ `"60s"`)                            |
    | `ENV_INPUT_CHRONY_TIMEOUT`              | `timeout`                | `"8s"`  (`"5s"` ~ `"30s"`)                             |
    | `ENV_INPUT_CHRONY_BIN_PATH`             | `bin_path`               | `"chronyc"`                                            |
    | `ENV_INPUT_CHRONY_REMOTE_ADDRS`         | `remote_addrs`           | `["192.168.1.1:22"]`                                   |
    | `ENV_INPUT_CHRONY_REMOTE_USERS`         | `remote_users`           | `["remote_login_name"]`                                |
    | `ENV_INPUT_CHRONY_REMOTE_RSA_PATHS`     | `remote_rsa_paths`       | `["/home/<your_name>/.ssh/id_rsa"]`                    |
    | `ENV_INPUT_CHRONY_REMOTE_COMMAND`       | `remote_command`         | `"chronyc -n tracking"`                                |
    | `ENV_INPUT_CHRONY_TAGS`                 | `tags`                   | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
    | `ENV_INPUT_CHRONY_ELECTION`             | `election`               | `"true"` or `"false"`                                   |

<!-- markdownlint-enable -->

## 指标 {#metric}



### `chrony`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`leap_status`|This is the leap status, which can be Normal, Insert second, Delete second or Not synchronized.|
|`reference_id`|This is the reference ID and name (or IP address) of the server to which the computer is currently synchronized.|
|`stratum`|The stratum indicates how many hops away from a computer with an attached reference clock we are.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`frequency`|This is the rate by which the system clock would be wrong if chronyd was not correcting it.|float|PPM|
|`last_offset`|This is the estimated local offset on the last clock update.|float|sec|
|`residual_freq`|This shows the residual frequency for the currently selected reference source.|float|PPM|
|`rms_offset`|This is a long-term average of the offset value.|float|sec|
|`root_delay`|This is the total of the network path delays to the stratum-1 computer from which the computer is ultimately synchronized.|float|sec|
|`root_dispersion`|This is the total dispersion accumulated through all the computers back to the stratum-1 computer from which the computer is ultimately synchronized.|float|sec|
|`skew`|This is the estimated error bound on the frequency.|float|PPM|
|`system_time`|This is the current offset between the NTP clock and system clock.|float|sec|
|`update_interval`|This is the interval between the last two clock updates.|float|sec|


