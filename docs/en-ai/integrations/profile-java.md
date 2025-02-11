---
title     : 'Profiling Java'
summary   : 'Java Profiling Integration'
tags:
  - 'JAVA'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

DataKit supports two collectors to gather Java profiling data, [`dd-trace-java`](https://github.com/DataDog/dd-trace-java){:target="_blank"} and [async-profiler](https://github.com/async-profiler/async-profiler){:target="_blank"}.

## `dd-trace-java` {#ddtrace}

Download `dd-trace-java` from the page [`dd-trace-java`](https://github.com/DataDog/dd-trace-java/releases){:target="_blank"}.

<!-- markdownlint-disable MD046 -->
???+ Note

    DataKit currently supports `dd-trace-java 1.19.x` and below versions; higher versions have not been tested, and compatibility is unknown. If you encounter compatibility issues, please provide feedback.
<!-- markdownlint-enable -->

`dd-trace-java` currently integrates two analysis engines: [`Datadog Profiler`](https://github.com/datadog/java-profiler){:target="_blank"} and JDK's built-in [`JFR (Java Flight Recorder)`](https://docs.oracle.com/javacomponents/jmc-5-4/jfr-runtime-guide/about.htm){:target="_blank"}. Each engine has specific requirements for platforms and JDK versions, as listed below:

<!-- markdownlint-disable MD046 -->
=== "Datadog Profiler"

    The `Datadog Profiler` currently only supports Linux systems, with JDK version requirements:

    - OpenJDK 8u352+, 11.0.17+, 17.0.5+ (including builds such as [`Eclipse Adoptium`](https://projects.eclipse.org/projects/adoptium){:target="_blank"}, [`Amazon Corretto`](https://aws.amazon.com/cn/corretto/){:target="_blank"}, [`Azul Zulu`](https://www.azul.com/downloads/?package=jdk#zulu){:target="_blank"})
    - Oracle JDK 8u352+, 11.0.17+, 17.0.5+
    - OpenJ9 JDK 8u372+, 11.0.18+, 17.0.6+

=== "Java Flight Recorder"

    - OpenJDK 11+
    - Oracle JDK 11+
    - OpenJDK 8 (version 1.8.0.262/8u262+)
    - Oracle JDK 8 (commercial features need to be enabled)

    ???+ Note

        `JFR` is a commercial feature in Oracle JDK 8 and is disabled by default. To enable it, add parameters `-XX:+UnlockCommercialFeatures -XX:+FlightRecorder` when starting the project. From JDK 11 onwards, `JFR` has become an open-source project and is no longer a commercial feature of Oracle JDK.
<!-- markdownlint-enable -->


To enable profiling

```shell
java -javaagent:/<your-path>/dd-java-agent.jar \
    -XX:FlightRecorderOptions=stackdepth=256 \
    -Ddd.agent.host=127.0.0.1 \
    -Ddd.trace.agent.port=9529 \
    -Ddd.service.name=profiling-demo \
    -Ddd.env=dev \
    -Ddd.version=1.2.3  \
    -Ddd.profiling.enabled=true  \
    -Ddd.profiling.ddprof.enabled=true \
    -Ddd.profiling.ddprof.cpu.enabled=true \
    -Ddd.profiling.ddprof.wall.enabled=true \
    -Ddd.profiling.ddprof.alloc.enabled=true \
    -Ddd.profiling.ddprof.liveheap.enabled=true \
    -Ddd.profiling.ddprof.memleak.enabled=true \
    -jar your-app.jar 
```

Partial parameter descriptions:

| Parameter Name                                       | Corresponding Environment Variable                               | Description                                                                     |
|-------------------------------------------|---------------------------------------|------------------------------------------------------------------------|
| `-Ddd.profiling.enabled`                  | DD_PROFILING_ENABLED                  | Whether to enable profiling functionality                                                      |
| `-Ddd.profiling.allocation.enabled`       | DD_PROFILING_ALLOCATION_ENABLED       | Whether to enable `JFR` engine memory allocation sampling, which may impact performance; it is recommended to use `Datadog Profiler` with higher JDK versions       |
| `-Ddd.profiling.heap.enabled`             | DD_PROFILING_HEAP_ENABLED             | Whether to enable `JFR` engine heap memory object sampling                                                   |
| `-Ddd.profiling.directallocation.enabled` | DD_PROFILING_DIRECTALLOCATION_ENABLED | Whether to enable `JFR` engine JVM direct memory allocation sampling                                             |
| `-Ddd.profiling.ddprof.enabled`           | DD_PROFILING_DDPROF_ENABLED           | Whether to enable the `Datadog Profiler` analysis engine                                           |
| `-Ddd.profiling.ddprof.cpu.enabled`       | DD_PROFILING_DDPROF_CPU_ENABLED       | Whether to enable `Datadog Profiler` CPU analysis                                         |
| `-Ddd.profiling.ddprof.wall.enabled`      | DD_PROFILING_DDPROF_WALL_ENABLED      | Whether to enable `Datadog Profiler` Wall time collection, this option relates to the association between Trace and Profile, it is recommended to enable |
| `-Ddd.profiling.ddprof.alloc.enabled`     | DD_PROFILING_DDPROF_ALLOC_ENABLED     | Whether to enable `Datadog Profiler` engine memory analysis                                        |
| `-Ddd.profiling.ddprof.liveheap.enabled`  | DD_PROFILING_DDPROF_LIVEHEAP_ENABLED  | Whether to enable `Datadog Profiler` engine Heap analysis                                     |
| `-Ddd.profiling.ddprof.memleak.enabled`   | DD_PROFILING_DDPROF_MEMLEAK_ENABLED   | Whether to enable `Datadog Profiler` engine memory leak sampling analysis                                     |

After the program runs, related data can be viewed on the Guance platform within approximately one minute.

### Generating Performance Metrics {#metrics}

Starting from [:octicons-tag-24: Version-1.39.0](../datakit/changelog.md#cl-1.39.0), DataKit supports extracting a set of JVM runtime-related metrics from the output information of `dd-trace-java`. This set of metrics is placed under the `profiling_metrics` measurement set. Below are some of these metrics explained:

| Metric Name                                | Description                                                           | Unit         |
|-------------------------------------|--------------------------------------------------------------|------------|
| prof_jvm_cpu_cores                  | Total number of CPU cores consumed by the application                                              | core       |      |
| prof_jvm_alloc_bytes_per_sec        | Total size of memory allocated per second                                                  | byte       |     |
| prof_jvm_allocs_per_sec             | Number of times memory is allocated per second                                                   | count      |   |
| prof_jvm_alloc_bytes_total          | Total size of memory allocated during a single profiling period                                      | byte       |
| prof_jvm_class_loads_per_sec        | Number of class loads executed per second                                                 | count      |
| prof_jvm_compilation_time           | Total JIT compilation time during a single profiling period (default dd-trace collection cycle is 60 seconds) | nanosecond |
| prof_jvm_context_switches_per_sec   | Number of thread context switches per second                                                  | count      |
| prof_jvm_direct_alloc_bytes_per_sec | Size of direct memory allocated per second                                                  | byte       |
| prof_jvm_throws_per_sec             | Number of exceptions thrown per second                                                     | count      |
| prof_jvm_throws_total               | Total number of exceptions thrown during a single profiling period                                     | count      |
| prof_jvm_file_io_max_read_bytes     | Maximum number of bytes read in a single file I/O operation during a single profiling period                              | byte       |
| prof_jvm_file_io_max_read_time      | Maximum duration of a single file read operation during a single profiling period                                | nanosecond |
| prof_jvm_file_io_max_write_bytes    | Maximum number of bytes written in a single file operation during a single profiling period                               | byte       |
| prof_jvm_file_io_max_write_time     | Maximum duration of a single file write operation during a single profiling period                                | nanosecond |
| prof_jvm_file_io_read_bytes         | Total number of bytes read during a single profiling period                                   | byte       |
| prof_jvm_file_io_time               | Total time spent executing file I/O operations during a single profiling period                                 | nanosecond |
| prof_jvm_file_io_read_time          | Total time spent reading files during a single profiling period                                   | nanosecond |
| prof_jvm_file_io_write_time         | Total time spent writing files during a single profiling period                                   | nanosecond |
| prof_jvm_avg_gc_pause_time          | Average duration of each GC pause                                          | nanosecond |
| prof_jvm_max_gc_pause_time          | Maximum duration of GC pauses during a single profiling period                             | nanosecond |
| prof_jvm_gc_pauses_per_sec          | Number of GC pauses per second                                             | count      |
| prof_jvm_gc_pause_time              | Total duration of GC pauses during a single profiling period                            | nanosecond |
| prof_jvm_lifetime_heap_bytes        | Total size of live objects in the heap                                               | byte       |
| prof_jvm_lifetime_heap_objects      | Total number of live objects in the heap                                                    | count      |
| prof_jvm_locks_max_wait_time        | Maximum wait time due to lock contention during a single profiling period                                | nanosecond |
| prof_jvm_locks_per_sec              | Number of lock contentions per second                                                    | count      |
| prof_jvm_socket_io_max_read_time    | Maximum duration of a single socket read operation during a single profiling period                        | nanosecond |
| prof_jvm_socket_io_max_write_bytes  | Maximum number of bytes sent in a single socket write operation during a single profiling period                           | byte       |
| prof_jvm_socket_io_max_write_time   | Maximum duration of a single socket write operation during a single profiling period                       | nanosecond |
| prof_jvm_socket_io_read_bytes       | Total number of bytes received via sockets during a single profiling period                             | byte       |
| prof_jvm_socket_io_read_time        | Total time spent reading data via sockets during a single profiling period                        | nanosecond |
| prof_jvm_socket_io_write_time       | Total time spent sending data via sockets during a single profiling period                        | nanosecond |
| prof_jvm_socket_io_write_bytes      | Total number of bytes sent via sockets during a single profiling period                            | byte       |
| prof_jvm_threads_created_per_sec    | Number of threads created per second                                                     | count      |
| prof_jvm_threads_deadlocked         | Number of threads in deadlock state                                                   | count      |
| prof_jvm_uptime_nanoseconds         | Duration since the program started                                                      | nanosecond |


<!-- markdownlint-disable MD046 -->
???+ tips

    This feature is enabled by default. If it is not needed, you can disable it by modifying the collector configuration file `<DATAKIT_INSTALL_DIR>/conf.d/profile/profile.conf` and setting the `generate_metrics` option to false, then restarting DataKit.

    ```toml
    [[inputs.profile]]

    ## set false to stop generating apm metrics from ddtrace output.
    generate_metrics = false
    ```
<!-- markdownlint-enable -->

## Async Profiler {#async-profiler}

Async-profiler is an open-source Java performance analysis tool based on HotSpot's API, capable of collecting stack traces and memory allocations during program execution.

Async-profiler can collect the following events:

- CPU cycles
- Hardware and software performance counters, such as Cache Misses, Branch Misses, Page Faults, Context Switches, etc.
- Java heap allocations
- Contended Lock Attempts, including Java object monitors and ReentrantLocks

### Installing Async Profiler {#install}

???+ node "Version Requirements"
    DataKit currently supports `async-profiler v2.9` and below versions; higher versions have not been tested, and compatibility is unknown.

The official website provides installation packages for different platforms (using v2.8.3 as an example):

- Linux x64 (glibc): [async-profiler-2.8.3-linux-x64.tar.gz](https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/async-profiler-2.8.3-linux-x64.tar.gz){:target="_blank"}
- Linux x64 (musl): [async-profiler-2.8.3-linux-musl-x64.tar.gz](https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/async-profiler-2.8.3-linux-musl-x64.tar.gz){:target="_blank"}
- Linux arm64: [async-profiler-2.8.3-linux-arm64.tar.gz](https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/async-profiler-2.8.3-linux-arm64.tar.gz){:target="_blank"}
- macOS x64/arm64: [async-profiler-2.8.3-macos.zip](https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/async-profiler-2.8.3-macos.zip){:target="_blank"}
- File converter: [converter.jar](https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/converter.jar){:target="_blank"}

Download the corresponding installation package and extract it. Using Linux x64 (glibc) as an example (other platforms are similar):

```shell
$ wget https://github.com/async-profiler/async-profiler/releases/download/v2.8.3/async-profiler-2.8.3-linux-x64.tar.gz 
$ tar -zxf async-profiler-2.8.3-linux-x64.tar.gz 
$ cd async-profiler-2.8.3-linux-x64 && ls

  build  CHANGELOG.md  LICENSE  profiler.sh  README.md
```

### Using Async-Profiler {#usage}

- Setting `perf_events` Parameters

For Linux kernel versions 4.6 and above, if non-root users need to start processes using `perf_events`, two system runtime variables need to be set as follows:

```shell
sudo sysctl kernel.perf_event_paranoid=1
sudo sysctl kernel.kptr_restrict=0 
```

- Installing Debug Symbols (for Memory Allocation Events)

If you need to collect memory allocation (`alloc`) related events, you must install Debug Symbols. Oracle JDK already includes these symbols and can skip this step. For OpenJDK, follow the steps below:

<!-- markdownlint-disable MD046 -->
=== "Debian/Ubuntu"

    ```shell
    sudo apt install openjdk-8-dbg # OpenJDK 8
    # Or
    sudo apt install openjdk-11-dbg # OpenJDK 11
    ```

=== "CentOS/RHEL"

    ```shell
    sudo debuginfo-install java-1.8.0-openjdk
    ```
<!-- markdownlint-enable -->

You can check whether they are installed correctly on Linux platforms using `gdb`:

```shell
gdb $JAVA_HOME/lib/server/libjvm.so -ex 'info address UseG1GC'
```

If the output contains `Symbol "UseG1GC" is at 0xxxxx` or `No symbol "UseG1GC" in current context`, the installation was successful.

- Viewing Java Process ID

Before collection, you need to find the PID of the Java process (you can use the `jps` command):

```shell
$ jps

9234 Jps
8983 Computey
```

- Collecting Java Process Data

Choose a Java process to profile (e.g., process 8983), execute the `profiler.sh` script in the directory to collect data:

```shell
./profiler.sh -d 10 -f profiling.html 8983 

Profiling for 10 seconds
Done
```

After about 10 seconds, a file named `profiling.html` will be generated in the current directory. Open this file in a browser to view the flame graph.

### Integrating DataKit and async-profiler {#async-datakit}

Preparation

- [Prepare DataKit Service](../datakit/datakit-install.md), version DataKit >= 1.4.3

Assume the default address is `http://localhost:9529`. If not, modify it to the actual DataKit service address.

- [Enable Profile Collector](profile.md)

- Injecting Service Name (`service`) into Java Application (Optional)

By default, it automatically acquires the program name as `service` and reports it to Guance. If customization is needed, inject the service name when starting the program:

```shell
java -Ddk.service=<service-name> ... -jar <your-jar>
```

Integration methods can be divided into two types:

- [Automation Script (Recommended)](profile-java.md#script)
- [Manual Operation](profile-java.md#manual)
- [Usage in k8s Environment](../datakit/datakit-operator.md#inject-async-profiler)

#### Automation Script {#script}

An automation script can conveniently integrate async-profiler and DataKit. Usage method is as follows.

- Create a Shell Script

Create a new file named `collect.sh` in the current directory and input the following content:

<!-- markdownlint-disable MD046 -->
???- note "collect.sh (click to expand)"

    ```shell
    set -e
    
    LIBRARY_VERSION=2.8.3
    
    # Allowed upload size of jfr file to DataKit (6 M), do not modify
    MAX_JFR_FILE_SIZE=6000000
    
    # DataKit service address
    datakit_url=http://localhost:9529
    if [ -n "$DATAKIT_URL" ]; then
        datakit_url=$DATAKIT_URL
    fi
    
    # Complete URL for uploading profiling data
    datakit_profiling_url=$datakit_url/profiling/v1/input
    
    # Application environment
    app_env=dev
    if [ -n "$APP_ENV" ]; then
        app_env=$APP_ENV
    fi
    
    # Application version
    app_version=0.0.0
    if [ -n "$APP_VERSION" ]; then
        app_version=$APP_VERSION
    fi
    
    # Hostname
    host_name=$(hostname)
    if [ -n "$HOST_NAME" ]; then
        host_name=$HOST_NAME
    fi
    
    # Service name
    service_name=
    if [ -n "$SERVICE_NAME" ]; then
        service_name=$SERVICE_NAME
    fi
    
    # Profiling duration, in seconds
    profiling_duration=10
    if [ -n "$PROFILING_DURATION" ]; then
        profiling_duration=$PROFILING_DURATION
    fi
    
    # Profiling event
    profiling_event=cpu
    if [ -n "$PROFILING_EVENT" ]; then
        profiling_event=$PROFILING_EVENT
    fi
    
    # Java application process IDs to profile, here you can customize the Java processes to profile, e.g., filter by process name
    java_process_ids=$(jps -q -J-XX:+PerfDisableSharedMem)
    if [ -n "$PROCESS_ID" ]; then
        java_process_ids=`echo $PROCESS_ID | tr "," " "`
    fi
    
    if [[ $java_process_ids == "" ]]; then
        printf "Warning: no java program found, exit now\n"
        exit 1
    fi
    
    is_valid_process_id() {
        if [ -n "$1" ]; then
            if [[ $1 =~ ^[0-9]+$ ]]; then
                return 1
            fi
        fi
        return 0
    }
    
    profile_collect() {
        # disable -e
        set +e
    
        process_id=$1
        is_valid_process_id $process_id
        if [[ $? == 0 ]]; then
            printf "Warning: invalid process_id: $process_id, ignore"
            return 1
        fi
    
        uuid=$(uuidgen)
        jfr_file=$runtime_dir/profiler_$uuid.jfr
        event_json_file=$runtime_dir/event_$uuid.json
    
        arr=($(jps -v | grep "^$process_id"))
    
        process_name="default"
    
        for (( i = 0; i < ${#arr[@]}; i++ ))
        do
            value=${arr[$i]}
            if [ $i == 1 ]; then
                process_name=$value
            elif [[ $value =~ "-Ddk.service=" ]]; then
                service_name=${value/-Ddk.service=/}
            fi
        done
    
        start_time=$(date +%FT%T.%N%:z)
        ./profiler.sh -d $profiling_duration --fdtransfer -e $profiling_event -o jfr -f $jfr_file $process_id
        end_time=$(date +%FT%T.%N%:z)
    
        if [ ! -f $jfr_file ]; then
            printf "Warning: generating profiling file failed for %s, pid %d\n" $process_name $process_id
            return
        else
            printf "generate profiling file successfully for %s, pid %d\n" $process_name $process_id
        fi
    
        jfr_zip_file=$jfr_file.gz
    
        gzip -qc $jfr_file > $jfr_zip_file
    
        zip_file_size=`ls -la $jfr_zip_file | awk '{print $5}'`
    
        if [ -z "$service_name" ]; then
            service_name=$process_name
        fi
    
        if [ $zip_file_size -gt $MAX_JFR_FILE_SIZE ]; then
            printf "Warning: the size of the jfr file generated is bigger than $MAX_JFR_FILE_SIZE bytes, now is $zip_file_size bytes\n"
        else
            tags="library_version:$LIBRARY_VERSION,library_type:async_profiler,process_id:$process_id,process_name:$process_name,service:$service_name,host:$host_name,env:$app_env,version:$app_version"
            if [ -n "$PROFILING_TAGS" ]; then
              tags="$tags,$PROFILING_TAGS"
            fi
            cat >$event_json_file <<END
    {
            "tags_profiler": "$tags",
            "start": "$start_time",
            "end": "$end_time",
            "family": "java",
            "format": "jfr"
    }
    END
    
            res=$(curl -i $datakit_profiling_url \
                -F "main=@$jfr_zip_file;filename=main.jfr" \
                -F "event=@$event_json_file;filename=event.json;type=application/json" | head -n 1 )
    
            if [[ ! $res =~ 2[0-9][0-9] ]]; then
                printf "Warning: send profile file to datakit failed, %s\n" "$res"
                printf "$res"
            else
                printf "Info: send profile file to datakit successfully\n"
                rm -rf $event_json_file $jfr_file $jfr_zip_file
            fi
        fi
    
        set -e
    }
    
    runtime_dir=runtime
    if [ ! -d $runtime_dir ]; then
        mkdir $runtime_dir
    fi
    
    # Parallel collection of profiling data
    for process_id in $java_process_ids; do
        printf "profiling process %d\n" $process_id
        profile_collect $process_id > $runtime_dir/$process_id.log 2>&1 &
    done
    
    # Wait for all tasks to finish
    wait
    
    # Output task execution logs
    for process_id in $java_process_ids; do
        log_file=$runtime_dir/$process_id.log
        if [ -f $log_file ]; then
            echo
            cat $log_file
            rm $log_file
        fi
    done
    ```
<!-- markdownlint-enable -->

- Execute the Script

```shell
bash collect.sh
```

After the script finishes executing, the collected profiling data will be reported to the Guance platform via DataKit. You can view it shortly after in "APM"-"Profile".

The script supports the following environment variables:

- `DATAKIT_URL`        : DataKit URL address, default is `http://localhost:9529`
- `APP_ENV`            : Current application environment, such as `dev/prod/test`
- `APP_VERSION`        : Current application version
- `HOST_NAME`          : Hostname
- `SERVICE_NAME`       : Service name
- `PROFILING_DURATION` : Sampling duration in seconds
- `PROFILING_EVENT`    : Events to profile, such as `cpu/alloc/lock`
- `PROFILING_TAGS`     : Additional custom Tags, comma-separated key-value pairs like `key1:value1,key2:value2`
- `PROCESS_ID`         : Java process ID(s) to profile, multiple IDs separated by commas, e.g., `98789,33432`

```shell
DATAKIT_URL=http://localhost:9529 APP_ENV=test APP_VERSION=1.0.0 HOST_NAME=datakit PROFILING_EVENT=cpu,alloc PROFILING_DURATION=60 PROFILING_TAGS="tag1:val1,tag2:val2" PROCESS_ID=98789,33432 bash collect.sh
```

#### Manual Operation {#manual}

Compared to the automation script, manual operation offers higher flexibility to meet various scenario needs.

- Collecting profiling file (*jfr* format)

First, use `async-profiler` to collect profiling information from the Java process and generate a *jfr* formatted file. For example:

```shell
./profiler.sh -d 10 -o jfr -f profiling.jfr jps
```

- Preparing Metadata File

Write a profiling metadata file, such as `event.json`:

```json
{
    "tags_profiler": "library_version:2.8.3,library_type:async_profiler,process_id:16718,host:host_name,service:profiling-demo,env:dev,version:1.0.0",
    "start": "2022-10-28T14:30:39.122688553+08:00",
    "end": "2022-10-28T14:32:39.122688553+08:00",
    "family": "java",
    "format": "jfr"
}
```

Field meanings:

- `tags_profiler`: Tags for profiling data, can include custom tags
    - `library_version`: Current `async-profiler` version
    - `library_type`: Profiler library type, i.e., `async-profiler`
    - `process_id`: Java process ID
    - `host`: Hostname
    - `service`: Service name
    - `env`: Application environment type
    - `version`: Application version
    - Other custom tags
- `start`: Start time of profiling
- `end`: End time of profiling
- `family`: Language type
- `format`: File format

- Upload to DataKit

Once both files (`profiling.jfr` and `event.json`) are ready, you can send them to DataKit via HTTP POST request as follows:

```shell
$ curl http://localhost:9529/profiling/v1/input \
  -F "main=@profiling.jfr;filename=main.jfr" \
  -F "event=@event.json;filename=event.json;type=application/json"
```

When the response returns a result in the format `{"content":{"ProfileID":"xxxxxxxx"}}`, it indicates a successful upload. DataKit will create a profiling record and save the jfr file to the backend storage for subsequent analysis.

#### Usage in k8s Environment

Refer to [Using `datakit-operator` to Inject `async-profiler`](../datakit/datakit-operator.md#inject-async-profiler){:target="_blank"}.