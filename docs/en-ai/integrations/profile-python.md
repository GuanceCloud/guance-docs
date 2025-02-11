---
title: 'Profiling Python'
summary: 'Python Profiling Integration'
tags:
  - 'PYTHON'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

Currently, DataKit Python profiling supports two performance collectors: [dd-trace-py](https://github.com/DataDog/dd-trace-py){:target="_blank"} and [py-spy](https://github.com/benfred/py-spy){:target="_blank"}.

## Prerequisites {#py-spy-requirement}

DataKit is installed and the [profile](profile.md#config) collector is enabled.

## dd-trace-py Integration {#ddtrace}

`dd-trace-py` is an open-source library for tracing and performance analysis provided by DataDog, capable of collecting Metrics such as CPU, memory, blocking, etc.

- Install the dd-trace-py library

<!-- markdownlint-disable MD046 -->
???+ note "Version Requirements"

    DataKit currently supports `dd-trace-py 1.14.x` and below. Higher versions have not been systematically tested, and compatibility is unknown.
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

After starting the program, DDTrace will periodically collect data (default is every 1 minute) and report it to DataKit. After a few minutes, you can view the corresponding data on the Guance platform under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.

### Generating Performance Metrics {#metrics}

Starting from [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0), DataKit supports extracting a set of Python runtime-related metrics from `dd-trace-py` output. These metrics are placed under the `profiling_metrics` Mearsurement set. Below is a partial list of these metrics with explanations:

| Metric Name                                  | Description                                                     | Unit         |
|---------------------------------------|--------------------------------------------------------|------------|
| prof_python_cpu_cores                 | Number of CPU cores consumed                                             | core       |
| prof_python_alloc_bytes_per_sec       | Memory bytes allocated per second                                            | byte       |
| prof_python_allocs_per_sec            | Number of memory allocations per second                                               | count      |
| prof_python_alloc_bytes_total         | Total memory allocated during a single profiling period (dd-trace defaults to 60 seconds per collection cycle) | byte       |
| prof_python_lock_acquisition_time     | Total time spent waiting for locks during a single profiling period                          | nanosecond |
| prof_python_lock_acquisitions_per_sec | Number of lock contentions per second                                             | count      |
| prof_python_lock_hold_time            | Total time holding locks during a single profiling period                              | nanosecond |
| prof_python_exceptions_per_sec        | Number of exceptions thrown per second                                               | count      |
| prof_python_exceptions_total          | Total number of exceptions thrown during a single profiling period                               | count      |
| prof_python_lifetime_heap_bytes       | Total size of heap memory objects currently in use                                        | byte       |
| prof_python_wall_time                 | Wall-clock duration                                                   | nanosecond |


<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If you do not need it, you can disable it by modifying the configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` and setting the `generate_metrics` option to false, then restart DataKit.

    ```toml
    [[inputs.profile]]
    
    ...
    
    ## Set false to stop generating APM metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->


## `py-spy` Integration {#py-spy}

### Usage in Host Environment {#py-spy-on-host}

`py-spy` is a non-intrusive Python performance sampling tool provided by the open-source community. It has the advantages of running independently and having minimal impact on the target program's load. By default, `py-spy` outputs sampling data in various formats to local files based on specified parameters. To simplify integration with DataKit, Guance provides a forked version [`py-spy-for-datakit`](https://github.com/GuanceCloud/py-spy-for-datakit){:target="_blank"}, which includes minor modifications to support automatically sending profiling data to DataKit.

- Installation

We recommend installing via pip:

```shell
pip3 install py-spy-for-datakit
```

Additionally, the [Github Release](https://github.com/GuanceCloud/py-spy-for-datakit/releases){:target="_blank"} page provides precompiled binaries for some mainstream platforms. You can also download and install them using pip. The following installation steps are for the Linux x86_64 platform (similar for other platforms):

```shell
# Download the precompiled package for the corresponding platform
curl -SL https://github.com/GuanceCloud/py-spy-for-datakit/releases/download/v0.3.15/py_spy_for_datakit-0.3.15-py2.py3-none-manylinux_2_5_x86_64.manylinux1_x86_64.whl -O

# Install using pip
pip3 install --force-reinstall --no-index --find-links . py-spy-for-datakit

# Verify installation success
py-spy-for-datakit help
```

If your system has rust and cargo installed, you can also install it using cargo:

```shell
cargo install py-spy-for-datakit
```

- Usage

`py-spy-for-datakit` adds the `datakit` command to the existing subcommands of `py-spy`, specifically for sending sampling data to DataKit. You can run `py-spy-for-datakit help datakit` to view usage instructions:

| Parameter                 | Description                                             | Default Value                  |
|--------------------|------------------------------------------------|----------------------|
| -H, --host         | Address of the DataKit listener to send data to                            | 127.0.0.1            |
| -P, --port         | Port of the DataKit listener to send data to                             | 9529                 |
| -S, --service      | Project name, used to distinguish projects in the backend and for filtering and querying, recommended to set              | unnamed-service      |
| -E, --env          | Deployment environment of the project, used to distinguish development, testing, and production environments, and for filtering, recommended to set         | unnamed-env          |
| -V, --version      | Project version, used for querying and filtering in the backend, recommended to set                          | unnamed-version      |
| -p, --pid          | PID of the Python process to analyze                         | Either process PID or project startup command must be specified |
| -d, --duration     | Sampling duration, sends data to DataKit at intervals of this duration, in seconds, minimum can be set to 10 | 60                   |
| -r, --rate         | Sampling frequency, number of samples per second                                    | 100                  |
| -s, --subprocesses | Whether to analyze subprocesses                                        | false                |
| -i, --idle         | Whether to sample idle threads                                   | false                |

`py-spy-for-datakit` can analyze currently running programs by passing the process PID of the running Python program using the `--pid <PID>` or `-p <PID>` parameter.

Assuming your Python application is running with a process PID of 12345, and DataKit is listening on 127.0.0.1:9529, the command would look like this:

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

If you encounter a permission issue, prepend the command with `sudo`.

`py-spy-for-datakit` also supports directly integrating with the Python project's startup command, eliminating the need to specify the process PID. Data sampling begins when the program starts. The command would look like this:

```shell
py-spy-for-datakit datakit \
  --host 127.0.0.1 \
  --port 9529 \
  --service your-service-name \
  --env testing \
  --version v0.1 \
  -d 60 \
  -- python3 server.py  # Note the extra space before python3
```

If no errors occur, you should be able to view specific performance metric data on the Guance platform under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"} within a couple of minutes.

### Usage in k8s Environment {#py-spy-on-k8s}

Please refer to [Injecting `py-spy` using `datakit-operator`](../datakit/datakit-operator.md#inject-py-spy){:target="_blank"}.