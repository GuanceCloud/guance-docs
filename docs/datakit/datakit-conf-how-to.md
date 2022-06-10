

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：全平台

> 本文档已经被废弃，其内容被分割到如下两个文档：
> 
> - [DataKit 主配置](datakit-conf)
> - [采集器配置](datakit-input-conf)

# 配置文件

DataKit 的配置均使用 [Toml 文件](https://toml.io/cn)。在 DataKit 中，配置文件分为两类，其一是 DataKit 主配置，一般情况下，无需修改；另一种为具体的采集器配置，在日常使用过程中，我们可能经常需要对其进行修改。

一个典型的配置采集器文件，大概如下：

```toml
[[inputs.some_name]] # 这一行是必须的，它表明这个 toml 文件是哪一个采集器的配置
	key = value
	...

[[inputs.some_name.other_options]] # 这一行则可选，有些采集器配置有这一行，有些则没有
	key = value
	...
```

## 默认开启的采集器

DataKit 安装完成后，默认会开启一批采集器，这些采集器一般跟主机相关，列表如下。由于这些采集器默认开启，我们无需手动再配置它们。

| 采集器名称                         | 说明                                           |
| ---------                          | ---                                            |
| [`cpu`](cpu)                       | 采集主机的 CPU 使用情况                        |
| [`disk`](disk)                     | 采集磁盘占用情况                               |
| [`diskio`](diskio)                 | 采集主机的磁盘 IO 情况                         |
| [`mem`](mem)                       | 采集主机的内存使用情况                         |
| [`swap`](swap)                     | 采集 Swap 内存使用情况                         |
| [`system`](system)                 | 采集主机操作系统负载                           |
| [`net`](net)                       | 采集主机网络流量情况                           |
| [`host_processes`](host_processes) | 采集主机上常驻（存活 10min 以上）进程列表      |
| [`hostobject`](hostobject)         | 采集主机基础信息（如操作系统信息、硬件信息等） |
| [`container`](container)           | 采集主机上可能的容器或 Kubernetes 数据         |

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

还有其它更多的分类，某些具体的采集器，无法分类，则单独成行，如 rabbitmq 就是一个单独的分类。如果不清楚具体某个采集器的示例文档位置，可参考该采集器的使用文档，其中必有类似如下描述：

> 进入 DataKit 安装目录下的 `conf.d/xxx` 目录，复制 `yyy.conf.sample` 并命名为 `yyy.conf`...

此处需注意的是，由于 DataKit 只会搜索 `conf.d/` 目录下的 `.conf` 文件，复制出来的 `yyy.conf`，必须放在 `conf.d` 目录下（不一定要在特定的 `conf.d/xxx` 目录中），且必须以 `.conf` 作为文件后缀，不然 DataKit 会忽略该配置文件的处理。

> Tips：如果要暂时移除掉某个采集配置，只需将其后缀改一下即可，如 `yyy.conf` 改成 `yyy.conf.bak`。

### 具体采集的开启

以 MySQL 采集器为例：

```toml
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # 省略其它配置项...
```

其中：

| 配置                  | 描述                                                               |
| ---------             | ---                                                                |
| `[[inputs.mysql]]`    | 这一行是必须的，它表明「这是一个 mysql 采集器」，便于 DataKit 识别 |
| `host/user/...`       | 这些属于基础配置项，连接 MySQL 必须要这些配置                      |
| `[inputs.mysql.log]`  | 采集 MySQL 日志配置入口                                            |
| `[inputs.mysql.tags]` | 对采集的 MySQL 数据追加额外的标签                                  |

几个注意点：

- 我们将 MySQL 的日志采集和指标采集放在一起，主要是便于大家使用，无需单独用额外的采集器配置来收集日志
- 在采集器的配置中，我们可以使用形如 `$XXXXX` 这样的环境变量（注意，DataKit 主配置中不支持这种）。例如，假定该 MySQL 运行在容器中，但其主机名实际上并不可提前预知，此时可以追加额外标签 `host = $HOSTNAME`。需注意的是，指定的环境变量必须真实有效，如果 DataKit 运行时获取不到该环境变量，那么会直接使用字符串 `no-value` 作为该字段的值。

### 单个采集器如何开启多份采集

如果要配置多个不同 MySQL 采集，可单独再复制一份出来，如下 `mysql.conf` 所示：

```toml
# 第一个 MySQL 采集
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # 省略其它配置项...

# 再来一个 MySQL 采集
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # 省略其它配置项...

# 下面继续再加一个
[[inputs.mysql]]
	...
```

## DataKit 主配置修改

以下涉及 DataKit 主配置的修改，均需重启 DataKit：

```shell
sudo datakit service -R
```

### HTTP 设定

#### HTTP 端口绑定

出于安全考虑，DataKit 的 HTTP 服务默认绑定在 `localhost:9529` 上，如果希望从外部访问 DataKit API，需编辑 `conf.d/datakit.conf` 中的 `listen` 字段，这样就能从其它主机上请求 DataKit 接口了：

```toml
[http_api]
	listen = "0.0.0.0:9529" # 将其改成 `0.0.0.0:9529` 或其它网卡、端口
```

当你需要做如下操作时，一般都需要修改 `listen` 配置：

- [远程查看 DataKit 运行情况](http://localhost:9529/monitor)
- [远程查看 DataKit 文档](http://localhost:9529/man)
- [RUM 采集](rum)
- 其它诸如 [APM](ddtrace)/[安全巡检](sec-checker) 等，看具体的部署情况，可能也需要修改 `listen` 配置

#### HTTP API 限流

为保证 DataKit 能较为平稳的在服务器上运行，对于其一些打数据的接口，提供了简单的限流功能（默认不开启限流）：

```toml
[http_api]
  request_rate_limit = 1000.0 # 每秒只能处理 1000 个请求
```

该设定影响所有的[数据上传接口](apis#f53903a9)、[HTTP 远程日志上报](logstreaming) 以及一系列 Tracing 采集器，对于被限流的 API 请求，客户端将收到 429 的 HTTP Code。

### 全局标签（tag）的开启

DataKit 允许在 `datakit.conf` 中配置全局标签，这些标签会默认添加到该 DataKit 采集的每一条数据上（前提是采集的原始数据上不带有这里配置的标签）。这里是一个全局标签配置示例：

```toml
[global_tags]
	ip         = "__datakit_ip"
	datakit_id = "$datakit_id"
	project    = "some_of_your_online_biz"
	other_tags = "..."                    # 可追加其它更多标签
```

注意，如下几个变量可用于这里的全局标签设置（双下划线（`__`）前缀和 `$` 都是可以的）：

- `__datakit_ip/$datakit_ip`：标签值会设置成 DataKit 获取到的第一个主网卡 IP
- `__datakit_id/$datakit_id`：标签值会设置成 DataKit 的 ID

另外，即使这里不设置全局 Tag，DataKit 也会将每一条数据追加上名为 `host` 的标签，其值为 DataKit 所在的主机名。这么做的原因是便于建立异类数据之间的关联（如关联容器数据和容器所在主机的数据）。如果要禁用这一行为，[参见这里](datakit-conf-how-to#1aab7c29)

另外注意的是，这里的标签值必须用双引号包围，否则会导致主配置解析失败。

### 日志配置修改

DataKit 默认日志等级为 `info`。编辑 `conf.d/datakit.conf`，可修改日志等级：

```toml
[logging]
	level = "debug" # 将 info 改成 debug
```

置为 `debug` 后，即可看到更多日志（目前只支持 `debug/info` 两个级别）。

DataKit 默认会对日志进行分片，默认分片大小（`rotate`）为 32MB，总共 6 个分片（1 个当前写入分片加上 5 个切割分片，分片个数尚不支持配置）。如果嫌弃 DataKit 日志占用太多磁盘空间（最多 32 x 6 = 192MB），可减少 `rotate` 大小（比如改成 4，单位为 MB）。

gin.log 也会按照同样的方式自动切割。

### 全局 host 标签问题

因为 DataKit 会默认给采集到的所有数据追加标签 `host=<DataKit所在主机名>`，但某些情况这个默认追加的 `host` 会带来困扰。

以 MySQL 为例，如果 MySQL 不在 DataKit 所在机器，肯定希望这个 `host` 标签是被采集的 MySQL 的真实主机名（或云数据库的其它标识字段），而非 DataKit 所在的主机名。此时可在 `[inputs.mysql.tags]` 中手动增加 `host = "<your-mysql-real-hostname>"`，以此来屏蔽 DataKit 默认追加的 `host` 标签。在 DataKit 看来，如果采集到的数据中就带有 `host` 标签，那么就不再追加 DataKit 所在主机的 host 信息了。

### DataKit 启用磁盘缓存

在 DataKit 中，可以通过磁盘缓存方式来避免某些情况下的数据丢失：

- DataKit 重启
- 因大量数据发送失败而导致的数据清空

进入 DataKit 安装目录下的 `conf.d` 目录，修改 `datakit.conf` 配置文件，将 `[io]` 模块中的 `enable_cache` 设置为 `true`，示例如下：

```toml
[io]
	enable_cache = true
```

### DataKit 限制运行资源

通过 cgourp 限制 DataKit 运行资源（例如 CPU 使用率等），==仅支持 Linux 操作系统==。

进入 DataKit 安装目录下的 `conf.d` 目录，修改 `datakit.conf` 配置文件，将 `enable` 设置为 `true`，示例如下：

```
[cgroup]
  # 是否开启资源限制，默认关闭
  enable = true

  # 允许 CPU 最大使用率（百分制）
  cpu_max = 40.0

  # 允许 CPU 最使用率（百分制）
  cpu_min = 5.0
```

配置好后，重启 DataKit 即可。

#### CPU 使用率说明

DataKit 会持续以当前 CPU 使用率为基准，动态调整自身能使用的 CPU 资源。假设现在 CPU 使用率较高，DataKit 可能会将自身限制在 `cpu_min` 值以下，反之 CPU 较为空闲时，可能会将限制调整到 `cpu_max`。

`cpu_max` 和 `cpu_min` 是正浮点数，且最大值不能超过 `100`。此值为主机 CPU 使用率，而非某个 CPU 核心使用率。

例如 `cpu_max` 为 `40.0`，8 核心 CPU 满负载使用率为 `800%`，则 DataKit 能使用的最大 CPU 资源是 `800% * 40% = 320%` 左右，是占全局 CPU 资源的 40%，而非单核心 CPU 的 40%。

## 通过 Git 管理配置文件

在安装时，即可指定 Git 配置仓库，详情参考 [datakit 安装文档](datakit-install#f9858758)。

### 手动配置 Git 管理

Datakit 支持使用 git 来管理采集器配置、Pipeline 以及 Python 脚本。在 *datakit.conf* 中，找到 *git_repos* 位置，编辑如下内容：

```toml
[git_repos]
  pull_interval = "1m" # 同步配置间隔，即 1 分钟同步一次

  [[git_repos.repo]]
    enable = false   # 不启用该 repo

    ###########################################
		# Git 地址支持的三种协议：http/git/ssh
    ###########################################
    url = "http://username:password@github.com/path/to/repository.git"

		# 以下两种协议(git/ssh)，需配置 key-path 以及 key-password
    # url = "git@github.com:path/to/repository.git"
    # url = "ssh://git@github.com:9000/path/to/repository.git"
    # ssh_private_key_path = "/Users/username/.ssh/id_rsa"
    # ssh_private_key_password = "<YOUR-PASSSWORD>"

    branch = "master" # 指定 git branch
```

注意：开启 Git 同步后，原 `conf.d` 目录下的采集器配置将不再生效（*datakit.conf* 除外）。

#### 应用 Git 管理的 Pipeline 示例

我们可以在采集器配置中，增加 Pipeline 来对相关服务的日志进行切割。在开启 Git 同步的情况下，**DataKit 自带的 Pipeline 和 Git 同步下来的 Pipeline 均可使用**。在 [Nginx 采集器](nginx)的配置中，一个 pipeline 的配置示例：

```toml
[[inputs.nginx]]
    ...
    [inputs.nginx.log]
    ...
    pipeline = "my-nginx.p" # 具体加载哪里的 my-nginx.p，参见下面的 「约束」 说明
```

### Git 管理的使用约束

在 Git 使用过程必须遵循以下约束:

- git repo 里面新建 `conf.d` 文件夹，下面放 DataKit 采集器配置
- git repo 里面新建 `pipeline` 文件夹，下面放置 Pipeline 文件
- git repo 里面新建 `python.d` 文件夹，下面放置 Python 脚本文件

下面以图例来说明：

```
datakit 根目录
├── conf.d
├── data
├── pipeline # 顶层 Pipeline 脚本
├── python.d # 顶层 python.d 脚本
├── externals
└── gitrepos
    ├── repo-1  # 仓库 1
    │   ├── conf.d    # 专门存放采集器配置
    │   ├── pipeline  # 专门存放 pipeline 切割脚本
    │   │   └── my-nginx.p # 合法的 pipeline 脚本
    │   │   └── 123     # 不合法的 Pipeline 子目录，其下文件也不会生效
    │   │       └── some-invalid.p
    │   └── python.d    存放 python.d 脚本
    │       └── core
    └── repo-2  # 仓库 2
        ├── ...
```

查找优先级定义如下:

1. 按 *datakit.conf* 中配置的 *git_repos* 次序（它是一个数组，可配置多个 Git 仓库），逐个查找指定文件名，若找到，返回第一个。比如查找 *my-nginx.p*，如果在第一个仓库目录的 *pipeline* 下找到，则以该找到的为准，**即使第二个仓库中也有同名的 *my-nginx.p*，也不会选择它**。

2. 在 *git_repos* 中找不到的情况下，则去 *<Datakit 安装目录>/pipeline* 目录查找 Pipeline 脚本，或者去 *<Datakit 安装目录>/python.d* 目录查找 Python 脚本。

## 正确使用正则表达式来配置

由于 DataKit 绝大部分使用 Golang 开发，故涉及配置部分中所使用的正则通配，也是使用 Golang 自身的正则实现。由于不同语言的正则体系有一些差异，导致难以一次性正确的将配置写好。

这里推荐一个[在线工具来调试我们的正则通配](https://regex101.com/)。如下图所示：

![](imgs/debug-golang-regexp.png)

另外，由于 DataKit 中的配置均使用 Toml，故建议大家使用 `'''这里是一个具体的正则表达式'''` 的方式来填写正则（即正则俩边分别用三个英文单引号），这样可以避免一些复杂的转义。

## 延伸阅读

- [Kubernetes 环境下的 DataKit 配置](k8s-config-how-to)
