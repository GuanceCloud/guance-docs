---
title: 'Kubernetes Logs'
summary: 'Collecting Container and Kubernetes Log Data'
tags:
  - 'Logs'
  - 'Container'
  - 'KUBERNETES'
__int_icon:    'icon/kubernetes/'
---

Datakit supports collecting logs from Kubernetes and host containers. From the data source perspective, these can be divided into the following two types:

- Console output: This refers to the stdout/stderr output of container applications, which is the most common method. You can view this using commands similar to `docker logs` or `kubectl logs`.

- Internal container files: If logs are not output to stdout/stderr, they are stored on disk as files. Collecting such logs is slightly more complicated and requires mounting.

This document will provide a detailed explanation of both collection methods.

## Console stdout/stderr Log Collection {#logging-stdout}

Console output (i.e., stdout/stderr) is written to files via the container runtime, and Datakit automatically retrieves the container's LogPath for collection.

If you need to customize the collection configuration, you can do so by adding container environment variables or Kubernetes Pod Annotations.

- The keys for custom configurations have the following cases:
    - The key for container environment variables is fixed at `DATAKIT_LOGS_CONFIG`.
    - There are two ways to write Pod Annotation keys:
        - `datakit/<container_name>.logs`, where `<container_name>` should be replaced with the current Pod's container name. This is used in multi-container environments.
        - `datakit/logs` applies to all containers within the Pod.

<!-- markdownlint-disable MD046 -->
???+ info

    If a container has an environment variable `DATAKIT_LOGS_CONFIG` and its Pod also has an Annotation `datakit/logs`, the configuration closest to the container takes precedence, i.e., the container environment variable.

<!-- markdownlint-enable -->

