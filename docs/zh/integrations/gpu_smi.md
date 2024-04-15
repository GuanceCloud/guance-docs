---
title     : 'GPU'
summary   : '采集 NVIDIA GPU 指标数据'
__int_icon      : 'icon/gpu_smi'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# GPU
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

采集包括 GPU 温度、时钟、GPU 占用率、内存占用率、GPU 内每个运行程序的内存占用等。

## 配置 {#config}

### 安装 驱动及 CUDA 工具包 {#install-driver}

参考网址 [https://www.nvidia.com/Download/index.aspx](https://www.nvidia.com/Download/index.aspx){:target="_blank"}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/gpu_smi` 目录，复制 `gpu_smi.conf.sample` 并命名为 `gpu_smi.conf`。示例如下：
    
    ```toml
        
    [[inputs.gpu_smi]]
    
      ##(Optional) Collect interval, default is 10 seconds
      interval = "10s"
    
      ##The binPath of gpu-smi
    
      ##If nvidia GPU
      #(Example & default) bin_paths = ["/usr/bin/nvidia-smi"]
      #(Example windows) bin_paths = ["nvidia-smi"]
    
      ##If lluvatar GPU
      #(Example) bin_paths = ["/usr/local/corex/bin/ixsmi"]
      #(Example) envs = [ "LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH" ]
      ##(Optional) Exec gpu-smi envs, default is []
      #envs = [ "LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH" ]
    
      ##If remote GPU servers collected
      ##If use remote GPU servers, election must be true
      ##If use remote GPU servers, bin_paths should be shielded
      #(Example) remote_addrs = ["192.168.1.1:22"]
      #(Example) remote_users = ["remote_login_name"]
      ##If use remote_rsa_path, remote_passwords should be shielded
      #(Example) remote_passwords = ["remote_login_password"]
      #(Example) remote_rsa_paths = ["/home/your_name/.ssh/id_rsa"]
      #(Example) remote_command = "nvidia-smi -x -q"
    
      ##(Optional) Exec gpu-smi timeout, default is 5 seconds
      timeout = "5s"
      ##(Optional) Feed how much log data for ProcessInfos, default is 10. (0: 0 ,-1: all)
      process_info_max_len = 10
      ##(Optional) GPU drop card warning delay, default is 300 seconds
      gpu_drop_warning_delay = "300s"
    
      ## Set true to enable election
      election = false
    
    [inputs.gpu_smi.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    ???+ attention
    
        1. Datakit 可以通过 SSH 远程采集 GPU 服务器的指标（开启远程采集后，本地采集配置将失效）。
        1. `remote_addrs` 配置的个数可以多于 `remote_users` `remote_passwords` `remote_rsa_paths` 个数，不够的匹配排位第一的数值。
        1. 可以通过 `remote_addrs`+`remote_users`+`remote_passwords` 采集。
        1. 也可以通过 `remote_addrs`+`remote_users`+`remote_rsa_paths` 采集。（配置 RSA 公钥后，`remote_passwords` 将失效）。
        1. 开启远程采集后，必须开启选举。（防止多个 Datakit 上传重复数据）。
        1. 出于安全考虑，可以变更 SSH 端口号，也可以单独为 GPU 远程采集创建专用的账户。 
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_GPUSMI_INTERVAL**
    
        采集器重复间隔时长
    
        **Type**: TimeDuration
    
        **ConfField**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_GPUSMI_TIMEOUT**
    
        超时时长
    
        **Type**: TimeDuration
    
        **ConfField**: `timeout`
    
        **Default**: 5s
    
    - **ENV_INPUT_GPUSMI_BIN_PATH**
    
        执行文件路径
    
        **Type**: JSON
    
        **ConfField**: `bin_path`
    
        **Example**: `["/usr/bin/nvidia-smi"]`
    
    - **ENV_INPUT_GPUSMI_PROCESS_INFO_MAX_LEN**
    
        最大收集最耗资源 GPU 进程数
    
        **Type**: Int
    
        **ConfField**: `process_info_max_len`
    
        **Default**: 10
    
    - **ENV_INPUT_GPUSMI_DROP_WARNING_DELAY**
    
        掉卡告警延迟
    
        **Type**: TimeDuration
    
        **ConfField**: `gpu_drop_warning_delay`
    
        **Default**: 5m
    
    - **ENV_INPUT_GPUSMI_ENVS**
    
        执行依赖库的路径
    
        **Type**: JSON
    
        **ConfField**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_ADDRS**
    
        远程 GPU 服务器
    
        **Type**: JSON
    
        **ConfField**: `remote_addrs`
    
        **Example**: ["192.168.1.1:22","192.168.1.2:22"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_USERS**
    
        远程登录名
    
        **Type**: JSON
    
        **ConfField**: `remote_users`
    
        **Example**: ["user_1","user_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_PASSWORDS**
    
        远程登录密码
    
        **Type**: JSON
    
        **ConfField**: `remote_passwords`
    
        **Example**: ["pass_1","pass_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_RSA_PATHS**
    
        秘钥文件路径
    
        **Type**: JSON
    
        **ConfField**: `remote_rsa_paths`
    
        **Example**: ["/home/your_name/.ssh/id_rsa"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_COMMAND**
    
        远程执行指令
    
        **Type**: String
    
        **ConfField**: `remote_command`
    
        **Example**: "`nvidia-smi -x -q`"
    
    - **ENV_INPUT_GPUSMI_ELECTION**
    
        开启选举
    
        **Type**: Boolean
    
        **ConfField**: `election`
    
        **Default**: true
    
    - **ENV_INPUT_GPUSMI_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: Map
    
        **ConfField**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## 指标字段 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.gpu_smi.tags]` 指定其它标签：

``` toml
 [inputs.gpu_smi.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `gpu_smi`

- 标签


| Tag | Description |
|  ----  | --------|
|`compute_mode`|Compute mode|
|`cuda_version`|CUDA version|
|`driver_version`|Driver version|
|`host`|Host name|
|`name`|GPU card model|
|`pci_bus_id`|PCI bus id|
|`pstate`|GPU performance level|
|`uuid`|UUID|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`clocks_current_graphics`|Graphics clock frequency.|int|MHz|
|`clocks_current_memory`|Memory clock frequency.|int|MHz|
|`clocks_current_sm`|Streaming Multiprocessor clock frequency.|int|MHz|
|`clocks_current_video`|Video clock frequency.|int|MHz|
|`encoder_stats_average_fps`|Encoder average fps.|int|-|
|`encoder_stats_average_latency`|Encoder average latency.|int|-|
|`encoder_stats_session_count`|Encoder session count.|int|count|
|`fan_speed`|Fan speed.|int|RPM%|
|`fbc_stats_average_fps`|Frame Buffer Cache average fps.|int|-|
|`fbc_stats_average_latency`|Frame Buffer Cache average latency.|int|-|
|`fbc_stats_session_count`|Frame Buffer Cache session count.|int|-|
|`memory_total`|Frame buffer memory total.|int|MB|
|`memory_used`|Frame buffer memory used.|int|MB|
|`pcie_link_gen_current`|PCI-Express link gen.|int|-|
|`pcie_link_width_current`|PCI link width.|int|-|
|`power_draw`|Power draw.|float|watt|
|`temperature_gpu`|GPU temperature.|int|C|
|`utilization_decoder`|Decoder utilization.|int|percent|
|`utilization_encoder`|Encoder utilization.|int|percent|
|`utilization_gpu`|GPU utilization.|int|percent|
|`utilization_memory`|Memory utilization.|int|percent|



## DCGM 指标采集 {#dcgm}

- 操作系统支持：:fontawesome-brands-linux: :material-kubernetes:

DCGM 指标包括 GPU 卡温度、时钟、GPU 占用率、内存占用率等。

### DCGM 配置 {#dcgm-config}

#### DCGM 指标前置条件 {#dcgm-precondition}

安装 `dcgm-exporter`，参考[这里](https://github.com/NVIDIA/dcgm-exporter){:target="_blank"}

#### DCGM 采集配置 {#dcgm-input-config}

进入 DataKit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `prom.conf`。示例如下：

```toml
# {"version": "1.4.11-13-gd70f1f8ff7", "desc": "do NOT edit this line"}

[[inputs.prom]]
  # Exporter URLs
  urls = ["http://127.0.0.1:9400/metrics"]

  # 忽略对 URL 的请求错误
  ignore_req_err = false

  # 采集器别名
  source = "prom"

  # 采集数据输出源
  # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
  # 之后可以直接用 datakit debug --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
  # 如果已经将 URL 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
  # output = "/abs/path/to/file"

  # 采集数据大小上限，单位为字节
  # 将数据输出到本地文件时，可以设置采集数据大小上限
  # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
  # 采集数据大小上限默认设置为 32MB
  # max_file_size = 0

  # 指标类型过滤，可选值为 counter/gauge/histogram/summary/untyped
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  # 指标名称筛选：符合条件的指标将被保留下来
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行筛选，所有指标均保留
  # metric_name_filter = ["cpu"]

  # 指标集名称前缀
  # 配置此项，可以给指标集名称添加前缀
  measurement_prefix = "gpu_"

  # 指标集名称
  # 默认会将指标名称以下划线 "_" 进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
  # 如果配置 measurement_name, 则不进行指标名称的切割
  # 最终的指标集名称会添加上 measurement_prefix 前缀
  measurement_name = "dcgm"

  # TLS 配置
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## 设置为 true 以开启选举功能
  election = true

  # 过滤 tags, 可配置多个 tag
  # 匹配的 tag 将被忽略，但对应的数据仍然会上报上来
  # tags_ignore = ["xxxx"]
  #tags_ignore = ["host"]

  # 自定义认证方式，目前仅支持 Bearer Token
  # token 和 token_file: 仅需配置其中一项即可
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"
  # 自定义指标集名称
  # 可以将包含前缀 prefix 的指标归为一类指标集
  # 自定义指标集名称配置优先 measurement_name 配置项
  #[[inputs.prom.measurements]]
  #  prefix = "cpu_"
  #  name = "cpu"

  # [[inputs.prom.measurements]]
  # prefix = "mem_"
  # name = "mem"

  # 对于匹配如下 tag 相关的数据，丢弃这些数据不予采集
  [inputs.prom.ignore_tag_kv_match]
  # key1 = [ "val1.*", "val2.*"]
  # key2 = [ "val1.*", "val2.*"]

  # 在数据拉取的 HTTP 请求中添加额外的请求头
  [inputs.prom.http_headers]
  # Root = "passwd"
  # Michael = "1234"

  # 重命名 prom 数据中的 tag key
  [inputs.prom.tags_rename]
    overwrite_exist_tags = false
    [inputs.prom.tags_rename.mapping]
    Hostname = "host"
    # tag1 = "new-name-1"
    # tag2 = "new-name-2"
    # tag3 = "new-name-3"

  # 将采集到的指标作为日志打到中心
  # service 字段留空时，会把 service tag 设为指标集名称
  [inputs.prom.as_logging]
    enable = false
    service = "service_name"

  # 自定义 Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

### DCGM 指标字段 {#dcgm-metric}

| 指标                               | 描述                                                              | 数据类型 |
| ---                                | ---                                                               | ---      |
| DCGM_FI_DEV_DEC_UTIL               | gauge, Decoder utilization (in %).                                | int      |
| DCGM_FI_DEV_ENC_UTIL               | gauge, Encoder utilization (in %).                                | int      |
| DCGM_FI_DEV_FB_FREE                | gauge, Frame buffer memory free (in MiB).                         | int      |
| DCGM_FI_DEV_FB_USED                | gauge, Frame buffer memory used (in MiB).                         | int      |
| DCGM_FI_DEV_GPU_TEMP               | gauge, GPU temperature (in C).                                    | int      |
| DCGM_FI_DEV_GPU_UTIL               | gauge, GPU utilization (in %).                                    | int      |
| DCGM_FI_DEV_MEM_CLOCK              | gauge, Memory clock frequency (in MHz).                           | int      |
| DCGM_FI_DEV_MEM_COPY_UTIL          | gauge, Memory utilization (in %).                                 | int      |
| DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL | counter, Total number of NVLink bandwidth counters for all lanes. | int      |
| DCGM_FI_DEV_PCIE_REPLAY_COUNTER    | counter, Total number of PCIe retries.                            | int      |
| DCGM_FI_DEV_SM_CLOCK               | gauge, SM clock frequency (in MHz).                               | int      |
| DCGM_FI_DEV_VGPU_LICENSE_STATUS    | gauge, vGPU License status                                        | int      |
| DCGM_FI_DEV_XID_ERRORS             | gauge, Value of the last XID error encountered.                   | int      |
