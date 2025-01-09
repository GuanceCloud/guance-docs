---
title     : 'GPU'
summary   : 'Collect NVIDIA GPU metrics and logs'
tags:
  - 'HOST'
__int_icon      : 'icon/gpu_smi'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

SMI metric display: including GPU card temperature, clock, GPU occupancy rate, memory occupancy rate, memory occupancy of each running program in GPU, etc.

## Configuration {#config}

### Install Driver and CUDA Kit {#install-driver}

See  [https://www.nvidia.com/Download/index.aspx]( https://www.nvidia.com/Download/index.aspx)

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/gpu_smi` directory under the DataKit installation directory, copy `gpu_smi.conf.sample` and name it `gpu_smi.conf`. Examples are as follows:

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

        1. DataKit can remotely collect GPU server indicators through SSH (when remote collection is enabled, the local configuration will be invalid).
        1. The number of `remote_addrs` configured can be more than the number of `remote_users` `remote_passwords` `remote_rsa_paths`.If not enough, it will match the first value.
        1. Can be collected through `remote_addrs`+`remote_users`+`remote_passwords`.
        1. It can also be collected through `remote_addrs`+`remote_users`+`remote_rsa_paths`. (`remote_passwords` will be invalid after configuring the RSA public key).
        1. After turning on remote collection, elections must be turned on. (Prevent multiple DataKit from uploading duplicate data).
        1. For security reasons, you can change the SSH port number or create a dedicated account for GPU remote collection.

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_GPUSMI_INTERVAL**
    
        Collect interval
    
        **Type**: Duration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_GPUSMI_TIMEOUT**
    
        Timeout
    
        **Type**: Duration
    
        **input.conf**: `timeout`
    
        **Default**: 5s
    
    - **ENV_INPUT_GPUSMI_BIN_PATH**
    
        The binPath
    
        **Type**: JSON
    
        **input.conf**: `bin_path`
    
        **Example**: `["/usr/bin/nvidia-smi"]`
    
    - **ENV_INPUT_GPUSMI_PROCESS_INFO_MAX_LEN**
    
        Maximum number of GPU processes that consume the most resources
    
        **Type**: Int
    
        **input.conf**: `process_info_max_len`
    
        **Default**: 10
    
    - **ENV_INPUT_GPUSMI_DROP_WARNING_DELAY**
    
        GPU card drop warning delay
    
        **Type**: Duration
    
        **input.conf**: `gpu_drop_warning_delay`
    
        **Default**: 5m
    
    - **ENV_INPUT_GPUSMI_ENVS**
    
        The envs of LD_LIBRARY_PATH
    
        **Type**: JSON
    
        **input.conf**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_ADDRS**
    
        If use remote GPU servers
    
        **Type**: JSON
    
        **input.conf**: `remote_addrs`
    
        **Example**: ["192.168.1.1:22","192.168.1.2:22"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_USERS**
    
        Remote login name
    
        **Type**: JSON
    
        **input.conf**: `remote_users`
    
        **Example**: ["user_1","user_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_PASSWORDS**
    
        Remote password
    
        **Type**: JSON
    
        **input.conf**: `remote_passwords`
    
        **Example**: ["pass_1","pass_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_RSA_PATHS**
    
        Remote rsa paths
    
        **Type**: JSON
    
        **input.conf**: `remote_rsa_paths`
    
        **Example**: ["/home/your_name/.ssh/id_rsa"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_COMMAND**
    
        Remote command
    
        **Type**: String
    
        **input.conf**: `remote_command`
    
        **Example**: "`nvidia-smi -x -q`"
    
    - **ENV_INPUT_GPUSMI_ELECTION**
    
        Enable election
    
        **Type**: Boolean
    
        **input.conf**: `election`
    
        **Default**: true
    
    - **ENV_INPUT_GPUSMI_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.gpu_smi.tags]` if needed:

``` toml
 [inputs.gpu_smi.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `gpu_smi`

- Tags


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

- Metrics


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



## DCGM Metrics Collection {#dcgm}

- Operating system support: :fontawesome-brands-linux: :material-kubernetes:

DCGM indicator display: including GPU card temperature, clock, GPU occupancy rate, memory occupancy rate, etc.

### DCGM Configuration {#dcgm-config}

#### DCGM Metrics Preconditions {#dcgm-precondition}

Install `dcgm-exporter`, refer to [NVIDIA official website](https://github.com/NVIDIA/dcgm-exporter){:target="_blank"}

#### DCGM Metrics Configuration {#dcgm-input-config}

Go to the `conf.d/Prom` directory under the DataKit installation directory, copy `prom.conf.sample` and name it `prom.conf`. Examples are as follows:

```toml
[[inputs.prom]]
  ## Exporter URLs
  urls = ["http://127.0.0.1:9400/metrics"]

  ## Error ignoring request to url
  ignore_req_err = false

  ## Collector alias
  source = "dcgm"

  ## Collection data output source
  ## Configure this to write collected data to a local file instead of typing the data to the center
  ## You can debug the locally saved metric set directly with the datakit debug --prom-conf /path/to/this/conf command
  ## If url has been configured as the local file path, then --prom-conf takes precedence over debugging the data in the output path
  # output = "/abs/path/to/file"

  ## Maximum size of data collected in bytes
  ## When outputting data to a local file, you can set the upper limit of the size of the collected data
  ## If the size of the collected data exceeds this limit, the collected data will be discarded
  ## The maximum size of collected data is set to 32MB by default
  # max_file_size = 0

  ## Metrics type filtering, optional values are counter, gauge, histogram, summary and untyped
  ## Only counter and gauge metrics are collected by default
  ## If empty, no filtering is performed
  # metric_types = ["counter", "gauge"]

  ## Metric Name Filter: Eligible metrics will be retained
  ## Support regular can configure more than one, that is, satisfy one of them
  ## If blank, no filtering is performed and all metrics are retained
  # metric_name_filter = ["cpu"]

  ## Measurement name prefix
  ## Configure this to prefix the measurement name
  measurement_prefix = "gpu_"

  ## Measurement name
  ## By default, the measurement name will be cut with an underscore "_". The first field after cutting will be the measurement name, and the remaining fields will be the current metric name
  ## If measurement_name is configured, the metric name is not cut
  ## The final measurement name is prefixed with measurement_prefix
  measurement_name = "dcgm"

  ## TLS configuration
  # tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## Set to true to turn on election
  election = true

  ## Filter tags, configurable multiple tags
  ## Matching tags will be ignored, but the corresponding data will still be reported
  # tags_ignore = ["xxxx"]

  ## Custom authentication method, currently only supports Bearer Token
  ## token and token_file: Just configure one of them
  # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

  ## Custom measurement name
  ## You can group metrics that contain the prefix prefix into one measurement
  ## Custom measurement name configuration priority measurement_name Configuration Items
  # [[inputs.prom.measurements]]
    # prefix = "cpu_"
    # name = "cpu"

  # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"

  ## For data that matches the following tag, discard the data and do not collect it
  # [inputs.prom.ignore_tag_kv_match]
    # key1 = [ "val1.*", "val2.*"]
    # key2 = [ "val1.*", "val2.*"]

  ## Add additional request headers to HTTP requests for data fetches
  ## Example basic authentication
  # [inputs.prom.http_headers]
    # Authorization = “Basic bXl0b21jYXQ="

  ## Rename tag key in prom data
  [inputs.prom.tags_rename]
    overwrite_exist_tags = false
    [inputs.prom.tags_rename.mapping]
    Hostname = "host"
    # tag1 = "new-name-1"
    # tag2 = "new-name-2"
    # tag3 = "new-name-3"

  ## Call the collected metrics to the center as logs
  ## When the service field is left blank, the service tag is set to measurement name
  [inputs.prom.as_logging]
    enable = false
    service = "service_name"

  ## Customize Tags
  # [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

## DCGM Metrics {#dcgm-metric}

### `gpu_dcgm`

- Tags

| Tag                           | Description                                |
| ----                          | --------                                   |
| gpu                           | GPU id.                                    |
| device                        | device.                                    |
| modelName                     | GPU model.                                 |
| Hostname                      | host name.                                 |
| host                          | Instance endpoint.                         |
| UUID                          | UUID.                                      |
| DCGM_FI_NVML_VERSION          | `NVML` Version.                            |
| DCGM_FI_DEV_BRAND             | Device Brand.                              |
| DCGM_FI_DEV_SERIAL            | Device Serial Number.                      |
| DCGM_FI_DEV_OEM_INFOROM_VER   | OEM `inforom` version.                     |
| DCGM_FI_DEV_ECC_INFOROM_VER   | ECC `inforom` version.                     |
| DCGM_FI_DEV_POWER_INFOROM_VER | Power management object `inforom` version. |
| DCGM_FI_DEV_INFOROM_IMAGE_VER | `Inforom` image version.                   |
| DCGM_FI_DEV_VBIOS_VERSION     | `VBIOS` version of the device.             |

- Metrics

| Metric                                        | Unit    | Description |
| ---                                           | ---     | ---         |
| DCGM_FI_DEV_SM_CLOCK                          | gauge   | SM clock frequency (in MHz). |
| DCGM_FI_DEV_MEM_CLOCK                         | gauge   | Memory clock frequency (in MHz). |
| DCGM_FI_DEV_MEMORY_TEMP                       | gauge   | Memory temperature (in C). |
| DCGM_FI_DEV_GPU_TEMP                          | gauge   | GPU temperature (in C). |
| DCGM_FI_DEV_POWER_USAGE                       | gauge   | Power draw (in W). |
| DCGM_FI_DEV_TOTAL_ENERGY_CONSUMPTION          | counter | Total energy consumption since boot (in mJ). |
| DCGM_FI_DEV_PCIE_TX_THROUGHPUT                | counter | Total number of bytes transmitted through PCIe TX (in KB) via `NVML`. |
| DCGM_FI_DEV_PCIE_RX_THROUGHPUT                | counter | Total number of bytes received through PCIe RX (in KB) via `NVML`. |
| DCGM_FI_DEV_PCIE_REPLAY_COUNTER               | counter | Total number of PCIe retries. |
| DCGM_FI_DEV_GPU_UTIL                          | gauge   | GPU utilization (in %). |
| DCGM_FI_DEV_MEM_COPY_UTIL                     | gauge   | Memory utilization (in %). |
| DCGM_FI_DEV_ENC_UTIL                          | gauge   | Encoder utilization (in %). |
| DCGM_FI_DEV_DEC_UTIL                          | gauge   | Decoder utilization (in %). |
| DCGM_FI_DEV_XID_ERRORS                        | gauge   | Value of the last XID error encountered. |
| DCGM_FI_DEV_POWER_VIOLATION                   | counter | Throttling duration due to power constraints (in us). |
| DCGM_FI_DEV_THERMAL_VIOLATION                 | counter | Throttling duration due to thermal constraints (in us). |
| DCGM_FI_DEV_SYNC_BOOST_VIOLATION              | counter | Throttling duration due to sync-boost constraints (in us). |
| DCGM_FI_DEV_BOARD_LIMIT_VIOLATION             | counter | Throttling duration due to board limit constraints (in us). |
| DCGM_FI_DEV_LOW_UTIL_VIOLATION                | counter | Throttling duration due to low utilization (in us). |
| DCGM_FI_DEV_RELIABILITY_VIOLATION             | counter | Throttling duration due to reliability constraints (in us). |
| DCGM_FI_DEV_FB_FREE                           | gauge   | `Framebuffer` memory free (in MiB). |
| DCGM_FI_DEV_FB_USED                           | gauge   | `Framebuffer` memory used (in MiB). |
| DCGM_FI_DEV_ECC_SBE_VOL_TOTAL                 | counter | Total number of single-bit volatile ECC errors. |
| DCGM_FI_DEV_ECC_DBE_VOL_TOTAL                 | counter | Total number of double-bit volatile ECC errors. |
| DCGM_FI_DEV_ECC_SBE_AGG_TOTAL                 | counter | Total number of single-bit persistent ECC errors. |
| DCGM_FI_DEV_ECC_DBE_AGG_TOTAL                 | counter | Total number of double-bit persistent ECC errors. |
| DCGM_FI_DEV_RETIRED_SBE                       | counter | Total number of retired pages due to single-bit errors. |
| DCGM_FI_DEV_RETIRED_DBE                       | counter | Total number of retired pages due to double-bit errors. |
| DCGM_FI_DEV_RETIRED_PENDING                   | counter | Total number of pages pending retirement. |
| DCGM_FI_DEV_NVLINK_CRC_FLIT_ERROR_COUNT_TOTAL | counter | Total number of NVLink flow-control CRC errors. |
| DCGM_FI_DEV_NVLINK_CRC_DATA_ERROR_COUNT_TOTAL | counter | Total number of NVLink data CRC errors. |
| DCGM_FI_DEV_NVLINK_REPLAY_ERROR_COUNT_TOTAL   | counter | Total number of NVLink retries. |
| DCGM_FI_DEV_NVLINK_RECOVERY_ERROR_COUNT_TOTAL | counter | Total number of NVLink recovery errors. |
| DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL            | counter | Total number of NVLink bandwidth counters for all lanes. |
| DCGM_FI_DEV_NVLINK_BANDWIDTH_L0               | counter | The number of bytes of active NVLink rx or tx data including both header and payload. |
| DCGM_FI_DEV_VGPU_LICENSE_STATUS               | gauge   | vGPU License status. |
| DCGM_FI_DEV_UNCORRECTABLE_REMAPPED_ROWS       | counter | Number of remapped rows for uncorrectable errors. |
| DCGM_FI_DEV_CORRECTABLE_REMAPPED_ROWS         | counter | Number of remapped rows for correctable errors. |
| DCGM_FI_DEV_ROW_REMAP_FAILURE                 | gauge   | Whether remapping of rows has failed. |
| DCGM_FI_PROF_GR_ENGINE_ACTIVE                 | gauge   | Ratio of time the graphics engine is active (in %). |
| DCGM_FI_PROF_SM_ACTIVE                        | gauge   | The ratio of cycles an SM has at least 1 warp assigned (in %). |
| DCGM_FI_PROF_SM_OCCUPANCY                     | gauge   | The ratio of number of warps resident on an SM (in %). |
| DCGM_FI_PROF_PIPE_TENSOR_ACTIVE               | gauge   | Ratio of cycles the tensor (`HMMA`) pipe is active (in %). |
| DCGM_FI_PROF_DRAM_ACTIVE                      | gauge   | Ratio of cycles the device memory interface is active sending or receiving data (in %). |
| DCGM_FI_PROF_PIPE_FP64_ACTIVE                 | gauge   | Ratio of cycles the fp64 pipes are active (in %). |
| DCGM_FI_PROF_PIPE_FP32_ACTIVE                 | gauge   | Ratio of cycles the fp32 pipes are active (in %). |
| DCGM_FI_PROF_PIPE_FP16_ACTIVE                 | gauge   | Ratio of cycles the fp16 pipes are active (in %). |
| DCGM_FI_PROF_PCIE_TX_BYTES                    | gauge   | The rate of data transmitted over the PCIe bus - including both protocol headers and data payloads - in bytes per .second. |
| DCGM_FI_PROF_PCIE_RX_BYTES                    | gauge   | The rate of data received over the PCIe bus - including both protocol headers and data payloads - in bytes per .second. |
| DCGM_FI_DRIVER_VERSION                        | label   | Driver Version. |
