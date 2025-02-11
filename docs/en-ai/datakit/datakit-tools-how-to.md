# Various Other Tool Usages
---

DataKit comes with many different tools built-in for daily use. You can view the command-line help for DataKit using the following command:

```shell
datakit help
```

> Note: Due to differences between platforms, the specific help content may vary.

If you want to check how a specific command is used (for example, `dql`), you can use the following command:

```shell
$ datakit help dql
usage: datakit dql [options]

DQL is used to query data. If no option is specified, it queries interactively. Other available options:

      --auto-json      pretty output string if field/tag value is JSON
      --csv string     Specify the directory
  -F, --force          overwrite CSV if file exists
  -H, --host string    specify DataKit host to query
  -J, --json           output in JSON format
      --log string     log path (default "/dev/null")
  -R, --run string     run single DQL
  -T, --token string   run query for specific token(workspace)
  -V, --verbose        verbosity mode
```

## Data Recording and Replay {#record-and-replay}

[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0)

Data import is mainly used to input existing collected data. When demonstrating or testing, additional data collection is not required.

### Enable Data Recording {#enable-recorder}

In *datakit.conf*, you can enable the data recording feature. Once enabled, DataKit will record data to the specified directory for subsequent imports:

```toml
[recorder]
  enabled  = true
  path     = "/path/to/recorder"     # Absolute path, default is <DataKit installation directory>/recorder
  encoding = "v2"                    # Use protobuf-JSON format (xxx.pbjson), or choose v1 (xxx.lp) for line protocol (the former is more readable and supports more data types)
  duration = "10m"                   # Recording duration, starting from when DataKit starts
  inputs   = ["cpu", "mem"]          # Record data from specified collectors (use the name shown in the monitor's Inputs Info panel); leave empty to record all collectors
  categories = ["logging", "metric"] # Record types; leave empty to record all data types
```

After recording starts, the directory structure looks like this (showing time series data in `pbjson` format):

```shell
[ 416] /usr/local/datakit/recorder/
├── [  64]  custom_object
├── [  64]  dynamic_dw
├── [  64]  keyevent
├── [  64]  logging
├── [  64]  network
├── [  64]  object
├── [  64]  profiling
├── [  64]  rum
├── [  64]  security
├── [  64]  tracing
└── [1.9K]  metric
    ├── [1.2K]  cpu.1698217783322857000.pbjson
    ├── [1.2K]  cpu.1698217793321744000.pbjson
    ├── [1.2K]  cpu.1698217803322683000.pbjson
    ├── [1.2K]  cpu.1698217813322834000.pbjson
    └── [1.2K]  cpu.1698218363360258000.pbjson

12 directories, 59 files
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - After completing data recording, remember to disable this function (`enable = false`), otherwise each DataKit startup will start recording, which could consume a lot of disk space.
    - Collector names do not fully match the names in the collector configuration (`[[inputs.some-name]]`), but rather the names displayed in the first column of the monitor's *Inputs Info* panel. Some collector names might look like this: `logging/some-pod-name`, and the corresponding data directory would be */usr/local/datakit/recorder/logging/logging-some-pod-name.1705636073033197000.pbjson*. Here, slashes `/` in the collector name are replaced with hyphens `-`.
<!-- markdownlint-enable -->

### Data Replay {#do-replay}

After DataKit has recorded data, you can save the directory containing the data using Git or other methods (**ensure the existing directory structure remains intact**). Then, you can import these data into Guance Cloud using the following command:

```shell
$ datakit import -P /usr/local/datakit/recorder -D https://openway.guance.com?token=tkn_xxxxxxxxx

> Uploading "/usr/local/datakit/recorder/metric/cpu.1698217783322857000.pbjson"(1 points) on metric...
+1h53m6.137855s ~ 2023-10-25 15:09:43.321559 +0800 CST
> Uploading "/usr/local/datakit/recorder/metric/cpu.1698217793321744000.pbjson"(1 points) on metric...
+1h52m56.137881s ~ 2023-10-25 15:09:53.321533 +0800 CST
> Uploading "/usr/local/datakit/recorder/metric/cpu.1698217803322683000.pbjson"(1 points) on metric...
+1h52m46.137991s ~ 2023-10-25 15:10:03.321423 +0800 CST
...
Total upload 75 kB bytes ok
```

Although the recorded data contains absolute timestamps (in nanoseconds), when replaying, DataKit automatically shifts these data points to the current time (preserving the relative intervals between data points), making them appear as newly collected data.

You can get more help on data import using the following command:

```shell
$ datakit help import

