---
title     : 'Profiling Golang'
summary   : 'Golang Profiling Integration'
tags:
  - 'GOLANG'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---


Go has built-in performance analysis (Profiling) tools `pprof`, which can collect performance data during program execution. These tools can be used in two ways:

- `runtime/pprof`: Through programming methods, customize the collection of runtime data, then save and analyze it.
- `net/http/pprof`: Calls `runtime/pprof` and encapsulates it into an interface, providing performance data via an HTTP Server.

Performance data mainly includes the following:

- `goroutine`: Call stack analysis of running Goroutines
- `heap`: Memory allocation status of active objects
- `allocs`: Memory allocation status of all objects
- `threadcreate`: OS thread creation analysis
- `block`: Blocking analysis
- `mutex`: Mutex analysis

Collected data can be analyzed using the official [`pprof`](https://github.com/google/pprof/blob/main/doc/README.md){:target="_blank"} tool.

DataKit can obtain this data through [pull mode](profile-go.md#pull-mode) or [push mode](profile-go.md#push-mode).

## Push Mode {#push-mode}

### DataKit Configuration {#push-datakit-config}

Enable the [profile](profile.md#config) collector in DataKit to register the profile HTTP service.

```toml
[[inputs.profile]]
  ## Profile Agent endpoints registered by version respectively.
  ## Endpoints can be skipped by removing them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]
```

### Go Application Configuration {#push-app-config}

Integrate [dd-trace-go](https://github.com/DataDog/dd-trace-go){:target="_blank"}, collect application performance data, and send it to DataKit. Refer to the following code example:

```go
package main

import (
    "log"
    "time"

    "gopkg.in/DataDog/dd-trace-go.v1/profiler"
)

func main() {
    err := profiler.Start(
        profiler.WithService("dd-service"),
        profiler.WithEnv("dd-env"),
        profiler.WithVersion("dd-1.0.0"),
        profiler.WithTags("k:1", "k:2"),
        profiler.WithAgentAddr("localhost:9529"), // DataKit url
        profiler.WithProfileTypes(
            profiler.CPUProfile,
            profiler.HeapProfile,
            // The profiles below are disabled by default to keep overhead low, but can be enabled as needed.

            // profiler.BlockProfile,
            // profiler.MutexProfile,
            // profiler.GoroutineProfile,
        ),
    )

    if err != nil {
        log.Fatal(err)
    }
    defer profiler.Stop()

    // your code here
    demo()
}

func demo() {
    for {
        time.Sleep(100 * time.Millisecond)
        go func() {
            buf := make([]byte, 100000)
            _ = len(buf)
            time.Sleep(1 * time.Hour)
        }()
    }
}
```

After running this program, DDTrace will periodically (default is every 1 minute) push data to DataKit.

### Generating Performance Metrics {#metrics}

Starting from [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0), DataKit supports extracting a set of Go runtime-related metrics from the output of `dd-trace-go`. This set of metrics is placed under the `profiling_metrics` measurement. Below are some of the metrics explained:

| Metric Name                             | Description                                                    | Unit         |
|------------------------------------|------------------------------------------------------------|------------|
| prof_go_cpu_cores                  | Number of CPU cores consumed                                      | core       |
| prof_go_cpu_cores_gc_overhead      | Number of CPU cores used for GC execution                              | core       |
| prof_go_alloc_bytes_per_sec        | Number of bytes allocated per second                                   | byte       |
| prof_go_frees_per_sec              | Number of objects freed by GC per second                                | count      |
| prof_go_heap_growth_bytes_per_sec  | Heap memory growth per second                                        | byte       |
| prof_go_allocs_per_sec             | Number of memory allocations per second                                 | count      |
| prof_go_alloc_bytes_total          | Total memory allocated during one profiling period (dd-trace defaults to a 60-second collection cycle) | byte       |
| prof_go_blocked_time               | Total duration of goroutine blocking during one profiling period                    | nanosecond |
| prof_go_mutex_delay_time           | Total time spent waiting for locks during one profiling period                        | nanosecond |
| prof_go_gcs_per_sec                | Number of GC runs per second                                         | count      |
| prof_go_max_gc_pause_time          | Longest pause time due to GC during one profiling period                         | nanosecond |
| prof_go_gc_pause_time              | Total pause time due to GC during one profiling period                          | nanosecond |
| prof_go_num_goroutine              | Current number of goroutines                                          | count      |
| prof_go_lifetime_heap_bytes        | Total size of live objects in heap memory                                     | byte       |
| prof_go_lifetime_heap_objects      | Total number of live objects in heap memory                                       | count      |

<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If you do not need it, you can modify the collector's configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` and set the `generate_metrics` option to false, then restart DataKit.

    ```toml
    [[inputs.profile]]

    ...

    ## Set false to stop generating APM metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->

## Pull Mode {#pull-mode}

### Enabling Profiling in Go Application {#app-config}

To enable profiling in the application, simply import the `pprof` package, as shown below:

```go
package main

import (
  "net/http"
   _ "net/http/pprof"
)

func main() {
    http.ListenAndServe(":6060", nil)
}
```

After running the code, you can check if it is successfully enabled by visiting `http://localhost:6060/debug/pprof/heap?debug=1`.

- Mutex and Block Performance Analysis

By default, mutex and block performance collection is not enabled. To enable it, add the following code:

```go
var rate = 1

// Enable mutex profiling
runtime.SetMutexProfileFraction(rate)

// Enable block profiling
runtime.SetBlockProfileRate(rate)
```

The `rate` sets the sampling frequency, where 1/rate events are collected. Setting it to 0 or less than 0 means no collection.

### DataKit Configuration {#datakit-config}

[Enable the Profile collector](profile.md) and configure `[[inputs.profile.go]]` as follows.

```toml
[[inputs.profile]]
  ## Profile Agent endpoints registered by version respectively.
  ## Endpoints can be skipped by removing them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]

  ## Set true to enable election
  election = true

 ## Go pprof configuration
[[inputs.profile.go]]
  ## pprof URL
  url = "http://localhost:6060"

  ## Pull interval, should be greater or equal than 10s
  interval = "10s"

  ## Service name
  service = "go-demo"

  ## App environment
  env = "dev"

  ## App version
  version = "0.0.0"

  ## Types to pull 
  ## Values: cpu, goroutine, heap, mutex, block
  enabled_types = ["cpu","goroutine","heap","mutex","block"]

[inputs.profile.go.tags]
  # tag1 = "val1"
```

<!-- markdownlint-disable MD046 -->
???+ note

    If you do not need to enable the Profile HTTP service, you can comment out the `endpoints` field.
<!-- markdownlint-enable -->

### Field Descriptions {#fields-info}

- `url`: Reporting address, such as `http://localhost:6060`
- `interval`: Collection interval, minimum 10s
- `service`: Service name
- `env`: Application environment type
- `version`: Application version
- `enabled_types`: Performance types, such as `cpu, goroutine, heap, mutex, block`

After configuring the Profile collector, start or restart DataKit. After some time, you can view the Go performance data in the Guance platform.