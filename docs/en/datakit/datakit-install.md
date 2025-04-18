
# Host Installation
---

This article describes the basic installation of DataKit.

## Register/log in to <<<custom_key.brand_name>>> {#login-guance}

The browser visits the [<<<custom_key.brand_name>>> registration](https://auth.<<<custom_key.brand_main_domain>>>/redirectpage/register){:target="_blank"} portal, fills in the corresponding information, and then [logs in to <<<custom_key.brand_name>>>](https://console.<<<custom_key.brand_main_domain>>>/pageloading/login){:target="_blank"}.

## Get the Installation Command {#get-install}

Log in to the workspace, click "Integration" on the left and select "Datakit" at the top, and you can see the installation commands of various platforms.

> Note that the following Linux/Mac/Windows installer can automatically identify the hardware platform (arm/x86, 32bit/64bit) without making a hardware platform selection.
<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    The installation command supports `bash` and `ash`([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)), and the command is roughly as follows:

    - `bash`
    
    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)" 
    ```
    
    - `ash`

    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> ash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

    After the installation is completed, you will see a prompt that the installation is successful at the terminal.

=== "Windows"

    Installation on Windows requires a Powershell command line installation and must run Powershell as an administrator. Press the Windows key, enter powershell to see the pop-up powershell icon, and right-click and select "Run as an administrator".
    
    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->
### Install DataKit lite {#lite-install}

You can specify the environment variable `DK_LITE` to install DataKit lite ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)):
<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> DK_LITE=1 bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
    $env:DK_LITE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->
DataKit lite only contains collectors as below:

| Collector Name                                                 | Description                                                                                                   |
| -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| [`cpu`](../integrations/cpu.md)                                | Collect the CPU usage of the host                                                                             |
| [`disk`](../integrations/disk.md)                              | Collect disk occupancy                                                                                        |
| [`diskio`](../integrations/diskio.md)                          | Collect the disk IO status of the host                                                                        |
| [`mem`](../integrations/mem.md)                                | Collect the memory usage of the host                                                                          |
| [`swap`](../integrations/swap.md)                              | Collect Swap memory usage                                                                                     |
| [`system`](../integrations/system.md)                          | Collect the load of host operating system                                                                     |
| [`net`](../integrations/net.md)                                | Collect host network traffic                                                                                  |
| [`host_processes`](../integrations/host_processes.md)          | Collect the list of resident (surviving for more than 10min) processes on the host                            |
| [`hostobject`](../integrations/hostobject.md)                  | Collect basic information of host computer (such as operating system information, hardware information, etc.) |
| [DataKit(dk)](../integrations/dk.md)                           | Collect Datakit running metrics                                                                               |
| [RUM(rum)](../integrations/rum.md)                             | Collect user access monitoring data                                                                           |
| [Net dialtesting(dialtesting)](../integrations/dialtesting.md) | Collect the data generated by dialing test                                                                    |
| [Prom (prom)](../integrations/prom.md)                         | Collect data exposed by Prometheus Exporters                                                                  |
| [logging](../integrations/logging.md)                          | Collect file log data                                                                                         |

<!-- markdownlint-enable -->
### Install DataKit eBPF Span Linker Version {#elinker-install}

You can specify the environment variable `DK_ELINKER` to install DataKit ELinker ([:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)):
<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> DK_ELINKER=1 bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
    $env:DK_ELINKER="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->
DataKit ELinker only contains collectors as below:

| Collector Name                                | Description                                                                                                   |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| [`cpu`](../integrations/cpu.md)               | Collect the CPU usage of the host                                                                             |
| [`disk`](../integrations/disk.md)             | Collect disk occupancy                                                                                        |
| [`diskio`](../integrations/diskio.md)         | Collect the disk IO status of the host                                                                        |
| [`ebpftrace`](../integrations/ebpftrace.md)   | Receive eBPF trace span and link these spans to generate trace id                                             |
| [`mem`](../integrations/mem.md)               | Collect the memory usage of the host                                                                          |
| [`swap`](../integrations/swap.md)             | Collect Swap memory usage                                                                                     |
| [`system`](../integrations/system.md)         | Collect the load of host operating system                                                                     |
| [`net`](../integrations/net.md)               | Collect host network traffic                                                                                  |
| [`hostobject`](../integrations/hostobject.md) | Collect basic information of host computer (such as operating system information, hardware information, etc.) |
| [`DataKit(dk)`](../integrations/dk.md)        | Collect Datakit running metrics                                                                               |

### Install Specific Version {#version-install}

We can install specific DataKit version, for example 1.2.3:

```shell
DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install-1.2.3.sh)"
```

And the same as Windows:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install-1.2.3.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

## Additional Supported Environment Variable {#extra-envs}

If you need to define some DataKit configuration during the installation phase, you can add environment variables to the installation command, just append them before `DK_DATAWAY` For example, append the `DK_NAMESPACE` setting:
<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> DK_NAMESPACE=<namespace> bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
    $env:DK_NAMESPACE="<namespace>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
---
<!-- markdownlint-enable -->
The setting format of the two environment variables is:

```shell
# Windows: Multiple environment variables are divided by semicolons
$env:NAME1="value1"; $env:Name2="value2"

