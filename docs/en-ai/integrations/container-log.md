---
title: 'Kubernetes Logs'
summary: 'Collecting Container and Kubernetes Log Data'
tags:
  - 'Logs'
  - 'Container'
  - 'KUBERNETES'
__int_icon:    'icon/kubernetes/'
---

Datakit supports collecting logs from Kubernetes and host containers. From the data source perspective, these can be divided into two types:

- Console Output: This refers to the stdout/stderr output of container applications, which is the most common method. You can view this using commands similar to `docker logs` or `kubectl logs`.

- Internal Container Files: If logs are not output to stdout/stderr, they are likely stored on disk in files. Collecting such logs is slightly more complex and requires mounting.

This article will detail both collection methods.

## Console stdout/stderr Log Collection {#logging-stdout}

Console output (i.e., stdout/stderr) is written to files by the container runtime, and Datakit automatically retrieves the LogPath for collection.

If you need to customize the collection configuration, you can do so by adding container environment variables or Kubernetes Pod Annotations.

- The Key for custom configurations has the following scenarios:
    - For container environment variables, the Key is fixed as `DATAKIT_LOGS_CONFIG`.
    - For Pod Annotations, there are two ways to write the Key:
        - `datakit/<container_name>.logs`, where `<container_name>` should be replaced with the current Pod's container name. This is used in multi-container environments.
        - `datakit/logs` applies to all containers in the Pod.

<!-- markdownlint-disable MD046 -->
???+ info

    If a container has an environment variable `DATAKIT_LOGS_CONFIG` and also finds its Pod Annotation `datakit/logs`, the container environment variable configuration takes precedence.
<!-- markdownlint-enable -->

- The Value for custom configurations is as follows:

``` json
[
  {
    "disable" : false,
    "source"  : "<your-source>",
    "service" : "<your-service>",
    "pipeline": "<your-pipeline.p>",
    "remove_ansi_escape_codes": false,
    "from_beginning"          : false,
    "tags" : {
      "<some-key>" : "<some_other_value>"
    }
  }
]
```

Field descriptions:

