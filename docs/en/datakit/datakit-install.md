# Host Installation
---

This article introduces the basic installation of DataKit.

## Register/Log in to Guance {#login-guance}

Access [Guance registration page](https://auth.guance.com/redirectpage/register){:target="_blank"} via your browser, fill in the required information, and you can [log in to Guance](https://console.guance.com/pageloading/login){:target="_blank"}

## Get Installation Command {#get-install}

Log in to your workspace, click on the left-hand side "Integration" and select "DataKit" at the top. You will see installation commands for various platforms.

> Note that the following Linux/Mac/Windows installation scripts automatically detect hardware platforms (arm/x86, 32bit/64bit), so there's no need to manually choose a hardware platform.

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

    After installation is complete, you'll see a success message in the terminal.

=== "Windows"

    On Windows, installation must be done through PowerShell with administrative privileges. Press the Windows key, type powershell, and right-click to select "Run as administrator".

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

### Install Lightweight DataKit {#lite-install}

You can install a lightweight version of DataKit by adding the `DK_LITE` environment variable to the installation command ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)):

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

The lightweight DataKit only includes the following collectors:

| Collector Name                                                        | Description                                           |
| ----------------------------------------------------------------- | ---------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                            | Collects CPU usage data from the host                        |
| [Disk (`disk`)](../integrations/disk.md)                         | Collects disk usage data                                 |
| [Disk IO (`diskio`)](../integrations/diskio.md)                  | Collects disk IO data from the host                         |
| [Memory (`mem`)](../integrations/mem.md)                           | Collects memory usage data from the host                         |
| [Swap (`swap`)](../integrations/swap.md)                         | Collects swap memory usage data                         |
| [System (`system`)](../integrations/system.md)                   | Collects operating system load data from the host                           |
| [Net (`net`)](../integrations/net.md)                            | Collects network traffic data from the host                           |
| [Host Processes (`host_processes`)](../integrations/host_processes.md) | Collects a list of resident processes (those alive for more than 10 minutes)      |
| [Host Object (`hostobject`)](../integrations/hostobject.md)         | Collects basic host information (such as OS and hardware details) |
| [Datakit (`dk`)](../integrations/dk.md)                          | Collects DataKit runtime metrics                     |
| [User Analysis (`rum`)](../integrations/rum.md)                    | Used to collect user analysis data                       |
| [Dial Testing (`dialtesting`)](../integrations/dialtesting.md)        | Collects dial testing data                               |
| [Prometheus Collection (`prom`)](../integrations/prom.md)               | Collects metrics exposed by Prometheus Exporters   |
| [Log Collection (`logging`)](../integrations/logging.md)                | Collects file log data                               |

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

The DataKit ELinker version only includes the following collectors:

| Collector Name                                                       | Description                                                        |
| ---------------------------------------------------------------- | ----------------------------------------------------------- |
| [CPU (`cpu`)](../integrations/cpu.md)                           | Collects CPU usage data from the host                                     |
| [Disk (`disk`)](../integrations/disk.md)                        | Collects disk usage data                                            |
| [Disk IO (`diskio`)](../integrations/diskio.md)                 | Collects disk IO data from the host                                      |
| [eBPF Trace Linker (`ebpftrace`)](../integrations/ebpftrace.md) | Receives eBPF span links and connects these spans to generate trace IDs and other information |
| [Swap (`swap`)](../integrations/swap.md)                        | Collects swap memory usage data                                      |
| [System (`system`)](../integrations/system.md)                  | Collects operating system load data from the host                                        |
| [Net (`net`)](../integrations/net.md)                           | Collects network traffic data from the host                                        |
| [Host Object (`hostobject`)](../integrations/hostobject.md)        | Collects basic host information (such as OS and hardware details)              |
| [DataKit (`dk`)](../integrations/dk.md)                         | Collects DataKit runtime metrics                               |

### Install a Specific Version of DataKit {#version-install}

You can specify a version number in the installation command to install a specific version of DataKit, such as installing version 1.2.3:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install-1.2.3.sh)"
```

For Windows, it is similar:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install-1.2.3.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

## Additional Supported Environment Variables {#extra-envs}

If you need to define some DataKit configurations during installation, you can add environment variables to the installation command before `DK_DATAWAY`. For example, adding `DK_NAMESPACE` setting:

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

The format for setting two environment variables is:

```shell
# Windows: Multiple environment variables are separated by semicolons
$env:NAME1="value1"; $env:Name2="value2"

