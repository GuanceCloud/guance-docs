# Host Installation
---

This document introduces the basic installation of DataKit.

## Register/Login to Guance {#login-guance}

Visit [Guance registration page](https://auth.guance.com/redirectpage/register){:target="_blank"} in your browser, fill in the required information, and then [log in to Guance](https://console.guance.com/pageloading/login){:target="_blank"}

## Obtain Installation Command {#get-install}

Log in to your workspace, click on "Integration" on the left side, and select "Datakit" at the top. You will see installation commands for various platforms.

> Note: The following Linux/Mac/Windows installation scripts can automatically identify hardware platforms (arm/x86, 32bit/64bit), so there is no need to choose a hardware platform manually.

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    The installation command supports `bash` and `ash`([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)):

    - `bash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    - `ash`

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> ash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    After installation, you will see a success message in the terminal.

=== "Windows"

    On Windows, installation must be done via PowerShell with administrative privileges. Press the Windows key, type powershell, and right-click on the PowerShell icon to select "Run as administrator".

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

### Install Lite Version of DataKit {#lite-install}

You can install the lite version of DataKit by adding the `DK_LITE` environment variable to the installation command ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)):

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

The lite version of DataKit includes only the following collectors:

| Collector Name                                                       | Description                                             |
| -------------------------------------------------------------------- | ------------------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                               | Collects CPU usage data                                 |
| [Disk (`disk`)](../integrations/disk.md)                            | Collects disk usage data                                |
| [Disk IO (`diskio`)](../integrations/diskio.md)                     | Collects disk I/O data                                  |
| [Memory (`mem`)](../integrations/mem.md)                            | Collects memory usage data                              |
| [Swap (`swap`)](../integrations/swap.md)                            | Collects swap memory usage data                         |
| [System (`system`)](../integrations/system.md)                      | Collects system load data                               |
| [Net (`net`)](../integrations/net.md)                               | Collects network traffic data                           |
| [Host Processes (`host_processes`)](../integrations/host_processes.md) | Collects long-running process lists (>10 minutes)       |
| [Host Object (`hostobject`)](../integrations/hostobject.md)         | Collects basic host information (e.g., OS, hardware)    |
| [DataKit (`dk`)](../integrations/dk.md)                             | Collects DataKit runtime metrics                        |
| [User Access Monitoring (`rum`)](../integrations/rum.md)            | Collects user access monitoring data                    |
| [Dial Testing (`dialtesting`)](../integrations/dialtesting.md)      | Collects dial testing data                              |
| [Prometheus Collection (`prom`)](../integrations/prom.md)           | Collects metrics exposed by Prometheus Exporters        |
| [Log Collection (`logging`)](../integrations/logging.md)            | Collects file log data                                  |

### Install the eBPF Trace Linker Version of DataKit {#elinker-install}

You can install the eBPF Trace Linker version of DataKit by adding the `DK_ELINKER` environment variable to the installation command ([:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)):

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

The eBPF Trace Linker version of DataKit includes only the following collectors:

| Collector Name                                                       | Description                                             |
| -------------------------------------------------------------------- | ------------------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                               | Collects CPU usage data                                 |
| [Disk (`disk`)](../integrations/disk.md)                            | Collects disk usage data                                |
| [Disk IO (`diskio`)](../integrations/diskio.md)                     | Collects disk I/O data                                  |
| [eBPF Trace Linker (`ebpftrace`)](../integrations/ebpftrace.md)     | Receives eBPF span links and connects them to generate trace IDs and other information |
| [Swap (`swap`)](../integrations/swap.md)                            | Collects swap memory usage data                         |
| [System (`system`)](../integrations/system.md)                      | Collects system load data                               |
| [Net (`net`)](../integrations/net.md)                               | Collects network traffic data                           |
| [Host Object (`hostobject`)](../integrations/hostobject.md)         | Collects basic host information (e.g., OS, hardware)    |
| [DataKit (`dk`)](../integrations/dk.md)                             | Collects DataKit runtime metrics                        |

### Install a Specific Version of DataKit {#version-install}

You can specify a version number in the installation command to install a specific version of DataKit, such as installing version 1.2.3:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install-1.2.3.sh)"
```

For Windows:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install-1.2.3.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

## Additional Supported Environment Variables {#extra-envs}

If you need to define some DataKit configurations during the installation stage, you can add environment variables to the installation command before `DK_DATAWAY`. For example, adding `DK_NAMESPACE`:

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

The format for setting two environment variables is as follows:

```shell
# Windows: Multiple environment variables are separated by semicolons
$env:NAME1="value1"; $env:Name2="value2"

# Linux/Mac: Multiple environment variables are separated by spaces
NAME1="value1" NAME2="value2"
```

The installation script supports the following environment variables (supported on all platforms).

<!-- markdownlint-disable MD046 -->
???+ attention

    [Offline Installation](datakit-offline-install.md#offline) does not support these environment variable settings. However, you can set these environment variables through [proxy](datakit-offline-install.md#with-datakit) or [setting local installation address](datakit-offline-install.md#with-nginx).
<!-- markdownlint-enable -->

### Most Common Environment Variables {#common-envs}

- `DK_DATAWAY`: Specifies the DataWay address, which is already included by default in the DataKit installation command.
- `DK_GLOBAL_TAGS`: Deprecated, replaced by DK_GLOBAL_HOST_TAGS
- `DK_GLOBAL_HOST_TAGS`: Supports defining global host tags during installation, example format: `host=__datakit_hostname,host_ip=__datakit_ip` (multiple tags are separated by commas)
- `DK_GLOBAL_ELECTION_TAGS`: Supports defining global election tags during installation, example format: `project=my-porject,cluster=my-cluster` (multiple tags are separated by commas)
- `DK_CLOUD_PROVIDER`: Supports defining cloud provider during installation (currently supports `aliyun/aws/tencent/hwcloud/azure`). **This feature is deprecated**, as DataKit can now automatically detect cloud provider types.
- `DK_USER_NAME`: Username under which DataKit service runs. Default is `root`. For more details, see the "Notes" section below.
- `DK_DEF_INPUTS`: Configuration for [default enabled collectors](datakit-input-conf.md#default-enabled-inputs). To disable certain collectors, you need to manually block them. For example, to disable the `cpu` and `mem` collectors, specify: `-cpu,-mem`, meaning that all other default collectors will be enabled except these two.
- `DK_LITE`: Set this variable to `1` to install the lite version of DataKit. ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0))

<!-- markdownlint-disable MD046 -->
???+ tip "Disable All Default Collectors [:octicons-tag-24: Version-1.5.5](changelog.md#cl-1.5.5)"

    If you want to disable all default collectors, set `DK_DEF_INPUTS` to `-`:

    ```shell
    DK_DEF_INPUTS="-" \
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
    bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    Additionally, if you have previously installed DataKit, you must delete all previous default collector configurations because DataKit can only add collector configurations during installation but cannot remove them.

???+ attention "Notes"

    Due to permission issues, if you modify the DataKit service's running username to a non-root user using `DK_USER_NAME`, the following collectors will not be usable:

    - [eBPF](../integrations/ebpf.md){:target="_blank"}

    Also, note the following points:

    - You must manually create the user and group before installation. The username and group name must be the same. Commands may vary across different Linux distributions; the following commands are for reference:

        === "CentOS/RedHat"

            ```sh
            # Create system group datakit
            groupadd --system datakit

            # Create system user datakit and add it to the datakit group
            adduser --system --no-create-home datakit -g datakit

            # Disable login for user datakit (for CentOS/RedHat Linux)
            usermod -s /sbin/nologin datakit
            ```

        === "Ubuntu/Debian"

            ```sh
            # On Ubuntu, creating a user and adding it to the group in one step may cause errors, so do it in two steps

            # Create system group datakit
            groupadd --system datakit

            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to the datakit group
            usermod -a -G datakit datakit

            # Disable login for user datakit (for Ubuntu/Debian Linux)
            usermod -s /usr/sbin/nologin datakit
            ```

        === "Other Linux"

            ```sh
            # On other Linux systems, creating a user and adding it to the group in one step may cause errors, so do it in two steps

            # Create system group datakit
            groupadd --system datakit
            
            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to the datakit group
            usermod -a -G datakit datakit
            
            # Disable login for user datakit (for other Linux systems)
            usermod -s /bin/false datakit
            ```

        ```sh
        # Install DataKit
        DK_USER_NAME="datakit" DK_DATAWAY="..." bash -c ...
        ```

<!-- markdownlint-enable -->

### DataKit Logging Related {#env-logging}

- `DK_LOG_LEVEL`: Options are info/debug
- `DK_LOG`: If set to stdout, logs will not be written to files but output to the terminal
- `DK_GIN_LOG`: If set to stdout, logs will not be written to files but output to the terminal

### DataKit pprof Related {#env-pprof}

- `DK_ENABLE_PPROF`: Whether to enable `pprof`. [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) has enabled it by default.
- `DK_PPROF_LISTEN`: Address for `pprof` service to listen on

### DataKit Election Related {#env-election}

- `DK_ENABLE_ELECTION`: Enable election, default is disabled. To enable, give this environment variable any non-empty string value (e.g., `True`/`False`)
- `DK_NAMESPACE`: Support specifying namespace during installation (for election)

### HTTP/API Related Environment Variables {#env-http-api}

- `DK_HTTP_LISTEN`: Support specifying the network interface DataKit HTTP service binds to (default `localhost`)
- `DK_HTTP_PORT`: Support specifying the port DataKit HTTP service binds to (default `9529`)
- `DK_RUM_ORIGIN_IP_HEADER`: RUM-specific
- `DK_DISABLE_404PAGE`: Disable DataKit 404 page (commonly used when deploying DataKit RUM publicly, e.g., `True`/`False`)
- `DK_INSTALL_IPDB`: Specify IP database during installation (current options are `iploc/geolite2`)
- `DK_UPGRADE_IP_WHITELIST`: Starting from DataKit [1.5.9](changelog.md#cl-1.5.9), remote API access is supported to upgrade DataKit. This environment variable sets a whitelist of client IPs that can remotely access (multiple IPs separated by commas `,`). IPs not in the whitelist will be denied (by default, there is no IP restriction).
- `DK_UPGRADE_LISTEN`: Specify the HTTP address for the upgrade service to bind to (default `0.0.0.0:9542`) [:octicons-tag-24: Version-1.38.1](changelog.md#cl-1.38.1)
- `DK_HTTP_PUBLIC_APIS`: Set HTTP APIs that DataKit allows remote access to, typically needed for RUM functionality, supported from DataKit [1.9.2](changelog.md#cl-1.9.2).

### DCA Related {#env-dca}

- `DK_DCA_ENABLE`: Support enabling DCA service during installation (default is not enabled)
- `DK_DCA_WEBSOCKET_SERVER`: Support customizing the websocket address for DCA during installation

### External Collector Related {#env-external-inputs}

- `DK_INSTALL_EXTERNALS`: Can be used to install external collectors not packaged with DataKit

### Confd Configuration Related {#env-connfd}

| Environment Variable Name | Type   | Applicable Scenario | Description | Example Value                                         |
| ------------------------- | ------ | ------------------- | ----------- | ----------------------------------------------------- |
| DK_CONFD_BACKEND          | string | All                 | Backend type | `etcdv3` or `zookeeper` or `redis` or `consul`        |
| DK_CONFD_BASIC_AUTH       | string | `etcdv3` or `consul` | Optional    |                                                      |
| DK_CONFD_CLIENT_CA_KEYS   | string | `etcdv3` or `consul` | Optional    |                                                      |
| DK_CONFD_CLIENT_CERT      | string | `etcdv3` or `consul` or `redis` | Optional |                                                      |
| DK_CONFD_CLIENT_KEY       | string | `etcdv3` or `consul` or `redis` | Optional |                                                      |
| DK_CONFD_BACKEND_NODES    | string | All                 | Backend addresses | `[IP:2379, IP2:2379]`                                 |
| DK_CONFD_PASSWORD         | string | `etcdv3` or `consul` | Optional    |                                                      |
| DK_CONFD_SCHEME           | string | `etcdv3` or `consul` | Optional    |                                                      |
| DK_CONFD_SEPARATOR        | string | `redis`             | Optional, default 0 |                                                      |
| DK_CONFD_USERNAME         | string | `etcdv3` or `consul` | Optional    |                                                      |

### Git Configuration Related {#env-gitrepo}

- `DK_GIT_URL`: Remote git repo URL for managing configuration files. (e.g., `http://username:password@github.com/username/repository.git`)
- `DK_GIT_KEY_PATH`: Full path to the local PrivateKey. (e.g., `/Users/username/.ssh/id_rsa`)
- `DK_GIT_KEY_PW`: Password for the local PrivateKey. (e.g., `passwd`)
- `DK_GIT_BRANCH`: Specifies the branch to pull. **Empty means default**, which is usually the main branch specified remotely, generally `master`.
- `DK_GIT_INTERVAL`: Interval for periodic pulls. (e.g., `1m`)

### Sinker Configuration Related {#env-sink}

Use `DK_SINKER_GLOBAL_CUSTOMER_KEYS` to set tag/field key names for sinker filtering, formatted as follows:

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

### Resource Limit Configuration Related {#env-cgroup}

Currently supported only on Linux and Windows ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)) operating systems.