usage: datakit import [options]

Import is used to play back recorded historical data to Guance Cloud. Available options:

  -D, --dataway strings   dataway list
      --log string        log path (default "/dev/null")
  -P, --path string       point data path (default "/usr/local/datakit/recorder")
```

<!-- markdownlint-disable MD046 -->
???+ attention

    For RUM data, if the target workspace does not have a matching APP ID, the data cannot be written. In the target workspace, create a new application and set the APP ID to match the one in the recorded data, or replace the APP ID in the existing recorded data with the corresponding RUM application's APP ID in the target workspace.
<!-- markdownlint-enable -->

## Viewing DataKit Operation Status {#using-monitor}

Refer to [this link](datakit-monitor.md) for monitor usage.

## Checking Collector Configuration Correctness {#check-conf}

After editing the collector configuration file, certain configurations may be incorrect (e.g., incorrect configuration file format). You can check for correctness using the following command:

```shell
datakit check --config
------------------------
checked 13 conf, all passing, cost 22.27455ms
```

## Viewing Workspace Information {#workspace-info}

To facilitate viewing workspace information on the server side, DataKit provides the following command:

```shell
datakit tool --workspace-info
{
  "token": {
    "ws_uuid": "wksp_2dc431d6693711eb8ff97aeee04b54af",
    "bill_state": "normal",
    "ver_type": "pay",
    "token": "tkn_2dc438b6693711eb8ff97aeee04b54af",
    "db_uuid": "ifdb_c0fss9qc8kg4gj9bjjag",
    "status": 0,
    "creator": "",
    "expire_at": -1,
    "create_at": 0,
    "update_at": 0,
    "delete_at": 0
  },
  "data_usage": {
    "data_metric": 96966,
    "data_logging": 3253,
    "data_tracing": 2868,
    "data_rum": 0,
    "is_over_usage": false
  }
}
```

## Debugging KV Files {#debug-kv}

When configuring collectors using KV templates, you can debug using the following command:

```shell
datakit tool --parse-kv-file conf.d/host/cpu.conf --kv-file data/.kv

[[inputs.cpu]]
  ## Collect interval, default is 10 seconds. (optional)
  interval = '10s'

  ## Collect CPU usage per core, default is false. (optional)
  percpu = false

  ## Setting disable_temperature_collect to false will collect CPU temperature stats for Linux. (deprecated)
  # disable_temperature_collect = false

  ## Enable collecting core temperature data.
  enable_temperature = true

  ## Enable getting average load information every five seconds.
  enable_load5s = true

[inputs.cpu.tags]
  kv = "cpu_kv_value3"
```

## Viewing DataKit Events {#event}

During DataKit operation, some critical events are reported as logs, such as DataKit startup and collector runtime errors. These can be queried via dql in the command-line terminal.

```shell
datakit dql

dql > L::datakit limit 10;

-----------------[ r1.datakit.s1 ]-----------------
    __docid 'L_c6vvetpaahl15ivd7vng'
   category 'input'
create_time 1639970679664
    date_ns 835000
       host 'demo'
    message 'elasticsearch Get "http://myweb:9200/_nodes/_local/name": dial tcp 150.158.54.252:9200: connect: connection refused'
     source 'datakit'
     status 'warning'
       time 2021-12-20 11:24:34 +0800 CST
-----------------[ r2.datakit.s1 ]-----------------
    __docid 'L_c6vvetpaahl15ivd7vn0'
   category 'input'
create_time 1639970679664
    date_ns 67000
       host 'demo'
    message 'postgresql pq: password authentication failed for user "postgres"'
     source 'datakit'
     status 'warning'
       time 2021-12-20 11:24:32 +0800 CST
-----------------[ r3.datakit.s1 ]-----------------
    __docid 'L_c6tish1aahlf03dqas00'
   category 'default'
create_time 1639657028706
    date_ns 246000
       host 'zhengs-MacBook-Pro.local'
    message 'datakit start ok, ready for collecting metrics.'
     source 'datakit'
     status 'info'
       time 2021-12-20 11:16:58 +0800 CST       
          
          ...       
```

Field explanations:

- `category`: Category, default is `default`, can also be `input`, indicating it is related to a collector (`input`)
- `status`: Event level, can be `info`, `warning`, `error`

## Updating DataKit IP Database File {#install-ipdb}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    - You can directly use the following command to install/update the IP geographic database (you can choose another IP address database `geolite2`; just replace `iploc` with `geolite2`):
    
    ```shell
    datakit install --ipdb iploc
    ```
    
    - After updating the IP geographic database, modify the *datakit.conf* configuration:
    
    ``` toml
    [pipeline]
      ipdb_type = "iploc"
    ```
    
    - Restart DataKit for changes to take effect

    - Test if the IP database is working

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If installation fails, the output will be:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province: 
       country: 
    ```

