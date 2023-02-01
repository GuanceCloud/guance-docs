# Configure the Collector
---

After we install the DataKit, we can collect more data through the DataKit. In DataKit, configuration files are divided into two categories, one is the main configuration of DataKit, which does not need to be modified in general; The other is a specific collector configuration, which we may often need to modify during daily use. The following is a typical configuration collector file:

```toml
[[inputs.some_name]] # This line is required to indicate which collector configuration this toml file is
	key = value
	...

[[inputs.some_name.other_options]] # This line is optional. Some collectors are configured with this line, while others are not
	key = value
	...
```

## Collector Turned on by Default

After DataKit is installed, a batch of host-related collectors will be turned on by default without manual configuration. The list of collectors turned on by default is as follows:

| Collector Name | Description |
| --- | --- |
| `[cpu](cpu)` | Collect the CPU usage of the host |
| `[disk](disk)` | Collect disk occupancy |
| `[diskio](diskio)` | Collect the disk IO status of the host |
| `[mem](mem)` | Collect the memory usage of the host |
| `[swap](swap)` | Collect Swap memory usage |
| `[system](system)` | Collect the load of host operating system |
| `[net](net)` | Collect host network traffic |
| `[host_processes](host_processes)` | Collect the list of resident (surviving for more than 10min) processes on the host |
| `[hostobject](hostobject)` | Collect basic information of host computer (such as operating system information and hardware information) |
| `[container](container)` | Collect possible container objects and container logs on the host |

Note: If you want to delete the default collector, you can open the `datakit.conf` file in the DataKit `conf.d` directory and delete the collector in `default_enabled_inputs`.

## Introduction to DataKit Directory

After the DataKit installation is complete, you can go to the DataKit installation directory to view the list of all collectors. DataKit currently supports three major Linux/Windows/Mac platforms, and its installation path is as follows:

| Operating System | Architecture | Installation Path |
| --- | --- | --- |
| Linux kernel version 2.6.23 or higher | amd64/386/arm/arm64 | `/usr/local/datakit` |
| macOS 10.12 or higher([reason](https://github.com/golang/go/issues/25633)<br />) | amd64 | `/usr/local/datakit` |
| Windows 7, Server 2008R2 or higher | amd64/386 | 64 bit: `C:\\Program Files\\datakit`<br />32位：`C:\\Program Files(32)\\datakit` |

The list of its directories is as follows:
```
├── [4.4K]  conf.d
├── [ 160]  data
├── [ 64M]  datakit
├── [ 192]  externals
├── [1.2K]  pipeline
├── [ 192]  gin.log   # Windows platform
└── [1.2K]  log       # Windows platform
```

For more details, please refer to the doc [DataKit service management](../../datakit/datakit-service-how-to.md).
## Collector Configuration File

The configuration files of each collector are stored in the `conf.d` directory, and are classified and stored in each sub-category. For example, the `conf.d/host` directory stores various host-related collector configuration examples, taking Linux as an example:

```
├── cpu.conf.sample
├── disk.conf.sample
├── diskio.conf.sample
├── host_processes.conf.sample
├── hostobject.conf.sample
├── kernel.conf.sample
├── mem.conf.sample
├── net.conf.sample
├── swap.conf.sample
└── system.conf.sample
```

The same database-related configuration example is in the `conf.d/db` directory:

```
├── elasticsearch.conf.sample
├── mysql.conf.sample
├── oracle.conf.sample
├── postgresql.conf.sample
└── sqlserver.conf.sample
```

Copy `yyy.conf.sample`, named `yyy.conf`, open the `.conf` ile, open `inputs`, and configure relevant parameters to open and configure the collector. See doc [collector configuration](../../datakit/datakit-input-conf.md).

Note: DataKit will only search for `.conf` files in the `conf.d/`, and the copied `yyy.conf` must be placed in the `conf.d` directory with `.conf` as the file suffix, otherwise DataKit will ignore the processing of this configuration file. If you want to temporarily remove a collection configuration, just change the suffix, such as `yyy.conf` to `yyy.conf.bak`.

Knowing how to install DataKit and configure the collector, we can [turn on log collection](enable-log-collection.md) to operate the specific opening and configuration of the collector.