# Linux/Mac: Multiple environment variables are divided by spaces
NAME1="value1" NAME2="value2"
```

The environment variables supported by the installation script are as follows (supported by the whole platform).
<!-- markdownlint-disable MD046 -->
???+ attention

    1. These environment variable settings are not supported for [full offline installation](datakit-offline-install.md#offline). However, these environment variables can be set by [proxy](datakit-offline-install.md#with-datakit) and [setting local installation address](datakit-offline-install.md#with-nginx).
    1. These environment variables are only effective in installation mode; they do not take effect in upgrade mode.
<!-- markdownlint-enable -->

### Most Commonly Used Environment Variables {#common-envs}

- `DK_DATAWAY`: Specify the DataWay address, and the DataKit installation command has been brought by default
- `DK_GLOBAL_TAGS`: Deprecated, DK_GLOBAL_HOST_TAGS instead
- `DK_GLOBAL_HOST_TAGS`: Support the installation phase to fill in the global host tag, format example: `host=__datakit_hostname,host_ip=__datakit_ip` (multiple tags are separated by English commas)
- `DK_GLOBAL_ELECTION_TAGS`: Support filling in the global election tag during the installation phase，format example: `project=my-porject,cluster=my-cluster` (support filling in the global election tag during the installation phase)
- `DK_DEF_INPUTS`: List of collector names opened by default, format example: `cpu,mem,disk`. We can also ban some default inputs by putting a `-` prefix at input name, such as `-cpu,-mem,-disk`. But if mixed them, such as `cpu,mem,-disk,-system`, we only accept the banned list, the effect is only `disk` and `system` disabled, but others enabled.
- `DK_CLOUD_PROVIDER`: Support filling in cloud vendors during installation (Currently support following clouds `aliyun/aws/tencent/hwcloud/azure`). **Deprecated:** Datakit can infer cloud type automatically.
- `DK_USER_NAME`：Datakit service running user name. Default is `root`. More details is in *Attention* below.
- `DK_LITE`： When installing the simplified DataKit, you can set this variable to `1`. ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0))
<!-- markdownlint-disable MD046 -->
???+ tip "Disable all default inputs[:octicons-tag-24: Version-1.5.5](changelog.md#cl-1.5.5)"

    We can set `DK_DEF_INPUTS` to `-` to disable all default inputs:

    ```shell
    DK_DEF_INPUTS="-" \
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> \
    bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

    Beside, if Datakit has been installed before, we must delete all default inputs *.conf* files manually. During installing, Datakit able to add new inputs configure, not cant delete them.

