# How to Troubleshoot No Data Issues

---

After deploying Datakit, you typically check the collected data directly from the Guance page. If everything is normal, the data will quickly appear on the page (most directly in the "Infrastructure" section with host/process data). However, due to various reasons, issues can occur during data collection, processing, or transmission, leading to no data being available.

The following sections analyze possible causes of no data:

- [Network Related](why-no-data.md#iss-network)
- [Host Related](why-no-data.md#iss-host)
- [Startup Issues](why-no-data.md#iss-start-fail)
- [Collector Configuration](why-no-data.md#iss-input-config)
- [Global Configuration](why-no-data.md#iss-global-settings)
- [Others](why-no-data.md#iss-others)

## Network Related {#iss-network}

Network-related issues are relatively straightforward and common. They can also be diagnosed using other methods (`ping/nc/curl` commands).

### Target Object Unreachable {#iss-input-connect}

Since Datakit is installed on specific machines/Nodes, when it collects certain data, network issues may prevent access to the target object (e.g., MySQL/Redis). Debugging the collector can help identify the problem:

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

A status code of 404 indicates a successful connection to Dataway.

For SaaS, the Dataway address is `https://openway.guance.com`.

If you get the following result, there is a network issue:

```shell
curl: (6) Could not resolve host: openway.guance.com
```

If similar error logs are found in the Datakit logs (`/var/log/datakit/log`), it indicates that the environment has connectivity issues with Dataway, possibly due to firewall restrictions:

```shell
request url https://openway.guance.com/v1/write/xxx/token=tkn_xxx failed:  ... context deadline exceeded...
```

## Host Related {#iss-host}

Host-related issues are often subtle and difficult to diagnose, especially lower-level problems. Here’s an overview:

### Timestamp Anomalies {#iss-timestamp}

On Linux/Mac, enter `date` to view the current system time:

```shell
$ date
Wed Jul 21 16:22:32 CST 2021
```

Sometimes it might show:

```shell
$ date
Wed Jul 21 08:22:32 UTC 2021
```

The former is China Standard Time (UTC+8), while the latter is Greenwich Mean Time (UTC). Both timestamps are identical but differ by 8 hours. If the system time significantly differs from your phone's time, especially if it's ahead, future data won't be visible in Guance.

If the time lags, the default Explorer in Guance won’t display this data (usually showing only the last 15 minutes). Adjust the time range in the Explorer.

### Unsupported Host Hardware/Software {#iss-os-arch}

Some collectors are unsupported on certain platforms and will not collect data even if configured:

- macOS lacks a CPU collector
- Collectors like Oracle/DB2/OceanBase/eBPF run only on Linux
- Some Windows-specific collectors don’t work on non-Windows platforms
- Datakit-Lite only compiles a few collectors into its binary

## Startup Issues {#iss-start-fail}

Datakit supports mainstream OS/Arch types, but deployment issues can still arise on certain OS versions, causing abnormal service states and preventing Datakit from starting.

### *datakit.conf* Errors {#iss-timestamp}

*datakit.conf* is the main configuration entry for Datakit. If it contains errors (invalid TOML syntax), Datakit won’t start. Similar logs will appear in the Datakit logs (different syntax errors produce different messages):

```shell
# Manually start the datakit program
$ /usr/local/datakit
2023-11-27T14:17:15.578+0800    INFO    main    datakit/main.go:166     load config from /user/local/datakit/conf.d/datakit.conf...
2023-11-27T14:15:56.519+0800    ERROR   main    datakit/main.go:169     load config failed: bstoml.Decode: toml: line 19 (last key "default_enabled_inputs"): expected value but found "ulimit" instead
```

### Service Abnormalities {#iss-service-fail}

Service startup timeouts or other issues can cause the `datakit` service to be in an invalid state. Follow [these steps to reset the Datakit system service](datakit-service-how-to.md#when-service-failed).

### Constant Restarts or Failures to Start {#iss-restart-notstart}

In Kubernetes, insufficient resources (memory) can lead to Datakit OOM, preventing data collection. Check if the memory resources allocated in *datakit.yaml* are sufficient:

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

Here, at least 128MB (`requests`) of memory is required to start Datakit. If Datakit’s tasks are resource-intensive, the default 4GB limit might be insufficient; adjust the `limits` parameter accordingly.

### Port Conflicts {#iss-port-in-use}

Some Datakit collectors need specific local ports to receive external data. If these ports are occupied, the corresponding collectors won’t start. Logs will indicate port conflicts.

Common collectors affected by port usage include:

- HTTP port 9529: Collectors like eBPF/Oracle/LogStream push data via Datakit’s HTTP interface
- StatsD port 8125: Receives StatsD metrics (e.g., JVM metrics)
- OpenTelemetry port 4317: Receives OpenTelemetry metrics and Trace data

Refer to [this list](datakit-port.md) for more details.

### Insufficient Disk Space {#iss-disk-space}

Insufficient disk space can lead to undefined behavior (Datakit logs unable to write/diskcache failure).

### Resource Limits Exceeded {#iss-ulimit}

Post-installation, Datakit defaults to opening 64K files (Linux). If a collector (like file log collection) opens too many files, subsequent files won’t be accessible, impacting collection.

Excessive open files indicate severe congestion, potentially consuming too much memory and causing OOM.

## Collector Configuration {#iss-input-config}

Collector configuration issues are usually straightforward. Common causes include:

### No Data Produced by Target Object {#iss-input-nodata}

For example, MySQL slow queries or lock-related collections require actual occurrences to generate data. Prometheus metrics exposed by targets might be disabled by default or accessible only locally. These configurations need adjustment on the target object for Datakit to collect data. Use the debugging feature (`datakit debug --input-conf ...`) to verify.

For log collection, if the log file doesn’t have new entries post Datakit startup, no data will be collected.

For Profiling data, the service/application must enable the corresponding feature for Profiling data to reach Datakit.

### Access Permissions {#iss-permission-deny}

Many middleware collectors require user authentication. Incorrect credentials will cause Datakit to report errors. Passwords in TOML configurations sometimes need URL-encoding (e.g., `@` becomes `%40`).

> Datakit is optimizing password string (connection string) configurations to reduce such encoding needs.

### Version Incompatibility {#iss-version-na}

Old or new software versions outside Datakit’s support list can cause collection issues. Unsupported versions should be reported.

### Collector Bugs {#iss-datakit-bug}

Submit a [Bug Report](why-no-data.md#bug-report).

### Misconfigured Collectors {#iss-no-input}

Datakit recognizes `.conf` files in the *conf.d* directory. Misplaced or incorrectly named files will be ignored. Correct the file location or name.

### Disabled Collectors {#iss-input-disabled}

In the main Datakit configuration, some collectors can be disabled:

```toml
default_enabled_inputs = [
  "-disk",
  "-mme",
]
```

Collectors prefixed with `-` are disabled. Remove the prefix or the item.

### Invalid Configuration {#iss-invalid-conf}

Invalid TOML syntax or incorrect data types in configuration files can prevent collectors from starting. Refer to [configuration checks](datakit-tools-how-to.md#check-conf).

### Misconfigured Methods {#iss-config-mistaken}

Collector configurations fall into two categories:

- Host installation: Add collector configurations directly in the *conf.d* directory.
- Kubernetes installation:

    - Use ConfigMap to mount configurations.
    - Modify via environment variables (higher priority than ConfigMap).
    - Use Annotations (highest priority).

If both default and ConfigMap configurations specify the same collector, behavior is undefined and may trigger singleton issues.

### Singleton Collectors {#iss-singleton}

[Singleton collectors](datakit-input-conf.md#input-singleton) can only be enabled once per Datakit instance. If multiple instances are specified, Datakit loads the first one alphabetically, ignoring others.

## Global Configuration {#iss-global-settings}

Certain global configurations can affect data collection beyond disabling collectors.

### Blacklist/Pipeline Filters {#iss-pipeline-filter}

Users may configure blacklists in the Guance page to discard data matching certain criteria. Pipelines can also drop data (`drop()`).

These behaviors can be observed in `datakit monitor -V`.

Pipelines can modify data, affecting front-end queries, such as time field slicing leading to significant time discrepancies.

### Disk Cache {#iss-diskcache}

Datakit uses disk caching for complex data processing. This temporarily caches data for peak handling, delaying reporting. Review [disk cache metrics](datakit-metrics.md#metrics) to understand cache status.

### Sinker Dataway {#iss-sinker-dataway}

If [Sinker Dataway](../deployment/dataway-sink.md) is enabled, data not matching rules will be discarded.

### IO Busy {#iss-io-busy}

Bandwidth limitations between Datakit and Dataway can delay data uploads, affecting collection speed. In such cases, Datakit drops metrics and blocks other data, preventing data visibility in Guance.

### Dataway Cache {#iss-dataway-cache}

Network issues between Dataway and Guance can cause Dataway to cache Datakit data, which may be delayed or ultimately dropped if exceeding disk cache limits.

### Account Issues {#iss-workspace}

If the Guance account is overdue or exceeds data quotas, Datakit data uploads may return 4xx errors. These issues are visible in `datakit monitor`.

## Other Issues {#iss-others}

`datakit monitor -V` outputs extensive status information. Due to resolution issues, some data isn’t immediately visible and requires scrolling within tables.

However, some terminals do not support drag-and-drop operations, leading to misinterpretations of missing data. Use specific modules (indicated by red letters in table headers) to view monitor output:

```shell
# View HTTP API status
$ datakit monitor -M H

# View collector configurations and collection status
$ datakit monitor -M I

# View basic information and runtime resource usage
$ datakit monitor -M B,R
```

These are basic troubleshooting steps for no data issues. Below are some Datakit features and methods used during troubleshooting.

## Collecting DataKit Runtime Information {#bug-report}

[:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

After various troubleshooting attempts, if the issue remains unresolved, we need to collect Datakit information (logs, configuration files, profiles, and internal metrics). To simplify this process, DataKit provides a command to gather all relevant information into a single zip file. Usage:

```shell
$ datakit debug --bug-report
...
```

Successful execution generates a zip file named `info-<timestamp>.zip` in the current directory.

<!-- markdownlint-disable MD046 -->
???+ tip

    - Ensure bug report collection occurs while Datakit is running, ideally during issues (e.g., high memory/CPU usage). With Datakit metrics and profile data, we can quickly pinpoint complex issues.


    - By default, the command collects profile data, which may impact performance. Disable profile collection with ([:octicons-tag-24: Version-1.15.0](changelog.md#cl-1.15.0)):
    
    ```shell
    $ datakit debug --bug-report --disable-profile
    ```
    
    - If public internet access is available, upload directly to OSS to avoid cumbersome file copying ([:octicons-tag-24: Version-1.27.0](changelog.md#cl-1.27.0)):
    
    ```shell hl_lines="7"
    # Must provide correct OSS address/Bucket name and corresponding AS/SK
    $ datakit debug --bug-report --oss OSS_HOST:OSS_BUCKET:OSS_ACCESS_KEY:OSS_SECRET_KEY
    ...
    bug report saved to info-1711794736881.zip
    uploading info-1711794736881.zip...
    download URL(size: 1.394224 M):
        https://OSS_BUCKET.OSS_HOST/datakit-bugreport/2024-03-30/dkbr_co3v2375mqs8u82aa6sg.zip
    ```

    Provide the download link (ensure the OSS file is publicly accessible).

    - By default, bug report collects 3 sets of Datakit metrics. Adjust with `--nmetrics` ([:octicons-tag-24: Version-1.27.0](changelog.md#cl-1.27.0)):
    
    ```shell
    $ datakit debug --bug-report --nmetrics 10
    ```
<!-- markdownlint-enable -->

Unzipped file structure:

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

| File Name       | Directory? | Description                                                                                                    |
| ---:          | ---:     | ---:                                                                                                    |
| `config`      | Yes       | Configuration files, including main configuration and enabled collector configurations                                          |
| `basic`       | Yes       | Operating system and environment variable information                                                                                  |
| `data`        | Yes       | Blacklist files under the `data` directory, i.e., `.pull` files                                                                                |
| `log`         | Yes       | Latest log files, including log and gin log, does not support `stdout`                                                  |
| `profile`     | Yes       | pprof data ([:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) already enabled by default)                                      |
| `metrics`     | Yes       | Data returned by the `/metrics` endpoint, named as `metric-<timestamp>`                                           |
| `syslog`      | Yes       | Only supported on `linux`, based on `journalctl` to fetch related logs                                                        |
| `error.log`   | No       | Records errors during command execution |

### Sensitive Information Handling {#sensitive}

Sensitive information (tokens, passwords, etc.) is automatically filtered. Rules:

- Environment Variables

Only retrieves variables starting with `ENV_`. Variables containing `password`, `token`, `key`, `key_pw`, `secret` are masked as `******`.

- Configuration Files

Content is replaced using regex:

- `https://openway.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` → `https://openway.guance.com?token=******`
- `pass = "1111111"` → `pass = "******"`
- `postgres://postgres:123456@localhost/test` → `postgres://postgres:******@localhost/test`

Despite filtering, exported files may still contain sensitive information. Please manually review and remove any sensitive data.

## Debugging Collector Configurations {#check-input-conf}

[:octicons-tag-24: Version-1.9.0](changelog.md#cl-1.9.0)

Use the command line to debug whether collectors can collect data normally, e.g., debugging the disk collector:

``` shell
$ datakit debug --input-conf /usr/local/datakit/conf.d/host/disk.conf
loading /usr/local/datakit/conf.d/host/disk.conf with 1 inputs...
running input "disk"(0th)...
disk,device=/dev/disk3s1s1,fstype=apfs free=167050518528i,inodes_free=1631352720i,inodes_free_mb=1631i,inodes_total=1631702195i,inodes_total_mb=1631i,inodes_used=349475i,inodes_used_mb=0i,inodes_used_percent=0.02141781760611041,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064064000
...
# 10 points("M"), 98 time series from disk, cost 1.544792ms | Ctrl+c to exit.
```

This command starts the collector and prints collected data to the terminal. The footer shows:

- Number of collected points and type (`M` indicates time series data)
- Number of time series (for time series data only)
- Collector name (`disk`)
- Collection duration

Press Ctrl + c to end debugging. Adjust the collector’s collection interval for faster results.

<!-- markdownlint-disable MD046 -->
???+ tip

    - For passive collectors (like DDTrace/RUM), specify HTTP service (`--hppt-listen=[IP:Port]`) and use HTTP clients (like `curl`) to send data. See `datakit help debug` for more.

    - Debug configurations can have any extension, not necessarily `.conf`. Use names like *my-input.conf.test* for debugging without affecting Datakit operation.
<!-- markdownlint-enable -->

## Viewing the Monitor Page {#monitor}

Refer to [here](datakit-monitor.md)

## Checking Data via DQL {#dql}

Supported on Windows/Linux/Mac, use PowerShell on Windows.

> Datakit [1.1.7-rc7](changelog.md#cl-1.1.7-rc7) added this feature.

```shell
$ datakit dql
> Enter DQL query statements here ...
```

For no data issues, refer to collector documentation to find corresponding metric sets. For the MySQL collector:

- `mysql`
- `mysql_schema`
- `mysql_innodb`
- `mysql_table_schema`
- `mysql_user_status`

Check if the `mysql` metric set has data:

``` python
#
# Query the latest `mysql` metric from the specified host (`tan-air.local`)
#
M::mysql {host='tan-air.local'} order by time desc limit 1
```

Check if a host reports data:

```python
O::HOST {host='tan-air.local'}
```

Check existing APM (tracing) data categories:

```python
show_tracing_service()
```

If data is indeed reported, DQL can help locate it. Any data collected by Datakit or other means (like Function) can be viewed directly, aiding in debugging.

## Checking Datakit Program Logs for Anomalies {#check-log}

Retrieve the last 10 ERROR/WARN logs via Shell/Powershell.

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

- Descriptions like `Beyond...` usually indicate exceeding free quota.
- `ERROR/WARN` messages generally indicate issues.

### Checking Individual Collector Logs {#check-input-log}

If no anomalies are found, check individual collector logs:

```shell
# shell
tail -f /var/log/datakit/log | grep "<collector_name>" | grep "WARN\|ERROR"

# powershell
Get-Content -Path "C:\Program Files\datakit\log" -Wait | Select-String "<collector_name>" | Select-String "ERROR", "WARN"
```

Remove `ERROR/WARN` filters to see all logs. Increase verbosity by setting debug level in `datakit.conf`:

```toml
# DataKit >= 1.1.8-rc0
[logging]
    ...
    level = "debug" # Change from info to debug
    ...

# DataKit < 1.1.8-rc0
log_level = "debug"
```

### Checking gin.log {#check-gin-log}

For remote data submissions to Datakit, check `gin.log` for incoming data:

```shell
tail -f /var/log/datakit/gin.log
```

## Troubleshooting Flowchart {#how-to-trouble-shoot}

To assist with troubleshooting, the following flowchart outlines basic steps:

``` mermaid
graph TD
  %% node definitions
  no_data[No Data];
  debug_fail{No Result};
  monitor[View <a href='https://docs.guance.com/datakit/datakit-monitor/'>Monitor</a>];
  debug_input[<a href='https://docs.guance.com/datakit/why-no-data/#check-input-conf'>Debug Collector Configuration</a>];
  read_faq[Review FAQ];
  dql[DQL Query];
  beyond_usage[Is Data Over Quota?];
  pay[Become a Paid User];
  filtered[Is Data Filtered Out?];
  sinked[Is Data Sunk?];
  check_time[Check Machine Time];
  check_token[Check Workspace Token];
  check_version[Check Datakit Version];
  dk_service_ok[<a href='https://docs.guance.com/datakit/datakit-service-how-to/'>Is Datakit Service Normal?</a>];
  check_changelog[<a href='https://docs.guance.com/datakit/changelog'>Check Changelog for Fixes</a>];
  is_input_ok[Is Collector Running Normally?];
  is_input_enabled[Is Collector Enabled?];
  enable_input[Enable Collector];
  dataway_upload_ok[Is Upload Normal?];
  ligai[Submit Issue to <a href='https://ligai.cn/'>Ligai</a>];

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
