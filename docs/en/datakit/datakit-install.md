# HOST Installation
---

This article introduces the basic installation of DataKit.

## Register/Login to Guance {#login-guance}

Access [Guance registration entry](https://auth.guance.com/redirectpage/register){:target="_blank"} via browser, fill in the corresponding information, and then you can [log in to Guance](https://console.guance.com/pageloading/login){:target="_blank"}

## Get Installation Command {#get-install}

Log in to your workspace, click on the left-hand "Integration" and select top "Datakit" to see the installation commands for various platforms.

> Note, the following Linux/Mac/Windows installation procedures can automatically identify hardware platforms (arm/x86, 32bit/64bit), so there is no need to choose a hardware platform.

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    The installation command supports `bash` and `ash`([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)) :

    - `bash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    - `ash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> ash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    After installation is complete, you will see a success message in the terminal.

=== "Windows"

    On Windows, installation must be done in Powershell, and Powershell must be run as an administrator. Press the Windows key, type powershell, and right-click to select "Run as administrator".
    
    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

### Install Lightweight Version of DataKit {#lite-install}

You can install the lightweight version of DataKit by adding the `DK_LITE` environment variable to the installation command ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)):

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
    powershell ./.install.ps1;
    ```

<!-- markdownlint-enable -->

The lightweight version of DataKit only includes the following collectors:

| Collector Name                                                        | Description                                           |
| ----------------------------------------------------------------- | ---------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                            | Collects HOST CPU usage                        |
| [Disk (`disk`)](../integrations/disk.md)                         | Collects disk usage                               |
| [Disk IO (`diskio`)](../integrations/diskio.md)                  | Collects HOST disk IO status                         |
| [Memory (`mem`)](../integrations/mem.md)                           | Collects HOST memory usage                         |
| [Swap (`swap`)](../integrations/swap.md)                         | Collects Swap memory usage                         |
| [System (`system`)](../integrations/system.md)                   | Collects HOST operating system load                           |
| [Net (`net`)](../integrations/net.md)                            | Collects HOST network traffic status                           |
| [HOST processes (`host_processes`)](../integrations/host_processes.md) | Collects HOST resident (alive for more than 10min) process list      |
| [HOST object (`hostobject`)](../integrations/hostobject.md)         | Collects HOST basic information (such as OS information, hardware information, etc.) |
| [Datakit (`dk`)](../integrations/dk.md)                          | Collects Datakit's own operational Metrics collection                  |
| [User Analysis (`rum`)](../integrations/rum.md)                    | Used to collect User Analysis data                       |
| [Network TESTING (`dialtesting`)](../integrations/dialtesting.md)        | Collects network TESTING data                               |
| [Prom Collection (`prom`)](../integrations/prom.md)                     | Collects Prometheus Exporters exposed Metrics data   |
| [LOG Collection (`logging`)](../integrations/logging.md)                | Collects file LOG data                               |

### Install eBPF Trace Linker Version of DataKit {#elinker-install}

You can install the ELinker version of DataKit used for connecting eBPF Spans and generating eBPF Trace by adding the `DK_ELINKER` environment variable to the installation command ([:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)):

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_ELINKER=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_ELINKER="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->
DataKit ELinker only includes the following collectors:

| Collector Name                                                       | Description                                                        |
| ---------------------------------------------------------------- | ----------------------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                           | Collects HOST CPU usage                                     |
| [Disk (`disk`)](../integrations/disk.md)                        | Collects disk usage                                            |
| [Disk IO (`diskio`)](../integrations/diskio.md)                 | Collects HOST disk IO status                                      |
| [eBPF Trace Linker (`ebpftrace`)](../integrations/ebpftrace.md) | Receives eBPF link spans and connects these spans to generate trace id information |
| [Swap (`swap`)](../integrations/swap.md)                        | Collects Swap memory usage                                      |
| [System (`system`)](../integrations/system.md)                  | Collects HOST operating system load                                        |
| [Net (`net`)](../integrations/net.md)                           | Collects HOST network traffic status                                        |
| [HOST object (`hostobject`)](../integrations/hostobject.md)        | Collects HOST basic information (such as OS information, hardware information, etc.)              |
| [DataKit (`dk`)](../integrations/dk.md)                         | Collects DataKit's own operational Metrics collection                               |

### Install Specific Version of DataKit {#version-install}

You can specify a version number in the installation command to install a specific version of DataKit, such as installing version 1.2.3 of DataKit:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install-1.2.3.sh)"
```

