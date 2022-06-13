# 快速开始
---


DataFlux Func 是一个基于Python 的脚本开发、管理、执行平台。

> `DataFlux Func` 读作`data flux function`，系统内有时会缩写为`DFF`。

前身为[观测云](https://guance.com/) 下属的一个函数计算组件，目前已成为可独立运行的系统。

#### 携带版下载命令

```shell
/bin/bash -c "$(curl -fsSL t.guance.com/func-portable-download)"
```

## 0. 阅读前提示

*注意：本文所有涉及到的shell命令，在root用户下可直接运行，非root用户下需要添加sudo运行*

*注意：本文仅提供最常见的操作步骤，详细安装部署请参考「维护手册」*



## 1. 系统及环境要求

安装DataFlux Func 之前，请务必确认环境已经满足以下条件。

### 1.1 系统要求

运行DataFlux Func 的主机需要满足以下条件：

- CPU 核心数 >= 2
- 内存容量 >= 4GB
- 磁盘空间 >= 20GB
- 网络带宽 >= 10Mbps
- 操作系统为 Ubuntu 16.04 LTS/CentOS 7.2 以上
- 纯净系统（安装完操作系统后，除了配置网络外没有进行过其他操作）
- 开放`8088`端口（本系统默认使用`8088`端口，请确保防火墙、安全组等配置允许`8088`入方向访问）
- 使用外部MySQL 时，MySQL 版本必须为5.7以上
- 使用外部Redis 时，Redis 版本必须为4.0以上

*注意：DataFlux Func 不支持macOS、Windows，您可以选择在虚拟机、云主机中安装DataFlux Func*

*注意：DataFlux Func 不支持集群版Redis，有高可用需要请选择主从版*

*注意：如果在阿里云ECS上安装DataFlux Func，并且开启了阿里云盾插件。由于云盾本身占用资源较多，所以系统配置应适当提高*

> 详细操作系统兼容性实测结果，可参考「维护手册 - 已实测操作系统兼容性」

如希望在树莓派上安装，请参考以下文章：

- [在树莓派上运行 - Ubuntu Server 64-bit](https://docs.guance.com/dataflux-func/run-on-raspberry-pi-ubuntu)
- [在树莓派上运行 - 官方Raspberry Pi OS](https://docs.guance.com/dataflux-func/run-on-raspberry-pi-os)

### 1.2 软件准备

本系统基于Docker Stack 运行，因此要求操作系统可以正常使用Docker 和Docker Stack

安装脚本本身已经自带了Docker 的安装包并会在安装时自动安装。
用户也可以自行安装Docker 并初始化Docker Swarm，然后运行安装脚本，
安装脚本在发现Docker 已经安装后会自动跳过这部分处理。

- Docker Swarm 初始化命令为：`sudo docker swarm init`

如果本机存在多个网卡，需要在上述初始化命令中指定网卡

- 存在多网卡的建议用户自行安装Docker 并初始化Docker Swarm
- Docker Swarm 指定网卡的初始化命令为：`sudo docker swarm init --advertise-addr={网卡名} --default-addr-pool={默认地址池}`
- 本机网卡列表可以通过`ifconfig`或者`ip addr`查询

*注意：自动安装脚本在进行`docker swarm init`时，`--advertise-addr`参数会指定为`127.0.0.1`，`--default-addr-pool`参数会指定为`10.255.0.0/16`*

*注意：DataFlux Func 不支持在snap 版Docker 上运行*



## 2. 使用「携带版」离线安装

DataFlux Func 支持将所需安装文件下载后，通过U盘等移动设备带入无公网环境安装的「携带版」。

下载的「携带版」本身附带了自动安装脚本，执行即可进行安装（详情见下文）

### 2.1 一键命令下载「携带版」安装文件

对于Linux、macOS 等系统，推荐使用官方提供的shell 命令下载「携带版」。

运行以下命令，即可自动下载DataFlux Func携带版的所需安装文件，下载脚本会自动根据当前环境选择下载`x86_64`或`aarch64`架构版本：

*注意：安装前请确认系统要求和服务器配置*

```shell
/bin/bash -c "$(curl -fsSL t.guance.com/func-portable-download)"
```

命令执行完成后，所有安装文件都保存在自动创建的`dataflux-func-portable-{架构}-{版本号}`目录下。

- 对于需要将DataFlux Func 安装到*无公网*的服务器时，可以先在本机下载，之后将整个目录通过U盘等移动存储设备，或`scp`工具等复制到目标机器中
- 对于需要将DataFlux Func 安装到可以访问公网的服务器，直接在服务器上下载即可

### 2.2 手工下载「携带版」安装文件

对于不便使用shell 命令的系统，可手工下载所需安装文件。

如需要手工下载，以下是所有的文件列表：

| #   | 内容                      | 文件名                      | x86_64架构                                                                           | aarch64架构                                                                           |
| --- | ------------------------- | --------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------- |
| 1   | Docker 二进制程序         | `docker-20.10.8.tgz`        | [下载](https://static.guance.com/dataflux-func/portable/x86_64/docker-20.10.8.tgz)   | [下载](https://static.guance.com/dataflux-func/portable/aarch64/docker-20.10.8.tgz)   |
| 2   | DataFlux Func 镜像        | `dataflux-func.tar.gz`      | [下载](https://static.guance.com/dataflux-func/portable/x86_64/dataflux-func.tar.gz) | [下载](https://static.guance.com/dataflux-func/portable/aarch64/dataflux-func.tar.gz) |
| 3   | MySQL/MariaDB 镜像        | `mysql.tar.gz`              | [下载](https://static.guance.com/dataflux-func/portable/x86_64/mysql.tar.gz)         | [下载](https://static.guance.com/dataflux-func/portable/aarch64/mysql.tar.gz)         |
| 4   | Redis 镜像                | `redis.tar.gz`              | [下载](https://static.guance.com/dataflux-func/portable/x86_64/redis.tar.gz)         | [下载](https://static.guance.com/dataflux-func/portable/aarch64/redis.tar.gz)         |
| 5   | Docker 服务配置文件       | `docker.service`            | [下载](https://static.guance.com/dataflux-func/portable/docker.service)              | [下载](https://static.guance.com/dataflux-func/portable/docker.service)               |
| 6   | DataFluxFunc 安装脚本     | `run-portable.sh`           | [下载](https://static.guance.com/dataflux-func/portable/run-portable.sh)             | [下载](https://static.guance.com/dataflux-func/portable/run-portable.sh)              |
| 7   | Docker Stack 配置文件模板 | `docker-stack.example.yaml` | [下载](https://static.guance.com/dataflux-func/portable/docker-stack.example.yaml)   | [下载](https://static.guance.com/dataflux-func/portable/docker-stack.example.yaml)    |
| 8   | 镜像列表                  | `image-list`                | [下载](https://static.guance.com/dataflux-func/portable/x86_64/image-list)           | [下载](https://static.guance.com/dataflux-func/portable/aarch64/image-list)           |
| 9   | 版本信息                  | `version`                   | [下载](https://static.guance.com/dataflux-func/portable/version)                     | [下载](https://static.guance.com/dataflux-func/portable/version)                      |

手工下载所有安装文件后，放入同一个目录下即可。

*注意：如有更新，【重新下载所有文件】。请勿自行猜测哪些文件有变动，哪些没有变动*

*注意：手工下载时，如使用浏览器等下载时，请注意不要下载到缓存的旧内容！！*

### 2.3 使用自动安装脚本执行安装

运行安装文件所在目录下的`run-portable.sh`，即可自动配置并最终启动整个DataFlux Func：

*注意：安装前请确认系统要求和服务器配置*

*注意：DataFlux Func 不支持Mac，请拷贝到Linux 系统下再运行安装*

```shell
cd {安装文件所在目录}
sudo /bin/bash run-portable.sh

# 或者
sudo /bin/bash {安装文件所在目录}/run-portable.sh
```

系统默认使用`8088`端口，如需要安装时指定端口号，可以加上`--port {端口号}`参数：

```shell
sudo /bin/bash run-portable.sh --port 9000
```

> 更多配置参数见下文「安装选项」或「维护手册」-「安装选项」

使用自动安装脚本可以实现几分钟内快速安装运行，自动配置的内容如下：

- 运行MySQL、Redis、DataFlux Func（包含Server，Worker，Beat）
- 自动创建并将所有数据保存于`/usr/local/dataflux-func/`目录下（包括MySQL数据、Redis数据、DataFlux Func 配置、日志等文件）
- 随机生成MySQL `root`用户密码、系统Secret，并保存于DataFlux Func 配置文件中
- Redis不设密码
- MySQL、Redis 不提供外部访问

执行完成后，可以使用浏览器访问`http://{服务器IP地址/域名}:{端口}`进行初始化操作界面。

*注意：如果运行环境性能较差，应当使用`docker ps`命令确认所有组件成功启动后，方可访问（见以下列表）*

1. `dataflux-func_mysql`
2. `dataflux-func_redis`
3. `dataflux-func_server`
4. `dataflux-func_worker-0`
5. `dataflux-func_worker-1-6`
6. `dataflux-func_worker-7`
7. `dataflux-func_worker-8-9`
8. `dataflux-func_beat`



## 3. 安装选项

自动安装脚本支持一些安装选项，用于适应不同的安装需求

### 3.1 「携带版」指定安装选项

安装「携带版」时，只需要在自动安装命令后添加`--{参数}[ 参数配置（如有）]`，即可指定安装选项

如，指定端口号为9000：

```shell
sudo /bin/bash run-portable.sh --port 9000
```

### 3.2 可用安装选项

具体参数详情见下文

##### `--mini`：安装迷你版

针对低配置环境下，需要节约资源时的安装模式。

开启后：

- 仅启动单个Worker 监听所有队列
- 遇到重负载任务更容易导致队列阻塞和卡顿
- 系统任务和函数任务共享处理队列，相互会受到影响
- 系统要求降低为：
    - CPU 核心数 >= 1
    - 内存容量 >= 2GB
- 如不使用内置的MySQL、Redis，系统要求可以进一步降低

##### `--port {端口号}`：指定监听端口号

DataFlux Func 默认使用`8088`端口访问，如果此端口被其他程序占用，可以选择其他端口，如：`9000`。

##### `--install-dir {安装目录}`：指定安装目录

需要安装到与默认路径`/usr/local/dataflux-func`不同的路径下时，可指定此参数

##### `--no-mysql`：禁用内置MySQL

需要使用已有的MySQL数据库时，可指定此参数，禁止在本机启动MySQL。

*注意：启用此选项后，需要在安装完成后的配置页面指定正确的MySQL连接信息*

##### `--no-redis`：禁用内置Redis

需要使用已有的Redis数据库时，可指定此参数，禁止在本机启动Redis。

*注意：启用此选项后，需要在安装完成后的配置页面指定正确的Redis连接信息*



## 4. 相关链接

- [观测云官方网站](https://guance.com/)
- [DataFlux Func 官方网站](https://function.guance.com/)
- [DataFlux Func 宣传小册子](https://t.guance.com/func-intro)
- [DataFlux Func 用户手册](https://static.guance.com/dataflux-func/resource/docs/user-guide.pdf)