???+ attention "Attention"

    For privilege reason, using `DK_USER_NAME` with not `root` name could cause following collector unavailable:

    - [eBPF](../integrations/ebpf.md){:target="_blank"}

    In addition, the following items need to be noted.

    - Manually create user and group first, then start install. There are difference between Linux distribution releases, below commands are for reference:

        === "CentOS/RedHat"

            ```sh
            groupadd --system datakit

            adduser --system --no-create-home datakit -g datakit

            usermod -s /sbin/nologin datakit
            ```

        === "Ubuntu/Debian"

            ```sh
            groupadd --system datakit

            adduser --system --no-create-home datakit
            
            usermod -a -G datakit datakit

            usermod -s /usr/sbin/nologin datakit
            ```

        === "其它 Linux"

            ```sh
            groupadd --system datakit
            
            adduser --system --no-create-home datakit
            
            usermod -a -G datakit datakit
            
            usermod -s /bin/false datakit
            ```

        ```sh
        DK_USER_NAME="datakit" DK_DATAWAY="..." bash -c ...
        ```
<!-- markdownlint-enable -->
### On DataKit's Own Log  {#env-logging}

- `DK_LOG_LEVEL`: Optional info/debug
- `DK_LOG`: If changed to stdout, the log will not be written to the file, but will be output by the terminal.
- `DK_GIN_LOG`: If changed to stdout, the log will not be written to the file, but will be output by the terminal.

### On DataKit pprof  {#env-pprof}

- `DK_ENABLE_PPROF`(deprecated): whether to turn on `pprof`
- `DK_PPROF_LISTEN`: `pprof` service listening address

> [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) enabled pprof by default.

### On DataKit Election  {#env-election}

- `DK_ENABLE_ELECTION`: Open the election, not by default. If you need to open it, give any non-empty string value to the environment variable. (eg `True`/`False`)
- `DK_NAMESPACE`: Supports namespaces specified during installation (for election)

### On HTTP/API  Environment {#env-http-api}

