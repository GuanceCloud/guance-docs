# View Datakit's Monitor
---

Datakit provides relatively comprehensive basic observability information output. By viewing Datakit’s monitor output, we can clearly understand the current operational status of Datakit.

## View Monitor {#view}

Execute the following command to obtain the operational status of the local Datakit.

``` shell
datakit monitor
```

<!-- markdownlint-disable MD046 -->
???+ tip

    You can view more monitor options via `datakit help monitor`.
<!-- markdownlint-enable -->

The basic Monitor page information for Datakit is shown in the figure below:

![not-set](https://static.guance.com/images/datakit/monitor-basic-v1.png)

Elements in this diagram can be operated using a mouse or keyboard. The block selected by the mouse will be highlighted with double borders (as shown in the `Basic Info` block in the upper left corner of the above image). Additionally, you can browse using the mouse scroll wheel or the up/down arrow keys on the keyboard (or vim's J/K).

Each UI block in the above image contains the following information:

- `Basic Info` displays basic information about Datakit, such as version number, hostname, runtime duration, etc. From here, we can get a basic understanding of the current state of Datakit. Here are a few fields explained separately:
    - `Uptime`: Datakit’s startup time
    - `Version`: Current version number of Datakit
    - `Build`: Release time of Datakit
    - `Branch`: Current code branch of Datakit, usually `master`
    - `Build Tag`: Compilation options for Datakit, [Lite Edition](datakit-install.md#lite-install) shows `lite`
    - `OS/Arch`: Current software and hardware platform of Datakit
    - `Hostname`: Current hostname
    - `Resource Limit`: Displays the current resource limit configuration of Datakit, where `mem` refers to the maximum memory limit, and `cpu` refers to the usage rate limit range (if displayed as `-`, it means that the current cgroup is not set)
    - `Elected`: Displays election status, see [here](election.md#status)
    - `From`: The address of the Datakit currently being monitored, such as `http://localhost:9529/metrics`
    - `Proxy`: The proxy server currently in use

- `Runtime Info` displays basic runtime consumption of Datakit (mainly memory, CPU, and Golang runtime), including:

    - `Goroutines`: The number of Goroutines currently running
    - `Total/Heap`: Memory used by the Golang VM and the memory currently in use (*excluding external collectors*)[^go-mem]
    - `RSS/VMS`: RSS memory usage and VMS (*excluding external collectors*)
    - `GC Paused`: Time and frequency consumed by GC (garbage collection) since Datakit started
    - `OpenFiles`: Number of currently open files (may show as `-1` on some platforms, indicating that the feature is unsupported)

[^go-mem]: For more information on Runtime Info, refer to the [Golang official documentation](https://pkg.go.dev/runtime#ReadMemStats){:target="_blank"}

- `Enabled Inputs` displays the list of enabled collectors, including:

    - `Input`: Refers to the collector name, which is fixed and cannot be modified
    - `Count`: Refers to the number of instances of this collector that are enabled
    - `Crashed`: Refers to the number of times this collector has crashed

- `Inputs Info`: Displays the collection status of each collector. There is a lot of information here, broken down as follows:
    - `Input`: Refers to the collector name. In some cases, this name is customized by the collector (e.g., Log collector/Prom collector)
    - `Cat`: Refers to the type of data collected by the collector (M(Metrics)/L(Logs)/O(Object)...)
    - `Feeds`: Refers to the number of times the collector has updated data (collected) since startup
    - `P90Lat`: Refers to the blocking duration (P90) when reporting data points; if the time is longer, it indicates slower data transmission [:octicons-tag-24: Version-1.36.0](../datakit/changelog.md#cl-1.36.0)
    - `P90Pts`: Number of points collected by the collector (P90) [:octicons-tag-24: Version-1.36.0](../datakit/changelog.md#cl-1.36.0)
    - `Filtered`: Number of points filtered out by the blacklist
    - `Last Feed`: Last time data was updated (collected) relative to the current time
    - `Avg Cost`: Average cost per collection
    - `Errors`: Number of collection errors (not displayed if there are none)

- The bottom text prompt informs how to exit the current Monitor program and shows the current Monitor refresh frequency.

---

If the verbose option (`-V`) is specified when running Monitor, additional information will be output, as shown in the figure below:

![not-set](https://static.guance.com/images/datakit/monitor-verbose-v1.png)

- `Goroutine Groups` displays the Goroutine groups present in Datakit (the number of Goroutines in these groups <= the number of `Goroutines` in the panel above)
- `HTTP APIs` displays the API call situation in Datakit
- `Filter` displays the blacklisting filter rules pull status in Datakit
- `Filter Rules` displays the filtering status for each type of blacklist
- `Pipeline Info` displays the Pipeline runtime status
- `WAL Info` displays the usage status of the WAL queue [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    The WAL queue consists of two parts: a small memory queue and a default 2GB disk queue. Here, `mem` refers to the number of points processed by the memory queue, `disk` refers to the number of points processed by the disk queue, and `drop` refers to the number of points discarded by the disk queue (e.g., when the disk queue is full). Total refers to the total number of points.

- `Point Upload Info` displays the runtime status of the data upload channel [^point-upload-info-on-160]
- `DataWay APIs` displays the call status of the Dataway API

[^point-upload-info-on-160]: [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) updates this section; previous versions may have slightly different displays here.

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to display the operational status of a specific Datakit module? {#specify-module}
<!-- markdownlint-enable -->

You can specify a list of module names (multiple modules separated by English commas): [:octicons-tag-24: Version-1.5.7](changelog.md#cl-1.5.7)

```shell
datakit monitor -M inputs,filter
# or
datakit monitor --module inputs,filter

# Also, you can use abbreviations of module names
datakit monitor -M in,f
```

### :material-chat-question: How to display the operational status of specific collectors? {#specify-inputs}

You can specify a list of collector names (multiple collectors separated by English commas):

```shell
datakit monitor -I cpu,mem
# or
datakit monitor --input cpu,mem
```

### :material-chat-question: How to display too long texts? {#too-long}

When certain collectors generate error messages, they can be very long and not fully displayed in the table. You can set the column width to display complete information:

```shell
datakit monitor -W 1024
# or
datakit monitor --max-table-width 1024
```

### :material-chat-question: How to change the Monitor refresh frequency? {#freq}

You can change the refresh frequency by setting it:

```shell
datakit monitor -R 1s
# or
datakit monitor --refresh 1s
```

<!-- markdownlint-disable MD046 -->
???+ info

    Note the units here must be one of the following: s (seconds), m (minutes), h (hours). If the time range is less than 1s, it will refresh at 1s intervals.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to monitor other Datakits? {#remote-monitor}
<!-- markdownlint-enable -->

You can specify the Datakit address to view its monitor data:

```shell
datakit monitor --to <remote-ip>:9529
```

<!-- markdownlint-disable MD046 -->
???+ info

    By default, monitor data cannot be accessed from non-localhost addresses. You can [manually add it to the API whitelist](datakit-conf.md#public-apis).
<!-- markdownlint-enable -->