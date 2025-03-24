# How to Enable Process Monitoring
---

## Introduction

<<< custom_key.brand_name >>> supports real-time monitoring of various running processes in the system, obtaining and analyzing process runtime Metrics such as memory usage rate, CPU time occupied, current process status, ports listened by the process, etc. By enabling the process collector, you can quickly view and analyze various Metric information about the process runtime through "Infrastructure", configure relevant alerts, understand the status of the process, and maintain faulty processes in a timely manner when a process fails.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/)
- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Supported operating systems: `windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## Methods/Steps

### Step1: Enable the Process Collector

After completing the installation of DataKit on the host machine/server, the host-related collectors are automatically enabled, including the process object collector. For more configurations, refer to [Collector Configuration](../datakit/datakit-input-conf.md).

| Collector Name       | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `cpu`                | Collects CPU usage of the host                        |
| `disk`               | Collects disk usage                                  |
| `diskio`             | Collects disk IO conditions of the host               |
| `mem`                | Collects memory usage of the host                     |
| `swap`               | Collects Swap memory usage                           |
| `system`             | Collects host operating system load                   |
| `net`                | Collects network traffic conditions of the host        |
| `host_processes`     | Collects resident (alive for over 10min) process list |
| `hostobject`         | Collects basic host information (e.g., OS info, hardware info, etc.) |
| `container`          | Collects possible container objects and container logs |

### Step2: Enable Metrics Collection for Processes

The process collector does not collect process Metrics data by default. If you want to collect Metrics-related data, you can set `open_metric` to `true` in `host_processes.conf`. The configuration process is as follows:

1. Navigate to the `conf.d/host` directory under the DataKit installation directory.
1. Copy `host_processes.conf.sample` and rename it to `host_processes.conf`.
1. Open `host_processes.conf` and set `open_metric` to `true`. An example is shown below:

```toml
[[inputs.host_processes]]
  # Only collect Metrics from these matched processes. For process objects,
  # these white lists are not applied. Process name supports regexp.
  # process_name = [".*nginx.*", ".*mysql.*"]

  # Minimum process run time (default 10m)
  # If the process running time is less than the setting, we ignore it (both for Metrics and objects)
  min_run_time = "10m"

  ## Enable process Metrics collection
  open_metric = true

  # Extra tags
  [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

4. After completing the configuration, use the command `datakit --restart` to restart DataKit for the changes to take effect.

If you installed DataKit via [K8S daemonset](../datakit/datakit-daemonset-deploy), you can modify the process collector's configuration parameters using environment variables. For more details, refer to the documentation [Process Collector](../integrations/host_processes.md).

| Environment Variable Name                 | Corresponding Configuration Item | Parameter Example                                                     |
| ---------------------------------------- | :------------------------------- | :-------------------------------------------------------------------- |
| `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`   | `open_metric`                    | `true`/`false`                                                       |
| `ENV_INPUT_HOST_PROCESSES_TAGS`          | `tags`                           | `tag1=value1,tag2=value2` If there is a tag with the same name in the configuration file, it will overwrite it |
| `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME`  | `process_name`                   | `".*datakit.*", "guance"` Separated by English commas                |
| `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME`  | `min_run_time`                   | `"10m"`                                                              |