# Linux/Mac: Multiple environment variables are separated by spaces
NAME1="value1" NAME2="value2"
```

The installation script supports the following environment variables (supported on all platforms).

<!-- markdownlint-disable MD046 -->
???+ attention

    [Offline Installation](datakit-offline-install.md#offline) does not support these environment variable settings. However, they can be set via [proxy](datakit-offline-install.md#with-datakit) or [setting up local installation addresses](datakit-offline-install.md#with-nginx).
<!-- markdownlint-enable -->

### Most Common Environment Variables {#common-envs}

- `DK_DATAWAY`: Specifies the DataWay address, which is already included by default in the DataKit installation command.
- `DK_GLOBAL_TAGS`: Deprecated, replaced by `DK_GLOBAL_HOST_TAGS`.
- `DK_GLOBAL_HOST_TAGS`: Supports defining global host tags during installation. Example format: `host=__datakit_hostname,host_ip=__datakit_ip` (tags are separated by commas).
- `DK_GLOBAL_ELECTION_TAGS`: Supports defining global election tags during installation. Example format: `project=my-project,cluster=my-cluster` (tags are separated by commas).
- `DK_CLOUD_PROVIDER`: Supports specifying cloud provider (currently supports `aliyun/aws/tencent/hwcloud/azure`). **This feature is deprecated**, as DataKit can now automatically identify cloud host types.
- `DK_USER_NAME`: Username under which DataKit service runs. Default is `root`. More details are provided in the "Notes" section below.
- `DK_DEF_INPUTS`: Configuration for [default enabled collectors](datakit-input-conf.md#default-enabled-inputs). To disable certain collectors, you need to manually shield them. For example, to disable `cpu` and `mem` collectors, specify `-cpu,-mem`, meaning all default collectors except these two will be enabled.
- `DK_LITE`: Set this variable to `1` to install the lightweight version of DataKit. ([:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0))

<!-- markdownlint-disable MD046 -->
???+ tip "Disable All Default Collectors [:octicons-tag-24: Version-1.5.5](changelog.md#cl-1.5.5)"

    To disable all default collectors, set `DK_DEF_INPUTS` to `-`:

    ```shell
    DK_DEF_INPUTS="-" \
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> \
    bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

    Additionally, if DataKit has been installed previously, all previous default collector configurations must be deleted, as DataKit can only add collector configurations during installation but cannot delete them.

