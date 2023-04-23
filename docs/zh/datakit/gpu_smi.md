
# GPU

---
## SMI指标 {#SMI-tag}
---

- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

SMI 指标展示：包括 GPU 卡温度、时钟、GPU占用率、内存占用率、GPU内每个运行程序的内存占用等。

### 使用SMI指标前置条件 {#SMI-precondition}

#### 安装 驱动及CUDA工具包 {#SMI-install-driver}
参考网址 [https://www.nvidia.com/Download/index.aspx](https://www.nvidia.com/Download/index.aspx)

### SMI指标配置 {#SMI-input-config}

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

    1. `datakit`可以通过 SSH 远程采集 GPU 服务器的指标。(开启远程采集后，本地采集配置将失效)。
    2. `remote_addrs`配置的个数可以多于`remote_users` `remote_passwords` `remote_rsa_paths`个数，不够的匹配排位第一的数值。
    3. 可以通过`remote_addrs`+`remote_users`+`remote_passwords`采集。
    4. 也可以通过`remote_addrs`+`remote_users`+`remote_rsa_paths`采集。(配置 RSA 公钥后，`remote_passwords`将失效)。
    5. 开启远程采集后，必须开启选举。(防止多个 datakit 上传重复数据)。
    6. 出于安全考虑，可以变更 SSH 端口号，也可以单独为 GPU 远程采集创建专用的账户。 



配置好后，重启 DataKit 即可。



支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名                        | 对应的配置参数项 | 参数示例                                                     |
|:-----------------------------| ---              | ---                                                          |
| `ENV_INPUT_GPUSMI_TAGS`   | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_GPUSMI_INTERVAL` | `interval`       | `10s`                                                        |
| `ENV_INPUT_GPUSMI_BIN_PATHS`            | `bin_paths`              | `["/usr/bin/nvidia-smi"]`         |
| `ENV_INPUT_GPUSMI_TIMEOUT`              | `timeout`                | `"5s"`                            |
| `ENV_INPUT_GPUSMI_PROCESS_INFO_MAX_LEN` | `process_info_max_len`   | `10`                              |
| `ENV_INPUT_GPUSMI_DROP_WARNING_DELAY`   | `gpu_drop_warning_delay` | `"300s"`                          |
| `ENV_INPUT_GPUSMI_ENVS`                 | `envs`                   | `["LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH"]` |
| `ENV_INPUT_GPUSMI_REMOTE_ADDRS`         | `remote_addrs`           | `["192.168.1.1:22"]`              |
| `ENV_INPUT_GPUSMI_REMOTE_USERS`         | `remote_users`           | `["remote_login_name"]`           |
| `ENV_INPUT_GPUSMI_REMOTE_RSA_PATHS`     | `remote_rsa_paths`       | `["/home/your_name/.ssh/id_rsa"]` |
| `ENV_INPUT_GPUSMI_REMOTE_COMMAND`       | `remote_command`         | `"nvidia-smi -x -q"`              |

### SMI指标集 {#SMI-measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.gpu_smi.tags]` 指定其它标签：

``` toml
 [inputs.gpu_smi.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



#### `gpu_smi`

-  标签


| Tag | Descrition |
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


| Metric | Descrition | Type | Unit |
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
|`memory_total`|Framebuffer memory total.|int|MB|
|`memory_used`|Framebuffer memory used.|int|MB|
|`pcie_link_gen_current`|PCI-Express link gen.|int|-|
|`pcie_link_width_current`|PCI link width.|int|-|
|`power_draw`|Power draw.|float|watt|
|`temperature_gpu`|GPU temperature.|int|C|
|`utilization_decoder`|Decoder utilization.|int|percent|
|`utilization_encoder`|Encoder utilization.|int|percent|
|`utilization_gpu`|GPU utilization.|int|percent|
|`utilization_memory`|Memory utilization.|int|percent|




### GPU掉卡 && 上卡信息 {#SMI-drop-card}

| 时间                  | 信息描述|UUID                                    |
|---------------------|--------------------|------------------------------------------|
| 09/13 09:56:54.567  | Warning! GPU drop! | GPU-06e04616-0ed5-4069-5ebc-345349a0d4f3 |
| 09/13 15:04:17.321  | Info! GPU online!  | GPU-06e04616-0ed5-4069-5ebc-345349a0d4f3 |


### GPU进程排行榜 {#SMI-process-list}

| 时间                 | UUID       | 进程程序名  | 占用GPU内存（MB）                                   |
|--------------------|------------|--------|-----------------------------------------------|
| 09/13 14:56:46.955 |GPU-06e04616-0ed5-4069-5ebc-345349a0d4f3|ProcessName=Xorg|UsedMemory= 59 MiB|
| 09/13 14:56:46.955 |GPU-06e04616-0ed5-4069-5ebc-345349a0d4f3|ProcessName=firefox|UsedMemory= 1 MiB|

观察技巧
```

 [日志] -> [快捷筛选] -> [编辑] -> [搜索或添加字段] 选 [uuid]和[pci_bus_id] -> [关闭]。
 [快捷筛选]栏会多出来[uuid]和[pci_bus_id]筛选，可以只看单卡进程排行榜信息。

```


---
## DCGM指标 {#DCGM-tag}
---

- 操作系统支持：:fontawesome-brands-linux: :material-kubernetes:

DCGM 指标展示：包括 GPU 卡温度、时钟、GPU占用率、内存占用率 等。

### DCGM指标前置条件 {#DCGM-precondition}

#### 安装 dcgm-exporter {#DCGM-install-driver}

参考网址 [https://github.com/NVIDIA/dcgm-exporter](https://github.com/NVIDIA/dcgm-exporter)

### DCGM指标配置 {#DCGM-input-config}

进入 DataKit 安装目录下的 `conf.d/Prom` 目录，复制 `prom.conf.sample` 并命名为 `prom.conf`。示例如下：

```toml
# {"version": "1.4.11-13-gd70f1f8ff7", "desc": "do NOT edit this line"}

[[inputs.prom]]
  # Exporter URLs
  # urls = ["http://127.0.0.1:9100/metrics", "http://127.0.0.1:9200/metrics"]
  urls = ["http://127.0.0.1:9400/metrics"]
  # 忽略对 url 的请求错误
  ignore_req_err = false

  # 采集器别名
  source = "prom"

  # 采集数据输出源
  # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
  # 之后可以直接用 datakit debug --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
  # 如果已经将 url 配置为本地文件路径，则 --prom-conf 优先调试 output 路径的数据
  # output = "/abs/path/to/file"

  # 采集数据大小上限，单位为字节
  # 将数据输出到本地文件时，可以设置采集数据大小上限
  # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
  # 采集数据大小上限默认设置为32MB
  # max_file_size = 0

  # 指标类型过滤, 可选值为 counter, gauge, histogram, summary, untyped
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
  # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
  # 如果配置measurement_name, 则不进行指标名称的切割
  # 最终的指标集名称会添加上measurement_prefix前缀
  measurement_name = "dcgm"

  # TLS 配置
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## 设置为 true 以开启选举功能
  election = true

  # 过滤 tags, 可配置多个tag
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

  # 自定义Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

配置好后，重启 DataKit 即可。

### DCGM指标集 {#DCGM-measurements}

gpu_dcgm

### 指标列表 {#DCGM-measurements-list}
| 指标 | 描述 | 数据类型 |
| --- | --- | --- |
|  DCGM_FI_DEV_DEC_UTIL                |  gauge, Decoder utilization (in %).                                | int |
|  DCGM_FI_DEV_ENC_UTIL                |  gauge, Encoder utilization (in %).                                | int |
|  DCGM_FI_DEV_FB_FREE                 |  gauge, Framebuffer memory free (in MiB).                          | int |
|  DCGM_FI_DEV_FB_USED                 |  gauge, Framebuffer memory used (in MiB).                          | int |
|  DCGM_FI_DEV_GPU_TEMP                |  gauge, GPU temperature (in C).                                    | int |
|  DCGM_FI_DEV_GPU_UTIL                |  gauge, GPU utilization (in %).                                    | int |
|  DCGM_FI_DEV_MEM_CLOCK               |  gauge, Memory clock frequency (in MHz).                           | int |
|  DCGM_FI_DEV_MEM_COPY_UTIL           |  gauge, Memory utilization (in %).                                 | int |
|  DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL  |  counter, Total number of NVLink bandwidth counters for all lanes. | int |
|  DCGM_FI_DEV_PCIE_REPLAY_COUNTER     |  counter, Total number of PCIe retries.                            | int |
|  DCGM_FI_DEV_SM_CLOCK                |  gauge, SM clock frequency (in MHz).                               | int |
|  DCGM_FI_DEV_VGPU_LICENSE_STATUS     |  gauge, vGPU License status                                        | int |
|  DCGM_FI_DEV_XID_ERRORS              |  gauge, Value of the last XID error encountered.                   | int |


---
## 掉卡告警通知配置 {#warning-config-tag}
---

```

 [监控] -> [监控器] -> [新建监控器] 选 [阈值检测] -> 输入[规则名称]
 [指标] 选 [日志] -> [指标集] 选 [gpu_smi] -> 第4栏选 [status_gpu] -> 第5栏选 [Max] -> by[检测维度] 选 [host]+[uuid]
 [紧急] 填写 [999] -> [重要] 填写 [2] -> [警告] 填写 [999]

```
