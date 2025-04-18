---
title     : 'eBPF Tracing'
summary   : 'Associate eBPF span and generate trace'
tags:
  - 'APM'
  - 'TRACING'
  - 'EBPF'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :material-kubernetes:

---

## Installation {#install}

The eBPF link function is divided into the eBPF Span (hereinafter referred to as eSpan) collector and the linker that collects and links eSpan to generate traces.

- eSpan's collection functionality is implemented by the `ebpf` external collector in DataKit
- Data aggregation and linking functionality is implemented by the `ebpftrace` collector in DataKit ELinker/DataKit.

A single `ebpftrace` collector receives and links eSpan data from multiple `ebpf` collectors, which currently must be in a **`1:N`** ratio.

### Install the eSpan collector {#install-ebpf-agent}

Deploy [DataKit](../datakit/datakit-install.md) on the host or cluster.

### Install the eSpan linker {#install-linker}

There are host deployment and Kubernetes deployment installation solutions:

- Deploy the ELinker version of DataKit or DataKit on the host. The two methods will currently overwrite each other:

    1. Install [*DataKit ELinker*](../datakit/datakit-install.md#elinker-install). This version does not contain the `ebpf` collector.
    1. Install [*DataKit*](../datakit/datakit-install.md#get-install). This method may be deprecated later.

- Deploy DataKit ELinker on Kubernetes:

Download [*datakit-elinker.yaml*](https://static.guance.com/datakit/datakit-elinker.yaml), execute the command `kubectl apply -f datakit-elinker.yaml`, we can view related resources by specifying the namespace `datakit-elinker`, such as `kubectl -n datakit-elinker get all -owide`

*In order to reduce the possibility of data pollution caused by misoperation, it is recommended to deploy DataKit ELinker instead of DataKit. The ELinker version of DataKit is about 50% and 75% smaller than the binary and image size of DataKit, respectively.*

## Configuration {#config}

### Prerequisites {#requirements}

If the data volume is 1e6 span/min, at least 4C of cpu resources and 4G of mem resources are currently required. It is recommended to deploy on a host with an SSD hard drive.

The `ebpftrace` plugin in DataKit ELinker or DataKit is used to receive and link eBPF spans, ultimately generating link trace_ids and establishing parent-child relationships between spans.

Please refer to the following deployment model (as shown below): The eBPF span data generated by the [`ebpf-trace`](./ebpf.md#ebpf-trace) plugin of all `ebpf` external collectors needs to be **sent to the same DataKit ELinker or DataKit** with the `ebpftrace` collector enabled.

> If three applications App 1 to 3 of a service are located on two different nodes, `ebpftrace` currently confirms the network call relationship between processes based on tcp seq, etc., and needs to link the relevant eBPF spans to generate trace_id and set parent_id.

![img0](./imgs/tracing.png)

<!-- markdownlint-disable MD013 -->
### DataKit ELinker/DataKit `ebpftrace` plugin configuration {#ebpftrace-config}
<!-- markdownlint-enable -->

Enable the `ebpftrace` plugin in DataKit ELinker or DataKit.

Configuration items:

- `db_path`:
    - Description: The directory where the database files are stored.
    - Environment variable: `ENV_INPUT_EBPFTRACE_DB_PATH`
- `use_app_trace_id`:
    - Description: Whether to inherit the trace id propagated by agents such as DataDog/OTEL on the network path.
    - Environment variable: `ENV_INPUT_EBPFTRACE_USE_APP_TRACE_ID`
- `window`:
    - Description: Set the link waiting time window of the eBPF Trace Span, which can also be regarded as the duration of the supported eBPF link.
    - Environment variable: `ENV_INPUT_EBPFTRACE_WINDOW`
- `sampling_rate`:
    - Description: Set the link sampling rate, ranging from `0.0 - 1.0`, and a value of `1.0` means no sampling. **By default, `0.1(10%)` sampling is enabled**.
    - Environment variable: `ENV_INPUT_EBPFTRACE_SAMPLING_RATE`

Configuration method:

- Configuration of host deployment scheme:
  The configuration file is located in the `conf.d/ebpftrace` directory under the `/var/usr/local/datakit` directory. Copy `ebpftrace.conf.sample` and name it `ebpftrace.conf`.

  ```toml
  [[inputs.ebpftrace]]
    db_path = "./ebpf_spandb"
    use_app_trace_id = true
    window = "20s"
    sampling_rate = 0.1
  ```

- Kubernetes deployment configuration:
  Modify the environment variables in `datakit-elinker.yaml`. The `dataway` address `ENV_DATAWAY` must be configured, and the sampling rate `ENV_INPUT_EBPFTRACE_WINDOW` must be configured as needed:

  ```yaml
  - name: ENV_DATAWAY
    value: https://openway.guance.com?token=<YOUR-WORKSPACE-TOKEN> # Fill your real Dataway server and(or) workspace token
  - name: ENV_INPUT_EBPFTRACE_WINDOW
    value: 20s # ebpf trace span link window
  - name: ENV_INPUT_EBPFTRACE_SAMPLING_RATE
    value: '0.1' # 0.0 - 1.0 (1.0 means no sampling)
  - name: ENV_INPUT_EBPFTRACE_USE_APP_TRACE_ID
    value: 'true' # true means use app trace id (from otel, datadog ...) as ebpf trace id in ebpftrace
  - name: ENV_INPUT_EBPFTRACE_DB_PATH
    value: /usr/local/datakit/ebpf_spandb/
  ```

After completing the setup, provide [DataKit ELinker](../datakit/datakit-install.md#elinker-install)/DataKit or the `<ip>:<port>` of the relevant K8s Service to the eBPF collector for the transmission of eBPF Span.

### DataKit's `ebpf` plugin configuration {#ebpf-config}

For details of the configuration items, see [eBPF collector environment variables and configuration items](./ebpf.md#input-cfg-field-env).

To enable this collector, you need to make the following settings in the configuration file:

For the configuration item `trace_server`, fill in the address of the DataKit ELinker/DataKit with the `ebpftrace` plugin enabled.

```toml
[[inputs.ebpf]]
  enabled_plugins = [
    "ebpf-net",
    "ebpf-trace",
  ]

  l7net_enabled = [
    "httpflow",
  ]

  trace_server = "x.x.x.x:9529"

  trace_all_process = false
  
  trace_env_list = [
    "DK_BPFTRACE_SERVICE",
    "DD_SERVICE",
    "OTEL_SERVICE_NAME",
  ]
  trace_env_blacklist = []
  
  trace_name_list = []
  trace_name_blacklist = [
    ## The following two processes are hard-coded to never be traced,
    ## and do not need to be set:
    ##
    # "datakit",
    # "datakit-ebpf",
  ]
```

There are several ways to choose whether to trace other processes:

- Set `trace_all_process` to `true` to trace all processes, and use `trace_name_blacklist` or `trace_env_blacklist` to exclude some processes that you do not want to collect
- Set `trace_env_list` to trace processes that contain any specified **environment variable**.
- Set `trace_name_list` to trace processes that contain any specified **process name**.

You can set the span service name by injecting any of the following environment variables into the collected process:

- `DK_BPFTRACE_SERVICE`
- `DD_SERVICE`
- `OTEL_SERVICE_NAME`
