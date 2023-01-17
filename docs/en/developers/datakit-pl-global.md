

# Pipeline Category Data Processing

---

Since DataKit v1.4. 0, DataKit can be directly manipulated to collect data through the built-in Pipeline function, and the supported categories are as follows:

- CustomObject
- Keyevent
- Logging
- Metric
- Network
- Object
- Rum
- Security
- Tracing

> Note:
>
> - Pipeline is applied to all data and is currently in the experimental stage, and there is no guarantee that incompatible adjustments will be made to the mechanism or behavior later.
> - Pipeline processing is supported even for data reported through [DataKit API](../datakit/apis.md).
> - Using Pipeline to process the existing collected data (especially non-log data) is very likely to destroy the existing data structure and cause the data to behave abnormally on Guance Cloud.
> - Before applying Pipeline, be sure to use the [Pipeline debug tool](datakit-pl-how-to.md) to verify that the data processing is as expected.

Pipeline can do the following on the data collected by DataKit:

- Add, delete and modify values or data types for field and tag
- Change field to tag
- Modify the measurement name
- Drop current data [drop()](pipeline.md#fn-drop)）
- Terminate the run of the Pipeline script（[exit()](pipeline.md#fn-exit)）
- ...

## Pipeline Script Storage, Loading and Selection {#loading}

Currently, DataKit supports three types of Pipeline:

1. Remote Pipeline: Located in _<datakit nstallation directory>/pipeline_remote_ directory
1. Git-managed Pipeline: in _<datakit installation directory>/gitrepos/<git repository name>_ directory
1. Pipeline that comes with the installation:  _<datakit installation directory>/pipeline_ directory

The above three types of Pipeline directories store Pipeline scripts as follows:

```
├── pattern   <-- directory dedicated to storing custom patterns
├── apache.p
├── consul.p
├── sqlserver.p        <--- Pipeline in all top-level directories works on logs by default to be compatible with history settings
├── tomcat.p
├── other.p
├── custom_object      <--- pipeline storage directory dedicated to custom objects
│   └── some-object.p
├── keyevent           <--- pipeline storage directory dedicated to events
│   └── some-event.p
├── logging            <--- pipeline storage directory dedicated to logs
│   └── nginx.p
├── metric             <--- pipeline storage directory dedicated to time series indicators
│   └── cpu.p
├── network            <--- pipeline storage directory dedicated to network metrics
│   └── ebpf.p
├── object             <--- pipeline storage directory dedicated to objects
│   └── HOST.p
├── rum                <--- pipeline storage directory dedicated to RUM
│   └── error.p
├── security           <--- pipeline storage directory dedicated to scheck
│   └── scheck.p
└── tracing            <--- pipeline storage directory dedicated to APM
    └── service_a.p
```

### Autoactive Rules for Scripts {#auto-apply-rules}

In the above directory setting, we store Pipeline applied to different data classifications in corresponding directories. For DataKit, once a certain type of data is collected, the corresponding Pipeline script will be automatically applied for processing. For different types of data, their application rules are also different. It is mainly divided into several categories:

1. Match the corresponding Pipeline with a specific line protocol tag name (tag):
   1. For Tracing and Profiling class data, Pipeline is automatically matched with the value of the label `service` . For example, DataKit collects a piece of data that, if the `service` value on the line protocol is `service-a`, will be sent to _tracing/service-a.p_ | _profiling/service-a.p_ for processing.
   1. For SECURITY (scheck) class data, Pipeline is automatically matched with the value of the label `category` For example, DataKit receives a piece of security data that is sent to _security/system.p_ for processing if its `category` value on the row protocol is `system`.
1. Matching the corresponding Pipeline with a specific row protocol label name (tag) and indicator set name: for rum class data, taking the value of label name `app_id` and measurement `action` as an example, `rum/<app_id>_action.p` will be automatically applied;
2. Matching the corresponding Pipeline with the name of the line protocol measurement: For other class data, all match the Pipeline with the line protocol measurement. Taking the time series measurement `cpu` as an example, _metric/cpu.p_ will be automatically applied; For host objects, _object/HOST.p_ is automatically applied.

Therefore, we can add corresponding Pipeline scripts in the corresponding directory in an appropriate way to realize Pipeline processing of the collected data.

### Pipeline Selection Policy {#apply-priority}

At present, pl scripts are divided into three categories according to their sources, which are as follows under the DataKit installation directory:

1. _pipeline_remote_
1. _gitrepo_
1. _pipeline_

When DataKit selects the corresponding Pipeline, the loading priority of these three categories is decreasing. Taking the `cpu` measurement as an example, when _metric/cpu.p_ is required, the DataKit is loaded in the following order:

1. `pipeline_remote/metric/cpu.p`
1. `gitrepo/<repo-name>/metric/cpu.p`
1. `pipeline/metric/cpu.p`

> Note: Here `<repo-name>` depends on the repository name of your git.

## Pipeline Running View {#monitor}

You can get the running status of each Pipeline through the DataKit monitor function:

```shell
datakit monitor -V
```

## Pipeline Processing Samples {#examples}

> The sample script is for reference only. Please write it according to the requirements for specific use.

### Processing Timseries Data {#M}

The following example is used to show how to modify tag and field with Pipeline. With DQL, we can know the fields of a CPU metric set as follows:

```shell
dql > M::cpu{host='u'} LIMIT 1
-----------------[ r1.cpu.s1 ]-----------------
core_temperature 76
             cpu 'cpu-total'
            host 'u'
            time 2022-04-25 12:32:55 +0800 CST
     usage_guest 0
usage_guest_nice 0
      usage_idle 81.399796
    usage_iowait 0.624681
       usage_irq 0
      usage_nice 1.695563
   usage_softirq 0.191229
     usage_steal 0
    usage_system 5.239674
     usage_total 18.600204
      usage_user 10.849057
---------
```

Write the following Pipeline script,

```python
# file pipeline/metric/cpu.p

set_tag(script, "metric::cpu.p")
set_tag(host2, host)
usage_guest = 100.1
```

After restarting DataKit, new data is collected, and we can get the following modified CPU measurement through DQL:

```shell
dql > M::cpu{host='u'}[20s] LIMIT 1
-----------------[ r1.cpu.s1 ]-----------------
core_temperature 54.250000
             cpu 'cpu-total'
            host 'u'
           host2 'u'                        <--- added tag
          script 'metric::cpu.p'            <--- added tag
            time 2022-05-31 12:49:15 +0800 CST
     usage_guest 100.100000                 <--- overwritten specific field value
usage_guest_nice 0
      usage_idle 94.251269
    usage_iowait 0.012690
       usage_irq 0
      usage_nice 0
   usage_softirq 0.012690
     usage_steal 0
    usage_system 2.106599
     usage_total 5.748731
      usage_user 3.616751
---------
```

### Processing Object Data {#O}

The following Pipeline example is used to show how to discard (filter) data. Taking Nginx processes as an example, the list of Nginx processes on the current host is as follows:

```shell
$ ps axuwf | grep  nginx
root        1278  0.0  0.0  55288  1496 ?        Ss   10:10   0:00 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
www-data    1279  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1280  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1281  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1282  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1283  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1284  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1286  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
www-data    1287  0.0  0.0  55856  5212 ?        S    10:10   0:00  \_ nginx: worker process
```

From DQL, we can know that the measurement fields of a specific process are as follows:

```shell
dql > O::host_processes:(host, class, process_name, cmdline, pid) {host='u', pid=1278}
-----------------[ r1.host_processes.s1 ]-----------------
       class 'host_processes'
     cmdline 'nginx: master process /usr/sbin/nginx -g daemon on; master_process on;'
        host 'u'
         pid 1278
process_name 'nginx'
        time 2022-05-31 14:19:15 +0800 CST
---------
```

Write the following Pipeline script:

```python
if process_name == "nginx" {
    drop()  # drop() function marks the data to be discarded and continues running pl after execution
    exit()  # Terminate Pipeline with the exit() function
}
```

After restarting DataKit, the corresponding Ngxin process object will not be collected again (the central object has an expiration policy, and it takes 5 ~ 10min for the original nginx object to automatically expire).
