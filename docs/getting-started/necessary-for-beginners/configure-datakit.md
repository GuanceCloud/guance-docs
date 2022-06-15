# 配置采集器
---

我们安装完成 DataKit 以后，就可以通过 DataKit 来采集更多数据。在 DataKit 中，配置文件分为两类，其一是 DataKit 主配置，一般情况下，无需修改；另一种为具体的采集器配置，在日常使用过程中，我们可能经常需要对其进行修改。如下是一个典型的配置采集器文件：

```toml
[[inputs.some_name]] # 这一行是必须的，它表明这个 toml 文件是哪一个采集器的配置
	key = value
	...

[[inputs.some_name.other_options]] # 这一行则可选，有些采集器配置有这一行，有些则没有
	key = value
	...
```

## 默认开启的采集器

DataKit 安装完成后，会默认开启一批主机相关的采集器，无需手动配置，默认开启的采集器列表如下：

| 采集器名称 | 说明 |
| --- | --- |
| `[cpu](cpu)` | 采集主机的 CPU 使用情况 |
| `[disk](disk)` | 采集磁盘占用情况 |
| `[diskio](diskio)` | 采集主机的磁盘 IO 情况 |
| `[mem](mem)` | 采集主机的内存使用情况 |
| `[swap](swap)` | 采集 Swap 内存使用情况 |
| `[system](system)` | 采集主机操作系统负载 |
| `[net](net)` | 采集主机网络流量情况 |
| `[host_processes](host_processes)` | 采集主机上常驻（存活 10min 以上）进程列表 |
| `[hostobject](hostobject)` | 采集主机基础信息（如操作系统信息、硬件信息等） |
| `[container](container)` | 采集主机上可能的容器对象以及容器日志 |

注意：若你要删除默认采集器，可以在 DataKit `conf.d`目录下，打开`datakit.conf`文件，在`default_enabled_inputs`中删除该采集器。

## DataKit 目录介绍

DataKit 安装完成后，你可以进入DataKit的安装目录查看所有的采集器列表。DataKit 目前支持 Linux / Windows / Mac 三种主流平台，其安装路径如下：

| 操作系统 | 架构 | 安装路径 |
| --- | --- | --- |
| Linux 内核 2.6.23 或更高版本 | amd64/386/arm/arm64 | `/usr/local/datakit` |
| macOS 10.12 或更高版本([原因](https://github.com/golang/go/issues/25633)<br />) | amd64 | `/usr/local/datakit` |
| Windows 7, Server 2008R2 或更高版本 | amd64/386 | 64位：`C:\\Program Files\\datakit`<br />32位：`C:\\Program Files(32)\\datakit` |

其目录列表如下：
```
├── [4.4K]  conf.d
├── [ 160]  data
├── [ 64M]  datakit
├── [ 192]  externals
├── [1.2K]  pipeline
├── [ 192]  gin.log   # Windows 平台
└── [1.2K]  log       # Windows 平台
```

更多详情可参考文档 [DataKit 服务管理](../../datakit/datakit-service-how-to.md) 。
## 采集器配置文件

各个采集器的配置文件均存放在 `conf.d` 目录下，且分门别类，存放在各个子分类中，如 `conf.d/host` 目录下存放着各种主机相关的采集器配置示例，以 Linux 为例：

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

同样数据库相关的配置示例，在 `conf.d/db` 目录下：

```
├── elasticsearch.conf.sample
├── mysql.conf.sample
├── oracle.conf.sample
├── postgresql.conf.sample
└── sqlserver.conf.sample
```

复制`yyy.conf.sample`，命名为 `yyy.conf`，打开`.conf`文件，开启`inputs`，配置相关参数即可开启并配置采集器。更多详情可参考文档 [采集器配置](../../datakit/datakit-input-conf.md) 。

注意：DataKit 只会搜索 `conf.d/` 目录下的 `.conf` 文件，复制出来的 `yyy.conf`，必须放在 `conf.d` 目录下，且必须以 `.conf` 作为文件后缀，不然 DataKit 会忽略该配置文件的处理。如果要暂时移除掉某个采集配置，只需将其后缀改一下即可，如 `yyy.conf` 改成 `yyy.conf.bak`。

了解了如何安装 DataKit 和配置采集器，我们可以通过[开启日志采集](enable-log-collection.md)来操作一下采集器的具体开启和配置。
