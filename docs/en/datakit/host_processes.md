
# Process
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The process collector can monitor various running processes in the system, acquire and analyze various metrics when the process is running, Including memory utilization rate, CPU time occupied, current state of the process, port of process monitoring, etc. According to various index information of process running, users can configure relevant alarms in Guance Cloud, so that users can know the state of the process, and maintain the failed process in time when the process fails.

???+ attention

    Process collectors (whether objects or metrics) may consume a lot on macOS, causing CPU to soar, so you can turn them off manually. At present, the default collector still turns on the process object collector (it runs once every 5min by default).

## Preconditions {#requirements}

- The process collector does not collect process metrics by default. To collect metrics-related data, set `open_metric` to `true` in `host_processes.conf`. For example:
                              
```toml
[[inputs.host_processes]]
	...
	 open_metric = true
```

## Configuration {#config}

=== "Host Installation"

    Go into the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and name it `host_processes.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.host_processes]]
      # Only collect these matched process' metrics. For process objects
      # these white list not applied. Process name support regexp.
      # process_name = [".*nginx.*", ".*mysql.*"]
    
      # Process minimal run time(default 10m)
      # If process running time less than the setting, we ignore it(both for metric and object)
      min_run_time = "10m"
    
      ## Enable process metric collecting
      open_metric = false
    
      # Extra tags
      [inputs.host_processes.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    It supports modifying configuration parameters as environment variables (effective only when the DataKit is running in K8s daemonset mode, which is not supported for host-deployed DataKits):
    
    | Environment Variable Name                              | Corresponding Configuration Parameter Item | Parameter Example                                                     |
    | :---                                    | ---              | ---                                                          |
    | `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`  | `open_metric`    | `true`/`false`                                               |
    | `ENV_INPUT_HOST_PROCESSES_TAGS`         | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
    | `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME` | `process_name`   | `".*datakit.*", "guance"` 以英文逗号隔开                     |
    | `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME` | `min_run_time`   | `"10m"`                                                      |

## Measurement {#measurement}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.host_processes.tags]`:

``` toml
 [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Metrics {#metrics}





#### `host_processes`

Collect process metric data, including cpu memory utilization rate, etc.

- Tag


| Tag Name | Description    |
|  ----  | --------|
|`host`|Hostname|
|`pid`|Process id|
|`process_name`|Process name|
|`username`|User name|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|The percentage of CPU used (%*100), the percentage of CPU the process has taken ==since startup==, which will be relatively stable (==different from the instantaneous percentage of top==)|float|percent|
|`cpu_usage_top`|CPU usage percentage (%*100), the average CPU usage of a process in a collection cycle|float|percent|
|`mem_used_percent`|mem usage(%*100)|float|percent|
|`open_files`|Number of open_files (linux only)|int|count|
|`rss`|Resident set size (memory resident size)|int|B|
|`threads`|Number of threads|int|count|








### Objects {#objects}









#### `host_processes`

Collect data of process object, including process name, cmd, etc.

- Tag


| Tag Name | Description    |
|  ----  | --------|
|`class`|Classification: host_processes|
|`host`|Hostname|
|`listen_ports`|The port on which the process is listening|
|`name`|The name field, consisting of host_pid|
|`process_name`|Process name|
|`state`|Process state, windows is not supported for the time being|
|`username`|User name|

- Field List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`cmdline`|Command line arguments for a process|string|-|
|`cpu_usage`|The percentage of CPU used (% * 100), the percentage of CPU the process has taken ==since startup==, which will be relatively stable (==different from the instantaneous percentage of top==)|float|percent|
|`cpu_usage_top`|CPU Usage Percentage (%*100), the average CPU usage of a process in a collection cycle|float|percent|
|`mem_used_percent`|mem usage (%*100)|float|percent|
|`message`|Process details|string|-|
|`open_files`|Number of open_files (linux only)|int|count|
|`open_files_list`|List of files opened by the process and their descriptors (linux only)|string|-|
|`pid`|process id|int|-|
|`rss`|Resident Set Size (memory resident size)|int|B|
|`start_time`|Process startup time|int|msec|
|`state_zombie`|Is it a zombie process|bool|-|
|`threads`|Number of threads|int|count|
|`work_directory`|Working directory (linux only)|string|-|