- `DK_LIMIT_DISABLED`: Disable resource limitation function (default is enabled)
- `DK_LIMIT_CPUMAX`: Maximum CPU power allowed, default 30.0
- `DK_LIMIT_MEMMAX`: Memory (including swap) maximum usage limit, default 4096 (4GB)

### APM Instrumentation {#apm-instrumentation}

[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

In the installation command, specify `DK_APM_INSTRUMENTATION_ENABLED` to automatically inject APM for Java/Python applications:

- Enable host injection:

```shell
DK_APM_INSTRUMENTATION_ENABLED=host \
  DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
  bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Enable Docker injection:

```shell
DK_APM_INSTRUMENTATION_ENABLED=docker \
  DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
  bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

For host deployment, after DataKit installation, restart the corresponding Java/Python application in a new terminal.

To enable or disable this feature, modify the `instrumentation_enabled` value under `[apm_inject]` in the `datakit.conf` file:

- Values `"host"`, `"docker"`, or `"host,docker"` to enable
- Values `""` or `"disable"` to disable

Notes:

1. Before deleting files in the DataKit installation directory, uninstall this feature by executing **`datakit tool --remove-apm-auto-inject`** to clean up system settings and Docker settings.

2. For Docker injection, additional steps are required to install and configure Docker injection and delete related files in the DataKit installation directory:

   - To apply changes to existing containers after configuring Docker injection:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of existing containers from runc to dk-runc provided by DataKit
   datakit tool --change-docker-containers-runtime dk-runc

   # Start docker service
   systemctl start docker

   # Restart containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

   - After uninstalling this feature (if Docker injection was enabled), to delete all files in the DataKit installation directory:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of existing containers back from dk-runc to runc
   datakit tool --change-docker-containers-runtime runc

   # Start docker service
   systemctl start docker

   # Restart containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

Runtime Requirements:

- Linux System
    - CPU Architecture: x86_64 or arm64
    - C Standard Library: glibc 2.4 and above, or musl
    - Java 8 and above
    - Python 3.7 and above

In Kubernetes, you can inject APM using [Datakit Operator](datakit-operator.md#datakit-operator-inject-lib).

### Other Installation Options {#env-others}

| Environment Variable Name               | Example Value                   | Description                                                                                                                             |
| --------------------------------------- | ------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `DK_INSTALL_ONLY`                       | `on`                            | Only install, do not run                                                                                                                |
| `DK_HOSTNAME`                           | `some-host-name`                | Support custom hostname configuration during installation                                                                               |
| `DK_UPGRADE`                            | `1`                             | Upgrade to the latest version                                                                                                           |
| `DK_UPGRADE_MANAGER`                    | `on`                            | Upgrade the **remote upgrade service** along with DataKit, needs to be used with `DK_UPGRADE`. Supported from [1.5.9](changelog.md#cl-1.5.9) |
| `DK_INSTALLER_BASE_URL`                 | `https://your-url`              | Choose installation script from different environments, default is `https://static.guance.com/datakit`                                  |
| `DK_PROXY_TYPE`                         | -                               | Proxy type. Options are: `datakit` or `nginx`, both lowercase                                                                          |
| `DK_NGINX_IP`                           | -                               | Proxy server IP address (only IP, no port). This is mutually exclusive with "HTTP_PROXY" and "HTTPS_PROXY" and has the highest priority  |
| `DK_INSTALL_LOG`                        | -                               | Set installation program log path, default is *install.log* in the current directory. If set to `stdout`, it outputs to the command line terminal |
| `HTTPS_PROXY`                           | `IP:Port`                       | Through Datakit proxy installation                                                                                                     |
| `DK_INSTALL_RUM_SYMBOL_TOOLS`           | `on`                            | Whether to install RUM source map tools, supported from Datakit [1.9.2](changelog.md#cl-1.9.2)                                          |
| `DK_VERBOSE`                            | `on`                            | Enable verbose options during installation (only supported on Linux/Mac), which outputs more debugging information[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0) |
| `DK_CRYPTO_AES_KEY`                     | `0123456789abcdfg`              | Use encrypted password decryption key for protecting plain text passwords in collectors [:octicons-tag-24: Version-1.31.0](changelog.md#cl-1.31.0) |
| `DK_CRYPTO_AES_KEY_FILE`                | `/usr/local/datakit/enc4dk`     | Another way to configure the key, prioritized over the previous method. Place the key in this file and configure the file path via an environment variable |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Handle Unfriendly Hostnames {#bad-hostname}
<!-- markdownlint-enable -->

Since DataKit uses the hostname (Hostname) as the basis for data association, in some cases, some hostnames may not be very friendly, like `iZbp141ahn....`. However, for certain reasons, you cannot change these hostnames, which can cause inconvenience. In DataKit, you can override this unfriendly hostname in the main configuration.

In `datakit.conf`, modify the following configuration. DataKit will read `ENV_HOSTNAME` to override the actual hostname:

```toml
[environments]
    ENV_HOSTNAME = "your-fake-hostname-for-datakit"
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If a host has already collected data for some time, changing the hostname will disassociate the historical data from the new hostname. Changing the hostname is equivalent to adding a brand new host.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Mac Installation Issues {#mac-failed}
<!-- markdownlint-enable -->

When installing/upgrading on Mac, if you encounter:

```shell
"launchctl" failed with stderr: /Library/LaunchDaemons/cn.dataflux.datakit.plist: Service is disabled
# Or
"launchctl" failed with stderr: /Library/LaunchDaemons/com.guance.datakit.plist: Service is disabled
```

Execute the following command:

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
### :material-chat-question: Does Datakit Perform High-Risk Operations on Files and Data? {#danger-ops}
<!-- markdownlint-enable -->

During its operation, DataKit reads many system information based on different collection configurations, such as process lists, software/hardware information (like OS, CPU, memory, disk, network card, etc.). However, it does not actively perform deletion or modification of data outside itself. Regarding file operations, it can be divided into two parts: one related to data collection, and the other necessary file read/write operations for DataKit's own operation.

Files read by DataKit for collection:

- During process information and software/hardware information collection, Linux reads relevant information from the */proc* directory; Windows mainly retrieves this information through WMI and the Golang Windows SDK.

- If log collection is configured, according to the configuration, it scans and reads logs that match the configuration (such as syslog, user application logs, etc.).

- Port occupation: DataKit opens certain ports to receive external data when interfacing with other systems. [These ports](datakit-port.md) are opened as needed based on the collector.

- eBPF Collection: Due to its special nature, eBPF requires more Linux kernel and process binary information, performing actions such as:

    - Analyzing symbols in the binaries of all (or specified) running programs (dynamic libraries, processes within containers)
    - Reading and writing files under the kernel DebugFS mount point or PMU (Performance Monitoring Unit) to place kprobe/uprobe/tracepoint eBPF probes
    - Uprobe probes modify user process CPU instructions to read relevant data

Apart from collection, DataKit performs the following file read/write operations:

- Its own log files

On Linux, they are located in the */var/log/datakit/* directory; on Windows, they are located in the *C:\Program Files\datakit* directory.

Log files rotate automatically when they reach a specified size (default 32MB) and have a maximum rotation count limit (default maximum 5 + 1 fragments).

- Disk Cache

Some data collection requires disk cache functionality (manually enabled), and this cache involves file creation and deletion during generation and consumption. Disk cache also has a maximum capacity setting, and when full, it automatically deletes old data using FIFO to prevent filling the disk.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How Does Datakit Control Its Own Resource Consumption? {#resource-limit}
<!-- markdownlint-enable -->

You can limit Datakit's resource usage using mechanisms like cgroup, refer to [here](datakit-conf.md#resource-limit). If Datakit is deployed in Kubernetes, refer to [here](datakit-daemonset-deploy.md#requests-limits).

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Datakit's Own Observability? {#self-obs}
<!-- markdownlint-enable -->

During its operation, Datakit exposes many [metrics about itself](datakit-metrics.md). By default, Datakit collects these metrics through [built-in collectors](../integrations/dk.md) and reports them to the user's workspace.

Additionally, Datakit comes with a [monitor command-line tool](datakit-monitor.md) that can view the current running status and collection/reporting situations.

## Further Reading {#more-reading}

- [Getting Started with DataKit](datakit-service-how-to.md)