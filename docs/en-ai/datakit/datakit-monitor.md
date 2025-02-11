# View Datakit's Monitor
---

Datakit provides relatively comprehensive basic observability information output. By viewing the monitor output of Datakit, we can clearly understand the current running status of Datakit.

## View Monitor {#view}

Execute the following command to obtain the runtime status of the local Datakit.

``` shell
datakit monitor
```

<!-- markdownlint-disable MD046 -->
???+ tip

    You can view more monitor options via `datakit help monitor`.
<!-- markdownlint-enable -->

The basic Monitor page information for Datakit is shown in the following figure:

![not-set](https://static.guance.com/images/datakit/monitor-basic-v1.png)

Elements in this image can be manipulated using the mouse or keyboard. The selected block will be highlighted with a double border (as shown in the `Basic Info` block in the upper-left corner of the above image). Additionally, you can browse using the mouse scroll wheel or the up/down arrow keys on the keyboard (or vim's J/K).

Each UI block in the above image contains the following information:

- `Basic Info` displays basic information about Datakit, such as version number, hostname, uptime, etc. From here, we can get a basic understanding of the current status of Datakit. Selected fields are explained individually:
    - `Uptime`: Start time of Datakit
    - `Version`: Current version of Datakit
    - `Build`: Release time of Datakit
    - `Branch`: Current code branch of Datakit, which is usually master
    - `Build Tag`: Build options for Datakit, [Lite Edition](datakit-install.md#lite-install) shows `lite`
    - `OS/Arch`: Current hardware and software platform of Datakit
    - `Hostname`: Current hostname
    - `Resource Limit`: Displays resource limit settings for the current Datakit, where `mem` indicates maximum memory limit, and `cpu` indicates usage limits (if displayed as `-`, it means cgroup is not set)
    - `Elected`: Shows election status, see [here](election.md#status)
    - `From`: Address of the currently monitored Datakit, such as `http://localhost:9529/metrics`
    - `Proxy`: Currently used proxy server

- `Runtime Info` displays basic runtime consumption of Datakit (mainly memory, CPU, and Golang runtime), including:

    - `Goroutines`: Number of currently running Goroutines
    - `Total/Heap`: Memory used by the Golang VM and the memory being used (excluding external collectors)[^go-mem]
    - `RSS/VMS`: RSS memory usage and VMS (excluding external collectors)
    - `GC Paused`: Time and frequency of garbage collection since Datakit started
    - `OpenFiles`: Number of currently open files (may show `-1` on some platforms, indicating that this feature is unsupported)

[^go-mem]: For details on Runtime Info, refer to the [Golang official documentation](https://pkg.go.dev/runtime#ReadMemStats){:target="_blank"}

- `Enabled Inputs` lists enabled collectors, including:

    - `Input`: Collector name, which is fixed and cannot be modified
    - `Count`: Number of instances of this collector
    - `Crashed`: Number of crashes for this collector

- `Inputs Info`: Displays detailed information about each collector, which includes:
    - `Input`: Collector name. In certain cases, this name is customized by the collector (e.g., Log collector/Prom collector)
    - `Cat`: Type of data collected by the collector (M(Metrics)/L(Logs)/O(Object)...)
    - `Feeds`: Number of updates (collections) since startup
    - `P90Lat`: Blocking duration (P90) when reporting data points; longer times indicate slower data transmission [:octicons-tag-24: Version-1.36.0](../datakit/changelog.md#cl-1.36.0)
    - `P90Pts`: Number of points collected (P90) [:octicons-tag-24: Version-1.36.0](../datakit/changelog.md#cl-1.36.0)
    - `Filtered`: Number of points filtered out by blacklists
    - `Last Feed`: Last update time (relative to the current time)
    - `Avg Cost`: Average cost per collection
    - `Errors`: Number of collection errors (not shown if there are none)

- The bottom prompt text informs how to exit the current Monitor program and shows the current Monitor refresh rate.

---

If the verbose option (`-V`) is specified when running Monitor, additional information will be output, as shown in the following figure:

![not-set](https://static.guance.com/images/datakit/monitor-verbose-v1.png)

- `Goroutine Groups` displays Goroutine groups in Datakit (the number of Goroutines in these groups ≤ the number of `Goroutines` in the panel above)
- `HTTP APIs` displays API call situations in Datakit
- `Filter` displays the status of blacklist filter rule pulls in Datakit
- `Filter Rules` displays filtering conditions for each type of blacklist
- `Pipeline Info` displays Pipeline operation status
- `WAL Info` displays WAL queue usage [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    The WAL queue consists of a small memory queue and a default 2GB disk queue. Here, `mem` refers to the number of points processed by the memory queue, `disk` refers to the number of points processed by the disk queue, and `drop` refers to the number of points discarded by the disk queue (e.g., when the disk queue is full). Total refers to the total number of points.

- `Point Upload Info` displays the operation status of the data upload channel [^point-upload-info-on-160]
- `DataWay APIs` displays the call status of Dataway APIs

[^point-upload-info-on-160]: [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) updated this section; previous versions had slightly different displays.

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to display the runtime status of a specific Datakit module? {#specify-module}
<!-- markdownlint-enable -->

You can specify a list of module names (separated by commas): [:octicons-tag-24: Version-1.5.7](changelog.md#cl-1.5.7)

```shell
datakit monitor -M inputs,filter
# or
datakit monitor --module inputs,filter

# Shortened module names can also be used
datakit monitor -M in,f
```

### :material-chat-question: How to display the runtime status of specific collectors? {#specify-inputs}

You can specify a list of collector names (separated by commas):

```shell
datakit monitor -I cpu,mem
# or
datakit monitor --input cpu,mem
```

### :material-chat-question: How to display too long text? {#too-long}

When certain collectors generate error messages, they may be very long and not fully visible in table format. You can adjust the column width to display complete information:

```shell
datakit monitor -W 1024
# or
datakit monitor --max-table-width 1024
```

### :material-chat-question: How to change the Monitor refresh frequency? {#freq}

You can change the refresh frequency:

```shell
datakit monitor -R 1s
# or
datakit monitor --refresh 1s
```

<!-- markdownlint-disable MD046 -->
???+ info

    Note the units here must be one of the following: s (seconds)/m (minutes)/h (hours). If the time range is less than 1s, it will refresh at 1s intervals.
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD013 -->
### :material-chat-question: How to Monitor other Datakits? {#remote-monitor}
<!-- markdownlint-enable -->

You can specify the Datakit address to view its monitor data:

```shell
datakit monitor --to <remote-ip>:9529
```

<!-- markdownlint-disable MD046 -->
???+ info

    By default, monitor data cannot be accessed from non-localhost addresses. You can [manually add it to the API whitelist](datakit-conf.md#public-apis).
<!-- markdownlint-enable -->