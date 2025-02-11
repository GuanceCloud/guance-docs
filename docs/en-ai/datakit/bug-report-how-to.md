# How to Analyze Datakit Bug Report

---

## Introduction to Bug Report {#intro}

Since Datakit is generally deployed in the user environment, to troubleshoot issues, it is necessary to obtain various on-site data. The Bug Report (hereafter referred to as BR) is used to collect this information while minimizing actions performed by on-site support engineers or users, reducing communication costs.

Through BR, we can obtain various runtime data of Datakit. According to the data directories under BR:

- *basic*: Basic machine environment information
- *config*: Various collection-related configurations
- *data*: Central configuration pull status
- *external*: Mainly logs and Profile data related to eBPF collectors [:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)
- *log*: Datakit's own program logs
- *metrics*: Prometheus metrics exposed by Datakit itself
- *profile*: Profile data of Datakit itself
- *pipeline*: Pipeline scripts [:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

The following sections explain how to use these collected information to troubleshoot specific issues.

## Viewing Basic Information {#basic}

BR filenames typically follow the format `info-<timestamp-ms>.zip`. By examining the timestamp (in milliseconds), we can determine when the BR was exported, which is useful for subsequent metric troubleshooting.

In the *info* file, it collects the current machine’s operating system information, including kernel version, distribution version, hardware architecture, etc. This information can assist in troubleshooting.

Additionally, if Datakit is installed in a container, it will also collect a set of environment variable configurations from the user side. All environment variables starting with `ENV_` are related to Datakit's main configuration or collector configurations.

## Viewing Collection Configurations {#config}

Under the *config* directory, all collector configurations and the main Datakit configuration are collected, with files having the `.conf.copy` suffix. These configurations are very helpful when troubleshooting data issues.

## Viewing Central Synchronization Data {#pull}

Under the *data* directory, there is a hidden file named *.pull* (in newer versions, this file is named *pull* and is no longer hidden). This file contains several types of configuration information pulled from the center:

``` shell
cat data/.pull | jq
```

The result is a JSON object, such as:

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

Sometimes, users report missing data, which could be due to their configured blacklists discarding the data. These blacklist rules can help us diagnose such data loss situations.

## Log Analysis {#logging}

Under the *log* directory, there are two files:

- *log*: This is the runtime log of Datakit. The information may be incomplete because Datakit periodically discards old logs (default 32MB).

In the *log* file, you can search for `run ID`, after which point it becomes a new startup log. If not found, it indicates that the logs have been rotated.

- *gin.log*: This is the access log recorded by Datakit as an HTTP service.

When integrating collectors like DDTrace, analyzing *gin.log* helps in troubleshooting the data collection status of DDTrace.

For other log analysis methods, refer to [this link](why-no-data.md#check-log).

## Metrics Analysis {#metrics}

Metrics analysis is a key part of BR analysis. Datakit exposes many [self-metrics](datakit-metrics.md#metrics). By analyzing these metrics, we can infer various behaviors of Datakit.

Each type of metric has different labels (label/tag), and combining these labels can better pinpoint issues.

### Collection Metrics {#collector-metrics}

Key metrics related to data collection include:

- `datakit_inputs_instance`: Indicates which collectors are enabled
- `datakit_io_last_feed_timestamp_seconds`: Last data collection time for each collector
- `datakit_inputs_crash_total`: Number of collector crashes
- `datakit_io_feed_cost_seconds`: Feed blocking duration; if this value is large, it suggests slow network upload, blocking normal collection
- `datakit_io_feed_drop_point_total`: Number of data points dropped during feed (currently defaults to dropping only time series metrics when blocked)

Analyzing these metrics can roughly reconstruct the operational status of each collector.

### Blacklist/Pipeline Execution Metrics {#filter-pl-metrics}

Blacklists/Pipelines are user-defined data processing modules that significantly impact data collection:

- Blacklists primarily discard data, and user-written rules might accidentally discard some data, leading to incomplete data.
- Pipelines can also discard data using the `drop()` function. During data processing, complex operations (e.g., complex regular expression matching) can consume significant resources, causing delays in collection and issues like log skipping[^log-skip].

[^log-skip]: Log skipping refers to the situation where the collection speed cannot keep up with the log generation speed. When users set up log rotation mechanisms, the first log file may not be fully collected before the second log file arrives, which then gets overwritten by the third log file. In this case, the second log file is skipped, and the collector never detects its existence, thus skipping it and directly collecting the third log file.

Key metrics involved include[^metric-naming]:

- `pipeline_drop_point_total`: Number of points dropped by Pipeline
- `pipeline_cost_seconds`: Time spent processing points by Pipeline; if it takes too long (ms level), it can block collection
- `datakit_filter_point_dropped_total`: Number of points dropped by blacklist

[^metric-naming]: Different versions of Datakit may have different naming conventions for Pipeline-related metrics. Here, we list only their common suffixes.

### Data Upload Metrics {#dataway-metrics}

Data upload metrics mainly refer to HTTP-related metrics of the Dataway reporting module.

- `datakit_io_dataway_point_total`: Total number of points uploaded (not necessarily all successful)
- `datakit_io_dataway_http_drop_point_total`: Points discarded during upload after retries fail
- `datakit_io_dataway_api_latency_seconds`: Latency in calling the Dataway API; if high, it can block collector operation
- `datakit_io_http_retry_total`: High retry counts indicate poor network quality or heavy central load

### Basic Metrics {#basic-metrics}

Basic metrics refer to business metrics during Datakit's operation, including:

- `datakit_cpu_usage`: CPU consumption
- `datakit_heap_alloc_bytes/datakit_sys_alloc_bytes`: Golang runtime heap/sys memory metrics; OOM usually occurs when the latter exceeds the memory limit
- `datakit_uptime_seconds`: Datakit uptime; an important auxiliary metric
- `datakit_data_overuse`: If the workspace is overcharged, Datakit reporting data fails, and this metric value is 1; otherwise, it is 0
- `datakit_goroutine_crashed_total`: Count of crashed Goroutines; critical Goroutine crashes can affect Datakit's normal operation

### Monitor View {#monitor-play}

The built-in monitor command of Datakit can visualize some key metrics in BR, making it more user-friendly compared to viewing raw numbers:

```shell
$ datakit monitor -P info-1717645398232/metrics
...
```

By default, BR collects three sets of metrics (each differing by about 10 seconds), so the monitor updates in real-time.

### Invalid Metrics Issue {#invalid-metrics}

BR provides significant assistance in problem analysis, but often users restart Datakit upon discovering issues, leading to lost on-site data and invalid BR data.

We can use the built-in [`dk` collector](../integrations/dk.md) to collect Datakit's own data (it is recommended to add it to the default collectors in newer Datakit versions[:octicons-tag-24: Version-1.11.0](changelog.md#cl-1.11.0)). This archives Datakit's metrics and reports them to the user's workspace. In the `dk` collector, enabling all self-metrics can provide even more detailed data (though it consumes more time series).

- For Kubernetes installations, enable all Datakit metrics using `ENV_INPUT_DK_ENABLE_ALL_METRICS`.
- For host installations, modify `dk.conf` and uncomment the first metric filter (`# ".*"`), allowing all metrics to be collected.

This way, all metrics exposed by Datakit are collected into the user's workspace. In the workspace, search for `datakit` in the "Built-in Views" (select "Datakit(New)") to visualize these metrics.

## Pipeline View {#pipeline}

[:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

If users configure Pipelines, a copy of the Pipeline configuration will be saved under the *pipeline* directory. Reviewing these Pipelines can help identify issues with data field splitting; if certain Pipelines take too long, optimization suggestions can be provided to reduce script overhead.

## External Information {#external}

[:octicons-tag-24: Version-1.33.0](changelog.md#cl-1.33.0)

Under the *external* directory, logs and debugging information from external collectors (mainly eBPF collectors) are collected to assist in troubleshooting issues related to these external collectors.

## Profile Analysis {#profile}

Profile analysis is primarily for developers. Through the profile in BR, we can analyze memory/CPU usage hotspots of Datakit at the time of BR collection. These profiles guide us in optimizing existing code or identifying potential bugs.

In the *profile* directory, the following files exist:

- *allocs*: Total memory allocations since Datakit started. This file shows where most memory allocations occur. Some areas may not need as much allocation.
- *heap*: Memory usage distribution at the moment of BR collection. Memory leaks are likely visible here (usually in modules that don't require much memory).
- *profile*: CPU usage of the current Datakit process. Unnecessary modules may consume too much CPU (e.g., frequent JSON parsing).

Other files (*block/goroutine/mutex*) are currently not used for troubleshooting.

To view these profile data in a browser (recommended using Golang 1.20+ for better visualization):

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

Then simply use:

```shell
gtp profile/heap
```

## Conclusion {#conclude}

While BR may not solve all problems, it avoids many communication gaps and misleads. It is recommended to provide corresponding BR when reporting issues. Existing BRs will continue to improve by exposing more metrics and collecting additional environmental information (e.g., client-side Tracing information), further enhancing the troubleshooting experience.