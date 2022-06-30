# 维护手册 - 系统要求
---


安装 DataFlux Func 之前，请务必确认环境已经满足以下条件。

## 1. 系统要求

运行 DataFlux Func 的主机需要满足以下条件：

- CPU 核心数 >= 2
- 内存容量 >= 4GB
- 磁盘空间 >= 20GB
- 网络带宽 >= 10Mbps
- 操作系统为 Ubuntu 16.04 LTS/CentOS 7.2 以上
- 纯净系统（安装完操作系统后，除了配置网络外没有进行过其他操作）
- 开放`8088`端口（本系统默认使用`8088`端口，请确保防火墙、安全组等配置允许`8088`入方向访问）
- 使用外部 MySQL 时，MySQL 版本必须为 5.7 以上
- 使用外部 Redis 时，Redis 版本必须为 4.0 以上

*注意：DataFlux Func 不支持 macOS、Windows，您可以选择在虚拟机、云主机中安装 DataFlux Func*

*注意：DataFlux Func 不支持集群版 Redis，有高可用需要请选择主从版*

*注意：如果在阿里云 ECS 上安装 DataFlux Func，并且开启了阿里云盾插件。由于云盾本身占用资源较多，所以系统配置应适当提高*

> 详细操作系统兼容性实测结果，可参考「已实测操作系统兼容性」

如希望在树莓派上安装，请参考以下文章：

- [在树莓派上运行 - Ubuntu Server 64-bit](/dataflux-func/run-on-raspberry-pi-ubuntu)
- [在树莓派上运行 - 官方 Raspberry Pi OS](/dataflux-func/run-on-raspberry-pi-os)

## 2. 软件准备

本系统基于 Docker Stack 运行，因此：

对于在线安装版，要求操作系统已经可以正常使用 Docker 和 Docker Stack。

对于携带版，安装脚本本身已经自带了 Docker 的安装包并会在安装时自动安装。
用户也可以自行安装 Docker 并初始化 Docker Swarm，然后运行安装脚本，
安装脚本在发现 Docker 已经安装后会自动跳过这部分处理。

- Docker Swarm 初始化命令为：`sudo docker swarm init`

如果本机存在多个网卡，需要在上述初始化命令中指定网卡

- 存在多网卡的建议用户自行安装 Docker 并初始化 Docker Swarm
- Docker Swarm 指定网卡的初始化命令为：`sudo docker swarm init --advertise-addr={网卡名} --default-addr-pool={默认地址池}`
- 本机网卡列表可以通过`ifconfig`或者`ip addr`查询
- 默认地址池注意不要与本地网络子网冲突

*注意：自动安装脚本在进行`docker swarm init`时，`--advertise-addr`参数会指定为`127.0.0.1`，`--default-addr-pool`参数会指定为`10.255.0.0/16`*

*注意：DataFlux Func 不支持在 snap 版 Docker 上运行*

## 3. 已实测操作系统兼容性

本系统运行依赖 Docker Swarm，部分比较旧的 Linux 发行版可能不支持新版 Docker，导致无法安装本系统。

以下实测环境中：

- 虚拟机：均使用官方 ISO 镜像，安装后直接部署 DataFlux Func
- 阿里云：均使用 ECS 自营镜像，ECS 启动后直接部署 DataFlux Func
- 树莓派：均为官方网站提供的 ISO 镜像（ARM 64 位运行），启动后直接部署 DataFlux Func

> 提示：以下列出的操作系统表示在云平台或虚拟机实际装机，并运行测试通过，未列出的不代表不兼容。

*注意：DataFlux Func 需要运行在 64 位系统中。官方 Raspberry Pi OS 也需要开启 ARM 64 位模式运行。*

### 3.1 Ubuntu 各版本实测

| 架构      | 操作系统                   | 实测环境         | 实测结果 | 备注                                                                                                       |
| --------- | -------------------------- | ---------------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `x86_64`  | Ubuntu Kylin 20.04 LTS Pro | 虚拟机           | 兼容     | 系统已自带 Docker，<br>需要事先手工初始化 Docker Swarm                                                     |
| `x86_64`  | Ubuntu 20.04 LTS           | 虚拟机           | 兼容     |                                                                                                            |
| `x86_64`  | Ubuntu 18.04 LTS           | 虚拟机           | 兼容     |                                                                                                            |
| `x86_64`  | Ubuntu 16.04 LTS           | 虚拟机           | 兼容     |                                                                                                            |
| `x86_64`  | Ubuntu 14.04 LTS           | 虚拟机           | *不兼容* | 因 Docker 新特性要求，<br>无法使用新版 Docker                                                              |
| `aarch64` | Ubuntu 18.04 LTS           | 阿里云           | 兼容     |                                                                                                            |
| `aarch64` | Ubuntu 20.04 LTS           | 树莓派 4B 8GB 版 | 兼容     | 详细请参考 [在树莓派上运行 - Ubuntu Server 64-bit](/dataflux-func/run-on-raspberry-pi-ubuntu) |

