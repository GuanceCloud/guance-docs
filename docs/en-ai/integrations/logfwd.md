---
title: 'Log Sidecar'
summary: 'Sidecar-based log collection'
tags:
  - 'KUBERNETES'
  - 'Logs'
  - 'Containers'
__int_icon: 'icon/kubernetes'
dashboard:
  - desc: 'None'
    path: '-'
monitor:
  - desc: 'None'
    path: '-'
---

:material-kubernetes:

---

To facilitate log collection from application containers within Kubernetes Pods, a lightweight log collection client is provided. This client is mounted as a sidecar to the Pod and sends the collected logs to DataKit.

## Usage {#using}

This guide is divided into two parts: one is configuring DataKit to enable the corresponding log reception functionality, and the other is configuring and starting logfwd for collection.

## Configuration {#config}

### DataKit Configuration {#datakit-conf}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    First, you need to enable [logfwdserver](logfwdserver.md). Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logfwdserver.conf.sample`, and rename it to `logfwdserver.conf`. Example configuration:

    ``` toml hl_lines="1"
    [inputs.logfwdserver] # Note this is the logfwdserver configuration
      ## Listening address and port for the logfwd receiver
      address = "0.0.0.0:9533"

      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the logfwdserver collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Logfwd Usage and Configuration {#config}

The main configuration for logfwd is in JSON format. Here is an example configuration:

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

- `datakit_addr`: The address of the DataKit logfwdserver. Typically configured using environment variables `LOGFWD_DATAKIT_HOST` and `LOGFWD_DATAKIT_PORT`.

- `loggings`: The main configuration, which is an array. Each item is similar to the [logging](logging.md) collector.
    - `logfiles`: List of log files, absolute paths are recommended and glob patterns are supported.
    - `ignore`: File path filters using glob patterns; any matching files will not be collected.
    - `source`: Data source; defaults to `'default'` if empty.
    - `service`: Tag added to logs; defaults to `$source` if empty.
    - `pipeline`: Path to the Pipeline script; defaults to `$source.p` if empty. If `$source.p` does not exist, no Pipeline is used.
    - `character_encoding`: Encoding selection; defaults to empty. Supported encodings include `utf-8/utf-16le/utf-16be/gbk/gb18030`.
    - `multiline_match`: Multi-line match pattern, same as [logging](logging.md). Note that JSON does not support triple single quotes for raw strings, so regex like `^\d{4}` should be escaped as `^\\d{4}`.
    - `tags`: Additional tags in JSON map format, e.g., `{ "key1":"value1", "key2":"value2" }`.

Supported environment variables:

| Environment Variable Name | Description |
| :--- | :--- |
| `LOGFWD_DATAKIT_HOST` | Address of DataKit |
| `LOGFWD_DATAKIT_PORT` | Port of DataKit |
| `LOGFWD_TARGET_CONTAINER_IMAGE` | Target container image name, e.g., `nginx:1.22`, parses and adds relevant tags (`image`, `image_name`, `image_short_name`, `image_tag`) |
| `LOGFWD_GLOBAL_SOURCE` | Global source configuration, highest priority |
| `LOGFWD_GLOBAL_SERVICE` | Global service configuration, highest priority |
| `LOGFWD_POD_NAME` | Specifies pod name, adds `pod_name` tag |
| `LOGFWD_POD_NAMESPACE` | Specifies pod namespace, adds `namespace` tag |
| `LOGFWD_ANNOTATION_DATAKIT_LOGS` | Uses current Pod's Annotations `datakit/logs` configuration, higher priority than logfwd JSON configuration |
| `LOGFWD_JSON_CONFIG` | Main logfwd configuration in JSON format |

#### Installation and Running {#install-run}

The deployment configuration for logfwd in Kubernetes consists of two parts: one is the Kubernetes Pod creation `spec.containers` configuration, including injecting environment variables and mounting directories. The configuration is as follows:

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
    image: pubrepo.guance.com/datakit/logfwd:1.66.1
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

The second part is the actual runtime configuration for logfwd, i.e., the main JSON configuration mentioned earlier, which exists as a ConfigMap in Kubernetes.

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

Integrate both configurations into your existing Kubernetes YAML and use `volumes` and `volumeMounts` to share directories between containers, enabling logfwd to collect logs from other containers.

> Note: Use `volumes` and `volumeMounts` to mount and share the log directory of the application container (e.g., the `count` container) so that it can be accessed normally within the logfwd container. For more information on `volumes`, see the official [documentation](https://kubernetes.io/docs/concepts/storage/volumes/){:target="_blank"}.

Complete example:

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
    image: pubrepo.guance.com/datakit/logfwd:1.66.1
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

- Log file content: 10 million Nginx logs, file size 2.2GB:

```not-set
192.168.17.1 - - [06/Jan/2022:16:16:37 +0000] "GET /google/company?test=var1%20Pl HTTP/1.1" 401 612 "http://www.google.com/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36" "-"
```

- Results:

It took **95 seconds** to read and forward all logs, averaging 100,000 logs per second.

Peak single-core CPU usage was 42%. Below is the `top` output at that time:

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

- [Overview of DataKit Log Collection](datakit-logging.md)
- [Best Practices for Socket Log Integration](logging_socket.md)
- [Specifying Log Collection Configuration for a Pod in Kubernetes](container-log.md#logging-with-annotation-or-label)
- [Third-party Log Integration](logstreaming.md)
- [Introduction to DataKit Configuration Methods in Kubernetes](../datakit/k8s-config-how-to.md)
- [Installing DataKit as a DaemonSet](../datakit/datakit-daemonset-deploy.md)
- [Deploying `logfwdserver` on DataKit](logfwdserver.md)
- [Correctly Using Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)