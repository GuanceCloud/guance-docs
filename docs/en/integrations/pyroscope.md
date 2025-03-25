---
title     : 'Pyroscope'
summary   : 'Grafana Pyroscope application performance collector'
__int_icon: 'icon/profiling'
tags:
  - 'PYROSCOPE'
  - 'PROFILE'
dashboard :
  - desc  : 'Not available yet'
    path  : '-'
monitor   :
  - desc  : 'Not available yet'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit has added the `Pyroscope` collector from [:octicons-tag-24: Version-1.67.0](../datakit/changelog.md#cl-1.67.0) version, supporting data reported by Grafana Pyroscope Agent to help users identify performance bottlenecks such as CPU, memory, IO in applications.

## Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/pyroscope` directory under the DataKit installation directory, copy `pyroscope.conf.sample` and rename it to `pyroscope.conf`. The configuration file description is as follows:
    
    ```toml
        
    [[inputs.pyroscope]]
      ## pyroscope Agent endpoints registered by version respectively.
      ## Endpoints can be skipped by removing them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/ingest"]
    
      ## set true to enable election, pull mode only
      election = true
    
      ## the max allowed size of http request body (in MB), 32MB by default.
      body_size_limit_mb = 32 # MB
    
      ## set false to stop generating apm Metrics from ddtrace output.
      generate_metrics = true
    
      ## io_config is used to control profiling uploading behavior.
      ## cache_path sets the disk directory where temporarily cache profiling data.
      ## cache_capacity_mb specifies the maximum storage space (in MiB) that profiling cache can use.
      ## clear_cache_on_start sets whether we should clear all previous profiling cache on restarting Datakit.
      ## upload_workers sets the count of profiling uploading workers.
      ## send_timeout specifies the http timeout when uploading profiling data to dataway.
      ## send_retry_count sets the maximum retry count when sending every profiling request.
      # [inputs.pyroscope.io_config]
      #   cache_path = "/usr/local/datakit/cache/pyroscope_inputs"  # C:\Program Files\datakit\cache\pyroscope_inputs by default on Windows
      #   cache_capacity_mb = 10240  # 10240MB
      #   clear_cache_on_start = false
      #   upload_workers = 8
      #   send_timeout = "75s"
      #   send_retry_count = 4
    
      ## set custom tags for profiling data
      # [inputs.pyroscope.tags]
      #   some_tag = "some_value"
      #   more_tag = "some_other_value"
    
    ```
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service) to start the Pyroscope collector.

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration through [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Client Application Configuration {#app-config}

The Pyroscope collector currently supports three languages for Pyroscope Agent integration: [Java](https://grafana.com/docs/pyroscope/latest/configure-client/language-sdks/java/){:target="_blank"}, [Python](https://grafana.com/docs/pyroscope/latest/configure-client/language-sdks/python/){:target="_blank}, and [Go](https://grafana.com/docs/pyroscope/latest/configure-client/language-sdks/go_push/){:target="_blank"}, with support for other languages being added gradually:

<!-- markdownlint-disable MD046 -->
=== "Java"

    Download the latest `pyroscope.jar` package from [Github](https://github.com/grafana/pyroscope-java/releases){:target="_blank"} and start your application with it as a Java Agent:
    ```shell
    PYROSCOPE_APPLICATION_NAME="java-pyro-demo" \
    PYROSCOPE_LOG_LEVEL=debug \
    PYROSCOPE_FORMAT="jfr" \
    PYROSCOPE_PROFILER_EVENT="cpu" \
    PYROSCOPE_LABELS="service=java-pyro-demo,version=1.2.3,env=dev,some_other_tag=other_value" \
    PYROSCOPE_UPLOAD_INTERVAL="60s" \
    PYROSCOPE_JAVA_STACK_DEPTH_MAX=512 \
    PYROSCOPE_PROFILING_INTERVAL="10ms" \
    PYROSCOPE_PROFILER_ALLOC=128k \
    PYROSCOPE_PROFILER_LOCK=10ms \
    PYROSCOPE_ALLOC_LIVE=false \
    PYROSCOPE_GC_BEFORE_DUMP=true \
    PYROSCOPE_SERVER_ADDRESS="http://127.0.0.1:9529" \
    java -javaagent:pyroscope.jar -jar your-app.jar
    ```
    For more details, refer to the [official Grafana documentation](https://grafana.com/docs/pyroscope/latest/configure-client/language-sdks/java/){:target="_blank"} 

=== "Python"

    Install the `pyroscope-io` dependency package:
    ```shell
    pip install pyroscope-io
    ```
    
    Import the `pyroscope-io` package in your code:
    ```python
    import os
    import pyroscope
    import socket

    pyroscope.configure(
        server_address="http://127.0.0.1:9529",
        detect_subprocesses=True,
        oncpu=True,
        enable_logging=True,
        report_pid=True,
        report_thread_id=True,
        report_thread_name=True,
        tags={
            "host": socket.gethostname(),
            "service": 'python-pyro-demo',
            "version": 'v1.2.3',
            "env": "testing",
            "process_id": os.getpid(),
        }
    )
    ```

    Start the application:
    ```shell
    PYROSCOPE_APPLICATION_NAME="python-pyro-demo" python app.py
    ```

=== "Go"

    Add the `pyroscope-go` module:
    ```shell
    go get github.com/grafana/pyroscope-go
    ```

    Import the module and start `pyroscope`:
    ```go
    import (
        "log"
        "os"
        "runtime"
        "strconv"
        "time"

        "github.com/grafana/pyroscope-go"
    )
    
    func Must[T any](t T, _ error) T {
        return t
    }

    runtime.SetMutexProfileFraction(5)
    runtime.SetBlockProfileRate(5)

    profiler, err := pyroscope.Start(pyroscope.Config{
        ApplicationName: "go-pyroscope-demo",

        // replace this with the address of pyroscope server
        ServerAddress: "http://127.0.0.1:9529",

        // you can disable logging by setting this to nil
        Logger: pyroscope.StandardLogger,

        // uploading interval period
        UploadRate: time.Minute,

        // you can provide static tags via a map:
        Tags: map[string]string{
            "service":    "go-pyroscope-demo",
            "env":        "demo",
            "version":    "1.2.3",
            "host":       Must(os.Hostname()),
            "process_id": strconv.Itoa(os.Getpid()),
            "runtime_id": UUID,
        },

        ProfileTypes: []pyroscope.ProfileType{
            // these profile types are enabled by default:
            pyroscope.ProfileCPU,
            pyroscope.ProfileAllocObjects,
            pyroscope.ProfileAllocSpace,
            pyroscope.ProfileInuseObjects,
            pyroscope.ProfileInuseSpace,

            // these profile types are optional:
            pyroscope.ProfileGoroutines,
            pyroscope.ProfileMutexCount,
            pyroscope.ProfileMutexDuration,
            pyroscope.ProfileBlockCount,
            pyroscope.ProfileBlockDuration,
        },
    })
    if err != nil {
        log.Fatal("unable to bootstrap pyroscope profiler: ", err)
    }
    defer profiler.Stop()
    ```

<!-- markdownlint-enable -->

## Custom Tags {#custom-tags}

By default, all data collection will append a global tag named `host` (tag value is the hostname of the host where DataKit resides). You can also specify other tags through `[inputs.pyroscope.tags]` in the configuration:

``` toml
 [inputs.pyroscope.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```