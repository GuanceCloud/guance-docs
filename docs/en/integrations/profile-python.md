---
title     : 'Profiling Python'
summary   : 'Python Profiling Integration'
tags:
  - 'PYTHON'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

Currently, DataKit Python profiling supports two performance collectors: [dd-trace-py](https://github.com/DataDog/dd-trace-py){:target="_blank"} and [py-spy](https://github.com/benfred/py-spy){:target="_blank"}.

## Prerequisites {#py-spy-requirement}

DataKit is installed and the [profile](profile.md#config) collector is enabled.

## dd-trace-py Integration {#ddtrace}

`dd-trace-py` is an open-source library for tracing and performance analysis introduced by DataDog. It can collect Metrics such as CPU, memory, and blocking.

- Install the dd-trace-py library

<!-- markdownlint-disable MD046 -->
???+ note "Version Requirements"

    Datakit currently supports `dd-trace-py 1.14.x` and earlier versions. Higher versions have not been systematically tested, and compatibility is unknown.
<!-- markdownlint-enable -->

```shell
pip3 install ddtrace
```

- Non-intrusive profiling

```shell
DD_PROFILING_ENABLED=true \
DD_ENV=dev \
DD_SERVICE=my-web-app \
DD_VERSION=1.0.3 \
DD_TRACE_AGENT_URL=http://127.0.0.1:9529 \
ddtrace-run python app.py
```

- Manually inject code to enable profiling

```python
import time
import ddtrace
from ddtrace.profiling import Profiler

ddtrace.tracer.configure(
     https=False,
     hostname="localhost",
     port="9529",
)

prof = Profiler()
prof.start(True, True)

# your code here ...
# while True:
#     time.sleep(1)
```

At this point, starting the project no longer requires the `ddtrace-run` command:

```shell
DD_ENV=testing DD_SERVICE=python-profiling-manual DD_VERSION=1.2.3 python3 app.py
```

### View Profile {#view}

After the program starts, DDTrace will periodically (by default, every minute) collect data and report it to Datakit. After waiting a few minutes, you can view the corresponding data in the Guance space [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.

### Generate Performance Metrics {#metrics}

Starting from [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0), Datakit supports extracting a set of Python runtime-related metrics from the output information of `dd-trace-py`. This set of Metrics is placed under the `profiling_metrics` Measurement. Below are some of these Metrics explained:

| Metric Name                                  | Description                                                     | Unit         |
|---------------------------------------|--------------------------------------------------------|------------|
| prof_python_cpu_cores                 | Number of CPU cores consumed                                             | core       |
| prof_python_alloc_bytes_per_sec       | Size of memory bytes allocated per second                                            | byte       |
| prof_python_allocs_per_sec            | Number of memory allocations per second                                               | count      |
| prof_python_alloc_bytes_total         | Total memory size allocated during a single profiling period (dd-trace defaults to a 60-second collection cycle, same below) | byte       |
| prof_python_lock_acquisition_time     | Total time spent waiting for locks during a single profiling period                          | nanosecond |
| prof_python_lock_acquisitions_per_sec | Number of lock contentions per second                                             | count      |
| prof_python_lock_hold_time            | Total duration of holding locks during a single profiling period                              | nanosecond |
| prof_python_exceptions_per_sec        | Number of exceptions thrown per second                                               | count      |
| prof_python_exceptions_total          | Total number of exceptions thrown during a single profiling period                               | count      |
| prof_python_lifetime_heap_bytes       | Total memory size occupied by current heap objects                                        | byte       |
| prof_python_wall_time                 | Clock duration                                                   | nanosecond |


<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If you do not need it, you can modify the configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` of the collector and set the configuration item `generate_metrics` to false, then restart Datakit.

    ```toml
    [[inputs.profile]]
    
    ...
    
    ## set false to stop generating apm metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->


## `py-spy` Integration {#py-spy}

### Usage in Host Environment {#py-spy-on-host}

`py-spy` is an open-source, non-intrusive Python performance metric sampling tool provided by the community, with advantages such as standalone operation and low impact on target program load. By default, `py-spy` outputs sampling data in different formats to local files based on specified parameters. To simplify the integration of `py-spy` and DataKit, Guance provides a forked version [`py-spy-for-datakit`](https://github.com/GuanceCloud/py-spy-for-datakit){:target="_blank"}. This version includes minor modifications to the original to support automatically sending profiling data to DataKit.

- Installation

We recommend using pip for installation

```shell
pip3 install py-spy-for-datakit
```

Additionally, the [Github Release](https://github.com/GuanceCloud/py-spy-for-datakit/releases){:target="_blank"} page offers precompiled versions for some mainstream platforms. You can also download and install them via pip. Below, we introduce the installation steps for the precompiled version on the Linux x86_64 platform (similar for other platforms).

```shell
# Download the precompiled package for the corresponding platform
curl -SL https://github.com/GuanceCloud/py-spy-for-datakit/releases/download/v0.3.15/py_spy_for_datakit-0.3.15-py2.py3-none-manylinux_2_5_x86_64.manylinux1_x86_64.whl -O

# Use pip to install
pip3 install --force-reinstall --no-index --find-links . py-spy-for-datakit

# Verify successful installation
py-spy-for-datakit help
```

If your system has rust and cargo installed, you can also use cargo to install

```shell
cargo install py-spy-for-datakit
```

- Usage

`py-spy-for-datakit` adds the `datakit` command to the existing subcommands of `py-spy`, specifically used to send sampling data to DataKit. You can input `py-spy-for-datakit help datakit` to view usage instructions:

| Parameter                 | Description                                             | Default Value                  |
|--------------------|------------------------------------------------|----------------------|
| -H, --host         | Address of the Datakit listener where data should be sent                           | 127.0.0.1            |
| -P, --port         | Port of the Datakit listener where data should be sent                            | 9529                 |
| -S, --service      | Project name, useful for distinguishing projects in the backend, and for filtering and querying; recommended to set              | unnamed-service      |
| -E, --env          | Deployment environment of the project, can be used to distinguish development, testing, and production environments, and also for filtering; recommended to set         | unnamed-env          |
| -V, --version      | Project version, can be used for backend querying and filtering; recommended to set                          | unnamed-version      |
| -p, --pid          | Process PID of the Python program that needs analysis                         | Must specify either process PID or project startup command |
| -d, --duration     | Sampling duration, sends data to Datakit at intervals of this duration, unit in seconds, minimum can be set to 10 | 60                   |
| -r, --rate         | Sampling frequency, number of samples per second                                    | 100                  |
| -s, --subprocesses | Whether to analyze subprocesses                                        | false                |
| -i, --idle         | Whether to sample threads that are not running                                   | false                |

`py-spy-for-datakit` can analyze currently running programs by passing the process PID of the running Python program using the `--pid <PID>` or `-p <PID>` parameter.

Assuming your Python application is currently running with a process PID of 12345, and Datakit is listening on 127.0.0.1:9529, the command would look similar to the following:

```shell
py-spy-for-datakit datakit \
  --host 127.0.0.1 \
  --port 9529 \
  --service <your-service-name> \
  --env testing \
  --version v0.1 \
  --duration 60 \
  --pid 12345
```

If prompted for `sudo` privileges, add `sudo` before the command.

`py-spy-for-datakit` also supports directly following the Python project's startup command, eliminating the need to specify the process PID. Data sampling begins when the program starts. In this case, the run command would look like:

```shell
py-spy-for-datakit datakit \
  --host 127.0.0.1 \
  --port 9529 \
  --service your-service-name \
  --env testing \
  --version v0.1 \
  -d 60 \
  -- python3 server.py  # Note: there must be an extra space before python3 here
```

If no errors occur, after waiting one or two minutes, you can view specific performance metric data on the Guance platform [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"} page.

### Usage in k8s Environment {#py-spy-on-k8s}

Please refer to [Using `datakit-operator` to Inject `py-spy`](../datakit/datakit-operator.md#inject-py-spy){:target="_blank"}.