=== "Kubernetes(yaml)"

    - Modify *datakit.yaml*, uncomment the sections between `---iploc-start` and `---iploc-end`.
    
    - Reinstall DataKit:
    
    ```shell
    kubectl apply -f datakit.yaml
    
    # Ensure the DataKit pod is running
    kubectl get pod -n datakit
    ```
    
    - Enter the container and test if the IP database is working

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If installation fails, the output will be:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province:
       country:
    ```

=== "Kubernetes(Helm)"

    - Add `--set iploc.enable` during Helm deployment
    
    ```shell
    helm install datakit datakit/datakit -n datakit \
        --set datakit.dataway_url="https://openway.guance.com?token=<YOUR-TOKEN>" \
        --set iploc.enable true \
        --create-namespace 
    ```
    
    Refer to [here](datakit-daemonset-deploy.md/#__tabbed_1_2) for Helm deployment details.
    
    - Enter the container and test if the IP database is working

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If installation fails, the output will be:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province:
       country:
    ```
<!-- markdownlint-enable -->

## Installing Third-party Software with DataKit {#extras}

### Telegraf Integration {#telegraf}

> Note: Before using Telegraf, ensure that DataKit cannot already meet your expected data collection needs. If DataKit already supports it, avoid using Telegraf to prevent data conflicts, which can cause operational issues.

Install Telegraf integration

```shell
datakit install --telegraf
```

Start Telegraf

```shell
cd /etc/telegraf
cp telegraf.conf.sample telegraf.conf
telegraf --config telegraf.conf
```

Refer to [here](../integrations/telegraf.md) for more details on Telegraf usage.

### Security Checker Integration {#scheck}

Install Security Checker

```shell
datakit install --scheck
```

It will automatically run after successful installation. Refer to [here](../scheck/scheck-install.md) for detailed usage of Security Checker.

### DataKit eBPF Integration {#ebpf}

Install the DataKit eBPF collector, currently only supported on `linux/amd64 | linux/arm64` platforms. Refer to [DataKit eBPF Collector](../integrations/ebpf.md) for usage instructions.

```shell
datakit install --ebpf
```

If you encounter an error like `open /usr/local/datakit/externals/datakit-ebpf: text file busy`, stop the DataKit service before executing the command.