### 3.2 Debian 各版本实测

| 架构      | 操作系统                             | 实测环境         | 实测结果 | 备注                                                                                                                                    |
| --------- | ------------------------------------ | ---------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `x86_64`  | Debian 10.2 "buster"                 | 阿里云           | 兼容     |                                                                                                                                         |
| `x86_64`  | Debian 9.6 "stretch"                 | 阿里云           | 兼容     |                                                                                                                                         |
| `x86_64`  | Debian 8.11 "jessie"                 | 阿里云           | 兼容     |                                                                                                                                         |
| `aarch64` | Debian 10.9 "buster"                 | 阿里云           | 兼容     |                                                                                                                                         |
| `aarch64` | Raspberry Pi OS (Debain 10 "buster") | 树莓派 4B 8GB 版 | 兼容     | 需要树莓派开启`arm64_bit`模式<br>详细请参考 [在树莓派上运行 - 官方 Raspberry Pi OS](/dataflux-func/run-on-raspberry-pi-os) |

### 3.3 CentOS 各版本实测

| 架构      | 操作系统    | 实测环境 | 实测结果 | 备注                                                    |
| --------- | ----------- | -------- | -------- | ------------------------------------------------------- |
| `x86_64`  | CentOS 8.2  | 阿里云   | 兼容     |                                                         |
| `x86_64`  | CentOS 8.0  | 阿里云   | 兼容     |                                                         |
| `x86_64`  | CentOS 7.9  | 阿里云   | 兼容     |                                                         |
| `x86_64`  | CentOS 7.6  | 阿里云   | 兼容     |                                                         |
| `x86_64`  | CentOS 7.2  | 阿里云   | 兼容     |                                                         |
| `x86_64`  | CentOS 6.10 | 阿里云   | *不兼容* | 因 Docker 新特性要求，<br>无法使用新版 Docker           |
| `aarch64` | CentOS 8.3  | 阿里云   | *不兼容* | 因官方 Redis 镜像无法启动而不兼容，<br>详见下方「提示」 |
| `aarch64` | CentOS 7.9  | 阿里云   | *不兼容* | 因官方 Redis 镜像无法启动而不兼容，<br>详见下方「提示」 |

官方 Redis 镜像在 ARM 版 CentOS 上启动时，会发生`<jemalloc>: Unsupported system page size`错误，参见：

- [CSDN：arm64 下启动 redis 官方容器报错处理](https://blog.csdn.net/toyangdon/article/details/104941161)
- [Github issue: docker-library/redis/issues/208](https://github.com/docker-library/redis/issues/208)

### 3.4 macOS、Windows

*暂不支持 macOS、Windows，您可以选择在虚拟机、云主机中安装 DataFlux Func*

### 3.5 其他操作系统

| 架构     | 操作系统                                             | 实测环境 | 实测结果 | 备注                                                                       |
| -------- | ---------------------------------------------------- | -------- | -------- | -------------------------------------------------------------------------- |
| `x86_64` | Alibaba Cloud Linux 2.1903 LTS 64 位 等保 2.0 三级版 | 阿里云   | 兼容     | 需要在`root`用户下进行安装<br>是否执行`/root/cybersecurity.sh`不影响兼容性 |

## 4. 已知浏览器兼容性

本系统为 Web 应用，部分浏览器可能存在兼容问题无法使用

| 浏览器                                     | 实测结果 |
| ------------------------------------------ | -------- |
| Chrome                                     | 兼容     |
| Safari                                     | 兼容     |
| Firefox                                    | 兼容     |
| Microsoft Edge (webkit)                    | 兼容     |
| Opera                                      | 兼容     |
| 遨游浏览器                                 | 兼容     |
| 搜狗浏览器                                 | 兼容     |
| QQ 浏览器                                  | 兼容     |
| 360 极速浏览器（极速模式，即 Chrome 模式） | 兼容     |
| 360 极速浏览器（兼容模式，即 IE 模式）     | *不兼容* |
| Internet Explorer                          | *不兼容* |