- `DK_HTTP_LISTEN`: Support the installation-stage specified DataKit HTTP service binding network card (default `localhost`)
- `DK_HTTP_PORT`: Support specifying the port of the DataKit HTTP service binding during installation (default `9529`)
- `DK_RUM_ORIGIN_IP_HEADER`: RUM-specific
- `DK_DISABLE_404PAGE`: Disable the DataKit 404 page (commonly used when deploying DataKit RUM on the public network. Such as `True`/`False`)
- `DK_INSTALL_IPDB`: Specify the IP library at installation time (currently only `iploc` and `geolite2` is supported)
- `DK_UPGRADE_IP_WHITELIST`: Starting from Datakit [1.5.9](changelog.md#cl-1.5.9), we can upgrade Datakit by access remote http API. This environment variable is used to set the IP whitelist of clients that can be accessed remotely(multiple IPs could be separated by commas `,`). Access outside the whitelist will be denied (default not restricted).
- `DK_UPGRADE_LISTEN`: Specify DK-Upgrader HTTP server address(default `0.0.0.0:9542`)[:octicons-tag-24: Version-1.38.1](changelog.md#cl-1.38.1)
- `DK_HTTP_PUBLIC_APIS`: Specify which Datakit HTTP APIs can be accessed by remote, generally config combined with RUM input，support from Datakit [1.9.2](changelog.md#cl-1.9.2).

### On DCA  {#env-dca}

- `DK_DCA_ENABLE`: Support DCA service to be turned on during installation (not turned on by default)
- `DK_DCA_WEBSOCKET_SERVER`:  DCA websocket server address that can be accessed by DataKit

### On External Collector  {#env-external-inputs}

- `DK_INSTALL_EXTERNALS`: Used to install external collectors not packaged with DataKit

### On Confd Configuration  {#env-connfd}

| Environment Variable Name | Type   | Applicable Scenario           | Description            | Sample Value                               |
| ------------------------- | ------ | ----------------------------- | ---------------------- | ------------------------------------------ |
| DK_CONFD_BACKEND          | string | All                           | Backend Source Type    | `etcdv3`, `zookeeper`, `redis` or `consul` |
| DK_CONFD_BASIC_AUTH       | string | `etcdv3`, `consul`            | Optional               |                                            |
| DK_CONFD_CLIENT_CA_KEYS   | string | `etcdv3`, `consul`            | Optional               |                                            |
| DK_CONFD_CLIENT_CERT      | string | `etcdv3`, `consul`            | Optional               |                                            |
| DK_CONFD_CLIENT_KEY       | string | `etcdv3`, `consul` or `redis` | Optional               |                                            |
| DK_CONFD_BACKEND_NODES    | string | All                           | Backend Source Address | `[IP 地址：2379,IP address 2:2379]`        |
| DK_CONFD_PASSWORD         | string | `etcdv3`, `consul`            | Optional               |                                            |
| DK_CONFD_SCHEME           | string | `etcdv3`, `consul`            | Optional               |                                            |
| DK_CONFD_SEPARATOR        | string | `redis`                       | Optional default 0     |                                            |
| DK_CONFD_USERNAME         | string | `etcdv3`, `consul`            | Optional               |                                            |

### On Git Configuration {#env-gitrepo}

- `DK_GIT_URL`: The remote git repo address for managing configuration files. (e.g. `http://username:password@github.com/username/repository.git`)
- `DK_GIT_KEY_PATH`: The full path of the local PrivateKey. (e.g.  `/Users/username/.ssh/id_rsa`)
- `DK_GIT_KEY_PW`: The password to use the local PrivateKey. (e.g.  `passwd`)
- `DK_GIT_BRANCH`: Specify the branch to pull. **If it is empty, it is the default**, and the default is the remotely specified main branch, which is usually `master`.
- `DK_GIT_INTERVAL`: The interval of the timed pull. (e.g. `1m`)

### WAL {#env-wal}

- `DK_WAL_WORKERS`: Set WAL workers, default to limited-CPU-cores * 4
- `DK_WAL_CAPACITY`: Set single WAL max disk size, default to 2GB

### On Sinker Configuration {#env-sink}

`DK_SINKER_GLOBAL_CUSTOMER_KEYS` used to setup sinker tag/field keys, here is the example:

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> DK_DATAWAY_ENABLE_SINKER=on DK_SINKER_GLOBAL_CUSTOMER_KEYS=key1,key2 bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>";
    $env:DK_DATAWAY_ENABLE_SINKER="on";
    $env:DK_SINKER_GLOBAL_CUSTOMER_KEYS="key1,key2";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.<<<custom_key.brand_main_domain>>>/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

### On Resource Limit Configuration {#env-cgroup}

Only Linux and Windows ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)) operating system are supported.

- `DK_LIMIT_DISABLED`: Turn off Resource limit function (on by default)
- `DK_LIMIT_CPUMAX`: Maximum CPU power, default 30.0
- `DK_LIMIT_MEMMAX`: Limit memory (including swap), default 4096 (4GB)

### APM Instrumentation {#apm-instrumentation}

[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

By specifying `DK_APM_INSTRUMENTATION_ENABLED` in the installation command, you can automatically inject APM for Java/Python applications:

- Enable host inject

```shell
DK_APM_INSTRUMENTATION_ENABLED=host \
  DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN>  \
  bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
```

- Enable host inject:

```shell
DK_APM_INSTRUMENTATION_ENABLED=docker \
  DK_DATAWAY=https://openway.<<<custom_key.brand_main_domain>>>?token=<TOKEN> \
  bash -c "$(curl -L https://static.<<<custom_key.brand_main_domain>>>/datakit/install.sh)"
```

For host deployment, after DataKit is installed, reopen a terminal and restart the corresponding Java/Python application.

To enable or disable this feature, modify the value of the `instrumentation_enabled` configuration under `[apm_inject]` in the `datakit.conf` file:

- Value `"host"`, `"docker"` or `"host,docker"`, enable
- Value `""` or `"disable"`, disable

Notes:

1. Before deleting the files in the DataKit installation directory, you need to uninstall the feature first. Please execute **`datakit tool --remove-apm-auto-inject`** to clean up the system settings and Docker settings.

2. For Docker injection, additional steps are required to install and configure Docker injection and delete injection-related files in the DataKit installation directory

   - After installing and configuring Docker injection, if you need to make it effective for the created container:

   ```shell
   # stop docker service
   systemctl stop docker docker.socket

   # change the runtime of the created container from runc to dk-runc provided by datakit
   datakit tool --change-docker-containers-runtime dk-runc

   # start docker service
   systemctl start docker

   # restart the container that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

   - After uninstalling the feature (with Docker injection enabled), if you need to delete all files in the DataKit installation directory:

   ```shell
   # stpp docker service
   systemctl stop docker docker.socket

   # Change the runtime of the created container from dk-runc back to runc
   datakit tool --change-docker-containers-runtime runc

   # start docker service
   systemctl start docker

   # restart the container that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

Operating environment requirements:

- Linux system
    - CPU architecture: x86_64 or arm64
    - C standard library: glibc 2.4 and above, or musl
    - Java 8 and above
    - Python 3.7 and above

In Kubernetes, you can inject APM through the [Datakit Operator](datakit-operator.md#datakit-operator-inject-lib).

### Other Installation Options {#env-others}

| Environment Variable Name        | Sample                      | Description                                                                                                                                                                                 |
| -------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DK_INSTALL_ONLY`                | `on`                        | Install only, not run                                                                                                                                                                       |
| `DK_HOSTNAME`                    | `some-host-name`            | Support custom configuration hostname during installation                                                                                                                                   |
| `DK_UPGRADE`                     | `1`                         | Upgrade to the latest version                                                               |
| `DK_UPGRADE_MANAGER`             | `on`                        | Whether we upgrade the **Remote Upgrade Service** when upgrading Datakit, it's used in conjunction with `DK_UPGRADE`, supported start from [1.5.9](changelog.md#cl-1.5.9)                   |
| `DK_INSTALLER_BASE_URL`          | `https://your-url`          | You can choose the installation script for different environments, default to `https://static.<<<custom_key.brand_main_domain>>>/datakit`                                                                           |
| `DK_PROXY_TYPE`                  | -                           | Proxy type. The options are: `datakit` or `nginx`, both lowercase                                                                                                                           |
| `DK_NGINX_IP`                    | -                           | Proxy server IP address (only need to fill in IP but not port). With the highest priority, this is mutually exclusive with the above "HTTP_PROXY" and "HTTPS_PROXY" and will override both. |
| `DK_INSTALL_LOG`                 | -                           | Set the setup log path, default to *install.log* in the current directory, if set to `stdout`, output to the command line terminal.                                                         |
| `HTTPS_PROXY`                    | `IP:Port`                   | Installed through the Datakit agent                                                                                                                                                         |
| `DK_INSTALL_RUM_SYMBOL_TOOLS`    | `on`                        | Install source map tools for RUM, support from Datakit [1.9.2](changelog.md#cl-1.9.2).                                                                                                      |
| `DK_VERBOSE`                     | `on`                        | Enable more verbose info during install(only for Linux/Mac)[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0)                                                                       |
| `DK_CRYPTO_AES_KEY`              | `0123456789abcdfg`          | Use the encrypted password decryption key to protect plaintext passwords in the collector.  [:octicons-tag-24: Version-1.31.0](changelog.md#cl-1.31.0)                                      |
| `DK_CRYPTO_AES_KEY_FILE`         | `/usr/local/datakit/enc4dk` | Another way to configure the secret key takes priority over the previous one. Put the key into the file and configure the configuration file path through environment variables.            |

## FAQ {#faq}
<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Deal with the Unfriendly Host Name {#bad-hostname}
<!-- markdownlint-enable -->
Because DataKit uses Hostname as the basis for data concatenation, in some cases, some host names are not very friendly, such as  `iZbp141ahn....`, but for some reasons, these host names cannot be modified, which brings some troubles to use. In DataKit, this unfriendly host name can be overwritten in the main configuration.

In `datakit.conf`, modify the following configuration and the DataKit will read `ENV_HOSTNAME` to overwrite the current real hostname:

```toml
[environments]
    ENV_HOSTNAME = "your-fake-hostname-for-datakit"
```

> Note: If a host has collected data for a period of time, after changing the host name, the historical data will no longer be associated with the new host name. Changing the host name is equivalent to adding a brand-new host.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Issue on macOS installation {#mac-failed}
<!-- markdownlint-enable -->

If it appears during the installation/upgrade process when installing on macOS:

```shell
"launchctl" failed with stderr: /Library/LaunchDaemons/com.datakit.plist: Service is disabled
```

Execute:

```shell
sudo launchctl enable system/datakit
```

Then execute the following command:

```shell
sudo launchctl load -w /Library/LaunchDaemons/com.datakit.plist
```

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Are there any high-risk operations on files and data in Datakit? {#danger-ops}
<!-- markdownlint-enable -->

During its operation, Datakit reads a significant amount of system information based on the collection configuration, such as process lists, hardware and software information (e.g., OS information, CPU, memory, disk, network card, etc.). However, it does not proactively execute deletion or modification of data outside of itself. About file reading and writing, there are two parts: one related to data collection read file/port operations, and one for the necessary file reading and writing operations during Datakit's own runtime.

Host files read/write during data collecting:

- During process information collection and hardware and software information collection, Linux systems will read relevant information from the */proc* directory; Windows systems mainly use WMI and the Golang Windows SDK to obtain these information.

- If log collection is configured, Datakit will scan and read logs that match the configuration (e.g., syslog, user application logs, etc.).

- Port usage: Datakit may open some ports to receive external data for interfacing with other systems. [These ports](datakit-port.md) are opened as needed based on the collector.

- eBPF collection: Due to its particularity, eBPF requires more binary information of the Linux kernel and processes, resulting in the following actions:

    - Analyze the binary files of all (or specified) running programs (dynamic libraries, processes within containers) for symbols and addresses.
    - Read and write files under the kernel DebugFS mount point or interact with the PMU (Performance Monitoring Unit) to place kprobe/uprobe/tracepoint eBPF probes.
    - uprobe probes will modify the CPU instructions of user processes to read relevant data.

In addition to collection, Datakit performs the following file reading and writing operations:

- Its own log files

On Linux, these are located in the */var/log/datakit/* directory; on Windows, they are located in the *C:\Program Files\datakit* directory.

Log files will automatically rotate when they reach a specified size (default 32MB), with a maximum number of rotations (default maximum of 5 + 1 segments).

- Disk cache

Some data collection requires the use of disk cache functionality (which must be manually enabled). This cache will involve file creation and deletion during the generation and consumption process. Disk cache also has a maximum capacity setting; when full, it will automatically perform FIFO deletion operations to prevent disk overflow.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How does Datakit control its own resource consumption? {#resource-limit}
<!-- markdownlint-enable -->

Datakit's resource usage can be limited through mechanisms such as cgroup. For more information, see [here](datakit-conf.md#resource-limit). If Datakit is deployed in Kubernetes, see [here](datakit-daemonset-deploy.md#requests-limits).

<!-- markdownlint-disable MD013 -->
### :material-chat-question: What is Datakit's own observability? {#self-obs}
<!-- markdownlint-enable -->

During its operation, Datakit exposes many [internal metrics](datakit-metrics.md). By default, Datakit collects these metrics using the [built-in collector](../integrations/dk.md) and reports them to the user's workspace.

In addition, Datakit also comes with a [monitor command-line](datakit-monitor.md) tool that allows users to view the current operational status as well as the collection and reporting status.

<!-- markdownlint-disable MD013 -->
## :material-chat-question: More Readings {#more-reading}
<!-- markdownlint-enable -->

- [Getting started with DataKit](datakit-service-how-to.md)
