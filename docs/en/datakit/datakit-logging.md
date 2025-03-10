# Comprehensive Guide to Datakit Log Collection

## Preface {#intro}

Log collection is an important feature of Guance Datakit. It processes log data collected proactively or received passively and ultimately uploads it to the Guance center.

Based on the data source, logs can be categorized into "log file data" and "network stream data". These correspond to the following:

- "Log file data":
    - Local disk files: Fixed files stored on the disk, collected via the logging collector
    - Container standard output: The container runtime stores standard output (stdout/stderr) on disk, and the container collector accesses the runtime to get the path of the log file for collection
    - Logs within containers: Using Volume/VolumeMount methods to mount files externally so that Datakit can access them

- "Network stream data":
    - tcp/udp data: Datakit listens to corresponding tcp/udp ports to receive log data
    - Log streaming: Receives data via the http protocol

The configuration methods and use cases for these types of data vary significantly, which will be detailed below.

## Use Cases and Configuration Methods {#config}

### Local Disk File Collection {#config-local-files}

This chapter only describes scenarios where Datakit is deployed on a host. It is not recommended to collect local files if deployed in Kubernetes.

First, start a logging collector by entering the `conf.d/log` directory under the Datakit installation directory, copying `logging.conf.sample` and renaming it to `logging.conf`. Example as follows:

``` toml
  [[inputs.logging]]
   # List of log files, absolute paths can be specified, supporting glob rules for batch designation
   # Recommend using absolute paths with file extensions
   # Try to narrow the scope to avoid collecting compressed or binary files
   logfiles = [
    "/var/log/*.log",           # All log files under this path
    "/var/log/*.txt",           # All txt files under this path
    "/var/log/sys*",            # All files starting with sys under this path
    "/var/log/syslog",           # Unix format file path
    "c:/path/space 空格中文路径/some.txt", # Windows style file path
   ]
  
   ## Socket currently supports two protocols: tcp/udp. It is recommended to enable internal network ports to prevent security risks
   ## Only one of socket or log can be chosen; both cannot be used simultaneously
   sockets = [
    "tcp://0.0.0.0:9540"
    "udp://0.0.0.0:9541"
   ]
  
  # File path filtering, using glob rules, any matching condition will result in the file not being collected
   ignore = [""]
   
   # Data source, if empty, defaults to 'default'
   source = ""
   
   # New tag, if empty, defaults to $source
   service = ""
   
   # Pipeline script path, if empty, uses $source.p; if $source.p does not exist, pipeline is not used
   pipeline = ""
   
   # Select encoding, incorrect encoding may cause data viewing issues. Default is empty
   # `utf-8`,`gbk`
   character_encoding = ""
   
   ## Set regular expressions, e.g., ^\d{4}-\d{2}-\d{2} matches yyyy-mm-dd time format at the beginning of lines
   ## Data matching this regular expression is considered valid; otherwise, it will be appended to the end of the previous valid data
   ## Use three single quotes '''this-regexp''' to avoid escaping
   ## Regular expression link: https://golang.org/pkg/regexp/syntax/#hdr-syntax
   # multiline_match = '''^\s'''
  
   ## Whether to enable automatic multiline mode, when enabled, it matches applicable multiline rules in the patterns list
   auto_multiline_detection = true
   ## Configure the patterns list for automatic multiline detection, containing arrays of multiline rules, i.e., multiple multiline_match. If empty, default rules apply, see documentation
   auto_multiline_extra_patterns = []
  
   ## Whether to remove ANSI escape codes, such as text color in standard output
   remove_ansi_escape_codes = false
  
   ## Ignore inactive files, e.g., if the last modification was 20 minutes ago, exceeding 10m from now, this file will be ignored
   ## Time units support "ms", "s", "m", "h"
   ignore_dead_log = "1h"
  
   ## Whether to read from the beginning of the file
   from_beginning = false
  
   # Custom tags
   [inputs.logging.tags]
   # some_tag = "some_value"
   # more_tag = "some_other_value"
```

This is a basic `logging.conf`, the roles of fields like `multiline_match`, `pipeline`, etc., are explained in detail in the subsequent features section.

### Container Standard Output Collection {#config-stdout}

Collecting the standard output of container applications is the most common method, similar to using `docker logs` or `crictl logs`.

Console output (i.e., stdout/stderr) is written to files through the container runtime, and Datakit automatically retrieves the container's `logpath` for collection.

If custom configurations are needed, they can be added through container environment variables or Kubernetes Pod Annotations.

- Custom configuration keys include:
    - Container environment variable key is fixed as `datakit_logs_config`
    - Pod Annotation key has two formats:
        - `datakit/<container_name>.logs`, where `<container_name>` should be replaced with the current Pod’s container name, useful in multi-container environments
        - `datakit/logs` applies to all containers in the Pod

<!-- markdownlint-disable md046 -->
???+ info

    If a container has an environment variable `datakit_logs_config` and its parent Pod also has an Annotation `datakit/logs`, the configuration in the container environment variable takes precedence.
