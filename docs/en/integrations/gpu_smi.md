---
title     : 'GPU'
summary   : 'Collect NVIDIA GPU Metrics data'
tags:
  - 'HOST'
__int_icon      : 'icon/gpu_smi'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

Collects data including GPU temperature, clock speed, GPU utilization, memory utilization, and memory usage for each running program on the GPU.

## Configuration {#config}

### Install Drivers and CUDA Toolkit {#install-driver}

Refer to [https://www.nvidia.com/Download/index.aspx](https://www.nvidia.com/Download/index.aspx){:target="_blank"}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/gpu_smi` directory under the DataKit installation directory, copy `gpu_smi.conf.sample`, and rename it as `gpu_smi.conf`. Example configuration is as follows:
    
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
    
        1. DataKit can collect metrics from GPU servers remotely via SSH (local collection configuration will be disabled after enabling remote collection).
        1. The number of `remote_addrs` can exceed the numbers of `remote_users`, `remote_passwords`, or `remote_rsa_paths`; insufficient ones will match the first value.
        1. Collection can be performed using `remote_addrs` + `remote_users` + `remote_passwords`.
        1. Collection can also be done using `remote_addrs` + `remote_users` + `remote_rsa_paths` (after configuring RSA public keys, `remote_passwords` will be invalid).
        1. Election must be enabled after enabling remote collection (to prevent multiple DataKits from uploading duplicate data).
        1. For security reasons, you can change the SSH port or create a dedicated account specifically for GPU remote collection.
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (requires adding to ENV_DEFAULT_ENABLED_INPUTS as the default collector):

    - **ENV_INPUT_GPUSMI_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_GPUSMI_TIMEOUT**
    
        Timeout duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `timeout`
    
        **Default Value**: 5s
    
    - **ENV_INPUT_GPUSMI_BIN_PATH**
    
        Path to executable file
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `bin_path`
    
        **Example**: `["/usr/bin/nvidia-smi"]`
    
    - **ENV_INPUT_GPUSMI_PROCESS_INFO_MAX_LEN**
    
        Maximum number of resource-consuming GPU processes to collect
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `process_info_max_len`
    
        **Default Value**: 10
    
    - **ENV_INPUT_GPUSMI_DROP_WARNING_DELAY**
    
        Card drop warning delay
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `gpu_drop_warning_delay`
    
        **Default Value**: 5m
    
    - **ENV_INPUT_GPUSMI_ENVS**
    
        Path to dependent libraries
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `envs`
    
        **Example**: ["LD_LIBRARY_PATH=/usr/local/corex/lib/:$LD_LIBRARY_PATH"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_ADDRS**
    
        Remote GPU server
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_addrs`
    
        **Example**: ["192.168.1.1:22","192.168.1.2:22"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_USERS**
    
        Remote login name
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_users`
    
        **Example**: ["user_1","user_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_PASSWORDS**
    
        Remote login password
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_passwords`
    
        **Example**: ["pass_1","pass_2"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_RSA_PATHS**
    
        Secret key file path
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_rsa_paths`
    
        **Example**: ["/home/your_name/.ssh/id_rsa"]
    
    - **ENV_INPUT_GPUSMI_REMOTE_COMMAND**
    
        Remote execution command
    
        **Field Type**: String
    
        **Collector Configuration Field**: `remote_command`
    
        **Example**: "`nvidia-smi -x -q`"
    
    - **ENV_INPUT_GPUSMI_ELECTION**
    
        Enable election
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `election`
    
        **Default Value**: true
    
    - **ENV_INPUT_GPUSMI_TAGS**
    
        Custom tags. If there are tags with the same name in the configuration file, they will override them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics Fields {#metric}

All data collected by default appends the global election tag unless otherwise specified through `[inputs.gpu_smi.tags]`:

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

- Metrics List


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

- Operating System Support: :fontawesome-brands-linux: :material-kubernetes:

DCGM metrics include GPU card temperature, clock speed, GPU utilization, memory utilization, etc.

### DCGM Configuration {#dcgm-config}

#### DCGM Metrics Prerequisites {#dcgm-precondition}

Install `dcgm-exporter`, refer to [NVIDIA Official Website](https://github.com/NVIDIA/dcgm-exporter){:target="_blank"}

#### DCGM Collection Configuration {#dcgm-input-config}

Navigate to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and rename it as `prom.conf`. Example configuration is as follows:

```toml
[[inputs.prom]]
  ## Exporter URLs
  urls = ["http://127.0.0.1:9400/metrics"]

  ## Ignore request errors for URLs
  ignore_req_err = false

  ## Collector alias
  source = "dcgm"

  ## Output source for collected data
  ## Configuring this option writes collected data to a local file instead of sending it to the center
  ## Subsequently, the `datakit debug --prom-conf /path/to/this/conf` command can be used to debug locally saved Measurement
  ## If URL is already configured as a local file path, then the `--prom-conf` debugging prioritizes the output path data
  # output = "/abs/path/to/file"

  ## Upper limit for collected data size, in bytes
  ## When outputting data to a local file, an upper limit for the collected data size can be set
  ## If the size of the collected data exceeds this upper limit, the collected data will be discarded
  ## The upper limit for collected data size is set to 32MB by default
  # max_file_size = 0

  ## Filter metric types, possible values are counter/gauge/histogram/summary/untyped
  ## By default, only counter and gauge type metrics are collected
  ## If empty, no filtering is performed
  # metric_types = ["counter", "gauge"]

  ## Metric name filter: metrics that meet the criteria will be retained
  ## Supports regular expressions, multiple configurations can be set, satisfying any one suffices
  ## If empty, no filtering is performed, all metrics are retained
  # metric_name_filter = ["cpu"]

  ## Prefix for Measurement names
  ## Configuring this option adds a prefix to Measurement names
  measurement_prefix = "gpu_"

  ## Measurement name
  ## By default, the metric name is split by underscores ("_"), the first field becomes the Measurement name, the rest become the current metric name
  ## If `measurement_name` is configured, the metric name is not split
  ## The final Measurement name will have the `measurement_prefix` added
  measurement_name = "dcgm"

  ## TLS Configuration
  # tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## Set to true to enable election functionality
  election = true

  ## Filter tags, multiple tags can be configured
  ## Matching tags will be ignored, but the corresponding data will still be reported
  # tags_ignore = ["xxxx"]

  ## Custom authentication method, currently only Bearer Token is supported
  ## Only one of token or token_file needs to be configured
  # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

  ## Custom Measurement names
  ## Metrics containing the prefix `prefix` can be grouped into a single Measurement
  ## Custom Measurement name configuration takes precedence over `measurement_name` configuration
  # [[inputs.prom.measurements]]
    # prefix = "cpu_"
    # name = "cpu"

  # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"

  ## Discard data matching these tag key-value pairs
  # [inputs.prom.ignore_tag_kv_match]
    # key1 = [ "val1.*", "val2.*"]
    # key2 = [ "val1.*", "val2.*"]

  ## Add extra request headers in the HTTP request for data retrieval (e.g., Basic Authentication)
  # [inputs.prom.http_headers]
    # Authorization = “Basic bXl0b21jYXQ="

  ## Rename prom data tag keys
  [inputs.prom.tags_rename]
    overwrite_exist_tags = false
    [inputs.prom.tags_rename.mapping]
    Hostname = "host"
    # tag1 = "new-name-1"
    # tag2 = "new-name-2"

  ## Send collected metrics as logs to the center
  ## Leave the service field empty to set the service tag as the Measurement name
  [inputs.prom.as_logging]
    enable = false
    service = "service_name"

  ## Custom Tags
  # [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

## DCGM Metrics {#dcgm-metric}

### `gpu_dcgm` {#gpu-dcgm}

- Tags

| Tag                           | Description                                |
| ----                          | --------                                   |
| gpu                           | GPU id.                                    |
| device                        | Device.                                    |
| modelName                     | GPU model.                                 |
| Hostname                      | Host name.                                 |
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

- Metrics List

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
</example>