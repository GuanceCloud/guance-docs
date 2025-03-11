---
title     : 'Profiling C++'
summary   : 'C++ Profiling Integration'
tags:
  - 'C/C++'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

Currently, DataKit supports one method to collect C/C++ profiling data, which is [Pyroscope](https://pyroscope.io/){:target="_blank"}.

## Pyroscope {#pyroscope}

[Pyroscope](https://pyroscope.io/){:target="_blank"} is an open-source continuous profiling platform. DataKit already supports displaying the profiling data reported by Pyroscope on [Guance](https://www.guance.com/){:target="_blank"}.

Pyroscope uses a C/S architecture and operates in two modes: [Pyroscope Agent](https://pyroscope.io/docs/agent-overview/){:target="_blank"} and [Pyroscope Server](https://pyroscope.io/docs/server-overview/){:target="_blank"}. Both modes are integrated into a single binary file and can be run using different command-line commands.

Here, the Pyroscope Agent mode is required. DataKit has integrated Pyroscope Server functionality and exposes an HTTP interface to receive profiling data from Pyroscope Agent.

Data flow for profiling: "Pyroscope Agent collects profiling data -> DataKit -> Guance".

### Prerequisites {#pyroscope-requirement}

- According to the Pyroscope official documentation on [eBPF Profiling](https://pyroscope.io/docs/ebpf/#prerequisites-for-profiling-with-ebpf){:target="_blank"}, the Linux kernel version must be >= 4.9 (due to the event [BPF_PROG_TYPE_PERF_EVENT](https://lkml.org/lkml/2016/9/1/831){:target="_blank"}).

- [DataKit](https://www.guance.com/){:target="_blank"} should be installed and the [profile](profile.md#config) collector should be enabled. Configuration reference is as follows:

```toml
[[inputs.profile]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]

  ## set true to enable election.
  election = true

  #  config
  [[inputs.profile.pyroscope]]
    # listen url
    url = "0.0.0.0:4040"

    # service name
    service = "pyroscope-demo"

    # app env
    env = "dev"

    # app version
    version = "0.0.0"

  [inputs.profile.pyroscope.tags]
    tag1 = "val1"
```

- Install Pyroscope

For example, on a Linux AMD64 platform:

```sh
wget https://dl.pyroscope.io/release/pyroscope-0.36.0-linux-amd64.tar.gz
tar -zxvf pyroscope-0.36.0-linux-amd64.tar.gz
```

The above method retrieves the Pyroscope binary file, which can be run directly or placed in the [PATH](http://www.linfo.org/path_env_var.html){:target="_blank"}.

For installation methods on other platforms and architectures, see the [download page](https://pyroscope.io/downloads/){:target="_blank"}.

### Configuring Pyroscope Agent for eBPF Collection Mode {#pyroscope-ebpf}

The [eBPF](https://pyroscope.io/docs/ebpf/){:target="_blank"} mode of Pyroscope Agent supports profiling data collection for C/C++ programs.

- Set environment variables:

```sh
export PYROSCOPE_APPLICATION_NAME='my.ebpf.program{host=server-node-1,region=us-west-1,tag2=val2}'
export PYROSCOPE_SERVER_ADDRESS='http://localhost:4040/' # Datakit profile configured Pyroscope listen URL.
export PYROSCOPE_SPY_NAME='ebpfspy'
```

- Use different commands based on the target for profiling:

    - Profile a running program (e.g., with PID `1000`): `sudo -E pyroscope connect --pid 1000`
    - Profile a specified program (e.g., `mongod`): `sudo -E pyroscope exec mongod`
    - Profile the entire system: `sudo -E pyroscope ebpf`

### Viewing Profiles {#pyroscope-view}

After running the above profiling commands, the Pyroscope Agent will start collecting the specified profiling data and report it to Guance. After a few minutes, you can view the corresponding data in the Guance workspace under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.
