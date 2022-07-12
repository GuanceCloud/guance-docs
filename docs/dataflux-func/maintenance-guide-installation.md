# 部署和维护手册 - 安装部署
---


本文主要介绍如何在服务器上直接安装、部署 DataFlux Func。

有关在 k8s 中使用 Helm 安装 DataFlux Func，请参考 [通过 Helm 部署](/dataflux-func/deploy-via-helm-guide/)

## 1. 使用「携带版」离线安装【推荐】

*本方式为推荐安装方式*

DataFlux Func 支持将所需安装文件下载后，通过 U 盘等移动设备带入无公网环境安装的「携带版」。

下载的「携带版」本身附带了自动安装脚本，执行即可进行安装（详情见下文）

### 1.1 一键命令下载「携带版」安装文件

对于 Linux、macOS 等系统，推荐使用官方提供的 shell 命令下载「携带版」。

运行以下命令，即可自动下载 DataFlux Func 携带版的所需安装文件，下载脚本会自动根据当前环境选择下载`x86_64`或`aarch64`架构版本：

*注意：安装前请确认系统要求和服务器配置*

```shell
/bin/bash -c "$(curl -fsSL t.guance.com/func-portable-download)"
```

如需要下载指定架构的版本，可以使用以下命令下载：

- `Intel x86_64`处理器

```shell
/bin/bash -c "$(curl -fsSL t.guance.com/func-portable-download)" -- --arch x86_64
```

- `ARM aarch64`处理器（即 ARM64v8，如：树莓派等）

```shell
/bin/bash -c "$(curl -fsSL t.guance.com/func-portable-download)" -- --arch aarch64
```

命令执行完成后，所有安装文件都保存在自动创建的`dataflux-func-portable-{架构}-{版本号}`目录下。

- 对于需要将 DataFlux Func 安装到*无公网*的服务器时，可以先在本机下载，之后将整个目录通过 U 盘等移动存储设备，或`scp`工具等复制到目标机器中
- 对于需要将 DataFlux Func 安装到可以访问公网的服务器，直接在服务器上下载即可

### 1.2 手工下载「携带版」安装文件

对于不便使用 shell 命令的系统，可手工下载所需安装文件。

如需要手工下载，以下是所有的文件列表：

| #   | 内容                      | 文件名                      | x86_64 架构                                                                          | aarch64 架构                                                                          |
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

### 1.3 使用「携带版」附带的脚本执行安装

运行安装文件所在目录下的`run-portable.sh`，即可自动配置并最终启动整个 DataFlux Func：

*注意：安装前请确认系统要求和服务器配置*

*注意：DataFlux Func 不支持 Mac，请拷贝到 Linux 系统下再运行安装*

```shell
cd {安装文件所在目录}
sudo /bin/bash run-portable.sh

# 或者
sudo /bin/bash {安装文件所在目录}/run-portable.sh
```

使用自动安装脚本可以实现几分钟内快速安装运行，自动配置的内容如下：

- 运行 MySQL、Redis、DataFlux Func（包含 Server，Worker，Beat）
- 自动创建并将所有数据保存于`/usr/local/dataflux-func/`目录下（包括 MySQL 数据、Redis 数据、DataFlux Func 配置、日志等文件）
- 随机生成 MySQL `root`用户密码、系统 Secret，并保存于 DataFlux Func 配置文件中
- Redis 不设密码
- MySQL、Redis 不提供外部访问

执行完成后，可以使用浏览器访问`http://{服务器 IP 地址/域名}:8088`进行初始化操作界面。

*注意：如果运行环境性能较差，应当使用`docker ps`命令确认所有组件成功启动后，方可访问（见以下列表）*

1. `dataflux-func_mysql`
2. `dataflux-func_redis`
3. `dataflux-func_server`
4. `dataflux-func_worker-0`
5. `dataflux-func_worker-1-6`
6. `dataflux-func_worker-7`
7. `dataflux-func_worker-8-9`
8. `dataflux-func_beat`

### 1.4 「携带版」指定安装选项

安装「携带版」时，只需要在自动安装命令后添加`--{参数}[ 参数配置（如有）]`，即可指定安装选项

如，指定端口号为 9000：

```shell
sudo /bin/bash run-portable.sh --port 9000
```

> 可用安装选项见下文

## 2. 使用一键安装命令在线安装【不推荐】

*注意：由于涉及驻云镜像库登录等事宜，本方式不做为首推方案*

*注意：需要事先已经安装好 Docker 且配置好 Docker Swarm，并已经登录驻云官方镜像库`pubrepo.jiagouyun.com`*

DataFlux Func 提供了一键在线安装脚本，可以在数分钟内完成安装并运行。

运行以下命令，即可自动下载配置脚本并最终启动整个 DataFlux Func：

```shell
sudo /bin/bash -c "$(curl -fsSL t.guance.com/func-docker-stack-run)"
```

使用自动安装脚本可以实现几分钟内快速安装运行，自动配置的内容如下：

- 运行 MySQL、Redis、DataFlux Func（包含 Server，Worker，Beat）
- 自动创建并将所有数据保存于`/usr/local/dataflux-func/`目录下（包括 MySQL 数据、Redis 数据、DataFlux Func 配置、日志等文件）
- 随机生成 MySQL `root`用户密码、系统 Secret，并保存于 DataFlux Func 配置文件中
- Redis 不设密码
- MySQL、Redis 不提供外部访问

