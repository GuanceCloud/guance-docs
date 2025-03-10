# How to Analyze Datakit Bug Report

---

## Introduction to Bug Report {#intro}

Since Datakit is typically deployed in user environments, to troubleshoot issues, it's necessary to gather various on-site data. The Bug Report (referred to as BR hereafter) is used to collect this information while minimizing the need for on-site support engineers or users to perform too many operations, thereby reducing communication costs.

Through BR, we can obtain various on-site data about Datakit during its runtime, categorized as follows:

- *basic*: Basic machine environment information
- *config*: Configuration related to various collectors
- *data*: Central configuration pull status
- *external*: Primarily logs and Profile data related to eBPF collectors [:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)
- *log*: Datakit program logs
- *metrics*: Prometheus metrics exposed by Datakit
- *profile*: Profile data of Datakit itself
- *pipeline*: Pipeline scripts [:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

The following sections will explain how to use this information to diagnose specific issues.

## Viewing Basic Information {#basic}

BR filenames generally follow the format `info-<timestamp-ms>.zip`. Using this timestamp (in milliseconds), we can determine when the BR was exported, which is useful for subsequent metric analysis.

In the *info* file, it collects the current machine's operating system information, including kernel version, distribution version, hardware architecture, etc. This information can assist in troubleshooting.

Additionally, if Datakit is containerized, it also collects a set of user-side environment variable configurations. All environment variables starting with `ENV_` are related to Datakit's main configuration or collector configurations.

## Viewing Collector Configurations {#config}

Under the *config* directory, all collector configurations and the main Datakit configuration are collected, with files ending in `.conf.copy`. These configurations are very helpful when troubleshooting data issues.

## Viewing Central Sync Data {#pull}

Under the *data* directory, there is a hidden file named *.pull* (in newer versions, this file is simply named *pull* and no longer hidden). It contains several types of configuration information pulled from the center:

``` shell
cat data/.pull | jq
```

The result is a JSON object, like this:

```json
{
  "dataways": null,
  "filters": {       # <--- This is the blacklist
    "logging": [
      "{ ... }"
    ],
    "rum": [
      "{ ... }"
    ],
    "tracing": [
      "{ ... }",
    ]
  },
  "pull_interval": 10000000000,
  "remote_pipelines": null
}
```

Sometimes, users report missing data, which could be due to their configured blacklists discarding the data. These blacklist rules can help us diagnose such data loss.

## Log Analysis {#logging}

Under the *log* directory, there are two files:

- *log*: This is the Datakit program runtime log. Information may be incomplete because Datakit periodically (default 32MB) discards old logs.

In the *log* file, you can search for `run ID`, which marks the start of a new runtime log after a restart. If not found, it indicates that the logs have been rotated.

- *gin.log*: This is the access log recorded by Datakit as an HTTP service.

When integrating collectors like DDTrace, analyzing *gin.log* can help diagnose DDTrace data collection issues.

For other log analysis methods, refer to [this link](why-no-data.md#check-log).

## Metrics Analysis {#metrics}

Metrics analysis is a key part of BR analysis. Datakit exposes numerous [self-metrics](datakit-metrics.md#metrics). By analyzing these metrics, we can infer Datakit's behavior.

Each type of metric has different labels (label/tag). Combining these labels helps better pinpoint issues.

### Data Collection Metrics {#collector-metrics}

Key metrics related to data collection include:

- `datakit_inputs_instance`: Indicates which collectors are enabled
- `datakit_io_last_feed_timestamp_seconds`: Timestamp of the last data collection by each collector
- `datakit_inputs_crash_total`: Number of collector crashes
- `datakit_io_feed_cost_seconds`: Feed blocking duration; high values suggest slow network uploads, blocking normal collection
- `datakit_io_feed_drop_point_total`: Number of dropped data points during feed (currently defaults to dropping time series metrics only during blockage)

Analyzing these metrics provides insight into the operational status of each collector.

### Blacklist/Pipeline Execution Metrics {#filter-pl-metrics}

Blacklists/Pipelines are user-defined data processing modules that significantly impact data collection:

- Blacklists discard data, and user-written rules might inadvertently drop some data, leading to incomplete data
- Pipelines can also drop data using the `drop()` function. During data processing, complex operations (e.g., intricate regular expressions) might consume significant resources, causing delays like log skips[^log-skip].

[^log-skip]: Log skips occur when the collection speed cannot keep up with log generation. When log rotation is enabled, if the first log hasn't finished collecting and the second log isn't processed in time, it gets overwritten by the third log, making the second log invisible to the collector, thus skipping it and directly collecting the third log file.

Key metrics involved include[^metric-naming]:

- `pipeline_drop_point_total`: Number of points dropped by Pipeline
- `pipeline_cost_seconds`: Time spent processing points by Pipeline; long durations (ms-level) can cause collection blockages
- `datakit_filter_point_dropped_total`: Number of points dropped by blacklists

[^metric-naming]: Different Datakit versions may name Pipeline-related metrics differently. Only common suffixes are listed here.

### Data Upload Metrics {#dataway-metrics}

Data upload metrics primarily refer to HTTP-related metrics of the Dataway reporting module.

- `datakit_io_dataway_point_total`: Total number of uploaded points (not all successful)
- `datakit_io_dataway_http_drop_point_total`: Points discarded by Datakit after failed retries
- `datakit_io_dataway_api_latency_seconds`: Latency in calling Dataway API; high latency can block collector operations
- `datakit_io_http_retry_total`: High retry counts indicate poor network quality or heavy central load

### Basic Metrics {#basic-metrics}

Basic metrics mainly refer to business metrics during Datakit's operation:

- `datakit_cpu_usage`: CPU consumption
- `datakit_heap_alloc_bytes/datakit_sys_alloc_bytes`: Golang runtime heap/sys memory metrics; OOM usually occurs when the latter exceeds memory limits
- `datakit_uptime_seconds`: Duration since Datakit started; important auxiliary metric
- `datakit_data_overuse`: If the workspace is over quota, Datakit reporting fails, and this metric value is 1, otherwise 0
- `datakit_goroutine_crashed_total`: Count of crashed Goroutines; critical Goroutine crashes affect Datakit's normal operation

### Monitor View {#monitor-play}

Datakit's built-in monitor command can play back key metrics from BR, providing a visual representation. Compared to plain numbers, it offers a more intuitive experience:

```shell
$ datakit monitor -P info-1717645398232/metrics
...
```

By default, BR collects three sets of metrics (each differing by about 10 seconds), so monitor playback updates in real-time.

### Invalid Metrics Issue {#invalid-metrics}

While BR provides substantial assistance in issue diagnosis, users often restart Datakit upon discovering problems, invalidating the collected data.

We recommend using the built-in [`dk` collector](../integrations/dk.md) to collect Datakit's own metrics (suggest adding it to default collectors; newer Datakit versions[:octicons-tag-24: Version-1.11.0](changelog.md#cl-1.11.0) do this by default) and report them to the user's workspace. This archives Datakit's metrics. In the `dk` collector, enabling all self-metrics collection (consuming more Time Series):

- In Kubernetes installations, enable all Datakit metrics via `ENV_INPUT_DK_ENABLE_ALL_METRICS`
- For host installations, modify `dk.conf` and uncomment the first metric filter (`# ".*"`) to allow all metric collection

This archives all Datakit-exposed metrics to the user's workspace. In the workspace, search for `datakit` (choose "Datakit(New)") under "Built-in Views" to visualize these metrics.

## Pipeline View {#pipeline}

[:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

If users configure Pipelines, a copy is saved in the *pipeline* directory. Reviewing these Pipelines helps identify data field parsing issues; if some Pipelines consume excessive time, optimization suggestions can be provided to reduce script overhead.

## External Information {#external}

[:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

Under the *external* directory, logs and debug information from external collectors (mainly eBPF collectors) are collected to aid in diagnosing issues related to these collectors.

## Profile Analysis {#profile}

Profile analysis is primarily for developers. Through BR profiles, we can analyze Datakit's memory/CPU usage hotspots at the time of BR collection. These profiles guide code optimization or reveal potential bugs.

In the *profile* directory, the following files exist:

- *allocs*: Total memory allocations since Datakit startup. This file reveals where most memory allocations occur.
- *heap*: Current memory distribution. Memory leaks are likely visible here (typically in modules that don't require much memory).
- *profile*: Current CPU consumption of the Datakit process. Unnecessary modules may consume too much CPU (e.g., frequent JSON parsing).

Other files (*block/goroutine/mutex*) are not yet used for issue diagnosis.

Use the following command to view these profile data in a browser (preferably with Go 1.20+ for better visualization):

```shell
go tool pprof -http=0.0.0.0:8080 profile/heap
```

You can create an alias in your shell for easier access:

```shell
# /your/path/to/bashrc
__gtp() {
    port=$(shuf -i 40000-50000 -n 1) # Random port between 40000 ~ 50000

    go tool pprof -http=0.0.0.0:${port} ${1}
}
alias gtp='__gtp'
```

```shell
source /your/path/to/bashrc
```

Use the following command directly:

```shell
gtp profile/heap
```

## Conclusion {#conclude}

While BR may not solve all problems, it avoids many communication gaps and misdirections. Therefore, it's recommended to provide corresponding BRs when reporting issues. Existing BRs will continue to improve by exposing more metrics and collecting additional environmental information (such as client information related to Tracing) to further enhance the issue diagnosis experience.