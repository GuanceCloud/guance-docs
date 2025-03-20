---
title     : 'Telegraf'
summary   : 'Receive data collected by Telegraf'
tags:
  - 'External Data Integration'
__int_icon: 'icon/telegraf'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

---

<!-- markdownlint-disable MD046 -->
???+ attention

    It is recommended to check whether DataKit can meet the expected data collection requirements before using Telegraf. If DataKit already supports the required functionality, it is not recommended to use Telegraf for data collection, as this could lead to data conflicts and cause usage issues.
<!-- markdownlint-enable MD046 -->

Telegraf is an open-source data collection tool. DataKit can integrate datasets collected by Telegraf through simple configuration.

## Telegraf Installation {#install}

Taking Ubuntu as an example, refer to [other systems](https://docs.influxdata.com/telegraf/v1.18/introduction/installation/){:target="_blank"}:

Add installation source

```shell
curl -s https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
```

Install Telegraf

```shell
sudo apt-get update && sudo apt-get install telegraf
```

### Telegraf Configuration {#config}

Default configuration file paths:

- Mac: `/usr/local/etc/telegraf.conf`
- Linux: `/etc/telegraf/telegraf.conf`
- Windows: The configuration file is in the same directory as the Telegraf binary (depending on the specific installation situation)

> Note: On Mac, if installed via [`datakit install --telegraf`](../datakit/datakit-tools-how-to.md#extras), the configuration directory is the same as Linux.

Modify the configuration file as follows:

```toml
[agent]
    interval                  = "10s"
    round_interval            = true
    precision                 = "ns"
    collection_jitter         = "0s"
    flush_interval            = "10s"
    flush_jitter              = "0s"
    metric_batch_size         = 1000
    metric_buffer_limit       = 100000
    logtarget                 = "file"
    logfile                   = "your_path.log"
    logfile_rotation_interval = ""

# Global tags for the data collected by Telegraf can be configured here
[global_tags]
  name = "zhangsan"

[[outputs.http]]
    ## URL is the address to send metrics to DataKit ,required
    url         = "http://localhost:9529/v1/write/metric?input=telegraf"
    method      = "POST"
    data_format = "influx" # Must select `influx` here; otherwise, DataKit cannot parse the data

# More other configurations ...
```

If the [DataKit API location has been adjusted](datakit-conf.md#config-http-server), adjust the following configuration by setting the `url` to the actual address of the DataKit API:

```toml
[[outputs.http]]
   ## URL is the address to send metrics to
   url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

The data collection configuration for Telegraf is similar to DataKit and also uses the [Toml format](https://toml.io/cn){:target="_blank"}. Each collector generally starts with `[[inputs.xxxx]]`. Here's an example enabling the `nvidia_smi` collector:

```toml
[[inputs.nvidia_smi]]
  ## Optional: path to nvidia-smi binary, defaults to $PATH via exec.LookPath
  bin_path = "/usr/bin/nvidia-smi"

  ## Optional: timeout for GPU polling
  timeout = "5s"
```

## Further Reading {#more-reading}

- [Detailed configuration for Telegraf collectors](https://docs.influxdata.com/telegraf){:target="_blank"}
- [More Telegraf plugins](https://github.com/influxdata/telegraf#input-plugins){:target="_blank"}