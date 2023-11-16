
# 主机安装
---

本文介绍 DataKit 的基本安装。

## 注册/登陆观测云 {#login-guance}

浏览器访问 [观测云注册入口](https://auth.guance.com/redirectpage/register){:target="_blank"}，填写对应信息之后，即可[登陆观测云](https://console.guance.com/pageloading/login){:target="_blank"}

## 获取安装命令 {#get-install}

登陆工作空间，点击左侧「集成」选择顶部「Datakit」，即可看到各种平台的安装命令。

> 注意，以下 Linux/Mac/Windows 安装程序，能自动识别硬件平台（arm/x86, 32bit/64bit），无需做硬件平台选择。

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    安装命令支持 `bash` 和 `ash`([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)) :

    - `bash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    - `ash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> ash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    安装完成后，在终端会看到安装成功的提示。

=== "Windows"

    Windows 上安装需在 Powershell 命令行安装，且必须以管理员身份运行 Powershell。按下 Windows 键，输入 powershell 即可看到弹出的 powershell 图标，右键选择「以管理员身份运行」即可。
    
    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```
<!-- markdownlint-enable -->

### 安装精简版的 DataKit {#lite-install}

可以通过在安装命令中添加 `DK_LITE` 环境变量来安装精简版的 DataKit ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)) :

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_LITE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_LITE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```

<!-- markdownlint-enable -->

精简版 DataKit 只包含以下采集器：

| 采集器名称                                                        | 说明                                                                         |
| ---                                                               | ---                                                                          |
| [CPU（`cpu`）](../integrations/cpu.md)                            | 采集主机的 CPU 使用情况                                                        |
| [Disk（`disk`）](../integrations/disk.md)                         | 采集磁盘占用情况                                                             |
| [磁盘 IO（`diskio`）](../integrations/diskio.md)                  | 采集主机的磁盘 IO 情况                                                         |
| [内存（`mem`）](../integrations/mem.md)                           | 采集主机的内存使用情况                                                       |
| [Swap（`swap`）](../integrations/swap.md)                         | 采集 Swap 内存使用情况                                                         |
| [System（`system`）](../integrations/system.md)                   | 采集主机操作系统负载                                                         |
| [Net（`net`）](../integrations/net.md)                            | 采集主机网络流量情况                                                         |
| [主机进程（`host_processes`）](../integrations/host_processes.md) | 采集主机上常驻（存活 10min 以上）进程列表                                      |
| [主机对象（`hostobject`）](../integrations/hostobject.md)         | 采集主机基础信息（如操作系统信息、硬件信息等）                               |
| [Datakit（`dk`）](../integrations/dk.md)                          | 采集 Datakit 自身运行指标收集                                                |
| [用户访问监测 (`rum`)](../integrations/rum.md)                    | 用于收集用户访问监测数据                                                |
| [网络拨测 (`dialtesting`)](../integrations/dialtesting.md)        | 采集网络拨测数据                                                |
| [Prom 采集 (`prom`)](../integrations/prom.md)                     | 采集 Prometheus Exporters 暴露出来的指标数据                          |
| [日志采集 (`logging`)](../integrations/logging.md)                 | 采集文件日志数据                          |

### 安装指定版本的 DataKit {#version-install}

可通过在安装命令中指定版本号来安装指定版本的 DataKit，如安装 1.2.3 版本的 DataKit：

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install-1.2.3.sh)"
```

Windows 下同理：

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install-1.2.3.ps1 -destination .install.ps1;
powershell .install.ps1;
```

## 额外支持的安装变量 {#extra-envs}

如果需要在安装阶段定义一些 DataKit 配置，可在安装命令中增加环境变量，在 `DK_DATAWAY` 前面追加即可。如追加 `DK_NAMESPACE` 设置：

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_NAMESPACE=[NAMESPACE] bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_NAMESPACE="[NAMESPACE]";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```
<!-- markdownlint-enable -->

俩种环境变量的设置格式为：

```shell
# Windows: 多个环境变量之间以分号分割
$env:NAME1="value1"; $env:Name2="value2"

