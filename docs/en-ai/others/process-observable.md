# How to Enable Process Monitoring
---

## Introduction

Guance supports real-time monitoring of various running processes in the system, collecting and analyzing process runtime Metrics such as memory usage rate, CPU time occupied, current process status, ports listened by the process, etc. By enabling the process collector, you can quickly view and analyze various Metrics information of process runtime through "Infrastructure," configure relevant alerts, understand the status of processes, and promptly maintain faulty processes when they fail.

## Prerequisites

- You need to first create a [Guance account](https://www.guance.com/)
- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Supported operating systems: `windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## Method/Steps

### Step1: Enable the Process Collector

After completing the installation of DataKit on the host machine/server, the host-related collectors, including the process object collector, are automatically enabled. For more configuration details, refer to [Collector Configuration](../datakit/datakit-input-conf.md).

| Collector Name       | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `cpu`                | Collects CPU usage statistics of the host             |
| `disk`               | Collects disk usage statistics                        |
| `diskio`             | Collects disk IO statistics of the host               |
| `mem`                | Collects memory usage statistics of the host          |
| `swap`               | Collects Swap memory usage statistics                 |
| `system`             | Collects host operating system load                   |
| `net`                | Collects network traffic statistics of the host       |
| `host_processes`     | Collects a list of long-running (over 10 minutes) processes on the host |
| `hostobject`         | Collects basic host information (e.g., OS info, hardware info) |
| `container`          | Collects possible container objects and container logs on the host |

### Step2: Enable Process Metrics Collection

The process collector does not collect process Metrics data by default. If you need to collect Metrics-related data, you can set `open_metric` to `true` in `host_processes.conf`. The configuration process is as follows:

1. Navigate to the `conf.d/host` directory under the DataKit installation directory.
2. Copy `host_processes.conf.sample` and rename it to `host_processes.conf`.
3. Open `host_processes.conf` and set `open_metric` to `true`. Example configuration:

```toml
[[inputs.host_processes]]
  # Only collect Metrics for these matched processes. For process objects,
  # these white lists do not apply. Process names support regular expressions.
  # process_name = [".*nginx.*", ".*mysql.*"]

  # Minimum process runtime (default 10m)
  # If the process runs for less time than this setting, we ignore it (both for Metrics and objects)
  min_run_time = "10m"

  ## Enable process Metrics collection
  open_metric = true

  # Extra tags
  [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

4. After completing the configuration, use the command `datakit --restart` to restart DataKit for changes to take effect.

If you installed DataKit via [K8S DaemonSet](../datakit/datakit-daemonset-deploy), you can modify the process collector's configuration parameters using environment variables. Refer to the [Process Collector](../integrations/host_processes.md) documentation for more details.

| Environment Variable Name                      | Corresponding Configuration Parameter | Parameter Example                                                     |
| ---------------------------------------------- | :------------------------------------ | :-------------------------------------------------------------------- |
| `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`         | `open_metric`                        | `true`/`false`                                                        |
| `ENV_INPUT_HOST_PROCESSES_TAGS`                | `tags`                               | `tag1=value1,tag2=value2` (if there are duplicate tags in the config file, they will be overwritten) |
| `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME`        | `process_name`                       | `".*datakit.*", "guance"` (comma-separated)                           |
| `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME`        | `min_run_time`                       | `"10m"`                                                               |