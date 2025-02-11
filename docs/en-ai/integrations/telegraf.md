---
title     : 'Telegraf'
summary   : 'Receive data collected by Telegraf'
tags:
  - 'External Data Ingestion'
__int_icon: 'icon/telegraf'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

---

<!-- markdownlint-disable MD046 -->
???+ attention

    It is recommended to check if DataKit can meet the expected data collection requirements before using Telegraf. If DataKit already supports the required data collection, it is not advisable to use Telegraf for this purpose as it may cause data conflicts and lead to usage issues.
<!-- markdownlint-enable MD046 -->

Telegraf is an open-source data collection tool. DataKit can easily integrate with Telegraf-collected datasets through simple configuration.

## Telegraf Installation {#install}

Using Ubuntu as an example, refer to [this link](https://docs.influxdata.com/telegraf/v1.18/introduction/installation/){:target="_blank"} for other systems:

Add the installation source

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
- Windows: The configuration file is in the same directory as the Telegraf binary (depending on the specific installation)

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
    data_format = "influx" # Must choose `influx` here; otherwise, DataKit cannot parse the data

# Additional configurations ...
```

If the [DataKit API location has changed](datakit-conf.md#config-http-server), adjust the following configuration to set the `url` to the actual DataKit API address:

```toml
[[outputs.http]]
   ## URL is the address to send metrics to
   url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

Telegraf's collection configuration is similar to DataKit and uses [Toml format](https://toml.io/en){:target="_blank"}. Each collector typically starts with `[[inputs.xxxx]]`. For example, to enable `nvidia_smi` collection:

```toml
[[inputs.nvidia_smi]]
  ## Optional: path to nvidia-smi binary, defaults to $PATH via exec.LookPath
  bin_path = "/usr/bin/nvidia-smi"

  ## Optional: timeout for GPU polling
  timeout = "5s"
```

## Further Reading {#more-reading}

- [Detailed configuration of Telegraf collectors](https://docs.influxdata.com/telegraf){:target="_blank"}
- [More Telegraf plugins](https://github.com/influxdata/telegraf#input-plugins){:target="_blank"}