- The value for custom configurations is as follows:

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
| -----                          | ----              | ----                                                                                                                                                                        |
| `disable`                      | true/false        | Whether to disable log collection for this container. Default is `false`.                                                                                                  |
| `type`                         | `file`/not filled | Select the collection type. If collecting from a file inside the container, it must be set to `file`. By default, it is empty for collecting `stdout/stderr`.                |
| `path`                         | string            | Configuration file path. If collecting from a file inside the container, you must specify the volume's path, not the file path inside the container, but the path accessible outside the container. By default, it is not required for collecting `stdout/stderr`. |
| `source`                       | string            | Log source, refer to [Container Log Source Settings](container.md#config-logging-source).                                                                                  |
| `service`                      | string            | The service to which the log belongs. Default is the log source (source).                                                                                                  |
| `pipeline`                     | string            | The Pipeline script applicable to this log. Default is the script name matching the log source (`<source>.p`).                                                             |
| `remove_ansi_escape_codes`     | true/false        | Whether to remove color characters from log data.                                                                                            |
| `from_beginning`               | true/false        | Whether to collect logs from the beginning of the file.                                                                                                                    |
| `multiline_match`              | regex string      | Used for [multi-line log matching](logging.md#multiline) to identify the first line, e.g., `"multiline_match":"^\\d{4}"` indicates that the line starts with 4 digits. In regex rules, `\d` represents digits, and the preceding `\` is used for escaping. |
| `character_encoding`           | string            | Choose encoding; if incorrect, it may result in unreadable data. Supported encodings include `utf-8`, `utf-16le`, `utf-16be`, `gbk`, `gb18030` or "". By default, leave it empty. |
| `tags`                         | key/value pairs   | Add extra tags. If a tag key already exists, it will be overridden by this configuration ([:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)) |

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
            ## Add configuration and specify the container as log-output
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

    - Unless necessary, do not easily configure Pipelines in environment variables or Pod Annotations; generally, automatic inference through the `source` field is sufficient.
    - If adding Env/Annotations in configuration files or terminal command lines, use double quotes and add escape characters.

    The value of `multiline_match` is doubly escaped; four backslashes represent one actual backslash. For example, `\"multiline_match\":\"^\\\\d{4}\"` is equivalent to `"multiline_match":"^\d{4}"`. Example:

    ```shell
    kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"log-source\",\"service\":\"log-service\",\"pipeline\":\"test.p\",\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
    ```

    If a Pod/container log is already being collected, adding a new configuration via the `kubectl annotate` command will not take effect.

<!-- markdownlint-enable -->

## Internal Container Log File Collection {#logging-with-inside-config}

For internal container log files, the difference from console output logs is that you need to specify the file path, with other configuration items being largely similar.

Similarly, add container environment variables or Kubernetes Pod Annotations, with keys and values mostly consistent. Refer to the previous sections for details.

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
    ## Specify non-stdout path, "type" and "path" are required fields, and a volume for the collection path needs to be created
    ## For example, to collect the `/tmp/opt/log` file, add an anonymous volume for `/tmp/opt`
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
            ## Add configuration and specify the container as logging-demo
            ## Both file and stdout collection are configured. Note that to collect the "/tmp/opt/log" file, an emptyDir volume must be added for "/tmp/opt"
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

For internal container log files, in Kubernetes environments, collection can also be achieved by adding a sidecar. See [here](logfwd.md).

## Adjusting Log Collection Based on Container Image {#logging-with-image-config}

By default, DataKit collects all container stdout/stderr logs on the machine/Node, which may not be the expected behavior. Sometimes, we only want to collect (or exclude) logs from certain containers. This can be indirectly specified by image name or namespace.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ``` toml
    ## Example with image
    ## When a container's image matches `datakit`, its logs will be collected
    container_include_log = ["image:datakit"]
    ## Ignore all kodo containers
    container_exclude_log = ["image:kodo"]
    ```

    `container_include` and `container_exclude` must start with attribute fields, formatted as a [glob-like pattern](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}: `"<field_name>:<glob_pattern>"`

    Currently, the following 4 field rules are supported, all of which are infrastructure attribute fields:

    - image : `image:pubrepo.guance.com/datakit/datakit:1.18.0`
    - image_name : `image_name:pubrepo.guance.com/datakit/datakit`
    - image_short_name : `image_short_name:datakit`
    - namespace : `namespace:datakit-ns`

    For the same rule type (`image` or `namespace`), if both `include` and `exclude` exist, the conditions must satisfy `include` and not `exclude`. For example:
    ```toml
    ## This would filter out all containers. If there is a container `datakit`, it satisfies include but also satisfies exclude, so it would be filtered out and not collect logs; if a container `nginx` does not satisfy include, it would be filtered out and not collect logs.

    container_include_log = ["image_name:datakit"]
    container_exclude_log = ["image_name:*"]
    ```

    If any one of multiple field rules matches, the logs will not be collected. For example:
    ```toml
    ## A container only needs to match either `image_name` or `namespace` to not collect its logs.

    container_include_log = []
    container_exclude_log = ["image_name:datakit", "namespace:datakit-ns"]
    ```

    The configuration rules for `container_include_log` and `container_exclude_log` are complex, and using both simultaneously results in various priority scenarios. It is recommended to use only `container_exclude_log`.

=== "Kubernetes"

    Use the following environment variables:

    - ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
    - ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG

    To configure log collection for containers. Suppose there are 3 Pods with images:

    - A: `hello/hello-http:latest`
    - B: `world/world-http:latest`
    - C: `pubrepo.guance.com/datakit/datakit:1.2.0`

    If you only want to collect logs from Pod A, configure ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
        value: image:hello*  # Specify image name or wildcard
    ```

    Or configure by namespace:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG
        value: namespace:foo  # Specify namespace containers not to collect
    ```

???+ tip "How to View Images"

    Docker:

    ``` shell
    docker inspect --format "{{.Config.Image}}" $CONTAINER_ID
    ```

    Kubernetes Pod:

    ``` shell
    echo `kubectl get pod -o=jsonpath="{.items[0].spec.containers[0].image}"`
    ```

???+ attention

    Global configuration `container_exclude_log` has lower priority than container custom configuration `disable`. For example, configuring `container_exclude_log = ["image:*"]` to not collect all logs, if a Pod Annotation is as follows:

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

    This configuration is closer to the container and has higher priority. The setting `disable=false` indicates collecting log files, overriding the global configuration.

    Therefore, the container log file will still be collected, but console output stdout/stderr will not be collected because `disable=true`.

<!-- markdownlint-enable -->

## FAQ {#faq}

### :material-chat-question: Soft Links in Log Directories {#log-path-link}

Normally, Datakit finds the log file path from the container/Kubernetes API and then collects the file.

In some special environments, a soft link is made for the directory containing the log file. Datakit cannot anticipate the target of the soft link and cannot mount the directory, leading to an inability to find the log file and perform collection.

For example, if a container log file path is `/var/log/pods/default_log-demo_f2617302-9d3a-48b5-b4e0-b0d59f1f0cd9/log-output/0.log`, but in the current environment, `/var/log/pods` is a soft link pointing to `/mnt/container_logs`, as shown below:

```shell
root@node-01:~# ls /var/log -lh
total 284K
lrwxrwxrwx 1 root root   20 Oct  8 10:06 pods -> /mnt/container_logs/
```

Datakit needs to mount the `/mnt/container_logs` hostPath to enable normal collection. For example, add the following in `datakit.yaml`:

```yaml
    # omitted
    spec:
      containers:
      - name: datakit
        image: pubrepo.guance.com/datakit/datakit:1.16.0
        volumeMounts:
        - mountPath: /mnt/container_logs
          name: container-logs
      # omitted
      volumes:
      - hostPath:
          path: /mnt/container_logs
        name: container-logs
```

This situation is uncommon and usually only occurs when you know in advance that the path has a soft link or when checking Datakit logs reveals collection errors.

### :material-chat-question: Configuring Log Source in Containers {#config-logging-source}

In a container environment, setting the log source (`source`) is an important configuration item that directly affects display on the page. However, manually configuring a source for each container's logs can be cumbersome. If you do not manually configure the container log source, DataKit uses the following rules (in descending order of priority) to automatically infer the source of the container logs:

> Not manually specifying the container log source means not specifying it in Pod Annotations or in `container.conf` (currently, `container.conf` does not have a configuration item for specifying container log sources)

- Kubernetes-specified container name: obtained from the `io.kubernetes.container.name` label on the container
- Container name itself: the container name visible via `docker ps` or `crictl ps`
- `default`: default `source`

### :material-chat-question: Retaining Specific Fields Based on a Whitelist {#field-whitelist}

Container log collection includes the following basic fields:

| Field Name                                 |
| -----------                            |
| `service`                              |
| `status`                               |
| `filepath`                             |
| `log_read_lines`                       |
| `container_id`                         |
| `container_name`                       |
| `namespace`                            |
| `pod_name`                             |
| `pod_ip`                               |
| `deployment`/`daemonset`/`statefulset` |
| `inside_filepath`                      |

In certain scenarios, many of these basic fields are unnecessary. Now, a whitelist feature is provided to retain only specified fields.

The field whitelist configuration, for example, `ENV_INPUT_CONTAINER_LOGGING_FIELD_WHITE_LIST = '["service", "filepath", "container_name"]'`, works as follows:

- If the whitelist is empty, all basic fields are added.
- If the whitelist is not empty and valid, for example, `["filepath", "container_name"]`, only these two fields are retained.
- If the whitelist is not empty and contains only invalid fields, such as `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, the data is discarded.

For other source tags, the following applies:

- The whitelist does not affect Datakit's global tags (`global tags`).
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` remain unaffected, including `log_read_offset` and `log_file_inode` for log collection, as well as debug fields for `pipeline`.

### :material-chat-question: Glob Pattern Collection for Internal Container Log Files {#config-logging-source}

To collect log files within a container, you need to add a configuration in Annotations/Labels and specify the `path`, as follows:

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

This `path` configuration supports [glob patterns](logging.md#glob-rules) for batch specification. For example, to collect `/var/top/mysql/1.log` and `/var/opt/mysql/errors/2.log`, you can write it as follows:

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
```

Using double asterisks (doublestar) allows multi-level directory wildcards, and `*.log` matches all files ending with `.log`. Thus, log files from different directories and with different names will be collected.

Note that the mounted emptyDir volume directory must be above the directory to be wildcarded. For example, to collect `/tmp/opt/**/*.log`, you must mount `/tmp/opt` or a higher-level `/tmp`, otherwise, the corresponding files will not be found.

## Further Reading {#more-reading}

- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [DataKit Log Collection Overview](datakit-logging.md)