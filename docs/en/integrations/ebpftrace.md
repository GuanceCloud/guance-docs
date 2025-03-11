---
title     : 'eBPF Tracing'
summary   : 'Associate eBPF-collected link spans to generate traces'
tags:
  - 'Trace Linking'
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

The eBPF tracing feature consists of an eBPF Span (hereafter referred to as eSpan) collector and a linker that aggregates and links eSpans to generate Traces.

- The collection function of eSpans is implemented by the `ebpf` external collector in DataKit.
- The data aggregation and linking functions are implemented by the `ebpftrace` collector in DataKit ELinker or DataKit.

A single `ebpftrace` collector receives and links eSpan data from multiple `ebpf` collectors, with a current ratio requirement of **`1:N`**.

### Installing the eSpan Collector {#install-ebpf-agent}

Deploy [DataKit](../datakit/datakit-install.md) on the host or cluster.

### Installing the eSpan Linker {#install-linker}

There are installation options for both host deployment and Kubernetes deployment:

- Host deployment of DataKit ELinker version or DataKit, two methods that currently overlap:
    1. Install [*DataKit ELinker*](../datakit/datakit-install.md#elinker-install). This version does not include the `ebpf` collector.
    1. Install [*DataKit*](../datakit/datakit-install.md#get-install). This method may be deprecated in the future.

- Kubernetes deployment of DataKit ELinker:

Download [*datakit-elinker.yaml*](https://static.guance.com/datakit/datakit-elinker.yaml), execute the command `kubectl apply -f datakit-elinker.yaml`, and use the specified namespace `datakit-elinker` like `kubectl -n datakit-elinker get all -owide` to view related resources.

*To reduce the possibility of data pollution caused by misoperation, it is recommended to deploy DataKit ELinker instead of DataKit. The DataKit ELinker version reduces the binary size by about 50% and the image size by about 75% compared to DataKit.*

## Configuration {#config}

### Prerequisites {#requirements}

If the data volume is around 1e6 spans/min, at least 4 CPU cores and 4 GB of memory are required, and it is recommended to deploy on a host using SSD drives.

The `ebpftrace` plugin in DataKit ELinker or DataKit is used to receive and link eBPF spans, ultimately generating trace IDs and establishing parent-child relationships between spans.

Please refer to the following deployment model (as shown in the figure): All `ebpf` external collectors' [`ebpf-trace`](./ebpf.md#ebpf-trace) plugins must send the generated eBPF span data **to the same DataKit ELinker or DataKit with the `ebpftrace` collector enabled**.

> If three applications App 1～3 of a service are located on two different nodes, `ebpftrace` currently determines the network call relationship between processes based on TCP sequence numbers, etc., requiring the relevant eBPF spans to be linked to generate trace_id and set parent_id.

![img0](./imgs/tracing.png)

### Configuration of the `ebpftrace` Plugin in DataKit ELinker/DataKit {#ebpftrace-config}

Enable the `ebpftrace` plugin in DataKit ELinker or DataKit.

Configuration items:

- `db_path`:
    - Description: Directory to store database files.
    - Environment variable: `ENV_INPUT_EBPFTRACE_DB_PATH`
- `use_app_trace_id`:
    - Description: Whether to inherit the trace id propagated by agents like DataDog/OTEL over the network path.
    - Environment variable: `ENV_INPUT_EBPFTRACE_USE_APP_TRACE_ID`
- `window`:
    - Description: Set the waiting time window for linking eBPF Trace Spans, which can also be considered as the supported duration of eBPF links.
    - Environment variable: `ENV_INPUT_EBPFTRACE_WINDOW`
- `sampling_rate`:
    - Description: Set the trace sampling rate, range `0.0 - 1.0`, with `1.0` meaning no sampling. **Default sampling rate is `0.1 (10%)`.**
    - Environment variable: `ENV_INPUT_EBPFTRACE_SAMPLING_RATE`

Configuration method:

- For host deployment configuration:
  The configuration file is located in the `conf.d/ebpftrace` directory under `/var/usr/local/datakit`. Copy `ebpftrace.conf.sample` and rename it to `ebpftrace.conf`.

  ```toml
  [[inputs.ebpftrace]]
    db_path = "./ebpf_spandb"
    use_app_trace_id = true
    window = "20s"
    sampling_rate = 0.1
  ```

- For Kubernetes deployment configuration:
  Modify the environment variables in `datakit-elinker.yaml`. The mandatory configuration is the `dataway` address `ENV_DATAWAY`, and the sampling rate `ENV_INPUT_EBPFTRACE_WINDOW` can be configured as needed:

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

After completing the settings, provide the `<ip>:<port>` of [DataKit ELinker](../datakit/datakit-install.md#elinker-install)/DataKit or the relevant K8s Service to the eBPF collector for eBPF Span transmission.

### Configuration of the `ebpf` Plugin in DataKit {#ebpf-config}

Refer to the [eBPF collector environment variables and configuration items](./ebpf.md#input-cfg-field-env) for detailed configuration items.

To enable this collector, make the following settings in the configuration file:

Set the address of the `trace_server` to the address of DataKit ELinker/DataKit with the `ebpftrace` plugin enabled.

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

There are several methods to choose whether to trace other processes:

- Set `trace_all_process` to `true` to trace all processes, which can be combined with `trace_name_blacklist` or `trace_env_blacklist` to exclude some processes you do not want to collect.
- Set `trace_env_list` to trace processes containing any one of the specified **environment variables**.
- Set `trace_name_list` to trace processes containing any one of the specified **process names**.

You can inject any of the following environment variables into the collected process to set the service name for the span:

- `DK_BPFTRACE_SERVICE`
- `DD_SERVICE`
- `OTEL_SERVICE_NAME`