# Linux/Mac: 多个环境变量之间以空格分割
NAME1="value1" NAME2="value2"
```

安装脚本支持的环境变量如下（全平台支持）。

<!-- markdownlint-disable MD046 -->
???+ attention

    [全离线安装](datakit-offline-install.md#offline)不支持这些环境变量设置。但可以通过[代理](datakit-offline-install.md#with-datakit)以及[设置本地安装地址](datakit-offline-install.md#with-nginx)方式来设置这些环境变量。
<!-- markdownlint-enable -->

### 最常用环境变量 {#common-envs}

- `DK_DATAWAY`：指定 DataWay 地址，目前 DataKit 安装命令已经默认带上
- `DK_GLOBAL_TAGS`：已弃用，改用 DK_GLOBAL_HOST_TAGS
- `DK_GLOBAL_HOST_TAGS`：支持安装阶段填写全局主机 tag，格式范例：`host=__datakit_hostname,host_ip=__datakit_ip`（多个 tag 之间以英文逗号分隔）
- `DK_GLOBAL_ELECTION_TAGS`：支持安装阶段填写全局选举 tag，格式范例：`project=my-porject,cluster=my-cluster`（多个 tag 之间以英文逗号分隔）
- `DK_CLOUD_PROVIDER`：支持安装阶段填写云厂商(目前支持如下几类云主机 `aliyun/aws/tencent/hwcloud/azure`)。**该功能已弃用**，Datakit 已经可以自动识别云主机类型。
- `DK_USER_NAME`：Datakit 服务运行时的用户名。默认为 `root`。更详情的说明见下面的 “注意事项”。
- `DK_DEF_INPUTS`：[默认开启的采集器](datakit-input-conf.md#default-enabled-inputs)配置。如果要禁用某些采集器，需手动将其屏蔽，比如，要禁用 `cpu` 和 `mem` 采集器，需这样指定：`-cpu,-mem`，即除了这两个采集器之外，其它默认采集器均开启。
- `DK_LITE`：安装精简版 DataKit 时，可设置该变量为 `1`。([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0))

<!-- markdownlint-disable MD046 -->
???+ tip "禁用所有默认采集器 [:octicons-tag-24: Version-1.5.5](changelog.md#cl-1.5.5)"

    如果要禁用所有默认开启的采集器，可以将 `DK_DEF_INPUTS` 设置为 `-`，如

    ```shell
    DK_DEF_INPUTS="-" \
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
    bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    另外，如果之前有安装过 Datakit，必须将之前的默认采集器配置都删除掉，因为 Datakit 在安装的过程中只能添加采集器配置，但不能删除采集器配置。

???+ attention "注意事项"

    由于权限问题，如果通过 `DK_USER_NAME` 修改 Datakit 服务运行时的用户名为非 `root`，那么以下采集器将不可使用：

    - [eBPF](../integrations/ebpf.md){:target="_blank"}

    另外，需要注意以下几项：

    - 必须先手动创建好用户和用户组，用户名和用户组名称必须一致，再进行安装。不同 Linux 发行版创建的命令可能会有差异，以下命令仅供参考：

        === "CentOS/RedHat"

            ```sh
            # 创建系统用户组 datakit
            groupadd --system datakit

            # 创建系统用户 datakit，并将用户 datakit 添加进组 datakit 中（这里用户名和组名都是 datakit）
            adduser --system --no-create-home datakit -g datakit

            # 禁止用户名 datakit 用于登录（用于 CentOS/RedHat 系 Linux）
            usermod -s /sbin/nologin datakit
            ```

        === "Ubuntu/Debian"

            ```sh
            # 在 Ubuntu 上，同时创建用户并添加进用户组的命令可能会报错，这个时候需要分成两步

            # 创建系统用户组 datakit
            groupadd --system datakit

            # 创建系统用户 datakit
            adduser --system --no-create-home datakit
            
            # 将用户 datakit 添加进组 datakit
            usermod -a -G datakit datakit

            # 禁止用户名 datakit 用于登录（用于 Ubuntu/Debian 系 Linux）
            usermod -s /usr/sbin/nologin datakit
            ```

        === "其它 Linux"

            ```sh
            # 在其它 Linux 上，同时创建用户并添加进用户组的命令可能会报错，这个时候需要分成两步

            # 创建系统用户组 datakit
            groupadd --system datakit
            
            # 创建系统用户 datakit
            adduser --system --no-create-home datakit
            
            # 将用户 datakit 添加进组 datakit
            usermod -a -G datakit datakit
            
            # 禁止用户名 datakit 用于登录（用于其它 Linux）
            usermod -s /bin/false datakit
            ```

        ```sh
        # 安装 Datakit
        DK_USER_NAME="datakit" DK_DATAWAY="..." bash -c ...
        ```

<!-- markdownlint-enable -->

### DataKit 自身日志相关 {#env-logging}

- `DK_LOG_LEVEL`: 可选值 info/debug
- `DK_LOG`: 如果改成 stdout, 日志将不写文件，而是终端输出
- `DK_GIN_LOG`: 如果改成 stdout, 日志将不写文件，而是终端输出

### DataKit pprof 相关 {#env-pprof}

- `DK_ENABLE_PPROF`: 是否开启 `pprof`。[:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) 已默认开启。
- `DK_PPROF_LISTEN`: `pprof` 服务监听地址