<!-- markdownlint-enable -->

- Custom configuration values are as follows:

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
| `type`                         | `file`/not filled | Choose the collection type. If collecting files within a container, must specify `file`. Default is empty for collecting `stdout/stderr`                                          |
| `path`                         | String            | Configuration file path. If collecting files within a container, must specify the Volume path, not the path inside the container but the accessible path outside the container. Default collects `stdout/stderr` without filling                             |
| `source`                       | String            | Log source, refer to [Container log collection source settings](../integrations/container.md#config-logging-source)                                                                 |
| `service`                      | String            | Service associated with the log, default value is the log source (source)                                                                                                         |
| `pipeline`                     | String            | Pipeline script applicable to this log, default value is the script name matching the log source (`<source>.p`)                                                                   |
| `remove_ansi_escape_codes`     | true/false        | Whether to remove color characters from log data                                                                                                                                  |
| `from_beginning`               | true/false        | Whether to collect logs from the beginning of the file                                                                                                                            |
| `multiline_match`              | Regular expression string | Used for identifying the first line of [multi-line log matching](../integrations/logging.md#multiline), e.g., `"multiline_match":"^\\d{4}"` indicating the line starts with four digits, `\d` represents a digit, and the preceding `\` escapes it |
| `character_encoding`           | String            | Select encoding, incorrect encoding may lead to unreadable data. Supports `utf-8`, `utf-16le`, `utf-16le`, `gbk`, `gb18030` or "". Default is empty                                                           |
| `tags`                         | Key/value pairs   | Add additional tags, existing same-name keys will be overwritten ([:octicons-tag-24: version-1.4.6](changelog.md#cl-1.4.6))                                                     |

A complete example is as follows:

<!-- markdownlint-disable md046 -->
=== "Container Environment Variable"

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
        ## Add configuration and specify the container as log-output
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
    
    Execute Kubernetes command to apply the configuration:
    
    ``` shell
    $ kubectl apply -f log-output.yaml
    #...
    ```

---

???+ attention

    - Unless necessary, do not configure Pipelines in environment variables and Pod Annotations; usually, automatic inference via the `source` field is sufficient.
    - If adding Environment/Annotations in configuration files or terminal commands, ensure double quotes are in English state and add escape characters on both sides.


The value of `multiline_match` is doubly escaped, requiring four backslashes to represent one, for example, `\"multiline_match\":\"^\\\\d{4}\"` is equivalent to `"multiline_match":"^\d{4}"`, example:

```shell
$ kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"log-source\",\"service\":\"log-service\",\"pipeline\":\"test.p\",\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
#...
```

If a Pod/container log is already being collected, adding configuration via the `kubectl annotate` command afterward will not take effect.


### Collection of Logs Within Containers {#config-container-files}

For logs inside containers, unlike console output logs, you need to specify the file path, with other configuration items being largely similar.

Similarly, add container environment variables or Kubernetes Pod Annotations, with keys and values basically consistent; see the earlier sections.

Complete example as follows:

<!-- markdownlint-disable md046 -->
=== "Container Environment Variable"

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
      ## Specify non-stdout path, "type" and "path" are mandatory fields, and a Volume needs to be created for the collection path
      ## For example, to collect `/tmp/opt/1.log`, an anonymous Volume for `/tmp/opt` needs to be added
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
        ## Add configuration and specify the container as logging-demo
        ## Both file and stdout collection are configured. Note that to collect "/tmp/opt/1.log", an emptydir Volume must be added for "/tmp/opt"
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
    
    Execute Kubernetes command to apply the configuration:
    
    ``` shell
    $ kubectl apply -f logging.yaml
    #...
    ```
    
    For logs inside containers, in a Kubernetes environment, sidecar addition can also be used for collection, see [here](../integrations/logfwd.md).

### TCP/UDP Data Reception {#config-tcpudp}

Comment out `logfiles` in `logging.conf` and configure `sockets`, for example:

```yaml
[[inputs.logging]]
 sockets = [
  "tcp://127.0.0.1:9540"
  "udp://127.0.0.1:9541"
 ]

 source = "socket-testing"
```

This configuration listens to tcp port 9540 and udp port 9541 simultaneously. Log data received from these ports has a unified source of `socket-testing`.

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

### HTTP Data Reception {#config-logstreaming}

Start an HTTP server to receive log text data and report it to Guance. The HTTP URL is fixed at: `/v1/write/logstreaming`, i.e., `http://datakit_ip:port/v1/write/logstreaming`

> Note: If Datakit is deployed as a DaemonSet in Kubernetes, you can use the Service method to access it, with the address being `http://datakit-service.datakit:9529`

<!-- markdownlint-disable md046 -->
=== "Host Installation"

    Enter the `conf.d/log` directory under the Datakit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`. Example as follows:
      
    ```toml
    [inputs.logstreaming]
      ignore_url_tags = false
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## Buffer is the size of jobs' buffering of worker channel.
      ## Threads is the total number fo goroutines at running time.
      # [inputs.logstreaming.threads]
      #   buffer = 100
      #   threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## Path is the local file path used to cache data.
      ## Capacity is total space size(MB) used to store data.
      # [inputs.logstreaming.storage]
      #   path = "./log_storage"
      #   capacity = 5120
    ```
    
    After configuring, [restart Datakit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, [ConfigMap injection can be used to enable the collector](datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

#### Supported Parameters for logstreaming {#logstreaming-args}

Logstreaming supports flexible operations on log data by adding parameters to the http url. Below are supported parameters and their functions:

- `type`: Data format, currently supports `influxdb` and `firelens`.
    - When `type` is `inflxudb` (`/v1/write/logstreaming?type=influxdb`), it indicates the data is in line protocol format (default precision is `s`), only built-in tags will be added, no other operations will be performed
    - When `type` is `firelens` (`/v1/write/logstreaming?type=firelens`), the data format should be JSON-formatted multiple logs
    - When this value is empty, the data will be processed for splitting and Pipeline operations
- `source`: Identifies the data source, i.e., the measurement of the line protocol. For example, `nginx` or `redis` (`/v1/write/logstreaming?source=nginx`)
    - When `type` is `influxdb`, this value is invalid
    - Defaults to `default`
- `service`: Adds a service label field, for example (`/v1/write/logstreaming?service=nginx_service`)
    - Defaults to the value of the `source` parameter.
- `pipeline`: Specifies the pipeline name for the data, for example `nginx.p` (`/v1/write/logstreaming?pipeline=nginx.p`)
- `tags`: Adds custom tags, separated by commas `,`, for example `key1=value1` and `key2=value2` (`/v1/write/logstreaming?tags=key1=value1,key2=value2`)

#### logstreaming Usage Examples {#logstreaming-cases}

- Fluentd using influxdb output [documentation](https://github.com/fangli/fluent-plugin-influxdb){:target="_blank"}
- Fluentd using http output [documentation](https://docs.fluentd.org/output/http){:target="_blank"}
- Logstash using influxdb output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-influxdb.html){:target="_blank"}
- Logstash using http output [documentation](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html){:target="_blank"}

Just configure the output host to the log-streaming url (`http://datakit_ip:port/v1/write/logstreaming`) and add the corresponding parameters.

## Log Collection Details {#logging-collect-details}

### Discovering Log Files {#discovery}

#### Glob Configuration File Paths {#glob-discovery}

Log collection uses glob rules to conveniently specify log files and automate discovery and file filtering.

| Wildcard   | Description                               | Regex Example       | Match Example                    | Not Match                        |
| :--        | ---                                | ---            | ---                         | ----                          |
| `*`        | Matches any number of any characters, including none     | `law*`         | `law, laws, lawyer`         | `groklaw, la, aw`             |
| `?`        | Matches any single character                   | `?at`          | `cat, bat`        | `at`                          |
| `[abc]`    | Matches one character given in brackets           | `[cb]at`       | `cat, bat`                  | `bat`                    |
| `[a-z]`    | Matches one character in the range given in brackets   | `letter[0-9]`  | `letter0, letter1, letter9` | `letters, letter, letter10`   |
| `[!abc]`   | Matches one character not given in brackets         | `[!c]at`       | `bat, bat, cat`             | `cat`                         |
| `[!a-z]`   | Matches one character not in the range given in brackets | `letter[!3-5]` | `letter1…`                  | `letter3 … letter5, letterxx` |

Additionally, the collector supports `**` for recursive file traversal, as shown in the sample configuration. More about globbing can be found [here](https://rgb-24bit.github.io/blog/2018/glob.html){:target="_blank"}.

#### Discovering Local Log Files {#local-file-discovery}

Regular log files are the most common type, directly writing readable record data to disk files by processes, like the famous “log4j” framework or executing `echo "this is log" >> /tmp/log` would generate log files.

These log file paths are mostly fixed. For instance, MySQL's log path on Linux platforms is `/var/log/mysql/mysql.log`. If running the MySQL Datakit collector, it will default to searching for log files in this path. However, since log storage paths are configurable, Datakit cannot cover all scenarios, so manual specification of file paths must be supported.

In Datakit, use glob patterns to configure file paths, using wildcards to locate filenames (though they can also be used without wildcards).

For example, there are the following files:

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

In the Datakit logging collector, specify the log files to collect by configuring the `logfiles` parameter, for example:

- Collect all files in the `datakit` directory, glob is `/tmp/datakit/*`
- Collect all files named `datakit`, corresponding glob is `/tmp/datakit/datakit-*log`
- Collect `mysql.log`, but there are two layers of directories `mysql.d` and `mysql` in between, several methods can be used to locate the `mysql.log` file:
    - Directly specify: `/tmp/mysql.d/mysql/mysql.log`
    - Single asterisk: `/tmp/*/*/mysql.log`, this method is rarely used
    - Double asterisk (`double star`): `/tmp/**/mysql.log`, using double asterisk `**` instead of multiple intermediate directory structures is a cleaner and commonly used way

After specifying file paths using glob in the configuration file, Datakit will periodically search the disk for files that match the rules. If it finds files not already in the collection list, it adds them and begins collection.

#### Locating Container Standard Output Logs {#discovery-container-stdout-logs}

There are two ways to output logs in containers:

- One is to write directly to mounted disk directories, which, from the host's perspective, is the same as the aforementioned "regular log files," being fixed-position files on the disk.
- Another way is to output to stdout/stderr, collected and managed by the container's Runtime and then written to disk. This is a more common approach. The path to this log file can be obtained by accessing the Runtime API.

Datakit connects to the sock files of Docker or containerd, accesses their APIs to obtain the `logpath` of the specified container, similar to executing `docker inspect --format='{{.logpath}}' <container_id>` in the command line:

```shell
$ docker inspect --format='{{.logpath}}' <container_id>

/var/lib/docker/containers/<container_id>/<container_id>-json.log
```

After obtaining the container's `logpath`, it creates log collection using this path and the corresponding configuration.

#### Locating Internal Container File Paths {#discovery-container-file-logs}

To collect logs from inside containers, you need to mount the file directory externally. This section only describes the scheme for locating internal container file paths in Kubernetes scenarios.

Using the previous example of "collecting logs from within containers," to collect the `/tmp/opt/1.log` file within a container, first create an `emptyDir` Volume for the `/tmp/opt` directory. At this point, execute the command on the host machine (using containerd Runtime as an example):

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

Datakit finds this `hostpath` from the container Runtime and concatenates it with the configured collection file `1.log` to form `/var/lib/kubelet/pods/<pod_id>/volumes/kubernetes.io~empty-dir/datakit-vol-opt/1.log`.

Since Datakit mounts the root directory of the host machine to the `/rootfs` path in the Datakit container, it eventually becomes `/rootfs/var/lib/kubelet/pods/<pod_id>/volumes/kubernetes.io~empty-dir/datakit-vol-opt/1.log`, which is the actual file Datakit needs to collect.

> When Datakit is deployed as a Kubernetes DaemonSet, it creates a VolumeMount that mounts the root directory `/` of the host machine to the `/rootfs` path in the Datakit container, allowing the Datakit process to read-only access files on the host machine.

### File Filtering {#skip-logs}

When configuring file paths using glob rules, many files may be found, some of which have not been updated for a long time and should not be opened or collected. The `ignore_dead_log` configuration item is needed here.

`ignore_dead_log` is a time configuration, which can be written as `1h` representing 1 hour or `20m` representing 20 minutes.

When Datakit discovers this file, it gets the last modified time (modify time) of the file, calculates the duration since the last modification using the current time. If the file has not been updated for more than 1 hour or 20 minutes, it ignores this file and does not collect it.

When discovering this file again next time, it performs the above judgment again. Only when the file changes will it create and collect it.

For files that are currently open and being collected, if they have not been updated for a certain period of time, the collection will exit and close the file resources to avoid long-term occupation.

> The `ignore_dead_log` for container standard output and internal container files is uniformly set to `1h` or 1 hour.

### Starting Position for Collection {#start-pos}

The starting position for file collection is very important: always collecting from the head might lead to duplicate data, while collecting from the tail might lose part of the data.

Datakit has several schemes for judging the starting position of collection, in order of priority:

1. Continue collecting from the last position of the previous collection
  Datakit calculates a hash value based on file information and records the current collection position of the file in `/usr/local/datakit/cache/logtail.history`. If it accurately finds this position and the value is less than or equal to the file size (indicating it has not been truncated), it continues to collect from this position.

1. Forcefully collect from the head using the `from_beginning` configuration
  When `from_beginning` is `true`, and there is no record of the file's position, it starts collecting from the head.

1. Determine whether to collect from the head based on file size using `from_beginning_threshold_size`
  `from_beginning_threshold_size` is an integer value. When Datakit discovers a new file, if the file size is less than `from_beginning_threshold_size`, it starts collecting from the head of the file; otherwise, it starts from the tail. The default value is `2e7` (i.e., 20 MB).

1. Start collecting from the tail
  By default, it starts collecting from the tail.

When should `from_beginning` be used?

- To fully collect a certain log file, for example, for backing up old data. Note that old data usually remains unchanged for a long time and may be filtered out by `ignore_dead_log`.
- In non-Linux systems where log data volume is large, for example, 10 seconds of writing exceeds 20 MB (`from_beginning_threshold_size`), enabling `from_beginning` is required.

Supplement for the second point:

Datakit searches for new files every 10 seconds. If it happens to coincide with this time boundary, causing Datakit to find the file 10 seconds later when it exceeds 20 MB, according to the strategy, it should start collecting from the tail. In this case, `from_beginning` should be forcibly enabled to start collecting from the head. Additionally, because Linux has the Inotify event notification mechanism, theoretically, Datakit can immediately capture and start collecting the file when it is generated, making the interval very short and unlikely to produce more than 20 MB of data, so it is not necessary to enable `from_beginning`.


### Data Encoding Conversion {#encoding}

Datakit supports collecting files encoded in `utf-8` and `gbk`.

### Multiline Data Concatenation {#multi-line}

By identifying the characteristics of the first line of multiline logs, it can determine whether a line is a new log entry. If it does not match this characteristic, it is considered an append to the previous multiline log.

For example, logs are generally written flush-left, but some logs are not, such as stack traces when a program crashes, which are multiline logs.

In Datakit, multiline log features are identified using regular expressions. Lines that match the regular expression are considered the start of a new log entry; all subsequent lines that do not match are considered appendages to this new log entry until another line matches the regular expression as the start of a new log entry.

In `logging.conf`, modify the following configuration:

```toml
  multiline_match = '''Here fill in the specific regular expression''' # It is recommended to enclose regular expressions with three single quotes
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

Setting `multiline_match` to `^\\d{4}-\\d{2}-\\d{2}.*` (meaning lines starting with something like `2020-10-23`),

The resulting three line protocol points are as follows (line numbers are 1/2/8). You can see that the `traceback ...` segment (lines 3 ~ 6) does not form a separate log entry but is appended to the `message` field of the previous log entry (line 2).

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

Besides manually writing multiline matching rules, there is also an automatic multiline mode. When this mode is enabled, each line of log data will be matched against the multiline list. If a match is successful, the weight of the current multiline rule increases by one to facilitate faster matching later, and then the matching cycle exits; if no match is found after the entire list ends, it is considered a failed match.

Successful and failed matches are handled similarly to normal multiline log collection: On a successful match, the existing multiline data is sent out, and the current data is filled in; on a failed match, it is appended to the end of the existing data.

Because there can be multiple multiline configurations, their priorities are as follows:

1. `multiline_match` is not empty, only the current rule is used
1. Use the mapping configuration from `source` to `multiline_match` (only in container log configurations where `logging_source_multiline_map` exists). If a multiline rule can be found using `source`, only this rule is used
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is not empty, it will match in these multiline rules
1. Enable `auto_multiline_detection`, if `auto_multiline_extra_patterns` is empty, use the default automatic multiline matching rule list, i.e.:

```not-set
// time.rfc3339, "2006-01-02t15:04:05z07:00"
`^\d+-\d+-\d+t\d+:\d+:\d+(\.\d+)?(z\d*:?\d*)?`,

// time.ansic, "mon jan _2 15:04:05 2006"
`^[a-za-z_]+ [a-za-z_]+ +\d+ \d+:\d+:\d+ \d+`,

// time.rubydate, "mon jan 02 15:04:05 -0700 2006"
`^[a-za-z_]+ [a-za-z_]+ \d+ \d+:\d+:\d+ [\-\+]\d+ \d+`,

// time.unixdate, "mon jan _2 15:04:05 mst 2006"
`^[a-za-z_]+ [a-za-z_]+ +\d+```not-set
\d+:\d+( [a-za-z_]+ \d+)?`,

// time.rfc822, "02 jan 06 15:04 mst"
`^\d+ [a-za-z_]+ \d+ \d+:\d+ [a-za-z_]+`,

// time.rfc822z, "02 jan 06 15:04 -0700" // rfc822 with numeric zone
`^\d+ [a-za-z_]+ \d+ \d+:\d+ -\d+`,

// time.rfc850, "monday, 02-jan-06 15:04:05 mst"
`^[a-za-z_]+, \d+-[a-za-z_]+-\d+ \d+:\d+:\d+ [a-za-z_]+`,

// time.rfc1123, "mon, 02 jan 2006 15:04:05 mst"
`^[a-za-z_]+, \d+ [a-za-z_]+ \d+ \d+:\d+:\d+ [a-za-z_]+`,

// time.rfc1123z, "mon, 02 jan 2006 15:04:05 -0700" // rfc1123 with numeric zone
`^[a-za-z_]+, \d+ [a-za-z_]+ \d+ \d+:\d+:\d+ -\d+`,

// time.rfc3339nano, "2006-01-02t15:04:05.999999999z07:00"
`^\d+-\d+-\d+[a-za-z_]+\d+:\d+:\d+\.\d+[a-za-z_]+\d+:\d+`,

// 2021-07-08 05:08:19,214
`^\d+-\d+-\d+ \d+:\d+:\d+(,\d+)?`,

// default java logging simpleformatter date format
`^[a-za-z_]+ \d+, \d+ \d+:\d+:\d+ (am|pm)`,

// 2021-01-31 - with stricter matching around the months/days
`^\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])`,
```

### Filtering Special Byte Codes {#escaping}

Logs may contain unreadable special characters (such as color codes in terminal output), which can be filtered out by setting `remove_ansi_escape_codes` to `true`.

"Special characters" here refer to color characters in the data, for example, the following command outputs a red `red` word in the command line terminal:

```shell
$ red='\033[0;31m' && nc='\033[0m' && print "${red}red${nc}"
#...
```

If not processed, the collected log would be `\033[0;31m`, which is not only unappealing and storage-consuming but may also negatively impact subsequent data processing. Therefore, it's necessary to filter out these special color characters.

<!-- markdownlint-disable md046 -->
???+ attention

The open-source community has many cases where regular expressions are used for implementation, but the performance is not optimal. For a mature log output framework, there should be a way to disable color characters. Datakit recommends this approach, where the log producer avoids printing color characters.

For such color characters, it is usually recommended to disable them at the log output framework level rather than filtering through Datakit. The filtering of special characters involves regex processing, which may not cover all cases comprehensively and incurs some performance overhead.
<!-- markdownlint-enable -->

Benchmark results for processing performance are as follows, for reference:

```text
goos: linux
goarch: arm64
pkg: ansi
benchmarkstrip
benchmarkstrip-2     653751       1775 ns/op       272 b/op     3 allocs/op
benchmarkstrip-4     673238       1801 ns/op       272 b/op     3 allocs/op
pass
ok   ansi   2.422s
```

Each text processing increases latency by approximately 1700 ns. Not enabling this feature will incur no additional overhead.

### Pipeline Field Splitting {#pipeline}

[Pipelines](../pipeline/use-pipeline/index.md) are mainly used to parse unstructured text data or extract partial information from structured text (such as JSON).

For log data, the main fields extracted are:

- `time`: The generation time of the log. If the `time` field is not extracted or parsing fails, the system current time is used by default.
- `status`: The log level. If the `status` field is not extracted, it defaults to `unknown`.

Valid values for the `status` field are as follows (case-insensitive):

| Log Level          | Abbreviation    | Studio Display Value |
| ------------          | :----   | ----          |
| `alert`               | `a`     | `alert`       |
| `critical`            | `c`     | `critical`    |
| `error`               | `e`     | `error`       |
| `warning`             | `w`     | `warning`     |
| `notice`              | `n`     | `notice`      |
| `info`                | `i`     | `info`        |
| `debug/trace/verbose` | `d`     | `debug`       |
| `ok`                  | `o`/`s` | `ok`          |

Example: Assuming the text data is as follows:

```not-set
12115:m 08 jan 17:45:41.572 # server started, redis version 3.0.6
```

Pipeline script:

```python
add_pattern("date2", "%{monthday} %{month} %{year}?%{time}")
grok(_, "%{int:pid}:%{word:role} %{date2:time} %{notspace:serverity} %{greedydata:msg}")
group_in(serverity, ["#"], "warning", status)
cast(pid, "int")
default_time(time)
```

Final result:

```python
{
  "message": "12115:m 08 jan 17:45:41.572 # server started, redis version 3.0.6",
  "msg": "server started, redis version 3.0.6",
  "pid": 12115,
  "role": "m",
  "serverity": "#",
  "status": "warning",
  "time": 1610127941572000000
}
```

Points to note about Pipelines:

- If `pipeline` is empty in the `logging.conf` configuration file, the default is `<source-name>.p` (assuming `source` is `nginx`, then the default is `nginx.p`)
- If `<source-name>.p` does not exist, the Pipeline feature is not enabled
- All Pipeline script files are stored uniformly in the `pipeline` directory under the Datakit installation path

### Retaining Specified Fields Based on Whitelist {#field-whitelist}

Log collection includes the following basic fields:

| Field Name                   | Exists Only in Container Logs |
| -----------              | -----------          |
| `service`                |                      |
| `status`                 |                      |
| `filepath`               |                      |
| `host`                   |                      |
| `log_read_lines`         |                      |
| `container_id`           | Yes                   |
| `container_name`         | Yes                   |
| `namespace`              | Yes                   |
| `pod_name`               | Yes                   |
| `pod_ip`                 | Yes                   |
| `deployment`/`daemonset` | Yes                   |

In special scenarios, many basic fields may not be necessary. A whitelist feature is provided to retain only specified fields.

Field whitelisting is only supported via environment variables, for example, `ENV_LOGGING_FIELD_WHITE_LIST = '["host", "service", "filepath", "container_name"]'`. Specific details are as follows:

- If the whitelist is empty, all basic fields are added
- If the whitelist is not empty and valid, for example, `["filepath", "container_name"]`, only these two fields are retained
- If the whitelist is not empty and contains invalid fields, for example, `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded

For tags from other sources, there are several situations:

- The whitelist does not affect Datakit's global tags (`global tags`)
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` are unaffected, including `log_read_offset` and `log_file_inode` for log collection, as well as debug fields for `pipeline`

<!-- markdownlint-disable md046 -->
???+ attention

The field whitelist is a global configuration that applies to both container logs and the logging collector.
<!-- markdownlint-enable -->

### Maximum Number of Files Being Collected {#max-collecting-files}

Set the maximum number of files being collected using the environment variable `ENV_LOGGING_MAX_OPEN_FILES`. For example, `ENV_LOGGING_MAX_OPEN_FILES="1000"` indicates up to 1000 files can be collected simultaneously.

This prevents excessive resource consumption by Datakit due to too many files matched by glob rules.

`ENV_LOGGING_MAX_OPEN_FILES` is a global configuration affecting both the logging collector and container log collection. Its default value is 500.

## Detailed Collection Description {#more-colect-details}

### Setting the Source for Container Log Collection {#source-for-container-log}

In container environments, the log source (`source`) setting is an important configuration item directly impacting display effects on the page. However, manually configuring the log source for each container would be cumbersome. If you do not manually configure the container log source, Datakit uses the following rules (in descending order of priority) to automatically infer the source of container logs:

> An unspecified container log source means not specifying it in Pod Annotations or container.conf (currently no configuration item for specifying container log sources in container.conf)

- Kubernetes-specified container name: obtained from the `io.kubernetes.container.name` label of the container
- Container name itself: the container name visible through `docker ps` or `crictl ps`
- `default`: the default `source`

### Limitation on Handling Extremely Long Multiline Logs {#split-large-log}

Datakit log collection supports up to 512 KiB per single line log. If it exceeds 512 KiB, it will be truncated, and the next byte starts a new log entry.

Multiline logs can be up to `ENV_DATAWAY_MAX_RAW_BODY_SIZE * 0.8`, which defaults to 819 KiB. If it exceeds this value, it will similarly be truncated and create a new log entry.

### Discovery Process of Disk Files {#scan-and-inotify}

Datakit discovers log files by regularly scanning files according to glob rules every 10 seconds and using the inotify event notification mechanism. Inotify is only supported when Datakit is deployed in a Linux environment.

### Recommended File Rotation Scheme {#file-rotate}

Log file rotation (rotate) is a common behavior, and most log output frameworks have this functionality.

Generally, there are two types of file rotations:

- Using time or numbers as filenames, always creating new files

For example, there is now a log file `/opt/log/access-20241203-10.log`. When this file meets certain conditions (usually exceeding a specified size), it stops updating, and a new file `/opt/log/access-20241203-11.log` is created for continued writing.

For this type of rotation, it is recommended to keep the number of files limited, ideally around 5. Too many files can reduce file search performance.

It is recommended to write the collection path as `/opt/log/*.log`. Datakit will monitor the directory or periodically search for log files that match this pattern. For old files that have stopped updating, Datakit will periodically clean up and release resources.

- Fixed filename unchanged, renaming files for rotation

For example, there is a file `/opt/log/access-0.log`. When it is full, it is renamed to `/opt/log/access-1.log` as a backup, and a new `/opt/log/access-0.log` is created for continued writing.

This is Docker's `file-json` rotation method. Docker containers can adjust file sizes and counts using parameters like `--log-opt max-size=100m` and `--log-opt max-file=3`.

For this type of rotation, the collection path cannot use `*.log`, as it would collect backup files, leading to duplicate collection.

The collection path should be written as `/opt/log/access-0.log`, collecting only this one file.

> Additionally, there is another type of rotation similar to executing `truncate -s 0` in Linux to truncate the file size to 0 bytes, clearing the file content. This rotation method is not recommended because it completely clears the file content. If Datakit does not collect the end in time, all end data will be lost.

## FAQ {#faq}

### Remote File Collection Scheme {#faq-remote-logs}

On Linux operating systems, you can use the [NFS method](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/){:target="_blank"} to mount the log file path on the host machine to the Datakit host. The logging collector configures the corresponding log path.

### MacOS Log Collector Error `operation not permitted` {#permission-on-macos}

On macOS, due to system security policies, the Datakit log collector might fail to open files, reporting an error `operation not permitted`. Refer to the [Apple Developer documentation](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection){:target="_blank"} for solutions.

### Estimating Total Log Volume {#stat-log-usage}

Since log charges are based on the number of entries, most logs are written to disk by programs, allowing you to see only the disk usage size (e.g., 100GB of logs daily).

A feasible method to estimate is using a simple shell command:

```shell
# Count lines in 1GB of logs
head -c 1g path/to/your/log.txt | wc -l
```

Sometimes, you need to estimate the potential network traffic consumption caused by log collection:

```shell
# Estimate compressed size (bytes) of 1GB logs
head -c 1g path/to/your/log.txt | gzip | wc -c
```

Here, the compressed byte count can be converted to bandwidth consumption using the following calculation method (considering network bit calculations), providing an approximate bandwidth consumption:

``` not-set
bytes * 2 * 8 /1024/1024 = xxx mbit
```

However, Datakit's compression rate is generally not this high because Datakit does not send 1GB of data at once but in multiple batches, with a compression rate around 85% (i.e., 100MB compressed to 15MB). Thus, an approximate calculation method is:

``` not-set
1gb * 2 * 8 * 0.15/1024/1024 = xxx mbit
```

<!-- markdownlint-disable md046 -->
??? info

Here `*2` considers the actual data expansion caused by [Pipeline splitting](../pipeline/use-pipeline/index.md), as generally the original data is included after splitting. Therefore, the worst-case scenario is considered, doubling the data volume for calculation purposes.
<!-- markdownlint-enable -->

### Soft Link Issues in Log Directories {#soft-links}

Under normal circumstances, Datakit retrieves the log file path from the container Runtime and then collects the file.

In some special environments, a soft link may be created for the directory containing the log file. Datakit cannot anticipate the target of the soft link and cannot mount the directory, resulting in failure to locate the log file and inability to collect it.

For example, suppose a container log file path is `/var/log/pods/default_log-demo_f2617302-9d3a-48b5-b4e0-b0d59f1f0cd9/log-output/0.log`, but in the current environment, `/var/log/pods` is a symbolic link pointing to `/mnt/container_logs`, as shown below:

```shell
$ ls /var/log -lh
total 284k
lrwxrwxrwx 1 root root  20 oct 8 10:06 pods -> /mnt/container_logs/
```

Datakit needs to mount the `/mnt/container_logs` hostpath to enable normal collection. For example, add the following in `datakit.yaml`:

```yaml
  # Omitted
  spec:
   containers:
   - name: datakit
    image: pubrepo.guance.com/datakit/datakit:1.16.0
    volumemounts:
    - mountpath: /mnt/container_logs
     name: container-logs
   # Omitted
   volumes:
   - hostpath:
     path: /mnt/container_logs
    name: container-logs
```

This situation is uncommon and is usually handled only if the path is known to have a symbolic link or if errors in Datakit logs indicate collection issues.

### Adjusting Log Collection Based on Container Image {#config-logging-on-container-image}

By default, Datakit collects standard output logs from all containers on the host, which can lead to collecting a large amount of logs. You can filter containers using the image or namespace.

<!-- markdownlint-disable md046 -->
=== "Host Installation"

    ``` toml
      ## Example using image
      ## When the container's image matches `datakit`, it will collect logs from this container
      container_include_log = ["image:datakit"]
    
      ## Ignore all kodo containers
      container_exclude_log = ["image:kodo"]
    ```
    
    `container_include` and `container_exclude` must start with a property field, formatted as a [glob-like regex](https://en.wikipedia.org/wiki/glob_(programming)){:target="_blank"}: `"<field_name>:<glob rule>"`
    
    Currently, the following four field rules are supported, all of which are infrastructure attribute fields:
    
    - image : `image:pubrepo.guance.com/datakit/datakit:1.18.0`
    - image_name : `image_name:pubrepo.guance.com/datakit/datakit`
    - image_short_name : `image_short_name:datakit`
    - namespace : `namespace:datakit-ns`
    
    For the same type of rule (`image` or `namespace`), if both `include` and `exclude` exist, both conditions must be met simultaneously. For example:
    
    ```toml
      ## This would filter out all containers
      ## For instance, a container `datakit` satisfies include but also satisfies exclude, so it will be filtered out and its logs not collected; if a container `nginx` does not satisfy include, it will also be filtered out.
      container_include_log = ["image_name:datakit"]
      container_exclude_log = ["image_name:*"]
    ```
    
    If any of the multiple field rules match, it will stop collecting logs from that container. For example:
    
    ```toml
      ## The container only needs to satisfy either `image_name` or `namespace` to stop collecting logs.
      container_include_log = []
      container_exclude_log = ["image_name:datakit", "namespace:datakit-ns"]
    ```
    
    The configuration rules for `container_include_log` and `container_exclude_log` are complex. It is recommended to only use `container_exclude_log`.

=== "Kubernetes"

    Use the following environment variables
    
    - ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
    - ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG
    
    To configure container log collection. Suppose there are 3 Pods with images respectively:
    
    - a：`hello/hello-http:latest`
    - b：`world/world-http:latest`
    - c：`pubrepo.guance.com/datakit/datakit:1.2.0`
    
    If you only want to collect logs from Pod a, configure ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG:
    
    ``` yaml
      - env:
       - name: ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
        value: image:hello* # Specify image name or wildcard
    ```
    
    Or configure by namespace:
    
    ``` yaml
      - env:
       - name: ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG
        value: namespace:foo # Specify namespace to ignore container logs
    ```

---

???+ tip "How to View Images"

    Docker:
    
    ``` shell
    $ docker inspect --format '{{.config.image}}' <container_id>
    #...
    ```
    
    Kubernetes Pod:
    
    ``` shell
    $ kubectl get pod -o=jsonpath="{.spec.containers[0].image}" <pod_name>
    #...
    ```
    
    ???+ attention
    
    The globally configured `container_exclude_log` takes precedence over the custom configuration `disable` in containers. For example, configuring `container_exclude_log = ["image:*"]` to exclude all logs, if there is a Pod Annotation like the following, it will still collect the standard output logs of the container:
    
    ```json
    [{
      "disable": false,
      "source": "logging-output"
    }]
    ```