<!-- markdownlint-disable MD046 -->
???+ warning

    This command was removed in [:octicons-tag-24: Version-1.5.6](changelog.md#cl-1.5.6-brk). The new version includes eBPF integration by default.
<!-- markdownlint-enable -->

## Viewing Cloud Attributes Data {#cloudinfo}

If the machine where DataKit is installed is a cloud server (currently supporting `aliyun/tencent/aws/hwcloud/azure`), you can view some cloud attributes data as follows (marked with `-` indicates invalid fields):

```shell
datakit tool --show-cloud-info aws

           cloud_provider: aws
              description: -
     instance_charge_type: -
              instance_id: i-09b37dc1xxxxxxxxx
            instance_name: -
    instance_network_type: -
          instance_status: -
            instance_type: t2.nano
               private_ip: 172.31.22.123
                   region: cn-northwest-1
        security_group_id: launch-wizard-1
                  zone_id: cnnw1-az2
```

## Parsing Line Protocol Data {#parse-lp}

[:octicons-tag-24: Version-1.5.6](changelog.md#cl-1.5.6)

You can parse line protocol data using the following command:

```shell
datakit tool --parse-lp /path/to/file
Parse 201 points OK, with 2 measurements and 201 time series
```

You can output in JSON format:

```shell
datakit tool --parse-lp /path/to/file --json
{
  "measurements": {  # Metrics list
    "testing": {
      "points": 7,
      "time_series": 6
    },
    "testing_module": {
      "points": 195,
      "time_series": 195
    }
  },
  "point": 202,        # Total number of points
  "time_serial": 201   # Total number of time series
}
```

## DataKit Command Auto-completion {#completion}

> Auto-completion is supported from DataKit 1.2.12, tested on Ubuntu and CentOS Linux distributions. It is not supported on Windows or Mac.

When using DataKit commands, due to the numerous command-line parameters, we have added command prompt and completion functionality.

Most mainstream Linux distributions support command completion. For Ubuntu and CentOS, if you want to use command completion, you can install the following packages:

- Ubuntu: `apt install bash-completion`
- CentOS: `yum install bash-completion bash-completion-extras`

If these packages were already installed before installing DataKit, the command completion feature will be automatically included. If these packages were installed after DataKit, you can execute the following command to install DataKit command completion:

```shell
datakit tool --setup-completer-script
```

Completion usage example:

```shell
$ datakit <tab> # Press \tab to display the following commands
dql       help      install   monitor   pipeline  run       service   tool

$ datakit dql <tab> # Press \tab to display the following options
--auto-json   --csv         -F,--force    --host        -J,--json     --log         -R,--run      -T,--token    -V,--verbose
```

All mentioned commands can be operated using this method.

### Getting the Auto-completion Script {#get-completion}

If your Linux system is not Ubuntu or CentOS, you can obtain the completion script using the following command and then add it according to your platform's shell completion method.

```shell
# Export the completion script to the local datakit-completer.sh file
datakit tool --completer-script > datakit-completer.sh
```

## DataKit Debugging Commands {#debugging}

### Debugging Blacklist {#debug-filter}

[:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)

To debug whether a piece of data will be filtered by the centrally configured blacklist, you can use the following command:

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    $ datakit debug --filter=/usr/local/datakit/data/.pull --data=/path/to/lineproto.data
    
    Dropped
    
        ddtrace,http_url=/webproxy/api/online_status,service=web_front f1=1i 1691755988000000000
    
    By 7th rule(cost 1.017708ms) from category "tracing":
    
        { service = 'web_front' and ( http_url in [ '/webproxy/api/online_status' ] )}
    ```

=== "Windows"

    ```powershell
    PS > datakit.exe debug --filter 'C:\Program Files\datakit\data\.pull' --data '\path\to\lineproto.data'
    
    Dropped
    
        ddtrace,http_url=/webproxy/api/online_status,service=web_front f1=1i 1691755988000000000
    
    By 7th rule(cost 1.017708ms) from category "tracing":
    
        { service = 'web_front' and ( http_url in [ '/webproxy/api/online_status' ] )}
    ```
<!-- markdownlint-enable -->

This output indicates that the data in the *lineproto.data* file was matched by the 7th rule (counting from 1) in the `tracing` category in the *.pull* file. Once matched, the data will be dropped.

### Using Glob Rules to Obtain File Paths {#glob-conf}
[:octicons-tag-24: Version-1.8.0](changelog.md#cl-1.8.0)

In log collection, glob rules can be used to configure log paths ([refer here](../integrations/logging.md#glob-rules)).

You can debug glob rules using DataKit. Provide a configuration file where each line is a glob statement.

Example configuration file:

```shell
$ cat glob-config
/tmp/log-test/*.log
/tmp/log-test/**/*.log
```

Complete command example:

```shell
$ datakit debug --glob-conf glob-config
============= glob paths ============
/tmp/log-test/*.log
/tmp/log-test/**/*.log

========== found the files ==========
/tmp/log-test/1.log
/tmp/log-test/logfwd.log
/tmp/log-test/123/1.log
/tmp/log-test/123/2.log
```

### Matching Text with Regular Expressions {#regex-conf}
[:octicons-tag-24: Version-1.8.0](changelog.md#cl-1.8.0)

In log collection, you can configure [regular expressions for multiline log collection](../integrations/logging.md#multiline).

You can debug regular expression rules using DataKit. Provide a configuration file where the **first line is the regular expression**, and the remaining lines are the text to be matched (can be multiple lines).

Example configuration file:

```shell
$ cat regex-config
^\d{4}-\d{2}-\d{2}
2020-10-23 06:41:56,688 INFO demo.py 1.0
2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
ZeroDivisionError: division by zero
2020-10-23 06:41:56,688 INFO demo.py 5.0
```

Complete command example:

```shell
$ datakit debug --regex-conf regex-config
============= regex rule ============
^\d{4}-\d{2}-\d{2}

========== matching results ==========
  Ok:  2020-10-23 06:41:56,688 INFO demo.py 1.0
  Ok:  2020-10-23 06:54:20,164 ERROR /usr/local/lib/python3.6/dist-packages/flask/app.py Exception on /0 [GET]
Fail:  Traceback (most recent call last):
Fail:    File "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
Fail:      response = self.full_dispatch_request()
Fail:  ZeroDivisionError: division by zero
  Ok:  2020-10-23 06:41:56,688 INFO demo.py 5.0
```