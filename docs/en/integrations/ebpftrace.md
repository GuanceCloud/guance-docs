---
title     : 'eBPF Tracing'
summary   : 'Associate eBPF collected link spans to generate traces'
tags:
  - 'APM'
  - 'EBPF'
__int_icon      : 'icon/ebpf'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :material-kubernetes:

---

## Installation {#install}

The eBPF tracing feature is divided into an eBPF Span (hereinafter referred to as eSpan) collector and a linker that aggregates and links eSpans to generate traces.

- The collection function of eSpan is implemented by the `ebpf` external collector in DataKit.
- The data aggregation and linking functions are implemented by the `ebpftrace` collector in DataKit ELinker/DataKit.

A single `ebpftrace` collector receives and links eSpan data from multiple `ebpf` collectors, and the current ratio must be **`1:N`**.

### Installing the eSpan Collector {#install-ebpf-agent}

Deploy [DataKit](../datakit/datakit-install.md) on the host or cluster.

### Installing the eSpan Linker {#install-linker}

There are host deployment and Kubernetes deployment installation options:

- Host deployment of the ELinker version of DataKit or DataKit, currently these two methods will overwrite each other:
    1. Install [*DataKit ELinker*](../datakit/datakit-install.md#elinker-install). This version does not include the `ebpf` collector.
    1. Install [*DataKit*](../datakit/datakit-install.md#get-install). This method may be deprecated later.

- Kubernetes deployment of DataKit ELinker:

Download [*datakit-elinker.yaml*](https://static.<<< custom_key.brand_main_domain >>>/datakit/datakit-elinker.yaml), execute the command `kubectl apply -f datakit-elinker.yaml`, you can specify the namespace `datakit-elinker`, such as `kubectl -n datakit-elinker get all -owide` to view related resources.

*To reduce the possibility of data pollution caused by misoperation, it is recommended to deploy DataKit ELinker instead of DataKit. The ELinker version of DataKit reduces the binary size by about 50% and the image size by about 75% compared to DataKit.*

## Configuration {#config}

### Prerequisites {#requirements}

If the data volume is 1e6 span/min, at least 4C CPU resources and 4G MEM resources need to be provided currently, and it is recommended to deploy on a host using SSD hard drives.

The `ebpftrace` plugin in DataKit ELinker or DataKit is used to receive and link eBPF spans, ultimately generating trace_id for the trace and establishing parent-child relationships between spans.

Please refer to the following deployment model (as shown in the figure below): All `ebpf` external collectors' [`ebpf-trace`](./ebpf.md#ebpf-trace) plugins must send the generated eBPF span data **to the same DataKit ELinker or DataKit with the `ebpftrace` collector enabled**.

> If three applications App 1～3 of a service are located on two different nodes, `ebpftrace` currently confirms the network call relationship between processes based on tcp seq, etc., and needs to link relevant eBPF spans to generate trace_id and set parent_id.

![img0](./imgs/tracing.png)

### Configuration of the `ebpftrace` Plugin in DataKit ELinker/DataKit {#ebpftrace-config}

Enable the `ebpftrace` plugin in DataKit ELinker or DataKit.

Configuration items:

- `db_path`:
    - Description: Directory where database files are stored.
    - Environment variable: `ENV_INPUT_EBPFTRACE_DB_PATH`
- `use_app_trace_id`:
    - Description: Whether to inherit the trace id propagated by network paths from DataDog/OTEL agents.
    - Environment variable: `ENV_INPUT_EBPFTRACE_USE_APP_TRACE_ID`
- `window`:
    - Description: Set the waiting time window for linking eBPF Trace Spans, which can also be considered as the duration supported by eBPF traces.
    - Environment variable: `ENV_INPUT_EBPFTRACE_WINDOW`
- `sampling_rate`:
    - Description: Set the trace sampling rate, range `0.0 - 1.0`, a value of `1.0` means no sampling. **Default sampling rate is `0.1(10%)`.**
    - Environment variable: `ENV_INPUT_EBPFTRACE_SAMPLING_RATE`

Configuration method:

- Host deployment configuration:
  The configuration file is located in the `conf.d/ebpftrace` directory under the `/var/usr/local/datakit` directory, copy `ebpftrace.conf.sample` and rename it to `ebpftrace.conf`.

  ```toml
  [[inputs.ebpftrace]]
    db_path = "./ebpf_spandb"
    use_app_trace_id = true
    window = "20s"
    sampling_rate = 0.1
  ```

- Kubernetes deployment configuration:
  Modify the environment variables in `datakit-elinker.yaml`, the required configuration is the `dataway` address `ENV_DATAWAY`, and the sampling rate `ENV_INPUT_EBPFTRACE_WINDOW` can be configured as needed:

  ```yaml
  - name: ENV_DATAWAY
    value: https://openway.<<< custom_key.brand_main_domain >>>?token=<YOUR-WORKSPACE-TOKEN> # Fill your real Dataway server and(or) workspace token
  - name: ENV_INPUT_EBPFTRACE_WINDOW
    value: 20s # ebpf trace span link window
  - name: ENV_INPUT_EBPFTRACE_SAMPLING_RATE
    value: '0.1' # 0.0 - 1.0 (1.0 means no sampling)
  - name: ENV_INPUT_EBPFTRACE_USE_APP_TRACE_ID
    value: 'true' # true means use app trace id (from otel, datadog ...) as ebpf trace id in ebpftrace
  - name: ENV_INPUT_EBPFTRACE_DB_PATH
    value: /usr/local/datakit/ebpf_spandb/
  ```

After completing the settings, provide the `<ip>:<port>` of [DataKit ELinker](../datakit/datakit-install.md#elinker-install)/DataKit or related K8s Service to the eBPF collector for eBPF Span transmission.

### Configuration of the `ebpf` Plugin in DataKit {#ebpf-config}

Refer to the details of configuration items in [eBPF Collector Environment Variables and Configuration Items](./ebpf.md#input-cfg-field-env).

To enable this collector, make the following settings in the configuration file:

Set the address of the `trace_server` to the address of the DataKit ELinker/DataKit that has the `ebpftrace` plugin enabled.

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

There are several methods to choose whether to perform trace tracking for other processes:

- Set `trace_all_process` to `true` to track all processes, and use `trace_name_blacklist` or `trace_env_blacklist` to exclude some processes that you do not want to collect.
- Set `trace_env_list` to track processes containing any specified **environment variable**.
- Set `trace_name_list` to track processes containing any specified **process name**.

You can inject any of the following environment variables into the process being collected to set the service name for the span:

- `DK_BPFTRACE_SERVICE`
- `DD_SERVICE`
- `OTEL_SERVICE_NAME`