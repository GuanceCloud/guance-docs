---
title: 'Log Sidecar'
summary: 'Sidecar-based log collection'
tags:
  - 'KUBERNETES'
  - 'Logs'
  - 'Container'
__int_icon: 'icon/kubernetes'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---

:material-kubernetes:

---

To facilitate the collection of application container logs within Kubernetes Pods, a lightweight log collection client is provided, mounted as a sidecar to the Pod, and sends the collected logs to DataKit.

## Usage {#using}

This process is divided into two parts: one is configuring DataKit to enable the corresponding log reception functionality, and the other is configuring and starting logfwd for collection.

## Configuration {#config}

### DataKit Configuration {#datakit-conf}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    You need to first enable [logfwdserver](logfwdserver.md), go to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample` and rename it to `logfwdserver.conf`. Example configuration:

    ``` toml hl_lines="1"
    [inputs.logfwdserver] # Note this is the logfwdserver configuration
      ## logfwd receiver listening address and port
      address = "0.0.0.0:9533"

      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the logfwdserver collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### logfwd Usage and Configuration {#config}

The main configuration for logfwd is in JSON format. Below is an example configuration:

``` json
[
    {
        "datakit_addr": "127.0.0.1:9533",
        "loggings": [
            {
                "logfiles": ["<your-logfile-path>"],
                "ignore": [],
                "source": "<your-source>",
                "service": "<your-service>",
                "pipeline": "<your-pipeline.p>",
                "character_encoding": "",
                "multiline_match": "<your-match>",
                "tags": {}
            },
            {
                "logfiles": ["<your-logfile-path-2>"],
                "source": "<your-source-2>"
            }
        ]
    }
]
```

Configuration parameter descriptions:

- `datakit_addr` is the DataKit logfwdserver address, typically configured using environment variables `LOGFWD_DATAKIT_HOST` and `LOGFWD_DATAKIT_PORT`.

- `loggings` is the main configuration, which is an array where sub-items are similar to the [logging](logging.md) collector.
    - `logfiles` is a list of log files, absolute paths can be specified, supports glob rules for batch specification, recommended to use absolute paths.
    - `ignore` filters file paths using glob rules; any matching condition will exclude the file from collection.
    - `source` specifies the data source; if empty, defaults to 'default'.
    - `service` adds a tag, if empty, defaults to `$source`.
    - `pipeline` specifies the Pipeline script path; if empty, uses `$source.p`; if `$source.p` does not exist, no Pipeline is used (this script resides on the DataKit end).
    - `character_encoding` selects encoding; if incorrect, data may be unreadable. Default is empty. Supports `utf-8/utf-16le/utf-16be/gbk/gb18030`.
    - `multiline_match` matches multiple lines, same as [logging](logging.md). Note that because it's JSON, triple single quotes for raw strings are not supported; regular expressions like `^\d{4}` need to be escaped as `^\\d{4}`.
    - `tags` adds extra tags, formatted as a JSON map, e.g., `{ "key1":"value1", "key2":"value2" }`.

Supported environment variables:

| Environment Variable | Description                                                                                                              |
| :---                 | :---                                                                                                                      |
| `LOGFWD_DATAKIT_HOST`| DataKit address                                                                                                           |
| `LOGFWD_DATAKIT_PORT`| DataKit port                                                                                                              |
| `LOGFWD_TARGET_CONTAINER_IMAGE` | Configures the target container image name, e.g., `nginx:1.22`, parses and adds related tags (`image`, `image_name`, `image_short_name`, `image_tag`) |
| `LOGFWD_GLOBAL_SOURCE` | Configures global source, highest priority                                                                               |
| `LOGFWD_GLOBAL_SERVICE` | Configures global service, highest priority                                                                              |
| `LOGFWD_POD_NAME`     | Specifies pod name, adds `pod_name` to tags                                                                               |
| `LOGFWD_POD_NAMESPACE`| Specifies pod namespace, adds `namespace` to tags                                                                          |
| `LOGFWD_ANNOTATION_DATAKIT_LOGS` | Uses the current Pod's Annotations `datakit/logs` configuration, higher priority than logfwd JSON configuration     |
| `LOGFWD_JSON_CONFIG`  | Main logfwd configuration, i.e., the JSON text above                                                                      |

#### Installation and Operation {#install-run}

Deployment configuration for logfwd in Kubernetes is split into two parts: one is the `spec.containers` configuration for creating Kubernetes Pods, including injecting environment variables and mounting directories. The configuration is as follows:

```yaml
spec:
  containers:
  - name: logfwd
    env:
    - name: LOGFWD_DATAKIT_HOST
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: status.hostIP
    - name: LOGFWD_DATAKIT_PORT
      value: "9533"
    - name: LOGFWD_ANNOTATION_DATAKIT_LOGS
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.annotations['datakit/logs']
    - name: LOGFWD_POD_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.name
    - name: LOGFWD_POD_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    - name: LOGFWD_GLOBAL_SOURCE
      value: nginx-souce-test
    image: pubrepo.guance.com/datakit/logfwd:1.68.1
    imagePullPolicy: Always
    resources:
      requests:
        cpu: "200m"
        memory: "128Mi"
      limits:
        cpu: "1000m"
        memory: "2Gi"
    volumeMounts:
    - mountPath: /opt/logfwd/config
      name: logfwd-config-volume
      subPath: config
    workingDir: /opt/logfwd
  volumes:
  - configMap:
      name: logfwd-config
    name: logfwd-config-volume
