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

`dd-trace-py` is an open-source library provided by DataDog for trace collection and performance analysis, capable of collecting metrics such as CPU, memory, and blocking.

- Install the dd-trace-py library

<!-- markdownlint-disable MD046 -->
???+ note "Version Requirements"

    DataKit currently supports `dd-trace-py 1.14.x` and earlier versions. Higher versions have not been systematically tested, and compatibility is unknown.
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

At this point, you can start the project without using the `ddtrace-run` command:

```shell
DD_ENV=testing DD_SERVICE=python-profiling-manual DD_VERSION=1.2.3 python3 app.py
```

### Viewing Profiles {#view}

After starting the program, DDTrace will periodically collect data (default is every 1 minute) and report it to Datakit. After a few minutes, you can view the corresponding data on the Guance platform under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.

### Generating Performance Metrics {#metrics}

Starting from [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0), DataKit supports extracting a set of Python runtime-related metrics from the output information of `dd-trace-py`. This set of metrics is placed under the `profiling_metrics` Mearsurement. Below are some of the metrics listed with explanations:

| Metric Name                                  | Description                                                     | Unit         |
|---------------------------------------|--------------------------------------------------------|------------|
| prof_python_cpu_cores                 | Number of CPU cores consumed                                             | core       |
| prof_python_alloc_bytes_per_sec       | Number of bytes allocated per second                                            | byte       |
| prof_python_allocs_per_sec            | Number of allocations per second                                               | count      |
| prof_python_alloc_bytes_total         | Total bytes allocated during a single profiling period (dd-trace defaults to a 60-second collection cycle) | byte       |
| prof_python_lock_acquisition_time     | Total time spent waiting for locks during a single profiling period                          | nanosecond |
| prof_python_lock_acquisitions_per_sec | Number of lock contentions per second                                             | count      |
| prof_python_lock_hold_time            | Total time holding locks during a single profiling period                              | nanosecond |
| prof_python_exceptions_per_sec        | Number of exceptions thrown per second                                               | count      |
| prof_python_exceptions_total          | Total number of exceptions thrown during a single profiling period                               | count      |
| prof_python_lifetime_heap_bytes       | Total size of heap memory objects currently in use                                        | byte       |
| prof_python_wall_time                 | Wall clock duration                                                   | nanosecond |


<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If you do not need it, you can disable it by modifying the configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` and setting the `generate_metrics` option to false, then restart Datakit.

    ```toml
    [[inputs.profile]]
    
    ...
    
    ## set false to stop generating apm metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->


## `py-spy` Integration {#py-spy}

### Usage in Host Environment {#py-spy-on-host}

`py-spy` is a non-intrusive Python performance sampling tool provided by the open-source community. It has advantages such as standalone operation and low impact on target program load. By default, `py-spy` outputs sample data in different formats to local files based on specified parameters. To simplify the integration of `py-spy` with DataKit, Guance provides a forked version [`py-spy-for-datakit`](https://github.com/GuanceCloud/py-spy-for-datakit){:target="_blank"}, which includes minor modifications to support automatically sending profiling data to DataKit.

- Installation

It is recommended to install using pip:

```shell
pip3 install py-spy-for-datakit
```

Additionally, the [Github Release](https://github.com/GuanceCloud/py-spy-for-datakit/releases){:target="_blank"} page provides precompiled versions for major platforms. You can also download and install them using pip. The following example demonstrates the installation steps for the Linux x86_64 platform (other platforms are similar):

```shell
# Download the precompiled package for the corresponding platform
curl -SL https://github.com/GuanceCloud/py-spy-for-datakit/releases/download/v0.3.15/py_spy_for_datakit-0.3.15-py2.py3-none-manylinux_2_5_x86_64.manylinux1_x86_64.whl -O

# Install using pip
pip3 install --force-reinstall --no-index --find-links . py-spy-for-datakit

# Verify the installation
py-spy-for-datakit help
```

If your system has rust and cargo installed, you can also install it using cargo:

```shell
cargo install py-spy-for-datakit
```

- Usage

`py-spy-for-datakit` adds the `datakit` command to the existing subcommands of `py-spy`, specifically for sending sample data to DataKit. You can run `py-spy-for-datakit help datakit` to view usage instructions:

| Parameter                 | Description                                             | Default Value                  |
|--------------------|------------------------------------------------|----------------------|
| -H, --host         | Address of the Datakit server to send data to                           | 127.0.0.1            |
| -P, --port         | Port of the Datakit server to send data to                            | 9529                 |
| -S, --service      | Service name, used to distinguish different services in the backend, and for filtering and querying, it is recommended to set              | unnamed-service      |
| -E, --env          | Deployment environment of the service, used to distinguish between development, testing, and production environments, and for filtering, it is recommended to set         | unnamed-env          |
| -V, --version      | Service version, used for querying and filtering in the backend, it is recommended to set                          | unnamed-version      |
| -p, --pid          | PID of the Python process to analyze                         | Either the process PID or the startup command must be specified |
| -d, --duration     | Duration of sampling, sends data to Datakit at intervals of this duration, minimum can be set to 10 seconds | 60                   |
| -r, --rate         | Sampling frequency, number of samples per second                                    | 100                  |
| -s, --subprocesses | Whether to analyze subprocesses                                        | false                |
| -i, --idle         | Whether to sample idle threads                                   | false                |

`py-spy-for-datakit` can analyze running programs. Pass the PID of the running Python program using the `--pid <PID>` or `-p <PID>` parameter.

Assuming your Python application's current running process PID is 12345 and Datakit is listening on 127.0.0.1:9529, the command would look like this:

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

If you encounter permission issues, add `sudo` before the command.

`py-spy-for-datakit` also supports directly following the startup command of a Python project, eliminating the need to specify the process PID. Data sampling starts immediately when the program starts. The command would look like this:

```shell
py-spy-for-datakit datakit \
  --host 127.0.0.1 \
  --port 9529 \
  --service your-service-name \
  --env testing \
  --version v0.1 \
  -d 60 \
  -- python3 server.py  # Note that there should be an extra space before python3
```

If no errors occur, wait a couple of minutes and you can view the specific performance metric data on the Guance platform under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.

### Usage in k8s Environment {#py-spy-on-k8s}

Refer to [Injecting `py-spy` using `datakit-operator`](../datakit/datakit-operator.md#inject-py-spy){:target="_blank"}.