### DataKit 选举相关 {#env-election}

- `DK_ENABLE_ELECTION`: 开启选举，默认不开启，如需开启，给该环境变量任意一个非空字符串值即可。（如 `True`/`False`）
- `DK_NAMESPACE`：支持安装阶段指定命名空间(选举用)

### HTTP/API 相关环境变量 {#env-http-api}

- `DK_HTTP_LISTEN`：支持安装阶段指定 DataKit HTTP 服务绑定的网卡（默认 `localhost`）
- `DK_HTTP_PORT`：支持安装阶段指定 DataKit HTTP 服务绑定的端口（默认 `9529`）
- `DK_RUM_ORIGIN_IP_HEADER`: RUM 专用
- `DK_DISABLE_404PAGE`: 禁用 DataKit 404 页面 (公网部署 DataKit RUM 时常用。如 `True`/`False`)
- `DK_INSTALL_IPDB`: 安装时指定 IP 库(当前仅支持 `iploc/geolite2`)
- `DK_UPGRADE_IP_WHITELIST`: 从 Datakit [1.5.9](changelog.md#cl-1.5.9) 开始，支持远程访问 API 的方式来升级 Datakit，此环境变量用于设置可以远程访问的客户端 IP 白名单（多个 IP 用逗号 `,` 分隔），不在白名单内的访问将被拒绝（默认是不做 IP 限制）。
- `DK_HTTP_PUBLIC_APIS`: 设置 Datakit 允许远程访问的 HTTP API ，RUM 功能通常需要进行此配置，从 Datakit [1.9.2](changelog.md#cl-1.9.2) 开始支持。

### DCA 相关 {#env-dca}

- `DK_DCA_ENABLE`：支持安装阶段开启 DCA 服务（默认未开启）
- `DK_DCA_LISTEN`：支持安装阶段自定义配置 DCA 服务的监听地址和端口（默认 `0.0.0.0:9531`）
- `DK_DCA_WHITE_LIST`: 支持安装阶段设置访问 DCA 服务白名单，多个白名单以 `,` 分割 (如：`192.168.0.1/24,10.10.0.1/24`)

### 外部采集器相关 {#env-external-inputs}

- `DK_INSTALL_EXTERNALS`: 可用于安装未与 DataKit 一起打包的外部采集器

### Confd 配置相关 {#env-connfd}

| 环境变量名              | 类型   | 适用场景                        | 说明       | 样例值                                         |
| ----                    | ----   | ----                            | ----       | ----                                           |
| DK_CONFD_BACKEND        | string | 全部                            | 后端源类型 | `etcdv3` 或 `zookeeper` 或 `redis` 或 `consul` |
| DK_CONFD_BASIC_AUTH     | string | `etcdv3` 或 `consul`            | 可选       |                                                |
| DK_CONFD_CLIENT_CA_KEYS | string | `etcdv3` 或 `consul`            | 可选       |                                                |
| DK_CONFD_CLIENT_CERT    | string | `etcdv3` 或 `consul`            | 可选       |                                                |
| DK_CONFD_CLIENT_KEY     | string | `etcdv3` 或 `consul` 或 `redis` | 可选       |                                                |
| DK_CONFD_BACKEND_NODES  | string | 全部                            | 后端源地址 | `[IP:2379, IP2:2379]`                          |
| DK_CONFD_PASSWORD       | string | `etcdv3` 或 `consul`            | 可选       |                                                |
| DK_CONFD_SCHEME         | string | `etcdv3` 或 `consul`            | 可选       |                                                |
| DK_CONFD_SEPARATOR      | string | `redis`                         | 可选默认 0 |                                                |
| DK_CONFD_USERNAME       | string | `etcdv3` 或 `consul`            | 可选       |                                                |

### Git 配置相关 {#env-gitrepo}

- `DK_GIT_URL`: 管理配置文件的远程 git repo 地址。（如 `http://username:password@github.com/username/repository.git`）
- `DK_GIT_KEY_PATH`: 本地 PrivateKey 的全路径。（如 `/Users/username/.ssh/id_rsa`）
- `DK_GIT_KEY_PW`: 本地 PrivateKey 的使用密码。（如 `passwd`）
- `DK_GIT_BRANCH`: 指定拉取的分支。**为空则是默认**，默认是远程指定的主分支，一般是 `master`。
- `DK_GIT_INTERVAL`: 定时拉取的间隔。（如 `1m`）

### Sinker 相关配置 {#env-sink}

通过 `DK_SINKER_GLOBAL_CUSTOMER_KEYS` 用于设置 sinker 过滤的 tag/field key 名称，其形式如下：

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_DATAWAY_ENABLE_SINKER=on DK_SINKER_GLOBAL_CUSTOMER_KEYS=key1,key2 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_DATAWAY_ENABLE_SINKER="on";
    $env:DK_SINKER_GLOBAL_CUSTOMER_KEYS="key1,key2";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```
<!-- markdownlint-enable -->

### 资源限制配置相关 {#env-cgroup}

目前仅支持 Linux 和 Windows ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)) 操作系统。

- `DK_LIMIT_DISABLED`：关闭资源限制功能（默认开启）
- `DK_LIMIT_CPUMAX`：支持 CPU 的最大功率，默认 30.0
- `DK_LIMIT_MEMMAX`：限制内存（含 swap）最大用量，默认 4096（4GB）

### 其它安装选项 {#env-others}

| 环境变量名                    | 取值示例           | 说明                                                                                                                             |
| ----                          | ---                | ----                                                                                                                             |
| `DK_INSTALL_ONLY`             | `on`               | 仅安装，不运行                                                                                                                   |
| `DK_HOSTNAME`                 | `some-host-name`   | 支持安装阶段自定义配置主机名                                                                                                     |
| `DK_UPGRADE`                  | `1`                | 升级到最新版本（注：一旦开启该选项，除 `DK_UPGRADE_MANAGER` 外其它选项均无效）                                                   |
| `DK_UPGRADE_MANAGER`          | `on`               | 升级 Datakit 同时是否升级 **远程升级服务**，需要和 `DK_UPGRADE` 配合使用， 从 [1.5.9](changelog.md#cl-1.5.9) 版本开始支持        |
| `DK_INSTALLER_BASE_URL`       | `https://your-url` | 可选择不同环境的安装脚本，默认为 `https://static.guance.com/datakit`                                                             |
| `DK_PROXY_TYPE`               | -                  | 代理类型。选项有：`datakit` 或 `nginx`，均为小写                                                                                 |
| `DK_NGINX_IP`                 | -                  | 代理服务器 IP 地址（只需要填 IP 不需要填端口）。这个与上面的 "HTTP_PROXY" 和 "HTTPS_PROXY" 互斥，而且优先级最高，会覆盖以上两者  |
| `DK_INSTALL_LOG`              | -                  | 设置安装程序日志路径，默认为当前目录下的 *install.log*，如果设置为 `stdout` 则输出到命令行终端                                   |
| `HTTPS_PROXY`                 | `IP:Port`          | 通过 Datakit 代理安装                                                                                                            |
| `DK_INSTALL_RUM_SYMBOL_TOOLS` | `on`               | 是否安装 RUM source map 工具集，从 Datakit [1.9.2](changelog.md#cl-1.9.2) 开始支持                                               |
| `DK_VERBOSE`                  | `on`               | 打开安装过程中的 verbose 选项（仅 Linux/Mac 支持），将输出更多调试信息[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0) |

## FAQ {#faq}

### :material-chat-question: 如何应付不友好的主机名 {#bad-hostname}

由于 DataKit 使用主机名（Hostname）作为数据串联的依据，某些情况下，一些主机名取得不是很友好，比如 `iZbp141ahn....`，但由于某些原因，又不能修改这些主机名，这给使用带来一定的困扰。在 DataKit 中，可在主配置中覆盖这个不友好的主机名。

在 `datakit.conf` 中，修改如下配置，DataKit 将读取 `ENV_HOSTNAME` 来覆盖当前的真实主机名：

```toml
[environments]
    ENV_HOSTNAME = "your-fake-hostname-for-datakit"
```

<!-- markdownlint-disable MD046 -->
???+ attention

    如果之前某个主机已经采集了一段时间的数据，更改主机名后，这些历史数据将不再跟新的主机名关联。更改主机名，相当于新增了一台全新的主机。
<!-- markdownlint-enable -->

### :material-chat-question: Mac 安装问题 {#mac-failed}

Mac 上安装时，如果安装/升级过程中出现

```shell
"launchctl" failed with stderr: /Library/LaunchDaemons/cn.dataflux.datakit.plist: Service is disabled
# 或者
"launchctl" failed with stderr: /Library/LaunchDaemons/com.guance.datakit.plist: Service is disabled
```

执行

```shell
sudo launchctl enable system/datakit
```

然后再执行如下命令即可

```shell
sudo launchctl load -w /Library/LaunchDaemons/cn.dataflux.datakit.plist
# 或者
sudo launchctl load -w /Library/LaunchDaemons/com.guance.datakit.plist
```

## 扩展阅读 {#more-reading}

- [DataKit 使用入门](datakit-service-how-to.md)