```

The second configuration is the actual running configuration for logfwd, i.e., the JSON-formatted main configuration mentioned earlier, existing in Kubernetes as a ConfigMap.

Based on the logfwd configuration example, modify `config` according to your actual situation. The `ConfigMap` format is as follows:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: logfwd-conf
data:
  config: |
    [
        {
            "loggings": [
                {
                    "logfiles": ["/var/log/1.log"],
                    "source": "log_source",
                    "tags": {}
                },
                {
                    "logfiles": ["/var/log/2.log"],
                    "source": "log_source2"
                }
            ]
        }
    ]
```

Integrate both configurations into the existing Kubernetes YAML and use `volumes` and `volumeMounts` to share directories between containers to allow logfwd to collect logs from other containers.

> Note, use `volumes` and `volumeMounts` to mount and share the log directory of the application container (e.g., the `count` container in the example) so that it can be accessed normally within the logfwd container. Official documentation on `volumes` is available [here](https://kubernetes.io/docs/concepts/storage/volumes/){:target="_blank"}

A complete example is as follows:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: logfwd
spec:
  containers:
  - name: count
    image: busybox
    args:
    - /bin/sh
    - -c
    - >
      i=0;
      while true;
      do
        echo "$i: $(date)" >> /var/log/1.log;
        echo "$(date) INFO $i" >> /var/log/2.log;
        i=$((i+1));
        sleep 1;
      done
    volumeMounts:
    - name: varlog
      mountPath: /var/log
  - name: logfwd
    env:
    - name: LOGFWD_DATAKIT_HOST
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: status.hostIP
    - name: LOGFWD_DATAKIT_PORT
      value: "9533"
    - name: LOGFWD_ANNOTATION_DATAKIT_LOGS
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.annotations['datakit/logs']
    - name: LOGFWD_POD_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.name
    - name: LOGFWD_POD_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    image: pubrepo.guance.com/datakit/logfwd:1.68.1
    imagePullPolicy: Always
    resources:
      requests:
        cpu: "200m"
        memory: "128Mi"
      limits:
        cpu: "1000m"
        memory: "2Gi"
    volumeMounts:
    - name: varlog
      mountPath: /var/log
    - mountPath: /opt/logfwd/config
      name: logfwd-config-volume
      subPath: config
    workingDir: /opt/logfwd
  volumes:
  - name: varlog
    emptyDir: {}
  - configMap:
      name: logfwd-config
    name: logfwd-config-volume

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: logfwd-config
data:
  config: |
    [
        {
            "loggings": [
                {
                    "logfiles": ["/var/log/1.log"],
                    "source": "log_source",
                    "tags": {
                        "flag": "tag1"
                    }
                },
                {
                    "logfiles": ["/var/log/2.log"],
                    "source": "log_source2"
                }
            ]
        }
    ]
```

### Performance Testing {#bench}

- Environment:

```shell
goos: linux
goarch: amd64
cpu: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
```

- Log file content consists of 10 million nginx logs, file size 2.2GB:

```not-set
192.168.17.1 - - [06/Jan/2022:16:16:37 +0000] "GET /google/company?test=var1%20Pl HTTP/1.1" 401 612 "http://www.google.com/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36" "-"
```

- Results:

It took **95 seconds** to read and forward all logs, averaging 100,000 logs per second.

Peak single-core CPU usage was 42%. Below is the `top` record at that time:

```shell
top - 16:32:46 up 52 days,  7:28, 17 users,  load average: 2.53, 0.96, 0.59
Tasks: 464 total,   2 running, 457 sleeping,   0 stopped,   5 zombie
%Cpu(s): 30.3 us, 33.7 sy,  0.0 ni, 34.3 id,  0.1 wa,  0.0 hi,  1.5 si,  0.0 st
MiB Mem :  15885.2 total,    985.2 free,   6204.0 used,   8696.1 buff/cache
MiB Swap:   2048.0 total,      0.0 free,   2048.0 used.   8793.3 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
1850829 root      20   0  715416  17500   8964 R  42.1   0.1   0:10.44 logfwd
```

## Further Reading {#more-reading}

- [DataKit Log Collection Overview](datakit-logging.md)
- [Best Practices for Socket Log Integration](logging_socket.md)
- [Specifying Log Collection Configuration for Specific Pods in Kubernetes](container-log.md#logging-with-annotation-or-label)
- [Third-party Log Integration](logstreaming.md)
- [Introduction to DataKit Configuration Methods in Kubernetes](../datakit/k8s-config-how-to.md)
- [Installing DataKit as a DaemonSet](../datakit/datakit-daemonset-deploy.md)
- [Deploying `logfwdserver` on DataKit](logfwdserver.md)
- [Correctly Using Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)
