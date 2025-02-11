# Datakit Log Collection Comprehensive Guide

## Preface

Log collection is an important feature of Datakit in Guance. It processes log data that is actively collected or passively received, ultimately uploading it to the central server of Guance.

Based on the source of the data, it can be divided into two types: "log file data" and "network stream data". These correspond to the following:

- "Log file data":
    - Local disk files: These are fixed files stored on the disk, collected via the logging collector.
    - Container standard output: The container Runtime writes standard output (stdout/stderr) to the disk for storage, and the container collector accesses the Runtime to obtain the path of the disk file and collects it.
    - Logs inside containers: By using Volume/VolumeMount methods, files are mounted externally so that Datakit can access them.

- "Network stream data":
    - tcp/udp data: Datakit listens on corresponding tcp/udp ports and receives the log data.
    - logstreaming: Receives data via HTTP protocol.

The configuration methods and usage scenarios for these data types differ significantly, which will be detailed below.

## Usage Scenarios and Configuration Methods

### Local Disk File Collection

This chapter only describes scenarios where Datakit is deployed on a host; Kubernetes deployment is not recommended for collecting local files.

First, you need to start a logging collector. Enter the `conf.d/log` directory under the Datakit installation directory, copy `logging.conf.sample`, and rename it to `logging.conf`. An example is as follows:

``` toml
[[inputs.logging]]
 # List of log files, absolute paths can be specified, supporting glob rules for batch designation
 # It is recommended to use absolute paths and specify file extensions
 # Try to narrow down the scope to avoid collecting compressed packages or binary files
 logfiles = [
  "/var/log/*.log",           # All .log files in the directory path
  "/var/log/*.txt",           # All .txt files in the directory path
  "/var/log/sys*",            # All files with the sys prefix in the directory path
  "/var/log/syslog",           # Unix format file path
  "c:/path/space 空格中文路径/some.txt", # Windows style file path
 ]

 ## Currently supports two protocols for socket: tcp/udp. It is recommended to open internal network ports to prevent security risks
 ## Only one of socket and log can be chosen; it cannot collect both through files and sockets simultaneously
 sockets = [
  "tcp://0.0.0.0:9540"
  "udp://0.0.0.0:9541"
 ]

# Path filtering for files, using glob rules. Files matching any filter condition will not be collected
 ignore = [""]
 
 # Source of data, if empty, defaults to 'default'
 source = ""
 
 # Additional tag, if empty, defaults to $source
 service = ""
 
 # Pipeline script path, if empty, uses $source.p, and if $source.p does not exist, pipeline is not used
 pipeline = ""
 
 # Select encoding, incorrect encoding may make data unreadable. Default is empty
 # `utf-8`,`gbk`
 character_encoding = ""
 
 ## Set regular expressions, e.g., ^\d{4}-\d{2}-\d{2} matches yyyy-mm-dd time format at the beginning of the line
 ## Data matching this regex is considered valid; otherwise, it will be appended to the end of the previous valid data
 ## Use three single quotes '''this-regexp''' to avoid escaping
 ## Regular expression link: https://golang.org/pkg/regexp/syntax/#hdr-syntax
 # multiline_match = '''^\s'''

## Whether to enable automatic multiline mode, when enabled, it matches applicable multiline rules in the patterns list
 auto_multiline_detection = true
 ## Configure the patterns list for automatic multiline, content is an array of multiline rules, i.e., multiple multiline_matches. If empty, default rules are used, see documentation
 auto_multiline_extra_patterns = []

## Whether to remove ANSI escape codes, such as text colors from standard output
 remove_ansi_escape_codes = false

## Ignore inactive files, e.g., if a file was last modified more than 20 minutes ago and has been over 10m since then, it will be ignored
 ## Supported time units are "ms", "s", "m", "h"
 ignore_dead_log = "1h"

## Whether to read from the beginning of the file
 from_beginning = false

# Custom tags
 [inputs.logging.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
```

This is a basic `logging.conf`. The roles of fields like `multiline_match`, `pipeline`, etc., are explained in detail later.

### Collection of Container Standard Output

Collecting standard output logs from container applications is the most common method and can be viewed similarly to `docker logs` or `crictl logs`.