???+ attention "Notes"

    Due to permission issues, if you modify the username under which DataKit service runs using `DK_USER_NAME` to a non-root user, the following collectors will not be usable:

    - [eBPF](../integrations/ebpf.md){:target="_blank"}

    Also, note the following points:

    - You must manually create the user and user group first, ensuring the username and group name are consistent, before proceeding with the installation. Commands may vary across different Linux distributions; the following commands are for reference:

        === "CentOS/RedHat"

            ```sh
            # Create system user group datakit
            groupadd --system datakit

            # Create system user datakit and add user datakit to group datakit (both username and group name are datakit)
            adduser --system --no-create-home datakit -g datakit

            # Disable login for user datakit (for CentOS/RedHat based Linux)
            usermod -s /sbin/nologin datakit
            ```

        === "Ubuntu/Debian"

            ```sh
            # In Ubuntu, creating a user and adding it to a user group simultaneously might fail, so do it in two steps

            # Create system user group datakit
            groupadd --system datakit

            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to group datakit
            usermod -a -G datakit datakit

            # Disable login for user datakit (for Ubuntu/Debian based Linux)
            usermod -s /usr/sbin/nologin datakit
            ```

        === "Other Linux"

            ```sh
            # In other Linux systems, creating a user and adding it to a user group simultaneously might fail, so do it in two steps

            # Create system user group datakit
            groupadd --system datakit
            
            # Create system user datakit
            adduser --system --no-create-home datakit
            
            # Add user datakit to group datakit
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
- `DK_LOG`: If changed to stdout, logs will not be written to files but will be output to the terminal.
- `DK_GIN_LOG`: If changed to stdout, logs will not be written to files but will be output to the terminal.

### DataKit pprof Related {#env-pprof}

- `DK_ENABLE_PPROF`: Whether to enable `pprof`. [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) has it enabled by default.
- `DK_PPROF_LISTEN`: Address where `pprof` service listens

### DataKit Election Related {#env-election}

- `DK_ENABLE_ELECTION`: Enable election, disabled by default. To enable, assign any non-empty string value to this environment variable (like `True`/`False`).
- `DK_NAMESPACE`: Support specifying namespace during installation (used for elections)

### HTTP/API Related Environment Variables {#env-http-api}

- `DK_HTTP_LISTEN`: Support specifying the network interface DataKit HTTP service binds to during installation (default `localhost`)
- `DK_HTTP_PORT`: Support specifying the port DataKit HTTP service binds to during installation (default `9529`)
- `DK_RUM_ORIGIN_IP_HEADER`: RUM specific
- `DK_DISABLE_404PAGE`: Disable DataKit 404 page (commonly used when deploying DataKit RUM publicly, like `True`/`False`)
- `DK_INSTALL_IPDB`: Specify IP database during installation (current options are `iploc/geolite2`)
- `DK_UPGRADE_IP_WHITELIST`: Starting from Datakit [1.5.9](changelog.md#cl-1.5.9), remote API access to upgrade Datakit is supported. This environment variable sets a whitelist of client IPs allowed to remotely access (multiple IPs separated by commas `,`). IPs not on the whitelist will be denied (default is no IP restriction).
- `DK_UPGRADE_LISTEN`: Specifies the HTTP address the upgrade service binds to (default `0.0.0.0:9542`) [:octicons-tag-24: Version-1.38.1](changelog.md#cl-1.38.1)
- `DK_HTTP_PUBLIC_APIS`: Sets HTTP APIs that Datakit allows remote access to. Typically needed for RUM functionality, supported from Datakit [1.9.2](changelog.md#cl-1.9.2).

### DCA Related {#env-dca}

- `DK_DCA_ENABLE`: Support enabling DCA service during installation (default not enabled)
- `DK_DCA_WEBSOCKET_SERVER`: Support customizing the websocket address for DCA during installation

### External Collector Related {#env-external-inputs}

- `DK_INSTALL_EXTERNALS`: Can be used to install external collectors not bundled with DataKit

### Confd Configuration Related {#env-connfd}

| Environment Variable Name              | Type   | Applicable Scenario                        | Description       | Sample Value                                         |
| ----------------------- | ------ | ------------------------------- | ---------- | ---------------------------------------------- |
| DK_CONFD_BACKEND        | string | All                            | Backend source type | `etcdv3` or `zookeeper` or `redis` or `consul` |
| DK_CONFD_BASIC_AUTH     | string | `etcdv3` or `consul`            | Optional       |                                                |
| DK_CONFD_CLIENT_CA_KEYS | string | `etcdv3` or `consul`            | Optional       |                                                |
| DK_CONFD_CLIENT_CERT    | string | `etcdv3` or `consul`            | Optional       |                                                |
| DK_CONFD_CLIENT_KEY     | string | `etcdv3` or `consul` or `redis` | Optional       |                                                |
| DK_CONFD_BACKEND_NODES  | string | All                            | Backend source address | `[IP:2379, IP2:2379]`                          |
| DK_CONFD_PASSWORD       | string | `etcdv3` or `consul`            | Optional       |                                                |
| DK_CONFD_SCHEME         | string | `etcdv3` or `consul`            | Optional       |                                                |
| DK_CONFD_SEPARATOR      | string | `redis`                         | Optional default 0 |                                                |
| DK_CONFD_USERNAME       | string | `etcdv3` or `consul`            | Optional       |                                                |

### Git Configuration Related {#env-gitrepo}

- `DK_GIT_URL`: Remote git repo URL for managing configuration files. (e.g., `http://username:password@github.com/username/repository.git`)
- `DK_GIT_KEY_PATH`: Full path to the local PrivateKey. (e.g., `/Users/username/.ssh/id_rsa`)
- `DK_GIT_KEY_PW`: Password for the local PrivateKey. (e.g., `passwd`)
- `DK_GIT_BRANCH`: Specifies the branch to pull. **Empty means default**, usually the main branch specified remotely, generally `master`.
- `DK_GIT_INTERVAL`: Interval for periodic pulls. (e.g., `1m`)

### Sinker Configuration Related {#env-sink}

Use `DK_SINKER_GLOBAL_CUSTOMER_KEYS` to set tag/field keys for sinker filtering. The format is as follows:

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

