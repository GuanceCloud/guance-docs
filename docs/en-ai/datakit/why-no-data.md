# How to Troubleshoot No Data Issues

---

After deploying Datakit, you typically check the collected data directly from the Guance page. If everything is normal, the data will soon be displayed on the page (most directly in the "Infrastructure" section, such as host/process data). However, due to various reasons, issues can occur during data collection, processing, or transmission, leading to no data.

The following sections analyze potential causes of no data:

- [Network-related](why-no-data.md#iss-network)
- [Host-related](why-no-data.md#iss-host)
- [Startup Issues](why-no-data.md#iss-start-fail)
- [Collector Configuration-related](why-no-data.md#iss-input-config)
- [Global Configuration-related](why-no-data.md#iss-global-settings)
- [Others](why-no-data.md#iss-others)

## Network-related {#iss-network}

Network-related issues are relatively straightforward and common. You can also troubleshoot them using other methods (`ping/nc/curl` commands).

### Target Object Cannot Be Connected {#iss-input-connect}

Since Datakit is installed on specific machines/Nodes, it may fail to access the target objects (e.g., MySQL/Redis) due to network issues. At this point, you can use collector debugging to identify the problem:

```shell
$ datakit debug --input-conf conf.d/db/redis.conf
loading /usr/local/datakit/conf.d/db/redis.conf.sample with 1 inputs...
running input "redis"(0th)...
[E] get error from input = redis, source = redis: dial tcp 192.168.3.100:6379: connect: connection refused | Ctrl+c to exit.
```

### Unable to Connect to Dataway {#iss-dw-connect}

If the host where Datakit resides cannot connect to Dataway, you can test Dataway's 404 page:

```shell
$ curl -I http[s]://your-dataway-addr:port
HTTP/2 404
date: Mon, 27 Nov 2023 06:03:47 GMT
content-type: text/html
content-length: 792
access-control-allow-credentials: true
access-control-allow-headers: Content-Type, Content-Length
access-control-allow-methods: POST, OPTIONS, GET, PUT
access-control-allow-origin: *
```

If it shows a status code of 404, it indicates that the connection to Dataway is normal.

For SaaS, the Dataway address is `https://openway.guance.com`.

If you get the following result, it indicates a network issue:

```shell
curl: (6) Could not resolve host: openway.guance.com
```

If you find similar error logs in the Datakit logs (`/var/log/datakit/log`), it suggests that there might be a firewall restriction preventing the connection to Dataway:

```shell
request url https://openway.guance.com/v1/write/xxx/token=tkn_xxx failed:  ... context deadline exceeded...
```

## Host-related {#iss-host}

Host-related issues are usually more hidden and often overlooked, making them difficult to troubleshoot (the lower-level problems are harder to detect). Here’s a rough outline:

### Timestamp Anomalies {#iss-timestamp}

On Linux/Mac, entering `date` displays the current system time:

```shell
$ date
Wed Jul 21 16:22:32 CST 2021
```

In some cases, it might show:

```shell
$ date
Wed Jul 21 08:22:32 UTC 2021
```

This is because the former is China Standard Time (UTC+8), while the latter is Greenwich Mean Time (UTC), differing by 8 hours. However, these two times have the same timestamp.

If your system time differs significantly from your phone’s time, especially if it is ahead, Guance won't display this "future" data.

Additionally, if the time lags behind, the default Explorer in Guance won't display these data (usually showing only the last 15 minutes of data). You can adjust the time range in the Explorer.

### Unsupported Host Hardware/Software {#iss-os-arch}

Some collectors are unsupported on certain platforms. Even if the configuration is enabled, no data will be collected:

- macOS lacks a CPU collector
- Collectors like Oracle/DB2/OceanBase/eBPF run only on Linux
- Some Windows-specific collectors do not work on non-Windows platforms
- The Datakit-Lite release compiles only a few collectors; most collectors are not included in its binary

## Startup Issues {#iss-start-fail}

Due to Datakit's adaptation to mainstream OS/Arch types, deployment issues can arise on certain OS distributions. After service installation, the service might be in an abnormal state, preventing Datakit from starting.

### *datakit.conf* Errors {#iss-timestamp}

*datakit.conf* is the main configuration entry for Datakit. If it contains errors (TOML syntax errors), Datakit won’t start, and the Datakit logs will contain similar entries (different syntax errors yield different messages):

```shell
# Manually start the datakit program
$ /usr/local/datakit
2023-11-27T14:17:15.578+0800    INFO    main    datakit/main.go:166     load config from /user/local/datakit/conf.d/datakit.conf...
2023-11-27T14:15:56.519+0800    ERROR   main    datakit/main.go:169     load config failed: bstoml.Decode: toml: line 19 (last key "default_enabled_inputs"): expected value but found "ulimit" instead
```

### Service Abnormalities {#iss-service-fail}

Certain reasons (such as Datakit service startup timeout) can cause the `datakit` service to be in an invalid state. In such cases, you need to [reset the Datakit system service](datakit-service-how-to.md#when-service-failed).

### Continuously Restarting or Not Starting {#iss-restart-notstart}

In Kubernetes, insufficient resources (memory) can lead to Datakit OOM, preventing it from performing specific data collection tasks. Check if the memory allocation in *datakit.yaml* is appropriate:

```yaml
  containers:
  - name: datakit
    image: pubrepo.guance.com/datakit:datakit:<VERSION>
    resources:
      requests:
        memory: "128Mi"
      limits:
        memory: "4Gi"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]
```

Here, the system requires at least (requests) 128MB of memory to start Datakit. If Datakit's own collection tasks are heavy, the default 4GB might not be sufficient, and you need to adjust the `limits` parameter.

### Port Occupied {#iss-port-in-use}

Some Datakit collectors need specific ports locally to receive external data. If these ports are occupied, the corresponding collectors won't start, and you'll see port occupation information in the Datakit logs.

Mainstream collectors affected by ports include:

- HTTP's port 9529: Some collectors (like eBPF/Oracle/LogStream) push data via Datakit's HTTP interface
- StatsD's port 8125: For receiving StatsD metrics (e.g., JVM-related metrics)
- OpenTelemetry's port 4317: For receiving OpenTelemetry metrics and trace data

Refer to [this list](datakit-port.md) for more port occupation details.

### Insufficient Disk Space {#iss-disk-space}

Insufficient disk space can lead to undefined behavior (Datakit's own logs cannot be written/diskcache cannot be written).

### Resource Usage Exceeds Default Settings {#iss-ulimit}

After installing Datakit, the default number of files it can open is 64K (Linux). If a collector (e.g., file log collector) opens too many files, subsequent files won't be opened, affecting collection.

Moreover, opening too many files indicates severe congestion, which may consume excessive memory resources, leading to OOM.

## Collector Configuration-related {#iss-input-config}

Issues related to collector configurations are generally straightforward. The following possibilities exist:

### Target Object Produces No Data {#iss-input-nodata}

For example, with MySQL, some slow queries or lock-related collections only produce data when corresponding issues occur. Otherwise, no data will be visible in the relevant views.

Additionally, for Prometheus-metric-exposing targets, their Prometheus metrics might be disabled by default (or accessible only from localhost). These configurations need to be set on the target object for Datakit to collect the data. Such issues can be verified using the collector debugging feature (`datakit debug --input-conf ...`).

For log collection, if the log file does not generate new logs relative to when Datakit starts, even if the log file already contains log data, no data will be collected.

For Profiling data, the service/application must enable the corresponding functionality for Profiling data to be pushed to Datakit.

### Access Permissions {#iss-permission-deny}

Many middleware collectors require user authentication configurations, which sometimes need settings on the target object. If the username/password configuration is incorrect, Datakit will report errors.

Additionally, since Datakit uses TOML configuration, some password strings need extra escaping (generally URL-Encoded). For instance, if the password contains `@`, it should be converted to `%40`.

> Datakit is gradually optimizing existing password string (connection string) configurations to reduce such escaping.

### Version Issues {#iss-version-na}

Some user environments' software versions might be too old or too new, not supported by Datakit, causing collection issues.

Unsupported versions might still collect data, but we can't test all version numbers. When encountering incompatible/unsupported versions, feedback is needed.

### Collector Bug {#iss-datakit-bug}

Report directly through [Bug Report](why-no-data.md#bug-report).

### Collector Configuration Not Enabled {#iss-no-input}

Since Datakit recognizes only `.conf` files under the *conf.d* directory, misplacing some collector configurations or using the wrong extension can cause Datakit to skip them. Correcting the file location or name resolves this.

### Collector Disabled {#iss-input-disabled}

In Datakit's main configuration, certain collectors can be disabled. Even if correctly configured in *conf.d*, Datakit will ignore these collectors:

```toml
default_enabled_inputs = [
  "-disk",
  "-mme",
]
```

Collectors prefixed with `-` are disabled. Remove the prefix or the item to enable them.

### Invalid Collector Configuration {#iss-invalid-conf}

Datakit collectors use TOML-formatted configuration files. If the configuration file doesn't conform to TOML specifications or the program field definitions (e.g., setting integers as strings), loading failures occur, preventing the collector from starting.

Datakit includes a built-in configuration detection function; refer to [here](datakit-tools-how-to.md#check-conf).

### Incorrect Configuration Method {#iss-config-mistaken}

Collector configurations in Datakit fall into two categories:

- Host Installation: Add corresponding collector configurations directly under the *conf.d* directory.
- Kubernetes Installation:
  - Use ConfigMap to mount collector configurations.
  - Modify via environment variables (if both ConfigMap and environment variables exist, environment variables take precedence).
  - Use Annotations for configuration (Annotations have the highest priority compared to environment variables and ConfigMap).
  - If a collector is specified in the default collector list (`ENV_DEFAULT_ENABLED_INPUTS`) and added again in ConfigMap with the same name and configuration, behavior is undefined, potentially triggering singleton collector issues.

### Singleton Collector {#iss-singleton}

[Singleton collectors](datakit-input-conf.md#input-singleton) can only be enabled once per Datakit. If multiple collectors are enabled, Datakit loads the first one in file order (only the first in the same `.conf` file), ignoring others. This can prevent later collectors from starting.

## Global Configuration-related {#iss-global-settings}

Certain global configurations in Datakit segments can affect collected data. Besides disabling collectors, the following aspects can impact data:

### Blacklist/Pipeline Impact {#iss-pipeline-filter}

Users might configure blacklists on the Guance page to discard data matching certain criteria.

Pipelines themselves also drop data (`drop()`).

Both types of discarding behaviors can be seen in the output of `datakit monitor -V`.

Besides discarding data, Pipelines can modify data, affecting front-end queries, such as cutting time fields, leading to significant time deviations.

### Disk Cache {#iss-diskcache}

Datakit sets up a disk cache mechanism for complex data processing. Due to high processing costs, these data are temporarily cached to disk for peak shaving and then reported later. Refer to [disk cache-related metrics](datakit-metrics.md#metrics) to understand cache conditions.

### Sinker Dataway {#iss-sinker-dataway}

If [Sinker Dataway](../deployment/dataway-sink.md) is enabled, data not matching existing Sinker rules are discarded.

### IO Busy {#iss-io-busy}

Due to bandwidth limitations between Datakit and Dataway, reporting data can be slow, impacting data collection (inability to consume data in time). In such cases, Datakit drops unprocessed metric data and blocks non-metric data, preventing data visibility on the Guance page.

### Dataway Cache {#iss-dataway-cache}

If a network failure occurs between Dataway and the Guance center, Dataway caches Datakit-pushed data. This data might arrive late or eventually be discarded (exceeding disk cache limits).

### Account Issues {#iss-workspace}

If the user's Guance account is overdue or exceeds data usage limits, Datakit data uploads may encounter 4xx issues. These problems can be directly seen in `datakit monitor`.

## Other {#iss-others}

`datakit monitor -V` outputs a lot of status information. Due to resolution issues, some data may not be directly displayed and need scrolling within the corresponding table.

However, certain terminals don't support dragging operations, leading to the mistaken belief that no data is being collected. You can view monitor data by specifying specific modules (indicated by red letters at the top of each table):

```shell
# View HTTP API status
$ datakit monitor -M H

# View collector configurations and collection status
$ datakit monitor -M I

# View basic information and runtime resource usage
$ datakit monitor -M B,R
```

The above outlines basic troubleshooting steps for no data issues. Below introduces some Datakit functionalities used during the troubleshooting process.

## Collect DataKit Runtime Information {#bug-report}

[:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

After various troubleshooting efforts, if the issue remains unresolved, you need to collect various Datakit information (such as logs, configuration files, profiles, and self-metrics). To simplify this process, DataKit provides a command to gather all relevant information and package it into a single file. Usage:

```shell
$ datakit debug --bug-report
...
```

Upon successful execution, a zip file named `info-<timestamp>.zip` is generated in the current directory.

<!-- markdownlint-disable MD046 -->
???+ tip

    - Ensure you collect bug report information while Datakit is running, ideally when the issue occurs (e.g., high memory/CPU usage). With the help of Datakit's own metrics and profile data, we can quickly pinpoint complex issues.

    - By default, the command collects profile data, which might impact Datakit performance. You can disable collecting profiles ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)):

    ```shell
    $ datakit debug --bug-report --disable-profile
    ```

    - If you have public internet access, you can upload the file directly to OSS to avoid cumbersome file copying ([:octicons-tag-24: Version-1.27.0](changelog.md#cl-1.27.0)):

    ```shell hl_lines="7"
    # You *must* provide the correct OSS address/Bucket name and corresponding AS/SK
    $ datakit debug --bug-report --oss OSS_HOST:OSS_BUCKET:OSS_ACCESS_KEY:OSS_SECRET_KEY
    ...
    bug report saved to info-1711794736881.zip
    uploading info-1711794736881.zip...
    download URL(size: 1.394224 M):
        https://OSS_BUCKET.OSS_HOST/datakit-bugreport/2024-03-30/dkbr_co3v2375mqs8u82aa6sg.zip
    ```

    Share the bottom link with us (ensure the OSS file is publicly accessible).

    - By default, the bug report collects Datakit's own metrics three times. Adjust this count using `--nmetrics` ([:octicons-tag-24: Version-1.27.0](changelog.md#cl-1.27.0)):

    ```shell
    $ datakit debug --bug-report --nmetrics 10
    ```
<!-- markdownlint-enable -->

Unpacked file structure:

```not-set
├── basic
│   └── info
├── config
│   ├── container
│   │   └── container.conf.copy
│   ├── datakit.conf.copy
│   ├── db
│   │   ├── kafka.conf.copy
│   │   ├── mysql.conf.copy
│   │   └── sqlserver.conf.copy
│   ├── host
│   │   ├── cpu.conf.copy
│   │   ├── disk.conf.copy
│   │   └── system.conf.copy
│   ├── network
│   │   └── dialtesting.conf.copy
│   ├── profile
│   │   └── profile.conf.copy
│   ├── pythond
│   │   └── pythond.conf.copy
│   └── rum
│       └── rum.conf.copy
├── data
│   └── pull
├── externals
│   └── ebpf
│       ├── datakit-ebpf.log
│       ├── datakit-ebpf.stderr
│       ├── datakit-ebpf.offset
│       └── profile
│           ├── allocs
│           ├── block
│           ├── goroutine
│           ├── heap
│           ├── mutex
│           └── profile
├── metrics 
│   ├── metric-1680513455403 
│   ├── metric-1680513460410
│   └── metric-1680513465416 
├── pipeline
│   ├── local_scripts
│   │   ├── elasticsearch.p.copy
│   │   ├── logging
│   │   │   ├── aaa.p.copy
│   │   │   └── refer.p.copy
│   │   └── tomcat.p.copy
│   └── remote_scripts
│       ├── pull_config.json.copy
│       ├── relation.json.copy
│       └── scripts.tar.gz.copy
├── log
│   ├── gin.log
│   └── log
├── syslog
│   └── syslog-1680513475416
└── profile
    ├── allocs
    ├── heap
    ├── goroutine
    ├── mutex
    ├── block
    └── profile
```

File descriptions:

| File Name          | Is Directory | Description                                                                                                    |
| ---:              | ---:         | ---:                                                                                                           |
| `config`          | Yes          | Configuration files, including main configuration and enabled collector configurations                        |
| `basic`           | Yes          | Operating system and environment variable information                                                         |
| `data`            | Yes          | `.pull` files under the `data` directory                                                                       |
| `log`             | Yes          | Latest log files, including log and gin log (no `stdout` support yet)                                         |
| `profile`         | Yes          | pprof data (enabled by default since [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2))                 |
| `metrics`         | Yes          | Data returned by the `/metrics` endpoint, named as `metric-<timestamp>`                                        |
| `syslog`          | Yes          | Only supports `linux`, based on `journalctl` to retrieve relevant logs                                          |
| `error.log`       | No           | Records errors encountered during command execution                                                            |

### Handling Sensitive Information {#sensitive}

Sensitive information (such as tokens, passwords) is automatically filtered and replaced during collection:

- Environment Variables

Only retrieves environment variables starting with `ENV_` and desensitizes those containing `password`, `token`, `key`, `key_pw`, `secret` by replacing them with `******`

- Configuration Files

Configuration file content is processed with regular expressions, such as:

- `https://openway.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` becomes `https://openway.guance.com?token=******`
- `pass = "1111111"` becomes `pass = "******"`
- `postgres://postgres:123456@localhost/test` becomes `postgres://postgres:******@localhost/test`

Despite these measures, sensitive information might still exist in the exported files. Please manually remove any remaining sensitive information and ensure confirmation.

## Debugging Collector Configurations {#check-input-conf}

[:octicons-tag-24: Version-1.9.0](changelog.md#cl-1.9.0)

You can debug whether collectors can normally collect data using the command line, such as debugging the disk collector:

``` shell
$ datakit debug --input-conf /usr/local/datakit/conf.d/host/disk.conf
loading /usr/local/datakit/conf.d/host/disk.conf with 1 inputs...
running input "disk"(0th)...
disk,device=/dev/disk3s1s1,fstype=apfs free=167050518528i,inodes_free=1631352720i,inodes_free_mb=1631i,inodes_total=1631702195i,inodes_total_mb=1631i,inodes_used=349475i,inodes_used_mb=0i,inodes_used_percent=0.02141781760611041,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064064000
...
# 10 points("M"), 98 time series from disk, cost 1.544792ms | Ctrl+c to exit.
```

This command starts the collector and prints the collected data to the terminal. It shows:

- Number of collected points and their type (here `M` represents time series data)
- Number of time series (only for time series data)
- Collector name (here `disk`)
- Collection duration

Use Ctrl + c to end debugging. To quickly obtain collected data, adjust the collector's collection interval (if applicable).

<!-- markdownlint-disable MD046 -->
???+ tip

    - For collectors that passively receive data (like DDTrace/RUM), specify the HTTP service (`--hppt-listen=[IP:Port]`) and send data to the corresponding Datakit address using HTTP client tools (like `curl`). See `datakit help debug` for details.

    - The debugging configuration can have any extension, not necessarily ending with `.conf`. You can use filenames like `my-input.conf.test` for debugging without affecting Datakit's normal operation.
<!-- markdownlint-enable -->

## Viewing Monitor Page {#monitor}

Refer to [here](datakit-monitor.md)

## Checking Data Generation via DQL {#dql}

Supported on Windows/Linux/Mac, where Windows needs to be executed in PowerShell

> Datakit [1.1.7-rc7](changelog.md#cl-1.1.7-rc7) supports this feature

```shell
$ datakit dql
> Enter DQL query statements here ...
```

For no data troubleshooting, refer to the collector documentation to find the names of relevant measurement sets. Taking the MySQL collector as an example, the current documentation lists several measurement sets:

- `mysql`
- `mysql_schema`
- `mysql_innodb`
- `mysql_table_schema`
- `mysql_user_status`

If the MySQL collector has no data, check if the `mysql` measurement set has data:

``` python
#
# View the latest `mysql` metrics for a specified host (here 'tan-air.local')
#
M::mysql {host='tan-air.local'} order by time desc limit 1
```

Check if a host object has reported data:

```python
O::HOST {host='tan-air.local'}
```

View existing APM (tracing) data classifications:

```python
show_tracing_service()
```

If data is indeed reported, it can always be found via DQL. Whether data is collected by Datakit or other means (like Function), DQL allows you to view raw data directly, facilitating debugging.

## Checking Datakit Program Logs for Abnormalities {#check-log}

Retrieve the last 10 ERROR/WARN level logs via Shell/Powershell

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    $ cat /var/log/datakit/log | grep "WARN\|ERROR" | tail -n 10
    ...
    ```

=== "Windows"

    ```powershell
    PS > Select-String -Path 'C:\Program Files\datakit\log' -Pattern "ERROR", "WARN"  | Select-Object Line -Last 10
    ...
    ```
<!-- markdownlint-enable -->

- If logs mention `Beyond...`, it generally indicates data exceeding the free quota.
- If there are `ERROR/WARN` entries, it usually signifies issues encountered by DataKit.

### Checking Individual Collector Logs {#check-input-log}

If no abnormalities are found, directly check individual collector logs:

```shell
# shell
tail -f /var/log/datakit/log | grep "<collector_name>" | grep "WARN\|ERROR"

# powershell
Get-Content -Path "C:\Program Files\datakit\log" -Wait | Select-String "<collector_name>" | Select-String "ERROR", "WARN"
```

You can also remove the `ERROR/WARN` filter to view the corresponding collector logs. If more logs are needed, enable debug logging in `datakit.conf`:

```toml
# DataKit >= 1.1.8-rc0
[logging]
    ...
    level = "debug" # Change default info to debug
    ...

# DataKit < 1.1.8-rc0
log_level = "debug"
```

### Checking gin.log {#check-gin-log}

For remote data sent to DataKit, check `gin.log` to see if remote data is received:

```shell
tail -f /var/log/datakit/gin.log
```

## Problem Troubleshooting Diagram {#how-to-trouble-shoot}

To facilitate troubleshooting, the following diagram outlines basic troubleshooting steps. Follow the guidance to identify potential issues:

``` mermaid
graph TD
  %% node definitions
  no_data[No Data];
  debug_fail{No Results};
  monitor[Check <a href='https://docs.guance.com/datakit/datakit-monitor/'>Monitor</a>];
  debug_input[Debug <a href='https://docs.guance.com/datakit/why-no-data/#check-input-conf'>Collector Configuration</a>];
  read_faq[Review FAQ in Documentation];
  dql[DQL Query];
  beyond_usage[Is Data Over Quota?];
  pay[Become a Paid User];
  filtered[Is Data Filtered Out by Blacklist?];
  sinked[Is Data Sunk?];
  check_time[Check Machine Time];
  check_token[Check Workspace Token];
  check_version[Check Datakit Version];
  dk_service_ok[Is <a href='https://docs.guance.com/datakit/datakit-service-how-to/'>Datakit Service Normal?</a>];
  check_changelog[Check <a href='https://docs.guance.com/datakit/changelog'>Changelog</a>];
  is_input_ok[Is Collector Running Normally?];
  is_input_enabled[Is Collector Enabled?];
  enable_input[Enable Collector];
  dataway_upload_ok[Is Upload Normal?];
  ligai[Submit <a href='https://ligai.cn/'>Ligai</a> Issue];

  no_data --> dk_service_ok --> check_time --> check_token --> check_version --> check_changelog;

  no_data --> monitor;
  no_data --> debug_input --> debug_fail;
  debug_input --> read_faq;
  no_data --> read_faq --> debug_fail;
  dql --> debug_fail;

  monitor --> beyond_usage -->|No| debug_fail;
  beyond_usage -->|Yes| pay;

  monitor --> is_input_enabled;

  is_input_enabled -->|Yes| is_input_ok;
  is_input_enabled -->|No| enable_input --> debug_input;

  monitor --> is_input_ok -->|No| debug_input;

  is_input_ok -->|Yes| dataway_upload_ok -->|Yes| dql;
  is_input_ok --> filtered --> sinked;

  trouble_shooting[<a href='https://docs.guance.com/datakit/why-no-data/#bug-report'>Collect Information</a>];

  debug_fail --> trouble_shooting;
  trouble_shooting --> ligai;
```