Console output (i.e., stdout/stderr) is written by the container Runtime to files on disk, and Datakit automatically obtains the `logpath` of the container for collection.

If custom configurations are needed, they can be added through container environment variables or Kubernetes Pod Annotations.

- The key for custom configurations can be:
    - For container environment variables, the key is fixed as `datakit_logs_config`.
    - For pod annotations, there are two ways to write the key:
        - `datakit/<container_name>.logs`, where `<container_name>` needs to be replaced with the current pod's container name. This is useful in multi-container environments.
        - `datakit/logs` applies to all containers in the pod.

<!-- markdownlint-disable md046 -->
???+ info

If a container has an environment variable `datakit_logs_config` and also finds the annotation `datakit/logs` for its pod, the configuration in the container environment variable takes precedence based on proximity.
<!-- markdownlint-enable -->

- The value for custom configurations is as follows:

``` json
[
 {
  "disable" : false,
  "source" : "<your-source>",
  "service" : "<your-service>",
  "pipeline": "<your-pipeline.p>",
  "remove_ansi_escape_codes": false,
  "from_beginning"     : false,
  "tags" : {
   "<some-key>" : "<some_other_value>"
  }
 }
]
```

Field descriptions:

| Field Name                     | Value             | Description                                                                                                                                                                       |
| -----                          | ----              | ----                                                                                                                                                                               |
| `disable`                      | true/false        | Whether to disable log collection for this container, default is `false`                                                                                                           |
| `type`                         | `file`/not filled | Choose the collection type. If collecting files within the container, it must be set to `file`. Defaults to collecting `stdout/stderr` if left empty.                             |
| `path`                         | string            | Configuration file path. If collecting files within the container, the Volume path must be specified, not the file path inside the container but the path accessible outside.      |
| `source`                       | string            | Log source, refer to [Container Log Collection Source Configuration](../integrations/container.md#config-logging-source)                                                         |
| `service`                      | string            | The service to which the log belongs, default is the log source (source)                                                                                                           |
| `pipeline`                     | string            | The pipeline script applicable to this log, default is the script name matching the log source (`<source>.p`)                                                                     |
| `remove_ansi_escape_codes`     | true/false        | Whether to remove color characters from log data                                                                                                                                   |
| `from_beginning`               | true/false        | Whether to collect logs from the beginning of the file                                                                                                                             |
| `multiline_match`              | Regular Expression String | Used for identifying the first line of multiline logs, e.g., `"multiline_match":"^\\d{4}"` indicates the first line starts with four digits. In regex rules, `\d` is a digit, preceded by `\` for escaping. |
| `character_encoding`           | string            | Choose encoding, incorrect encoding may make data unreadable. Supports `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or "". Default is empty.                               |
| `tags`                         | Key/Value Pairs   | Add extra tags. If the same key already exists, it will be overwritten by this one ([:octicons-tag-24: version-1.4.6](changelog.md#cl-1.4.6))                                      |

A complete example is as follows:

<!-- markdownlint-disable md046 -->
=== "Container Environment Variables"

``` shell
$ cat dockerfile
from pubrepo.guance.com/base/ubuntu:18.04 as base
run mkdir -p /opt
run echo 'i=0; \n\
while true; \n\
do \n\
  echo "$(date +"%y-%m-%d %h:%m:%s") [$i] bash for loop examples. hello, world! testing output."; \n\
  i=$((i+1)); \n\
  sleep 1; \n\
done \n'\
>> /opt/s.sh
cmd ["/bin/bash", "/opt/s.sh"]

## Build image
$ docker build -t testing/log-output:v1 .

## Start container, add environment variable datakit_logs_config
$ docker run --name log-output -env datakit_logs_config='[{"disable":false,"source":"log-source","service":"log-service"}]' -d testing/log-output:v1
```

=== "Kubernetes Pod Annotation"

``` yaml title="log-demo.yaml"
apiversion: apps/v1
kind: deployment
metadata:
 name: log-demo-deployment
 labels:
  app: log-demo
spec:
 replicas: 1
 selector:
  matchlabels:
   app: log-demo
 template:
  metadata:
   labels:
    app: log-demo
   annotations:
    ## Add configuration and specify container as log-output
    datakit/log-output.logs: |
     [{
       "disable": false,
       "source": "log-output-source",
       "service": "log-output-service",
       "tags" : {
        "some_tag": "some_value"
       }
     }]
  spec:
   containers:
   - name: log-output
    image: pubrepo.guance.com/base/ubuntu:18.04
    args:
    - /bin/sh
    - -c
    - >
     i=0;
     while true;
     do
      echo "$(date +'%f %h:%m:%s') [$i] bash for loop examples. hello, world! testing output.";
      i=$((i+1));
      sleep 1;
     done
```

Execute the Kubernetes command to apply this configuration:

``` shell
$ kubectl apply -f log-output.yaml
#...
```

???+ attention

    - Do not configure Pipelines in environment variables and Pod Annotations unless necessary. Generally, automatic inference through the `source` field is sufficient.
    - If configuring Environment/Annotations in configuration files or terminal commands, double quotes should be used in English state, and escape characters need to be added.


The value of `multiline_match` requires double escaping; four backslashes represent one actual backslash. For example, `\"multiline_match\":\"^\\\\d{4}\"` is equivalent to `"multiline_match":"^\d{4}"`. Example:

```shell
$ kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"log-source\",\"service\":\"log-service\",\"pipeline\":\"test.p\",\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
#...
```

If a pod/container log is already being collected, adding a new configuration via the `kubectl annotate` command will not take effect.


### Collection of Logs Inside Containers

For logs inside containers, unlike console output logs, file paths need to be specified, while other configuration items are largely similar.

Similarly, add container environment variables or Kubernetes Pod Annotations, with keys and values basically consistent as described earlier.

Complete example:

<!-- markdownlint-disable md046 -->
=== "Container Environment Variables"

``` shell
$ cat dockerfile
from pubrepo.guance.com/base/ubuntu:18.04 as base
run mkdir -p /opt
run echo 'i=0; \n\
while true; \n\
do \n\
  echo "$(date +"%y-%m-%d %h:%m:%s") [$i] bash for loop examples. hello, world! testing output." >> /tmp/opt/1.log; \n\
  i=$((i+1)); \n\
  sleep 1; \n\
done \n'\
>> /opt/s.sh
cmd ["/bin/bash", "/opt/s.sh"]

## Build image
$ docker build -t testing/log-to-file:v1 .

## Start container, add environment variable datakit_logs_config, note character escaping
## Specify non-stdout path, "type" and "path" are required fields, and the collection path Volume must be created
## For example, to collect `/tmp/opt/1.log` file, add an anonymous Volume for `/tmp/opt`
$ docker run --env datakit_logs_config="[{\"disable\":false,\"type\":\"file\",\"path\":\"/tmp/opt/1.log\",\"source\":\"log-source\",\"service\":\"log-service\"}]" -v /tmp/opt -d testing/log-to-file:v1
```

=== "Kubernetes Pod Annotation"

``` yaml title="logging.yaml"
apiversion: apps/v1
kind: deployment
metadata:
 name: log-demo-deployment
 labels:
  app: log-demo
spec:
 replicas: 1
 selector:
  matchlabels:
   app: log-demo
 template:
  metadata:
   labels:
    app: log-demo
   annotations:
    ## Add configuration and specify container as logging-demo
    ## Also configure both file and stdout collection. Note that to collect "/tmp/opt/1.log", an emptydir Volume must be added for "/tmp/opt"
    datakit/logging-demo.logs: |
     [
      {
       "disable": false,
       "type": "file",
       "path":"/tmp/opt/1.log",
       "source": "logging-file",
       "tags" : {
        "some_tag": "some_value"
       }
      },
      {
       "disable": false,
       "source": "logging-output"
      }
     ]
  spec:
   containers:
   - name: logging-demo
    image: pubrepo.guance.com/base/ubuntu:18.04
    args:
    - /bin/sh
    - -c
    - >
     i=0;
     while true;
     do
      echo "$(date +'%f %h:%m:%s') [$i] bash for loop examples. hello, world! testing output.";
      echo "$(date +'%f %h:%m:%s') [$i] bash for loop examples. hello, world! testing output." >> /tmp/opt/1.log;
      i=$((i+1));
      sleep 1;
     done
    volumemounts:
    - mountpath: /tmp/opt
     name: datakit-vol-opt
   volumes:
   - name: datakit-vol-opt
    emptydir: {}
```

Execute the Kubernetes command to apply this configuration:

``` shell
$ kubectl apply -f logging.yaml
#...
```

For logs inside containers, sidecar injection can also be used in Kubernetes environments to achieve collection. Refer to [here](../integrations/logfwd.md).

### Receiving tcp/udp Data

Comment out `logfiles` in `logging.conf` and configure `sockets`, for example:

```yaml
[[inputs.logging]]
 sockets = [
  "tcp://127.0.0.1:9540"
  "udp://127.0.0.1:9541"
 ]

 source = "socket-testing"
```

This configuration listens on TCP port 9540 and UDP port 9541 simultaneously. Logs received from these ports have a unified source of `socket-testing`.

Testing with Linux's `nc` command:

```shell
# Send tcp data, press ctrl-c to exit
$ nc 127.0.0.1 9540
This is a tcp message-1
This is a tcp message-2
This is a tcp message-3

# Send a udp message
$ echo "This is a udp message" | nc -w 3 -v -u 127.0.0.1 9541
Connection to 127.1 (127.0.0.1) 9531 port [udp/*] succeeded!
```

> Note: UDP data lacks context, so multiline matching is not applicable.

### Receiving http Data

Start an HTTP server to receive log text data and report it to Guance. The HTTP URL is fixed at `/v1/write/logstreaming`, i.e., `http://datakit_ip:port/v1/write/logstreaming`.

> Note: If Datakit is deployed as a DaemonSet in Kubernetes, it can be accessed via Service, with the address being `http://datakit-service.datakit:9529`

<!-- markdownlint-disable md046 -->
=== "Host Installation"

Enter the `conf.d/log` directory under the Datakit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`. Example:

```toml
[inputs.logstreaming]
  ignore_url_tags = false

  ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
  ## buffer is the size of jobs' buffering of worker channel.
  ## threads is the total number fo goroutines at running time.
  # [inputs.logstreaming.threads]
  #   buffer = 100
  #   threads = 8

  ## Storage config a local storage space in hard dirver to cache trace data.
  ## path is the local file path used to cache data.
  ## capacity is total space size(MB) used to store data.
  # [inputs.logstreaming.storage]
  #   path = "./log_storage"
  #   capacity = 5120
```

After configuration, [restart Datakit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

Currently, the collector configuration can be injected via [ConfigMap](datakit-daemonset-deploy.md#configmap-setting) to enable the collector.
<!-- markdownlint-enable -->

#### Supported Parameters for logstreaming

Logstreaming supports flexible operations on log data by adding parameters to the HTTP URL. Here are the supported parameters and their functions:

- `type`: Data format, currently supports `influxdb` and `firelens`.
    - When `type` is `inflxudb` (`/v1/write/logstreaming?type=influxdb`), it means the data is already in line protocol format (default precision is `s`), only built-in tags will be added without further processing.
    - When `type` is `firelens` (`/v1/write/logstreaming?type=firelens`), the data format should be JSON-formatted multiple logs.
    - When this value is empty, the data will be processed line by line and with Pipeline.
- `source`: Identifies the data source, i.e., the measurement in the line protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)
    - This parameter is invalid when `type` is `influxdb`.
    - Defaults to `default`.
- `service`: Adds a service label field, for example (`/v1/write/logstreaming?service=nginx_service`)
    - Defaults to the value of the `source` parameter.
- `pipeline`: Specifies the name of the pipeline script to be used, for example `nginx.p` (`/v1/write/logstreaming?pipeline=nginx.p`)
- `tags`: Adds custom tags separated by commas, for example `key1=value1` and `key2=value2` (`/v1/write/logstreaming?tags=key1=value1,key2=value2`)

#### logstreaming Usage Examples

- Fluentd using influxdb output [documentation](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd using http output [documentation](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash using influxdb output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash using http output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Just configure the output host to the log-streaming URL (`http://datakit_ip:port/v1/write/logstreaming`) and add the corresponding parameters.

## Details of Log Collection

### Discovering Log Files

#### Configuring File Paths Using Glob

Log collection uses glob rules to conveniently specify log files and automatically discover and filter files.

| Wildcard   | Description                               | Regex Example       | Matching Example                    | Non-Matching                        |
| :--        | ---                                | ---            | ---                         | ----                          |
| `*`        | Matches any number of any characters, including none     | `law*`         | `law, laws, lawyer`         | `groklaw, la, aw`             |
| `?`        | Matches any single character                   | `?at`          | `cat, cat, bat, bat`        | `at`                          |
| `[abc]`    | Matches one of the characters given in brackets           | `[cb]at`       | `cat, bat`                  | `cat, bat`                    |
| `[a-z]`    | Matches one of the characters in the range given in brackets   | `letter[0-9]`  | `letter0, letter1, letter9` | `letters, letter, letter10`   |
| `[!abc]`   | Matches one of the characters not given in brackets         | `[!c]at`       | `bat, bat, cat`             | `cat`                         |
| `[!a-z]`   | Matches one of the characters not in the range given in brackets | `letter[!3-5]` | `letter1…`                  | `letter3 … letter5, letterxx` |

In addition to the above standard glob rules, the collector also supports `**` for recursive file traversal, as shown in the sample configuration. More about grok, refer to [here](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}.

#### Discovering Local Log Files

Ordinary log files are the most common type. They are directly written to disk files by processes as readable records, like the famous "log4j" framework or executing `echo "this is log" >> /tmp/log` would generate log files.

These log file paths are mostly fixed. For example, MySQL's log path on Linux platforms is `/var/log/mysql/mysql.log`. If running the Datakit MySQL collector, it defaults to looking for log files at this path. However, log storage paths are configurable, and Datakit cannot accommodate all cases, so manual specification of file paths is supported.

In Datakit, use glob patterns to configure file paths, using wildcards to locate filenames (although wildcards can be omitted).

For example, consider the following files:

```shell
$ tree /tmp

/tmp
├── datakit
│   ├── datakit-01.log
│   ├── datakit-02.log
│   └── datakit-03.log
└── mysql.d
  └── mysql
    └── mysql.log

3 directories, 4 files
```

In the Datakit logging collector, you can specify the log files to collect by configuring the `logfiles` parameter, for example:

- Collect all files in the `datakit` directory, glob pattern `/tmp/datakit/*`
- Collect all files named `datakit`, corresponding glob pattern `/tmp/datakit/datakit-*log`
- Collect `mysql.log`, but there are two intermediate directories `mysql.d` and `mysql`. There are several methods to locate the `mysql.log` file:
    - Directly specify: `/tmp/mysql.d/mysql/mysql.log`
    - Single asterisk: `/tmp/*/*/mysql.log`, this method is rarely used
    - Double asterisk (`double star`): `/tmp/**/mysql.log`, using double asterisk `**` to replace multiple intermediate directory structures, which is a more concise and commonly used way

After specifying file paths using glob in the configuration file, Datakit periodically searches the disk for files that match the rules. If it finds a file not in the collection list, it adds it and begins collection.

#### Locating Container Standard Output Logs

There are two ways to output logs in containers:

- One is writing directly to a mounted disk directory, which appears the same as "ordinary log files" on the host, as they are files at fixed positions on the disk.
- Another way is outputting to stdout/stderr, collected and managed by the container's Runtime and written to disk. This is a more common approach. The disk path can be obtained by accessing the Runtime API.

Datakit connects to the sock files of docker or containerd, accesses their APIs to get the `logpath` of the specified container, similar to executing `docker inspect --format='{{.logpath}}' <container_id>` on the command line:

```shell
$ docker inspect --format='{{.logpath}}' <container_id>

/var/lib/docker/containers/<container_id>/<container_id>-json.log
```

After obtaining the container `logpath`, it uses this path along with the relevant configuration to create log collection.

#### Locating File Paths Inside Containers

To collect files inside containers, you need to mount the file directory externally. This section only describes the scheme for locating file paths inside containers in Kubernetes scenarios.

Taking "collection of logs inside containers" as an example, to collect the `/tmp/opt/1.log` file inside the container, first create an `emptyDir` Volume for the directory `/tmp/opt`. Then execute the command on the host machine (using containerd Runtime as an example):

```shell
$ crictl inspect <container_id>
#...
```

You can see a Mount as follows:

```json
  "mounts": [
    {
      "containerpath": "/tmp/opt",
      "hostpath": "/var/lib/kubelet/pods/<pod_id>/volumes/kubernetes.io~empty-dir/datakit-vol-opt",
      "propagation": "propagation_private",
      "selinuxrelabel": false
    }
  ]
```

Where `containerpath` is the mounted directory inside the container, and `hostpath` is the directory on the host machine. Under this directory, there is a file named `1.log`, which is the log file to be collected.

Datakit finds this `hostpath` from the container Runtime and, according to the configured collection file `1.log`, concatenates it into `/var/lib/kubelet/pods/<pod_id>/volumes/kubernetes.io~empty-dir/datakit-vol-opt/1.log`.

Since Datakit mounts the root directory of the host machine to the `/rootfs` path inside the Datakit container, it eventually becomes `/rootfs/var/lib/kubelet/pods/<pod_id>/volumes/kubernetes.io~empty-dir/datakit-vol-opt/1.log`, which is the actual file Datakit needs to collect.

> When Datakit is deployed as a Kubernetes DaemonSet, it creates a VolumeMount to mount the root directory `/` of the host machine to the `/rootfs` path inside the Datakit container, allowing the Datakit process to read-only access the host machine's files.

### File Filtering

When configuring file paths using glob rules, many files might be found, and some files might not have been updated for a long time, so you don't want to open and collect them. You need to use the `ignore_dead_log` configuration item.

`ignore_dead_log` is a time configuration that can be written as `1h` for 1 hour or `20m` for 20 minutes.

When Datakit discovers this file, it gets its last modification time (`modify time`) and calculates the duration since the last modification using the current time. If the file hasn't been updated for more than 1 hour or 20 minutes, it ignores the file and does not collect it.

The next time it discovers this file, it performs the above check again. Only when the file changes will it initiate collection.

For files that are being opened and collected, if they haven't been updated for a certain period, the collection will stop and close the file resources to avoid long-term occupation.

> The `ignore_dead_log` for container standard output and container internal files is uniformly set to `1h` (1 hour).

### Starting Position for Collection

The starting position for file collection is very important: always collecting from the head may lead to duplicates, while collecting from the tail may lose part of the data.

Datakit has several judgment schemes for the starting position of collection, in order of priority:

1. Continue collecting from the last collection position of the file
  Datakit calculates a hash value based on the file information and records the current collection position of the file in `/usr/local/datakit/cache/logtail.history`. If it accurately finds this position and the value is less than or equal to the file size (indicating no truncation), it continues collecting from this position.

1. Forcefully collect from the head by setting `from_beginning`
  When `from_beginning` is `true` and there is no record of the file's position, collection starts from the head.

1. Determine whether to collect from the head based on file size using `from_beginning_threshold_size`
  `from_beginning_threshold_size` is an integer value. When Datakit discovers a new file, if the file size is less than `from_beginning_threshold_size`, it starts collecting from the head of the file; otherwise, it collects from the tail. The default value is `2e7` (i.e., 20 MB).

1. Start collecting from the tail
  By default, it starts collecting from the tail of the file.

In what situations should `from_beginning` be used?

- To completely collect a specific log file, such as backing up old data. Note that for old data, files that aren't updated for a long time might be filtered out by `ignore_dead_log`.
- On non-Linux systems, if the log data volume is large, for example, writing more than 20 MB (the value of `from_beginning_threshold_size`) every 10 seconds, enabling `from_beginning` is required. Additionally, because the Linux Inotify event notification mechanism exists, theoretically, when a file is generated, Datakit can immediately capture it and start collecting, making the interval very short and unlikely to produce more than 20 MB of data, so enabling `from_beginning` is not strictly necessary.

### Data Encoding Conversion

Datakit supports collecting files encoded in `utf-8` and `gbk`.

### Multiline Data Concatenation

By recognizing the characteristics of the first line of multiline logs, it can determine whether a line of logs is a new log entry. If it doesn't match this characteristic, it considers the current line as an append to the previous multiline log.

For example, logs are usually written flush left, but some log texts are not flush left, such as stack traces during program crashes, which are multiline logs.

In Datakit, multiline log features are identified using regular expressions. Lines that match the regular expression are considered the start of a new log entry; subsequent lines that don't match are considered appendages to the previous multiline log until another line matches the regular expression.

In `logging.conf`, modify the following configuration:

```toml
  multiline_match = '''Here, enter the specific regular expression''' # It is recommended to enclose regular expressions with three 'single quotes'
```

The regular expression style used in the log collector can be referenced [here](https://golang.org/pkg/regexp/syntax/#hdr-syntax){:target="_blank"}

Assuming the original data is:

```not-set
2020-10-23 06:41:56,688 info demo.py 1.0
2020-10-23 06:54:20,164 error /usr/local/lib/python3.6/dist-packages/flask/app.py exception on /0 [get]
traceback (most recent call last):
 file "/usr/local/lib/python3.6/dist-packages/flask/app.py", line 2447, in wsgi_app
  response = self.full_dispatch_request()
zerodivisionerror: division by zero
2020-10-23 06:41:56,688 info demo.py 5.0
```

Setting `multiline_match` to `^\\d{4}-\\d{2}-\\d{2}.*` (meaning matching lines starting with `2020-10-23`),

The three line protocol points cut out (with line numbers 1/2/8). Notice that the segment `traceback ...` (lines 3 ~ 6) does not form a separate log entry but is appended to the `message` field of the previous log entry (line 2).

```not-set
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 info demo.py 1.0" 1611746438938808642
testing,filename=/tmp/094318188 message="2020-10-23 06:54:20,164 error /usr/local/lib/python3.6/dist-packages/flask/app.py exception on /0 [get]
traceback (most recent call last):
 file \"/usr/local/lib/python3.6/dist-packages/flask/app.py\", line 2447, in wsgi_app
  response = self.full_dispatch_request()
zerodivisionerror: division by zero
" 1611746441941718584
testing,filename=/tmp/094318188 message="2020-10-23 06:41:56,688 info demo.py 5.0" 1611746443938917265
```

Besides manually writing multiline matching rules, there is also an automatic multiline mode. Enabling this mode will match each line of log data against the multiline list. If a match is successful, the weight of the current multiline rule is incremented to facilitate faster matching later, and the matching loop exits; if no match is found after going through the entire list, it is considered a failed match.

Successful and failed matches result in the same subsequent operations as normal multiline log collection: on a successful match, the existing multiline data is sent out, and the current data is inserted; on a failed match, it is appended to the end of the existing data.

Because there can be multiple multiline configurations, their priorities are as follows:

1. `multiline_match` is not empty, only the current rule is used.
1. Use the mapping configuration from `source` to `multiline_match` (only available if `logging_source_multiline_map` exists in container log configurations). If the `source` can find a corresponding multiline rule, only this rule is used.
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is not empty, it will match against these multiline rules.
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is empty, use the default automatic multiline matching rule list, i.e.:

```not-set
// time.rfc3339, "2006-01-02t15:04:05z07:00"
`^\d+-\d+-\d+t\d+:\d+:\d+(\.\d+)?(z\d*:?\d*)?`,

// time.ansic, "mon jan _2 15:04:05 2006"
`^[a-za-z_]+ [a-za-z_]+ +\d+ \d+:\d+:\d+ \d+`,

// time.rubydate, "mon jan 02 15:04:05 -0700 2006"
`^[a-za-z_]+ [a-za-z_]+ \d+ \d+:\d+:\d+ [\-\+]\d+ \d+`,

// time.unixdate, "mon jan _2 15:04:05 mst 2006"
`^[a-za-z_]+ [a-za-z_]+ +\d+ \d+:\d+:\d+( [a-za-z_]+ \d+)?`,

// time.rfc822, "02 jan 06 15:04 mst"
`^\d+ [a-za-z_]+ \d+ \d+:\d+ [a-za-z_]+`,

// time.rfc822z, "02 jan 06 15:04 -0700" // rfc822 with numeric zone
`^\d+ [a-za-z_]+ \d+ \d+:\d+ -\d+`,

// time.rfc850, "monday, 02-jan-06 15:04:05 mst"
`^[a-za-z_]+, \d+-[a-za-z_]+-\d+ \d+:\d+:\d+ [a-za-z_]+`,

// time.rfc1123, "mon, 02 jan 2006 15:04:05 m