For Windows, it works similarly:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install-1.2.3.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

## Additional Supported Environment Variables {#extra-envs}

If you need to define some DataKit configurations during the installation stage, you can add environment variables to the installation command, appending them before `DK_DATAWAY`. For example, appending `DK_NAMESPACE` setting:

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
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

The format for setting two types of environment variables is as follows:

```shell
# Windows: Multiple environment variables are separated by semicolons
$env:NAME1="value1"; $env:Name2="value2"

# Linux/Mac: Multiple environment variables are separated by spaces
NAME1="value1" NAME2="value2"
```

The installation script supports the following environment variables (supported on all platforms).

<!-- markdownlint-disable MD046 -->
???+ attention

    [Full offline installation](datakit-offline-install.md#offline) does not support these environment variable settings. However, they can be set through [proxy](datakit-offline-install.md#with-datakit) or [setting local installation address](datakit-offline-install.md#with-nginx).
<!-- markdownlint-enable -->

### Most Commonly Used Environment Variables {#common-envs}

- `DK_DATAWAY`: Specifies the DataWay address, which is already included by default in the DataKit installation command.
- `DK_GLOBAL_TAGS`: Deprecated, replaced with DK_GLOBAL_HOST_TAGS.
- `DK_GLOBAL_HOST_TAGS`: Supports filling out global HOST tags at the installation stage. Example format: `host=__datakit_hostname,host_ip=__datakit_ip` (multiple tags are separated by commas).
- `DK_GLOBAL_ELECTION_TAGS`: Supports filling out global election tags at the installation stage. Example format: `project=my-porject,cluster=my-cluster` (multiple tags are separated by commas).
- `DK_CLOUD_PROVIDER`: Supports specifying cloud vendors (currently supporting the following types of cloud HOSTs `aliyun/aws/tencent/hwcloud/azure`). **This function has been deprecated**, Datakit can now automatically recognize the type of cloud HOST.
- `DK_USER_NAME`: Username under which the Datakit service runs. Default is `root`. More detailed explanations are below in the "Precautions" section.
- `DK_DEF_INPUTS`: Configuration for [default enabled collectors](datakit-input-conf.md#default-enabled-inputs). If you want to disable certain collectors, you need to manually block them, for example, to disable `cpu` and `mem` collectors, specify as follows: `-cpu,-mem`, meaning that except for these two collectors, all other default collectors are enabled.
- `DK_LITE`: When installing the lightweight version of DataKit, this variable can be set to `1`. ([Version-1.14.0](changelog.md#cl-1.14.0))

<!-- markdownlint-disable MD046 -->
???+ tip "Disable All Default Collectors [:octicons-tag-24: Version-1.5.5](changelog.md#cl-1.5.5)"

    If you want to disable all default collectors, set `DK_DEF_INPUTS` to `-`, like this:

    ```shell
    DK_DEF_INPUTS="-" \
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
    bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    Additionally, if Datakit has been installed previously, you must delete all previous default collector configurations because Datakit can only add collector configurations during installation but cannot remove them.

???+ attention "Precautions"

    Due to permission issues, if you modify the username under which the Datakit service runs via `DK_USER_NAME` to something other than `root`, the following collectors will not be usable:

    - [eBPF](../integrations/ebpf.md){:target="_blank"}

    Also, note the following points:

    - You must manually create the user and user group first, ensuring that the usernames and group names are consistent before proceeding with the installation. The creation commands may vary depending on the Linux distribution; the following commands are provided for reference:

        === "CentOS/RedHat"

            ```sh
            # Create system user group datakit
            groupadd --system datakit

            # Create system user datakit and add user datakit to group datakit (here both the username and group name are datakit)
            adduser --system --no-create-home datakit -g datakit

            # Prohibit username datakit from logging in (for CentOS/RedHat series Linux)
            usermod -s /sbin/nologin datakit
            ```

        === "Ubuntu/Debian"

            ```sh
            # On Ubuntu, simultaneously creating a user and adding them to a group may result in errors, so it needs to be done in two steps

            # Create system user group datakit
            groupadd --system datakit

            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to group datakit
            usermod -a -G datakit datakit

            # Prohibit username datakit from logging in (for Ubuntu/Debian series Linux)
            usermod -s /usr/sbin/nologin datakit
            ```

        === "Other Linux"

            ```sh
            # On other Linux distributions, simultaneously creating a user and adding them to a group may result in errors, so it needs to be done in two steps

            # Create system user group datakit
            groupadd --system datakit
            
            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to group datakit
            usermod -a -G datakit datakit
            
            # Prohibit username datakit from logging in (for other Linux)
            usermod -s /bin/false datakit
            ```

        ```sh
        # Install Datakit
        DK_USER_NAME="datakit" DK_DATAWAY="..." bash -c ...
        ```

<!-- markdownlint-enable -->

### DataKit Self-Logging Related {#env-logging}

- `DK_LOG_LEVEL`: Options are info/debug
- `DK_LOG`: If changed to stdout, logs will not be written to files but instead output to the terminal.
- `DK_GIN_LOG`: If changed to stdout, logs will not be written to files but instead output to the terminal.

### DataKit pprof Related {#env-pprof}

- `DK_ENABLE_PPROF`: Whether to enable `pprof`. It has been enabled by default since [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2).
- `DK_PPROF_LISTEN`: `pprof` service listening address

### DataKit Election Related {#env-election}

- `DK_ENABLE_ELECTION`: Enable election, disabled by default. To enable, give this environment variable any non-empty string value (e.g., `True`/`False`).
- `DK_NAMESPACE`: Support specifying namespace at installation stage (used for elections)

### HTTP/API Related Environment Variables {#env-http-api}

- `DK_HTTP_LISTEN`: Support specifying DataKit HTTP service bound NIC at installation stage (default `localhost`)
- `DK_HTTP_PORT`: Support specifying DataKit HTTP service bound port at installation stage (default `9529`)
- `DK_RUM_ORIGIN_IP_HEADER`: RUM-specific
- `DK_DISABLE_404PAGE`: Disable DataKit 404 page (commonly used when deploying DataKit RUM publicly. Such as `True`/`False`)
- `DK_INSTALL_IPDB`: Specify IP library during installation (currently only supports `iploc/geolite2`)
- `DK_UPGRADE_IP_WHITELIST`: Starting from Datakit [1.5.9](changelog.md#cl-1.5.9), remote API access to upgrade Datakit is supported, this environment variable is used to set the whitelist of client IPs that can remotely access (IPs separated by commas `,`), access from IPs not in the whitelist will be rejected (default is no IP restriction).
- `DK_UPGRADE_LISTEN`: Specifies the HTTP address bound by the upgrade service (default `0.0.0.0:9542`)[:octicons-tag-24: Version-1.38.1](changelog.md#cl-1.38.1)
- `DK_HTTP_PUBLIC_APIS`: Sets the HTTP APIs that Datakit allows remote access to, RUM functionality usually requires this configuration, starting from Datakit [1.9.2](changelog.md#cl-1.9.2).

### DCA Related {#env-dca}

- `DK_DCA_ENABLE`: Support enabling DCA service at installation stage (default not enabled)
- `DK_DCA_WEBSOCKET_SERVER`: Support customizing the websocket address for DCA at installation stage

### External Collector Related {#env-external-inputs}

- `DK_INSTALL_EXTERNALS`: Can be used to install external collectors not packaged with DataKit

### Confd Configuration Related {#env-connfd}

| Environment Variable Name       | Type   | Applicable Scenario          | Description       | Example Value                                         |
| ----------------------------- | ------ | -------------------------- | -------------- | ---------------------------------------------------- |
| DK_CONFD_BACKEND             | string | All                         | Backend source type | `etcdv3` or `zookeeper` or `redis` or `consul`        |
| DK_CONFD_BASIC_AUTH          | string | `etcdv3` or `consul`        | Optional       |                                                     |
| DK_CONFD_CLIENT_CA_KEYS     | string | `etcdv3` or `consul`        | Optional       |                                                     |
| DK_CONFD_CLIENT_CERT         | string | `etcdv3` or `consul`        | Optional       |                                                     |
| DK_CONFD_CLIENT_KEY          | string | `etcdv3` or `consul` or `redis` | Optional       |                                                     |
| DK_CONFD_BACKEND_NODES       | string | All                         | Backend source address | `[IP:2379, IP2:2379]`                                 |
| DK_CONFD_PASSWORD           | string | `etcdv3` or `consul`        | Optional       |                                                     |
| DK_CONFD_SCHEME             | string | `etcdv3` or `consul`        | Optional       |                                                     |
| DK_CONFD_SEPARATOR         | string | `redis`                    | Optional default 0 |                                                     |
| DK_CONFD_USERNAME          | string | `etcdv3` or `consul`        | Optional       |                                                     |

### Git Configuration Related {#env-gitrepo}

- `DK_GIT_URL`: Remote git repo address for managing configuration files. (e.g., `http://username:password@github.com/username/repository.git`)
- `DK_GIT_KEY_PATH`: Full path to the local PrivateKey. (e.g., `/Users/username/.ssh/id_rsa`)
- `DK_GIT_KEY_PW`: Password for using the local PrivateKey. (e.g., `passwd`)
- `DK_GIT_BRANCH`: Specify the branch to pull. **Empty means default**, which is the main branch specified remotely, usually `master`.
- `DK_GIT_INTERVAL`: Interval for scheduled pulls. (e.g., `1m`)

### WAL Disk Cache {#env-wal}

- `DK_WAL_WORKERS`: Set the number of WAL consumption workers, default is CPU limit core count * 4
- `DK_WAL_CAPACITY`: This is the maximum disk space occupied by a single WAL, default is 2GB

### Sinker Related Configuration {#env-sink}

Use `DK_SINKER_GLOBAL_CUSTOMER_KEYS` to set sinker filtering tag/field key names, its form is as follows:

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
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

### Resource Restriction Configuration Related {#env-cgroup}

Currently only supports Linux and Windows ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)) operating systems.

- `DK_LIMIT_DISABLED`: Turn off resource limitation feature (enabled by default)
- `DK_LIMIT_CPUMAX`: Limit the maximum percentage of CPU usage, default is 30.0, maximum value is 100 (deprecated, recommend using `DK_LIMIT_CPUCORES`)
- `DK_LIMIT_CPUCORES`: Limit the number of CPU cores used, default is 2.0 (i.e., 2 cores)
- `DK_LIMIT_MEMMAX`: Limit the maximum memory (including swap) usage, default is 4096 (4GB)

### APM Instrumentation {#apm-instrumentation}

[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

In the installation command, specify `DK_APM_INSTRUMENTATION_ENABLED` to automatically inject APM for Java/Python applications:

- Enable HOST injection:

```shell
DK_APM_INSTRUMENTATION_ENABLED=host \
  DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
  bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Enable DOCKER injection:

```shell
DK_APM_INSTRUMENTATION_ENABLED=docker \
  DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
  bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

For HOST deployment, after DataKit installation, restart a new terminal and restart the corresponding Java/Python application.

To enable or disable this feature, modify the value of the `instrumentation_enabled` configuration under `[apm_inject]` in the `datakit.conf` file:

- Values `"host"`, `"docker"`, or `"host,docker"` to enable
- Values `""` or `"disable"` to disable

Precautions:

1. Before deleting files in the DataKit installation directory, uninstall this feature first by executing **`datakit tool --remove-apm-auto-inject`** to clean up system settings and Docker settings.

2. For Docker injection, additional steps are required to install and configure Docker injection and delete injected-related files in the DataKit installation directory.

   - After installing and configuring Docker injection, if you want it to take effect on already created containers:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of already created containers from runc to dk-runc provided by datakit
   datakit tool --change-docker-containers-runtime dk-runc

   # Start docker service
   systemctl start docker

   # Restart the containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

   - After uninstalling this feature (if Docker injection was enabled), if you want to delete all files in the DataKit installation directory:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of already created containers back from dk-runc to runc
   datakit tool --change-docker-containers-runtime runc

   # Start docker service
   systemctl start docker

   # Restart the containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

Runtime requirements:

- Linux system
    - CPU architecture: x86_64 or arm64
    - C standard library: glibc 2.4 or higher versions, or musl
    - Java 8 or higher versions
    - Python 3.7 or higher versions

In Kubernetes, you can use [Datakit Operator to inject APM](datakit-operator.md#datakit-operator-inject-lib).

### Other Installation Options {#env-others}

| Environment Variable Name               | Example Value                     | Description                                                                                                                             |
| -------------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `DK_INSTALL_ONLY`                     | `on`                              | Only install, do not run                                                                                                                |
| `DK_HOSTNAME`                         | `some-host-name`                  | Support customizing hostnames at the installation stage                                                                                   |
| `DK_UPGRADE`                          | `1`                               | Upgrade to the latest version                                                   |
| `DK_UPGRADE_MANAGER`                  | `on`                              | Whether to upgrade the **remote upgrade service** along with Datakit, needs to be used with `DK_UPGRADE`, supported starting from [1.5.9](changelog.md#cl-1.5.9) |
| `DK_INSTALLER_BASE_URL`               | `https://your-url`                 | Choose different environment installation scripts, default is `https://static.guance.com/datakit`                                             |
| `DK_PROXY_TYPE`                       | -                                 | Proxy type. Options are: `datakit` or `nginx`, both lowercase                                                                                 |
| `DK_NGINX_IP`                         | -                                 | Proxy server IP address (only fill in IP without port). This is mutually exclusive with the above "HTTP_PROXY" and "HTTPS_PROXY" and takes precedence, overriding the above two  |
| `DK_INSTALL_LOG`                      | -                                 | Set the installation program log path, default is *install.log* under the current directory, if set to `stdout` then output to the command-line terminal                                   |
| `HTTPS_PROXY`                         | `IP:Port`                          | Install via Datakit proxy                                                                                                               |
| `DK_INSTALL_RUM_SYMBOL_TOOLS`         | `on`                               | Whether to install RUM source map tools, supported starting from Datakit [1.9.2](changelog.md#cl-1.9.2)                                               |
| `DK_VERBOSE`                          | `on`                               | Enable verbose options during the installation process (only supported on Linux/Mac), outputs more debugging information [:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0) |
| `DK_CRYPTO_AES_KEY`                   | `0123456789abcdfg`                 | Use encrypted password decryption keys for protecting plain-text passwords in collectors [:octicons-tag-24: Version-1.31.0](changelog.md#cl-1.31.0)                  |
| `DK_CRYPTO_AES_KEY_FILE`              | `/usr/local/datakit/enc4dk`        | Another way to configure the key, takes precedence over the previous one. Place the key in this file and configure the file path via environment variables.                               |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to deal with unfriendly HOST names {#bad-hostname}
<!-- markdownlint-enable -->

Since DataKit uses the HOST name (Hostname) as the basis for data serialization, in some cases, some HOST names are not very friendly, for example, `iZbp141ahn....`, but due to some reasons, these HOST names cannot be modified, which brings certain inconvenience. In DataKit, you can override this unfriendly HOST name in the main configuration.

In `datakit.conf`, modify the following configuration, and DataKit will read `ENV_HOSTNAME` to override the actual current HOST name:

```toml
[environments]
    ENV_HOSTNAME = "your-fake-hostname-for-datakit"
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If a certain HOST has already collected data for a period of time, changing the HOST name afterward will no longer associate these historical data with the new HOST name. Changing the HOST name is equivalent to adding a brand-new HOST.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
### :material-chat-question: MAC installation issues {#mac-failed}
<!-- markdownlint-enable -->

On Mac, if you encounter issues during installation/upgrade:

```shell
"launchctl" failed with stderr: /Library/LaunchDaemons/cn.dataflux.datakit.plist: Service is disabled
# Or
"launchctl" failed with stderr: /Library/LaunchDaemons/com.guance.datakit.plist: Service is disabled
```

Execute

```shell
sudo launchctl enable system/datakit
```

Then execute the following command:

```shell
sudo launchctl load -w /Library/LaunchDaemons/cn.dataflux.datakit.plist
# Or
sudo launchctl load -w /Library/LaunchDaemons/com.guance.datakit.plist
```

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Does Datakit perform high-risk operations on files and data? {#danger-ops}
<!-- markdownlint-enable -->

During operation, Datakit reads a lot of system information based on the collection configuration, such as process lists, software and hardware information (such as OS information, CPU, memory, disk, network card, etc.). However, it does not actively execute deletion or modification of other data outside itself. Regarding file reading and writing, it is divided into two parts: one related to data collection, and another necessary file reading and writing during the operation of Datakit itself.

Files that need to be read for collection:

- During the collection of process information and software/hardware information, Linux reads related information under the */proc* directory; Windows mainly acquires this information through WMI and Golang Windows SDK.

- If relevant log collection is configured, according to the collection configuration, it scans and reads logs that match the configuration (such as syslog, user application logs, etc.).

- Port occupation: To interface with some other systems, Datakit opens some ports separately to receive external data. These ports are opened as needed depending on the collector.

- eBPF Collection: Due to its special nature, eBPF requires more Linux kernel and process binary information, including the following actions:

    - Analyze all (or specified) running programs' binary files containing symbol addresses.
    - Read and write files under the kernel DebugFS mount point or PMU (Performance Monitoring Unit) to place kprobe/uprobe/tracepoint eBPF probes.
    - Uprobe probes modify user process CPU instructions to read related data.

Besides collection, Datakit itself performs the following file read/write operations:

- Its own log files

When installed on Linux, they are located under the */var/log/datakit/* directory; on Windows, they are located under the *C:\Program Files\datakit* directory.

Log files rotate automatically when they reach a specified size (default 32MB) and have a maximum rotation count limit (default maximum 5 + 1 shards).

- Disk cache

Some data collection requires disk caching functionality (manual activation required). During generation and consumption, there will be file additions and deletions in the disk cache. The disk cache also has a maximum capacity setting, and when full, automatic FIFO deletion occurs to prevent disk overflow.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How does Datakit control its own resource consumption? {#resource-limit}
<!-- markdownlint-enable -->

You can restrict Datakit's own resource usage through mechanisms such as cgroups, refer to [here](datakit-conf.md#resource-limit). If Datakit is deployed in Kubernetes, refer to [here](datakit-daemonset-deploy.md#requests-limits).

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Observability of Datakit itself? {#self-obs}
<!-- markdownlint-enable -->

During operation, Datakit exposes many [its own Metrics](datakit-metrics.md). By default, Datakit collects these metrics through [built-in collectors](../integrations/dk.md) and reports them to the user's workspace.

Additionally, Datakit comes with a [monitor command-line](datakit-monitor.md) tool, which can be used to view the current running status and collection/reporting situations.

## Further Reading {#more-reading}

- [Getting Started with DataKit](datakit-service-how-to.md)