# Various Other Tool Usages
---

DataKit comes with many different tools for daily use. You can view the command-line help of DataKit via the following command:

```shell
datakit help
```

> Note: Due to differences between platforms, the specific help content may vary.

If you want to check how a specific command is used (for example, `dql`), you can use the following command:

```shell
$ datakit help dql
usage: datakit dql [options]

DQL used to query data. If no option specified, query interactively. Other available options:

      --auto-json      pretty output string if field/tag value is JSON
      --csv string     Specify the directory
  -F, --force          overwrite csv if file exists
  -H, --host string    specify datakit host to query
  -J, --json           output in json format
      --log string     log path (default "/dev/null")
  -R, --run string     run single DQL
  -T, --token string   run query for specific token(workspace)
  -V, --verbose        verbosity mode
```

## Data Recording and Playback {#record-and-replay}

[:octicons-tag-24: Version-1.19.0](changelog.md#cl-1.19.0)

Data import is mainly used to input existing collected data, which can be reused for demonstration or testing without additional collection.

### Enable Data Recording {#enable-recorder}

In *datakit.conf*, you can enable the data recording feature. Once enabled, DataKit will record data to the specified directory for later import:

```toml
[recorder]
  enabled  = true
  path     = "/path/to/recorder"     # Absolute path, default is <DataKit installation directory>/recorder
  encoding = "v2"                    # Uses protobuf-JSON format (xxx.pbjson); can also choose v1 (xxx.lp) using line protocol (former is easier to read and supports more complete data types)
  duration = "10m"                   # Recording duration, starting from when DataKit starts
  inputs   = ["cpu", "mem"]          # Record data from specified collectors (names as per specific feed names in monitor); empty means all collectors
  categories = ["logging", "metric"] # Record types; empty means all data types
```

After recording starts, the directory structure looks roughly like this (showing `pbjson` format for time series data):

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

    - After completing data recording, remember to disable this function (`enable = false`) to avoid unnecessary disk consumption.
    - Collector names do not exactly match the names in collector configurations (`[[inputs.some-name]]`), but rather the names shown in the first column of the monitor *Inputs Info* panel. Some collector names might appear as `logging/some-pod-name`, and their data directories would be `/usr/local/datakit/recorder/logging/logging-some-pod-name.1705636073033197000.pbjson`, where slashes are replaced with hyphens.
<!-- markdownlint-enable -->

### Data Playback {#do-replay}

After DataKit records data, you can save the data in this directory using Git or other methods (**make sure to preserve the directory structure**). Then, you can import this data into Guance Cloud using the following command:

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

Although the recorded data includes absolute timestamps (nanoseconds), during playback, DataKit automatically shifts these data points to the current time (preserving relative intervals between data points) to make it look like newly collected data.

You can get more help on data import with the following command:

```shell
$ datakit help import

usage: datakit import [options]

Import used to play recorded history data to Guance Cloud. Available options:

  -D, --dataway strings   dataway list
      --log string        log path (default "/dev/null")
  -P, --path string       point data path (default "/usr/local/datakit/recorder")
```

<!-- markdownlint-disable MD046 -->
???+ attention

    For RUM data, if the target workspace does not have a matching APP ID, the data cannot be written. You can create a new application in the target workspace and change its APP ID to match the one in the recorded data, or replace the APP ID in the recorded data with the corresponding RUM application's APP ID in the target workspace.
<!-- markdownlint-enable -->

## Viewing DataKit Running Status {#using-monitor}

Refer to [here](datakit-monitor.md) for monitor usage.

## Checking Collector Configuration Correctness {#check-conf}

After editing the collector configuration file, some configurations may be incorrect (e.g., incorrect configuration file format). You can check correctness with the following command:

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

When configuring collector configurations using KV templates, if debugging is required, you can debug with the following command.

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

## Viewing DataKit Related Events {#event}

During DataKit operation, some critical events are reported in log form, such as DataKit startup, collector runtime errors, etc. These can be queried in the command-line terminal using dql.

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

Field descriptions:

- `category`: Category, default is `default`, can also be `input`, indicating it is related to the collector (`input`)
- `status`: Event level, can be `info`, `warning`, `error`

## Updating DataKit IP Database File {#install-ipdb}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    - You can directly use the following command to install/update the IP geolocation database (you can choose another IP address database `geolite2`; just replace `iploc` with `geolite2`):
    
    ```shell
    datakit install --ipdb iploc
    ```
    
    - After updating the IP geolocation database, modify the *datakit.conf* configuration:
    
    ``` toml
    [pipeline]
      ipdb_type = "iploc"
    ```
    
    - Restart DataKit for changes to take effect

    - Test if the IP library works

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If the installation fails, the output will be as follows:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province: 
       country: 
    ```

=== "Kubernetes(yaml)"

    - Modify *datakit.yaml* and uncomment the sections between `---iploc-start` and `---iploc-end`.
    
    - Reinstall DataKit:
    
    ```shell
    kubectl apply -f datakit.yaml
    
    # Ensure the DataKit pod is running
    kubectl get pod -n datakit
    ```

    - Enter the container and test if the IP library works

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If the installation fails, the output will be as follows:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province:
       country:
    ```

=== "Kubernetes(Helm)"

    - Add `--set iploc.enable` when deploying with Helm
    
    ```shell
    helm install datakit datakit/datakit -n datakit \
        --set datakit.dataway_url="https://openway.guance.com?token=<YOUR-TOKEN>" \
        --set iploc.enable true \
        --create-namespace 
    ```
    
    Refer to [here](datakit-daemonset-deploy.md/#__tabbed_1_2) for Helm deployment details.
    
    - Enter the container and test if the IP library works

    ```shell
    datakit tool --ipinfo 1.2.3.4
            ip: 1.2.3.4
          city: Brisbane
      province: Queensland
       country: AU
           isp: unknown
    ```

    If the installation fails, the output will be as follows:
    
    ```shell
    datakit tool --ipinfo 1.2.3.4
           isp: unknown
            ip: 1.2.3.4
          city: 
      province:
       country:
    ```
<!-- markdownlint-enable -->

## Installing Third-Party Software with DataKit {#extras}

### Telegraf Integration {#telegraf}

> Note: It is recommended to confirm whether DataKit can meet your expected data collection before using Telegraf. If DataKit already supports it, it is not advisable to use Telegraf for collection, as this could lead to data conflicts and cause operational issues.

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

For details on using Telegraf, refer to [here](../integrations/telegraf.md).

### Security Checker Integration {#scheck}

Install Security Checker

```shell
datakit install --scheck
```

After successful installation, Security Checker will run automatically. For detailed usage, refer to [here](../scheck/scheck-install.md).

### DataKit eBPF Integration {#ebpf}

Install the DataKit eBPF collector, currently supported only on `linux/amd64 | linux/arm64` platforms. Refer to [DataKit eBPF Collector](../integrations/ebpf.md) for usage instructions.

```shell
datakit install --ebpf
```

If you encounter an error like `open /usr/local/datakit/externals/datakit-ebpf: text file busy`, stop the DataKit service and then execute the command again.

<!-- markdownlint-disable MD046 -->
???+ warning

    This command has been removed since [:octicons-tag-24: Version-1.5.6](changelog.md#cl-1.5.6-brk). New versions come with eBPF integration by default.
<!-- markdownlint-enable -->

## Viewing Cloud Attribute Data {#cloudinfo}

If the machine where DataKit is installed is a cloud server (currently supports `aliyun/tencent/aws/hwcloud/azure`), you can view some cloud attribute data as follows (fields marked `-` indicate invalid fields):

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

You can parse line protocol data with the following command:

```shell
datakit tool --parse-lp /path/to/file
Parse 201 points OK, with 2 measurements and 201 time series
```

It can also output in JSON format:

```shell
datakit tool --parse-lp /path/to/file --json
{
  "measurements": {  # Measurement list
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

## DataKit Automatic Command Completion {#completion}

> Command completion is supported from DataKit 1.2.12 onwards and has been tested on Ubuntu and CentOS Linux distributions. Windows and Mac are not supported.

While using DataKit commands, due to the numerous command-line parameters, we have added command prompt and completion features.

Most mainstream Linux distributions support command completion. For Ubuntu and CentOS, if you want to use command completion, you can install the following packages:

- Ubuntu: `apt install bash-completion`
- CentOS: `yum install bash-completion bash-completion-extras`

If these packages were already installed before installing DataKit, command completion will be automatically included during DataKit installation. If these packages are installed after DataKit, you can execute the following command to add DataKit command completion:

```shell
datakit tool --setup-completer-script
```

Completion usage example:

```shell
$ datakit <tab> # Press \tab to prompt the following commands
dql       help      install   monitor   pipeline  run       service   tool

$ datakit dql <tab> # Press \tab to prompt the following options
--auto-json   --csv         -F,--force    --host        -J,--json     --log         -R,--run      -T,--token    -V,--verbose
```

All mentioned commands can be operated in this manner.

### Obtaining the Auto-Completion Script {#get-completion}

If your Linux system is not Ubuntu or CentOS, you can obtain the completion script with the following command and then add it according to your platform's shell completion method.

```shell
# Export the completion script to a local datakit-completer.sh file
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

This output indicates that the data in the *lineproto.data* file was matched by the 7th rule (counting from 1) under the `tracing` category in the *.pull* file. Once matched, the data will be dropped.

### Using Glob Rules to Obtain File Paths {#glob-conf}
[:octicons-tag-24: Version-1.8.0](changelog.md#cl-1.8.0)

In log collection, glob rules can be used to configure log paths [refer here](../integrations/logging.md#glob-rules).

You can use DataKit to debug glob rules. Provide a configuration file where each line is a glob statement.

Configuration file example:

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

In log collection, regular expressions can be used to [collect multi-line logs](../integrations/logging.md#multiline).

You can use DataKit to debug regular expression rules. Provide a configuration file where **the first line is the regular expression**, and the remaining lines are the text to be matched (which can be multiple lines).

Configuration file example:

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