| Field Name                     | Value             | Description                                                                                                                                                                |
| -----                          | ----              | ----                                                                                                                                                                       |
| `disable`                      | true/false        | Whether to disable log collection for this container. Default is `false`.                                                                                                 |
| `type`                         | `file`/not filled | Select the collection type. If collecting logs from files within the container, it must be set to `file`. By default, it is empty for collecting `stdout/stderr`.         |
| `path`                         | String            | Configure the file path. If collecting logs from files within the container, you must specify the volume path, not the file path inside the container. Default is empty.  |
| `source`                       | String            | Log source, see [Container Log Collection Source Configuration](container.md#config-logging-source).                                                                      |
| `service`                      | String            | The service to which the log belongs. Default value is the log source (source).                                                                                            |
| `pipeline`                     | String            | The Pipeline script applicable to this log. Default value is the script name matching the log source (`<source>.p`).                                                      |
| `remove_ansi_escape_codes`     | true/false        | Whether to remove color characters from log data.                                                                                            |
| `from_beginning`               | true/false        | Whether to collect logs from the beginning of the file.                                                                                                                   |
| `multiline_match`              | Regex string      | Used for [multi-line log matching](logging.md#multiline), such as `"multiline_match":"^\\d{4}"` indicating that the line starts with 4 digits.                           |
| `character_encoding`           | String            | Choose encoding. If incorrect, data may not be viewable. Supported encodings include `utf-8`, `utf-16le`, `utf-16be`, `gbk`, `gb18030`, or "". Default is empty.           |
| `tags`                         | key/value pairs   | Add additional tags. If a key already exists, it will be overwritten by this one ([Version-1.4.6](../datakit/changelog.md#cl-1.4.6)).                                      |

Complete example:

<!-- markdownlint-disable MD046 -->
=== "Container Environment Variable"

    ``` shell
    $ cat Dockerfile
    FROM pubrepo.guance.com/base/ubuntu:18.04 AS base
    Run mkdir -p /opt
    Run echo 'i=0; \n\
    while true; \n\
    do \n\
        echo "$(date +"%Y-%m-%d %H:%M:%S")  [$i]  Bash For Loop Examples. Hello, world! Testing output."; \n\
        i=$((i+1)); \n\
        sleep 1; \n\
    done \n'\
    >> /opt/s.sh
    CMD ["/bin/bash", "/opt/s.sh"]

    ## Build image
    $ docker build -t testing/log-output:v1 .

    ## Start container, add environment variable DATAKIT_LOGS_CONFIG
    $ docker run --name log-output -env DATAKIT_LOGS_CONFIG='[{"disable":false,"source":"log-source","service":"log-service"}]' -d testing/log-output:v1
    ```

=== "Kubernetes Pod Annotation"

    ``` yaml title="log-demo.yaml"
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: log-demo-deployment
      labels:
        app: log-demo
    spec:
      replicas: 1
      selector:
        matchLabels:
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
                  "source":  "log-output-source",
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
                echo "$(date +'%F %H:%M:%S')  [$i]  Bash For Loop Examples. Hello, world! Testing output.";
                i=$((i+1));
                sleep 1;
              done
    ```

    Execute the Kubernetes command to apply this configuration:

    ``` shell
    $ kubectl apply -f log-output.yaml
    ...
    ```

???+ attention

    - Unless necessary, do not easily configure Pipelines in environment variables and Pod Annotations. Generally, automatic inference through the `source` field is sufficient.
    - If configuring Env/Annotations in configuration files or terminal command lines, both sides use double quotes in English state and need to add escape characters.

    The value of `multiline_match` is doubly escaped, four backslashes represent one actual backslash. For example, `\"multiline_match\":\"^\\\\d{4}\"` is equivalent to `"multiline_match":"^\d{4}"`. Example:

    ```shell
    kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"log-source\",\"service\":\"log-service\",\"pipeline\":\"test.p\",\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
    ```

    If a Pod/container log is already being collected, adding configuration via the `kubectl annotate` command at this time will not take effect.

<!-- markdownlint-enable -->

## Collection of Logs from Files Inside Containers {#logging-with-inside-config}

For log files inside containers, the difference from console output logs is that you need to specify the file path, while other configuration items are largely similar.

Similarly, you can add container environment variables or Kubernetes Pod Annotations, with Keys and Values basically consistent with those mentioned earlier.

Complete example:

<!-- markdownlint-disable MD046 -->
=== "Container Environment Variable"

    ``` shell
    $ cat Dockerfile
    FROM pubrepo.guance.com/base/ubuntu:18.04 AS base
    Run mkdir -p /opt
    Run echo 'i=0; \n\
    while true; \n\
    do \n\
        echo "$(date +"%Y-%m-%d %H:%M:%S")  [$i]  Bash For Loop Examples. Hello, world! Testing output." >> /tmp/opt/log; \n\
        i=$((i+1)); \n\
        sleep 1; \n\
    done \n'\
    >> /opt/s.sh
    CMD ["/bin/bash", "/opt/s.sh"]

    ## Build image
    $ docker build -t testing/log-to-file:v1 .

    ## Start container, add environment variable DATAKIT_LOGS_CONFIG, note character escaping
    ## Specify non-stdout path, "type" and "path" are required fields, and you need to create a volume for the collection path
    ## For example, to collect `/tmp/opt/log`, you need to add an anonymous volume for `/tmp/opt`
    $ docker run --env DATAKIT_LOGS_CONFIG="[{\"disable\":false,\"type\":\"file\",\"path\":\"/tmp/opt/log\",\"source\":\"log-source\",\"service\":\"log-service\"}]" -v /tmp/opt  -d testing/log-to-file:v1
    ```

=== "Kubernetes Pod Annotation"

    ``` yaml title="logging.yaml"
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: log-demo-deployment
      labels:
        app: log-demo
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: log-demo
      template:
        metadata:
          labels:
            app: log-demo
          annotations:
            ## Add configuration and specify container as logging-demo
            ## Also configured for both file and stdout collection. Note that to collect `/tmp/opt/log`, you need to add an emptyDir volume for `/tmp/opt`
            datakit/logging-demo.logs: |
              [
                {
                  "disable": false,
                  "type": "file",
                  "path":"/tmp/opt/log",
                  "source":  "logging-file",
                  "tags" : {
                    "some_tag": "some_value"
                  }
                },
                {
                  "disable": false,
                  "source":  "logging-output"
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
                echo "$(date +'%F %H:%M:%S')  [$i]  Bash For Loop Examples. Hello, world! Testing output.";
                echo "$(date +'%F %H:%M:%S')  [$i]  Bash For Loop Examples. Hello, world! Testing output." >> /tmp/opt/log;
                i=$((i+1));
                sleep 1;
              done
            volumeMounts:
            - mountPath: /tmp/opt
              name: datakit-vol-opt
          volumes:
          - name: datakit-vol-opt
            emptyDir: {}
    ```

    Execute the Kubernetes command to apply this configuration:

    ``` shell
    $ kubectl apply -f logging.yaml
    ...
    ```
<!-- markdownlint-enable -->

For log files inside containers, in Kubernetes environments, you can also achieve collection by adding a sidecar, see [here](logfwd.md).

## Adjusting Log Collection Based on Container Image {#logging-with-image-config}

By default, DataKit collects all container stdout/stderr logs on the machine/Node, which may not be the expected behavior. Sometimes, we want to collect (or not collect) logs from certain containers, which can be indirectly specified by the image name or namespace.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ``` toml
    ## Using image as an example
    ## When the container's image matches `datakit`, its logs will be collected
    container_include_log = ["image:datakit"]
    ## Ignore all kodo containers
    container_exclude_log = ["image:kodo"]
    ```

    `container_include` and `container_exclude` must start with attribute fields, formatted as a [glob-like regular expression](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}: `"<field_name>:<glob_pattern>"`

    Currently supported fields:

    - image : `image:pubrepo.guance.com/datakit/datakit:1.18.0`
    - image_name : `image_name:pubrepo.guance.com/datakit/datakit`
    - image_short_name : `image_short_name:datakit`
    - namespace : `namespace:datakit-ns`

    For the same rule type (`image` or `namespace`), if both `include` and `exclude` exist simultaneously, both conditions must be met: `include` must be true, and `exclude` must be false. For example:
    ```toml
    ## This would filter out all containers. If a container named `datakit` matches include but also matches exclude, it will be filtered out and not have its logs collected; if a container named `nginx` does not match include, it will also be filtered out and not have its logs collected.

    container_include_log = ["image_name:datakit"]
    container_exclude_log = ["image_name:*"]
    ```

    Multiple field rules, if any match, will not collect logs. For example:
    ```toml
    ## A container only needs to match either `image_name` or `namespace` to stop collecting its logs.

    container_include_log = []
    container_exclude_log = ["image_name:datakit", "namespace:datakit-ns"]
    ```

    The configuration rules for `container_include_log` and `container_exclude_log` are complex, especially when used together. It is recommended to use only `container_exclude_log`.

=== "Kubernetes"

    You can configure log collection for containers using the following environment variables:

    - ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
    - ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG

    Suppose there are three Pods with images:

    - A: `hello/hello-http:latest`
    - B: `world/world-http:latest`
    - C: `pubrepo.guance.com/datakit/datakit:1.2.0`

    If you only want to collect logs from Pod A, you can configure ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
        value: image:hello*  # Specify image name or wildcard
    ```

    Or configure by namespace:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG
        value: namespace:foo  # Specify namespace to not collect logs from its containers
    ```

???+ tip "How to Check Images"

    Docker:

    ``` shell
    docker inspect --format "{{.Config.Image}}" $CONTAINER_ID
    ```

    Kubernetes Pod:

    ``` shell
    echo `kubectl get pod -o=jsonpath="{.items[0].spec.containers[0].image}"`
    ```

???+ attention

    The global configuration `container_exclude_log` has lower priority than the container's custom configuration `disable`. For example, if `container_exclude_log = ["image:*"]` is configured to not collect all logs, but there is a Pod Annotation like this:

    ```json
    [
      {
          "disable": false,
          "type": "file",
          "path":"/tmp/opt/log",
          "source":  "logging-file",
          "tags" : {
            "some_tag": "some_value"
          }
      },
      {
          "disable": true,
          "source":  "logging-output"
      }
    ]
    ```

    This configuration is closer to the container and has higher priority. The `disable=false` indicates that log files should be collected, overriding the global configuration.

    Therefore, the container log files will still be collected, but console output stdout/stderr will not be collected because `disable=true`.

<!-- markdownlint-enable -->

## FAQ {#faq}

### :material-chat-question: Soft Link Issues with Log Directories {#log-path-link}

Under normal circumstances, Datakit locates the log file path from the container/Kubernetes API and then collects the file.

In some special environments, a symbolic link might be created for the directory containing the log files. Datakit cannot anticipate the target of the symbolic link, making it unable to mount the directory, resulting in not finding the log file and failing to collect it.

For example, suppose a container log file is found at `/var/log/pods/default_log-demo_f2617302-9d3a-48b5-b4e0-b0d59f1f0cd9/log-output/0.log`, but in the current environment, `/var/log/pods` is a symbolic link pointing to `/mnt/container_logs`, as shown below:

```shell
root@node-01:~# ls /var/log -lh
total 284K
lrwxrwxrwx 1 root root   20 Oct  8 10:06 pods -> /mnt/container_logs/
```

To make Datakit collect logs normally, you need to mount `/mnt/container_logs` as a hostPath in `datakit.yaml`:

```yaml
    # Omitted
    spec:
      containers:
      - name: datakit
        image: pubrepo.guance.com/datakit/datakit:1.16.0
        volumeMounts:
        - mountPath: /mnt/container_logs
          name: container-logs
      # Omitted
      volumes:
      - hostPath:
          path: /mnt/container_logs
        name: container-logs
```

This situation is uncommon and usually only occurs if you know in advance that the path has a symbolic link or if you find an error in the Datakit logs.

### :material-chat-question: Setting the Source for Container Logs {#config-logging-source}

In container environments, setting the log source (`source`) is a crucial configuration item that directly affects how it appears on the page. However, manually configuring the source for each container's logs can be cumbersome. If you do not manually configure the source for container logs, DataKit uses the following rules (in decreasing order of priority) to infer the source of container logs:

> Not manually specifying the source of container logs means not specifying it in Pod Annotations or in `container.conf` (currently no configuration item for specifying container log sources in `container.conf`)

- Kubernetes-specified container name: Retrieved from the label `io.kubernetes.container.name`
- Container's own name: As seen through `docker ps` or `crictl ps`
- `default`: Default `source`

### :material-chat-question: Retaining Specified Fields Based on a Whitelist {#field-whitelist}

Container log collection includes the following basic fields:

| Field Name                                 |
| -----------                                |
| `service`                                  |
| `status`                                   |
| `filepath`                                 |
| `log_read_lines`                           |
| `container_id`                             |
| `container_name`                           |
| `namespace`                                |
| `pod_name`                                 |
| `pod_ip`                                   |
| `deployment`/`daemonset`/`statefulset`     |
| `inside_filepath`                          |

In special scenarios, many basic fields may not be necessary. Now, a whitelist feature is provided to retain only specified fields.

The whitelist configuration, for example, `ENV_INPUT_CONTAINER_LOGGING_FIELD_WHITE_LIST = '["service", "filepath", "container_name"]'`, works as follows:

- If the whitelist is empty, all basic fields are added.
- If the whitelist is not empty and valid, e.g., `["filepath", "container_name"]`, only these fields are retained.
- If the whitelist is not empty but contains invalid fields, e.g., `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded.

For other tag fields from different sources:

- The whitelist does not affect Datakit's global tags (`global tags`).
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` are unaffected, including `log_read_offset` and `log_file_inode` for log collection, and debug fields for `pipeline`.

### :material-chat-question: Wildcard Collection of Logs from Files Inside Containers {#config-logging-source}

To collect logs from files inside containers, you need to add a configuration in Annotations/Labels and specify the `path`:

```yaml
  [
    {
      "disable": false,
      "type": "file",
      "path":"/tmp/opt/log",
      "source":  "logging-file",
      "tags" : {
        "some_tag": "some_value"
      }
    }
  ]
```

The `path` configuration supports [glob rules](logging.md#glob-rules) for batch specification. For example, to collect `/var/top/mysql/1.log` and `/var/opt/mysql/errors/2.log`, you can write:

```yaml
  [
    {
      "disable": false,
      "type": "file",
      "path":"/tmp/opt/**/*.log",
      "source":  "logging-file",
      "tags" : {
        "some_tag": "some_value"
      }
    }
  ]
```

The `path` configuration uses double stars (doublestar) for multi-level directory matching, and `*.log` matches all files ending with `.log`. Thus, logs from different directories and filenames will be collected.

Note that the mounted emptyDir volume directory must be above the directory to be matched. For example, to collect `/tmp/opt/**/*.log`, you must mount `/tmp/opt` or a higher-level directory like `/tmp`, otherwise, the corresponding files will not be found.

## Further Reading {#more-reading}

- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [DataKit Log Collection Overview](datakit-logging.md)