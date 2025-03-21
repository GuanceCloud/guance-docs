---
title     : 'Profiling Golang'
summary   : 'Golang Profiling Integration'
tags:
  - 'GOLANG'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---


Go has a built-in performance analysis (Profiling) tool called `pprof`, which can collect performance data during program execution. It can be used in the following two ways:

- `runtime/pprof`: Through programming methods, customize the collection of runtime data and then save for analysis.
- `net/http/pprof`: Calls `runtime/pprof` and encapsulates it into an interface, providing performance data via an HTTP Server.

Performance data mainly includes the following:

- `goroutine`: Call stack analysis of running Goroutines
- `heap`: Memory allocation status of active objects
- `allocs`: Memory allocation status of all objects
- `threadcreate`: OS thread creation analysis
- `block`: Blocking analysis
- `mutex`: Mutex lock analysis

The collected data can be analyzed using the official [`pprof`](https://github.com/google/pprof/blob/main/doc/README.md){:target="_blank"} tool.

DataKit can obtain these data through [active pulling](profile-go.md#pull-mode) (pull) or [passive pushing](profile-go.md#push-mode) (push).

## Push Mode {#push-mode}

### DataKit Configuration {#push-datakit-config}

DataKit enables the [profile](profile.md#config) collector and registers the profile http service.

```toml
[[inputs.profile]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]
```

### Go Application Configuration {#push-app-config}

Integrate with [dd-trace-go](https://github.com/DataDog/dd-trace-go){:target="_blank"}, to collect application performance data and send it to DataKit. Code reference is as follows:

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

After running this program, DDTrace will periodically (default every 1 minute) push the data to DataKit.

### Generating Performance Metrics {#metrics}

Datakit [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0) and above supports extracting a set of Go runtime-related metrics from the output of `dd-trace-go`. These metrics are placed under the `profiling_metrics` Measurement. Below are some of these metrics explained:

| Metric Name                              | Description                                                     | Unit         |
|-----------------------------------|--------------------------------------------------------|------------|
| prof_go_cpu_cores                 | Number of consumed CPU cores                                             | core       |
| prof_go_cpu_cores_gc_overhead     | Number of CPU cores used by GC execution                                      | core       |
| prof_go_alloc_bytes_per_sec       | Size of memory bytes allocated per second                                            | byte       |
| prof_go_frees_per_sec             | Number of GC recycled objects per second                                            | count      |
| prof_go_heap_growth_bytes_per_sec | Heap memory growth size per second                                              | byte       |
| prof_go_allocs_per_sec            | Number of memory allocations executed per second                                             | count      |
| prof_go_alloc_bytes_total         | Total memory size allocated during one profiling cycle (dd-trace defaults to a 60-second collection period) | byte       |
| prof_go_blocked_time              | Total duration of coroutine blocking during one profiling cycle                              | nanosecond |
| prof_go_mutex_delay_time          | Total time spent waiting for locks during one profiling cycle                          | nanosecond |
| prof_go_gcs_per_sec               | Number of GC executions per second                                             | count      |
| prof_go_max_gc_pause_time         | Longest interruption caused by GC during one profiling cycle                | nanosecond |
| prof_go_gc_pause_time             | Total interruption time caused by GC during one profiling cycle                   | nanosecond |
| prof_go_num_goroutine             | Current total number of goroutines                                                 | count      |
| prof_go_lifetime_heap_bytes       | Total memory size occupied by live objects in the current heap                                     | byte       |
| prof_go_lifetime_heap_objects     | Total number of live objects in the current heap                                          | count      |


<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If not needed, you can disable it by modifying the configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` and setting the configuration item `generate_metrics` to false, then restart Datakit.

    ```toml
    [[inputs.profile]]

    ...

    ## set false to stop generating apm metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->

## Pull Mode {#pull-mode}

### Enabling Profiling in Go Applications {#app-config}

Enabling Profiling in applications only requires referencing the `pprof` package, as shown below:

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

After running the code, you can check if it's successfully enabled by accessing `http://localhost:6060/debug/pprof/heap?debug=1`.

- Mutex and Block Performance Analysis

By default, mutex and block performance collection are not enabled. If you need to enable them, add the following code:

```go
var rate = 1

// enable mutex profiling
runtime.SetMutexProfileFraction(rate)

// enable block profiling
runtime.SetBlockProfileRate(rate)
```

`rate` sets the collection frequency, i.e., 1/rate events are collected. Setting it to 0 or less than 0 disables collection.

### DataKit Configuration {#datakit-config}

[Enable Profile collector](profile.md), configure `[[inputs.profile.go]]` as follows:

```toml
[[inputs.profile]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]

  ## set true to enable election
  election = true

 ## go pprof config
[[inputs.profile.go]]
  ## pprof url
  url = "http://localhost:6060"

  ## pull interval, should be greater or equal than 10s
  interval = "10s"

  ## service name
  service = "go-demo"

  ## app env
  env = "dev"

  ## app version
  version = "0.0.0"

  ## types to pull 
  ## values: cpu, goroutine, heap, mutex, block
  enabled_types = ["cpu","goroutine","heap","mutex","block"]

[inputs.profile.go.tags]
  # tag1 = "val1"
```

<!-- markdownlint-disable MD046 -->
???+ note

    If you do not need to enable the Profile HTTP service, you can comment out the endpoints field.
<!-- markdownlint-enable -->

### Field Explanation {#fields-info}

- `url`: Reporting address, such as `http://localhost:6060`
- `interval`: Collection interval, minimum 10s
- `service`: Service name
- `env`: Application environment type
- `version`: Application version
- `enabled_types`: Performance types, such as `cpu, goroutine, heap, mutex, block`

After configuring the Profile collector, start or restart DataKit. After a while, you can view Go performance data in the <<< custom_key.brand_name >>> center.