执行完成后，可以使用浏览器访问`http://localhost:8088`进行初始化操作界面。

*注意：如果运行环境性能较差，应当使用`docker ps`命令确认所有组件成功启动后，方可访问（见以下列表）*

1. `dataflux-func_mysql`
2. `dataflux-func_redis`
3. `dataflux-func_server`
4. `dataflux-func_worker-0`
5. `dataflux-func_worker-1-6`
6. `dataflux-func_worker-7`
7. `dataflux-func_worker-8-9`
8. `dataflux-func_beat`

### 2.1 在线安装版指定安装选项

使用一键安装命令在线安装时，只需要在自动安装命令后添加`-- --{参数}[ 参数配置（如有）]`，即可指定安装选项

如，指定安装目录：

```shell
sudo /bin/bash -c "$(curl -fsSL t.guance.com/func-docker-stack-run)" -- --install-dir /home/dev/datafluxfunc
```

*注意：参数前确实有`--`，表示参数传递给需要执行的脚本，此处不是笔误*

> 可用安装选项见下文

## 3. 验证安装

DataFlux Func 默认安装完成后，就已经附带了一些示例脚本。

依次执行以下操作，即可验证安装：

1. 点击顶部导航条的「脚本编辑器」，在左侧栏依次选择「脚本库」-「示例」-「基础演示」
2. 在右侧脚本编辑器顶部，点击「编辑」进入编辑模式，选择「hello_world」函数并点击「执行」按钮执行函数
3. 此时，如果在底部「脚本输出」中，能够正常看到函数的返回值

至此，验证安装完毕

### 3.1 各服务说明

默认情况下，DataFlux Func 正常启动后，共有如下服务运行：

| 名称                       | 说明                                                                         |
| -------------------------- | ---------------------------------------------------------------------------- |
| `dataflux-func_server`     | DataFlux Func 的前端服务。<br>主要用于提供 Web 界面、API 接口等              |
| `dataflux-func_worker-0`   | 监听#0 号队列的 Python 工作单元。<br>主要处理 DataFlux Func 的内部任务       |
| `dataflux-func_worker-1-6` | 监听#1~#6 号队列的 Python 工作单元。<br>主要处理同步任务（授权链接）         |
| `dataflux-func_worker-7`   | 监听#7 号队列的 Python 工作单元。<br>主要处理在 Web 界面中运行脚本的调试任务 |
| `dataflux-func_worker-8-9` | 监听#1~#6 号队列的 Python 工作单元。<br>主要处理异步任务（自动触发、批处理） |
| `dataflux-func_beat`       | 自动触发任务的触发器，全局只能开启 1 个                                      |
| `dataflux-func_mysql`      | DataFlux Func 自带的内置 MySQL                                               |
| `dataflux-func_redis`      | DataFlux Func 自带的内置 Redis                                               |

### 3.2 数据保存位置

DataFlux Func 运行需要存储各种不同的数据，大致内容及存储位置如下：

| 存储    | 存储内容                                                                                                                                                                            |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `MySQL` | 绝大部分在 UI 操作中产生的数据，包括且不限于：<br>1. 脚本、数据源配置、环境变量<br>2. 用户信息、授权链接配置、自动触发配置、批处理配置<br>3. 操作记录、脚本运行记录、导入导出记录等 |
| `Redis` | 主要用于缓存和队列，包括且不限于：<br>1. 用户登录信息<br>2. 脚本运行时建立的各种缓存<br>3. 脚本执行任务队列<br>4. Func 自身监控数据等                                               |
| `磁盘`  | 主要用于必须以文件形式存在的数据，包括且不限于：<br>1. DataFlux Func 系统配置<br>2. PIP 工具安装的第三方包<br>3. 用户上传的文件<br>4. 数据库备份文件等                              |

## 4. 安装选项

在执行安装脚本时，可以指定安装选项以满足个性化需求：

### `--mini`：安装迷你版

针对低配置环境下，需要节约资源时的安装模式。

开启后：

- 仅启动单个 Worker 监听所有队列
- 遇到重负载任务更容易导致队列阻塞和卡顿
- 系统任务和函数任务共享处理队列，相互会受到影响
- 系统要求降低为：
    - CPU 核心数 >= 1
    - 内存容量 >= 2GB
- 如不使用内置的 MySQL、Redis，系统要求可以进一步降低

### `--port {端口号}`：指定监听端口号

DataFlux Func 默认使用`8088`端口访问，如果此端口被其他程序占用，可以选择其他端口，如：`9000`。

### `--install-dir {安装目录}`：指定安装目录

需要安装到与默认路径`/usr/local/dataflux-func`不同的路径下时，可指定此参数

### `--no-mysql`：禁用内置 MySQL

需要使用已有的 MySQL 数据库时，可指定此参数，禁止在本机启动 MySQL。

*注意：启用此选项后，需要在安装完成后的配置页面指定正确的 MySQL 连接信息*

### `--no-redis`：禁用内置 Redis

需要使用已有的 Redis 数据库时，可指定此参数，禁止在本机启动 Redis。

*注意：启用此选项后，需要在安装完成后的配置页面指定正确的 Redis 连接信息*

## 5. 使用 Helm 在 k8s 中安装

请参考文档 [部署和维护手册 - 通过 Helm 在 k8s 中部署](/dataflux-func/maintenance-guide-helm/)