### Resource Limitation Configuration Related {#env-cgroup}

Currently supported only on Linux and Windows ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)) operating systems.

- `DK_LIMIT_DISABLED`: Disable resource limitation (default enabled)
- `DK_LIMIT_CPUMAX`: Limit maximum CPU usage percentage, default 30.0, max 100 (deprecated, recommend using `DK_LIMIT_CPUCORES`)
- `DK_LIMIT_CPUCORES`: Limit the number of CPU cores used, default 2.0 (i.e., 2 cores)
- `DK_LIMIT_MEMMAX`: Limit maximum memory (including swap) usage, default 4096 (4GB)

### APM Instrumentation {#apm-instrumentation}

[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

In the installation command, specify `DK_APM_INSTRUMENTATION_ENABLED` to automatically inject APM into Java/Python applications:

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

For host deployment, after DataKit installation is complete, open a new terminal and restart the corresponding Java/Python application.

To enable or disable this feature, modify the `instrumentation_enabled` value under `[apm_inject]` in the `datakit.conf` file:

- Values `"host"`, `"docker"` or `"host,docker"`, to enable
- Values `""` or `"disable"`, to disable

Notes:

1. Before deleting files in the DataKit installation directory, uninstall this feature by executing **`datakit tool --remove-apm-auto-inject`** to clean up system and Docker settings.

2. For Docker injection, additional steps are required to install and configure Docker injection and delete injection-related files in the DataKit installation directory after unloading this feature.

   - After installing and configuring Docker injection, if you want to apply it to existing containers:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of already created containers from runc to dk-runc provided by DataKit
   datakit tool --change-docker-containers-runtime dk-runc

   # Start docker service
   systemctl start docker

   # Restart containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

   - After unloading this feature (if Docker injection was enabled), if you want to delete all files in the DataKit installation directory:

   ```shell
   # Stop docker service
   systemctl stop docker docker.socket

   # Change the runtime of already created containers back to runc
   datakit tool --change-docker-containers-runtime runc

   # Start docker service
   systemctl start docker

   # Restart containers that exited due to dockerd restart
   docker start <container_id1> <container_id2> ...
   ```

Running environment requirements:

- Linux system
    - CPU architecture: x86_64 or arm64
    - C standard library: glibc 2.4 or higher, or musl
    - Java 8 or higher
    - Python 3.7 or higher

In Kubernetes, you can inject APM through the [Datakit Operator](datakit-operator.md#datakit-operator-inject-lib).

### Other Installation Options {#env-others}

| Environment Variable Name                       | Example Value                    | Description                                                                                                                             |
| -------------------------------- | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `DK_INSTALL_ONLY`                | `on`                        | Install only, do not run                                                                                                                   |
| `DK_HOSTNAME`                    | `some-host-name`            | Customize hostname during installation                                                                                                     |
| `DK_UPGRADE`                     | `1`                         | Upgrade to the latest version                                                   |
| `DK_UPGRADE_MANAGER`             | `on`                        | Upgrade the **remote upgrade service** along with Datakit, needs to be used with `DK_UPGRADE`, supported from [1.5.9](changelog.md#cl-1.5.9)        |
| `DK_INSTALLER_BASE_URL`          | `https://your-url`          | Choose different environment installation scripts, default is `https://static.guance.com/datakit`                                                             |
| `DK_PROXY_TYPE`                  | -                           | Proxy type. Options are: `datakit` or `nginx`, both lowercase                                                                                 |
| `DK_NGINX_IP`                    | -                           | Proxy server IP address (only IP, no port). This is mutually exclusive with "HTTP_PROXY" and "HTTPS_PROXY", and has the highest priority, overriding the above two  |
| `DK_INSTALL_LOG`                 | -                           | Set installation program log path, default is *install.log* in the current directory, if set to `stdout` it outputs to the command line terminal                                   |
| `HTTPS_PROXY`                    | `IP:Port`                   | Use Datakit proxy for installation                                                                                                            |
| `DK_INSTALL_RUM_SYMBOL_TOOLS`    | `on`                        | Whether to install RUM source map tools, supported from Datakit [1.9.2](changelog.md#cl-1.9.2)                                               |
| `DK_VERBOSE`                     | `on`                        | Enable verbose options during installation (only supported on Linux/Mac), output more debug information[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0) |
| `DK_CRYPTO_AES_KEY`              | `0123456789abcdfg`          | AES encryption key for decrypting passwords in collectors [:octicons-tag-24: Version-1.31.0](changelog.md#cl-1.31.0)                  |
| `DK_CRYPTO_AES_KEY_FILE`         | `/usr/local/datakit/enc4dk` | Another way to configure the key, prioritized over the previous method. Place the key in this file and specify the configuration file path via an environment variable.                               |

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Handle Unfriendly Hostnames {#bad-hostname}
<!-- markdownlint-enable -->

Since DataKit uses the hostname (Hostname) as the basis for data correlation, sometimes hostnames can be unfriendly, like `iZbp141ahn....`. However, for certain reasons, you cannot change these hostnames, which can cause inconvenience. In DataKit, you can override this unfriendly hostname in the main configuration.

In `datakit.conf`, modify the following configuration, and DataKit will read `ENV_HOSTNAME` to override the actual hostname:

```toml
[environments]
    ENV_HOSTNAME = "your-fake-hostname-for-datakit"
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If a host has already collected data for some time, changing the hostname will disconnect historical data from the new hostname. Changing the hostname is equivalent to adding a brand new host.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Mac Installation Issues {#mac-failed}
<!-- markdownlint-enable -->

When installing/upgrading on macOS, if you encounter:

```shell
"launchctl" failed with stderr: /Library/LaunchDaemons/cn.dataflux.datakit.plist: Service is disabled
# Or
"launchctl" failed with stderr: /Library/LaunchDaemons/com.guance.datakit.plist: Service is disabled
```

Execute:

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
### :material-chat-question: Does Datakit Perform Any High-Risk File or Data Operations? {#danger-ops}
<!-- markdownlint-enable -->

During operation, DataKit reads a lot of system information based on collection configurations, such as process lists, hardware and software information (like OS, CPU, memory, disk, NIC, etc.). However, it does not actively perform deletion or modification of any data outside its own scope. Regarding file operations, it is divided into two parts: one related to data collection and reading files/ports, and another related to necessary file read/write operations for Datakit's own operation.

Files read during collection:

- During process information and hardware/software information collection, on Linux, it reads relevant information from the */proc* directory; on Windows, it mainly retrieves this information through WMI and the Golang Windows SDK.

- If log collection is configured, according to the configuration, it scans and reads logs that match the configuration (such as syslog, user application logs, etc.).

- Port occupancy: DataKit opens separate ports to receive external data when interfacing with other systems. [These ports](datakit-port.md) are opened as needed based on the collector.

- eBPF Collection: Due to its special nature, eBPF requires more detailed Linux kernel and process binary information, performing actions such as:

    - Analyzing the symbol addresses contained in the binaries of all (or specified) running programs (dynamic libraries, container processes)
    - Reading/writing files under the kernel DebugFS mount point or PMU (Performance Monitoring Unit) to place kprobe/uprobe/tracepoint eBPF probes
    - Uprobes modify user process CPU instructions to read relevant data

Besides collection, DataKit performs the following file read/write operations:

- Its own log files

On Linux, located in */var/log/datakit/*; on Windows, in *C:\Program Files\datakit*. 

Log files rotate automatically when they reach a specified size (default 32MB) and have a maximum rotation limit (default 5 + 1 shards).

- Disk Cache

Some data collections require disk cache functionality (manually enabled), which involves file creation and deletion during generation and consumption. Disk cache has a maximum capacity setting, and when full, it automatically executes FIFO deletions to prevent filling the disk.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How Does Datakit Control Its Own Resource Consumption? {#resource-limit}
<!-- markdownlint-enable -->

You can limit Datakit's resource usage through mechanisms like cgroup; refer to [here](datakit-conf.md#resource-limit). If Datakit is deployed in Kubernetes, refer to [here](datakit-daemonset-deploy.md#requests-limits).

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Datakit's Self-Observability {#self-obs}
<!-- markdownlint-enable -->

During operation, Datakit exposes many [metrics about itself](datakit-metrics.md). By default, Datakit collects these metrics via [built-in collectors](../integrations/dk.md) and reports them to the user's workspace.

Additionally, Datakit comes with a [monitor command-line tool](datakit-monitor.md), which can be used to view the current running status and collection/reporting situations.

## Further Reading {#more-reading}

- [Getting Started with DataKit](datakit-service-how-to.md)