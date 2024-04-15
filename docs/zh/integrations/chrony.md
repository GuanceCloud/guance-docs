---
title     : 'Chrony'
summary   : '采集 Chrony 服务器相关的指标数据'
__int_icon: 'icon/chrony'
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

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Chrony 采集器用于采集 Chrony 服务器相关的指标数据。

Chrony 采集器支持远程采集，采集器 Datakit 可以运行在多种操作系统中。

## 配置 {#config}

### 前置条件 {#requirements}

- 安装 Chrony 服务

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

### 采集器配置 {input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/chrony` 目录，复制 `chrony.conf.sample` 并命名为 `chrony.conf`。示例如下：
    
    ```toml
        
    [[inputs.chrony]]
      ## (Optional) Collect interval, default is 10 seconds
      # interval = "10s"
    
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
      election = true
    
    [inputs.chrony.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_CHRONY_INTERVAL**
    
        采集器重复间隔时长
    
        **Type**: TimeDuration
    
        **ConfField**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_CHRONY_TIMEOUT**
    
        超时时长
    
        **Type**: TimeDuration
    
        **ConfField**: `timeout`
    
        **Default**: 8s
    
    - **ENV_INPUT_CHRONY_BIN_PATH**
    
        Chrony 的路径
    
        **Type**: String
    
        **ConfField**: `bin_path`
    
        **Default**: `chronyc`
    
    - **ENV_INPUT_CHRONY_REMOTE_ADDRS**
    
        可以使用远程 Chrony 服务器
    
        **Type**: JSON
    
        **ConfField**: `remote_addrs`
    
        **Example**: ["192.168.1.1:22","192.168.1.2:22"]
    
    - **ENV_INPUT_CHRONY_REMOTE_USERS**
    
        远程登录名
    
        **Type**: JSON
    
        **ConfField**: `remote_users`
    
        **Example**: ["user_1","user_2"]
    
    - **ENV_INPUT_CHRONY_REMOTE_PASSWORDS**
    
        远程登录密码
    
        **Type**: JSON
    
        **ConfField**: `remote_passwords`
    
        **Example**: ["pass_1","pass_2"]
    
    - **ENV_INPUT_CHRONY_REMOTE_RSA_PATHS**
    
        秘钥文件路径
    
        **Type**: JSON
    
        **ConfField**: `remote_rsa_paths`
    
        **Example**: ["/home/your_name/.ssh/id_rsa"]
    
    - **ENV_INPUT_CHRONY_REMOTE_COMMAND**
    
        执行指令
    
        **Type**: String
    
        **ConfField**: `remote_command`
    
        **Example**: "`chronyc -n tracking`"
    
    - **ENV_INPUT_CHRONY_ELECTION**
    
        开启选举
    
        **Type**: Boolean
    
        **ConfField**: `election`
    
        **Default**: true
    
    - **ENV_INPUT_CHRONY_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: Map
    
        **ConfField**: `tags`
    
        **Example**: tag1=value1,tag2=value2

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
|`frequency`|This is the rate by which the system clock would be wrong if *chronyd* was not correcting it.|float|PPM|
|`last_offset`|This is the estimated local offset on the last clock update.|float|sec|
|`residual_freq`|This shows the residual frequency for the currently selected reference source.|float|PPM|
|`rms_offset`|This is a long-term average of the offset value.|float|sec|
|`root_delay`|This is the total of the network path delays to the stratum-1 computer from which the computer is ultimately synchronized.|float|sec|
|`root_dispersion`|This is the total dispersion accumulated through all the computers back to the stratum-1 computer from which the computer is ultimately synchronized.|float|sec|
|`skew`|This is the estimated error bound on the frequency.|float|PPM|
|`system_time`|This is the current offset between the NTP clock and system clock.|float|sec|
|`update_interval`|This is the interval between the last two clock updates.|float|sec|


