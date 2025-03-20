---
title: 'Kubernetes Logs'
summary: 'Collect logs data from Containers and Kubernetes'
tags:
  - 'LOGS'
  - 'CONTAINERS'
  - 'KUBERNETES'
__int_icon:    'icon/kubernetes/'
---

Datakit supports collecting Kubernetes and host container logs, which can be divided into the following two types in terms of data sources:

- Console output: This is the stdout/stderr output of the container application, which is also the most common method. It can be viewed using commands similar to `docker logs` or `kubectl logs`.

- Internal files in containers: If logs are not output to stdout/stderr, they are likely stored on disk in files. Collecting this type of log is slightly more complicated and requires a mount.

This article will detail both collection methods.

## Console stdout/stderr Log Collection {#logging-stdout}

Console output (i.e., stdout/stderr) is written to files by the container runtime, and Datakit automatically retrieves the container's LogPath for collection.

If you need to customize the configuration, this can be done by adding container environment variables or Kubernetes Pod Annotations.

- The Key for custom configurations has the following cases:
    - The Key for container environment variables is fixed as `DATAKIT_LOGS_CONFIG`.
    - There are two ways to write the Key for Pod Annotations:
        - `datakit/<container_name>.logs`, where `<container_name>` needs to be replaced with the container name of the current Pod. This is used in multi-container environments.
        - `datakit/logs` applies to all containers in the Pod.


<!-- markdownlint-disable MD046 -->
???+ info

    If a container has an environment variable `DATAKIT_LOGS_CONFIG` and its associated Pod Annotation `datakit/logs` is also found, the container environment variable takes precedence according to the principle of proximity.
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
| -----                         | ----              | ----                                                                                                                                                                      |
| `disable`                     | true/false       | Whether to disable log collection for this container. Default is `false`.                                                                                                   |
| `type`                        | `file`/not filled| Select the collection type. If it is collecting files inside the container, it must be set to `file`. Default is empty for collecting `stdout/stderr`.                          |
| `path`                        | String           | Configuration file path. If it is collecting files inside the container, the volume's path must be specified, not the file path inside the container but the accessible path outside. |
| `source`                      | String           | Log source, see [Container Log Collection Source Settings](container.md#config-logging-source).                                                                             |
| `service`                     | String           | The service that the log belongs to. Default value is the log source (source).                                                                                            |
| `pipeline`                    | String           | The Pipeline script applicable to this log. Default is the script name matching the log source (`<source>.p`).                                                            |
| `remove_ansi_escape_codes`   | true/false       | Whether to remove color characters from log data.                                                                                                                          |
| `from_beginning`             | true/false       | Whether to collect logs from the beginning of the file.                                                                                                                    |
| `multiline_match`             | Regular expression string | Used for identifying the first line in [multiline log matching](logging.md#multiline), e.g., `"multiline_match":"^\\d{4}"` indicates the start of the line is four digits. In regular expressions, `\d` represents numbers, and the preceding `\` is used for escaping. |
| `character_encoding`          | String           | Select encoding; if incorrect, data may not be viewable. Supported encodings include `utf-8`, `utf-16le`, `utf-16be`, `gbk`, `gb18030` or "". Default is empty.                  |
| `tags`                       | key/value pairs  | Add extra tags. If there is an existing tag with the same name, it will take precedence ([:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)).                   |

Complete example:

<!-- markdownlint-disable MD046 -->
=== "Container Environment Variables"

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

    ## Start the container, add environment variable DATAKIT_LOGS_CONFIG
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

    - Unless necessary, do not easily configure Pipelines in environment variables or Pod Annotations; usually, automatic deduction through the `source` field is sufficient.
    - If configuring Env/Annotations in configuration files or terminal command lines, both sides require English state double quotes and escape characters.

    The value of `multiline_match` is doubly escaped; four backslashes represent one actual backslash. For example, `\"multiline_match\":\"^\\\\d{4}\"` is equivalent to `"multiline_match":"^\d{4}"`. Example:

    ```shell
    kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"log-source\",\"service\":\"log-service\",\"pipeline\":\"test.p\",\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
    ```

    If a Pod/container log is already being collected, adding configuration via the `kubectl annotate` command will not take effect.

<!-- markdownlint-enable -->

## Container Internal Log File Collection {#logging-with-inside-config}

For internal log files within containers, the difference compared to console output logs is the need to specify the file path; other configuration items are largely the same.

Similarly, container environment variables or Kubernetes Pod Annotations are added, with Keys and Values mostly consistent with the previous section.

Complete example:

<!-- markdownlint-disable MD046 -->
=== "Container Environment Variables"

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

    ## Start the container, add environment variable DATAKIT_LOGS_CONFIG, note character escaping
    ## Specify non-stdout paths, "type" and "path" are required fields, and the collection path volume must be created
    ## For example, to collect `/tmp/opt/log`, an anonymous volume for `/tmp/opt` must be added
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
            ## Both file and stdout collection are configured. To collect "/tmp/opt/log", an emptyDir volume must be added for "/tmp/opt"
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

For internal log files within containers, sidecar implementation can also be used for collection in the Kubernetes environment, refer to [here](logfwd.md).

## Adjust Log Collection Based on Container Image {#logging-with-image-config}

By default, DataKit collects all containers' stdout/stderr logs on the machine/Node, which may not be expected behavior. Sometimes, we hope to only collect (or not collect) logs from some containers, which can be indirectly referenced through the image name or namespace.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ``` toml
    ## Using image as an example
    ## When the container's image matches `datakit`, the logs of this container will be collected
    container_include_log = ["image:datakit"]
    ## Ignore all kodo containers
    container_exclude_log = ["image:kodo"]
    ```

    `container_include` and `container_exclude` must start with attribute fields, formatted as a [glob-like regex](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}: `"<field>:<glob rule>"`

    Currently, the following 4 field rules are supported, all infrastructure property fields:

    - image : `image:pubrepo.guance.com/datakit/datakit:1.18.0`
    - image_name : `image_name:pubrepo.guance.com/datakit/datakit`
    - image_short_name : `image_short_name:datakit`
    - namespace : `namespace:datakit-ns`

    For the same rule type (`image` or `namespace`), if both `include` and `exclude` exist simultaneously, conditions must meet both `include` being true and `exclude` being false. For example:
    ```toml
    ## This would filter out all containers. If a container `datakit` meets include, it also meets exclude, so it will be filtered out and logs won't be collected; if a container `nginx` doesn't meet include, it will be filtered out and logs won't be collected.

    container_include_log = ["image_name:datakit"]
    container_exclude_log = ["image_name:*"]
    ```

    If any of multiple field rules match, logs will no longer be collected. For example:
    ```toml
    ## A container needs to meet either `image_name` or `namespace`, then logs will no longer be collected.

    container_include_log = []
    container_exclude_log = ["image_name:datakit", "namespace:datakit-ns"]
    ```

    The configuration rules for `container_include_log` and `container_exclude_log` are relatively complex when used together. It is recommended to use only `container_exclude_log`.

=== "Kubernetes"

    These environment variables can be used:

    - ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
    - ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG

    To configure container log collection. Suppose there are 3 Pods, their images respectively are:

    - A: `hello/hello-http:latest`
    - B: `world/world-http:latest`
    - C: `pubrepo.guance.com/datakit/datakit:1.2.0`

    If you want to collect logs only from Pod A, you can configure ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
        value: image:hello*  # Specify image name or its wildcard
    ```

    Or configure by namespace:

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG
        value: namespace:foo  # Do not collect logs from containers in this namespace
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

    Global configuration of `container_exclude_log` has lower priority than the container's custom configuration `disable`. For example, if `container_exclude_log = ["image:*"]` is configured not to collect all logs, and if there is a Pod Annotation like this:

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

    This configuration is closer to the container and has higher priority. The configured `disable=false` indicates that log files should be collected, overriding the global configuration above.

    Therefore, the container log file will still be collected eventually, but the console output stdout/stderr will not be collected because `disable=true`.

<!-- markdownlint-enable -->

## FAQ {#faq}

### :material-chat-question: Soft Link Issues with Log Directories {#log-path-link}

Under normal circumstances, Datakit finds the path of the log file from the container/Kubernetes API and collects that file.

In some special environments, a soft link may be made to the directory containing the logs. Datakit cannot know in advance the target of the soft link and cannot mount the directory, resulting in the inability to find the log file and thus perform the collection.

For example, if the path of a container log file is `/var/log/pods/default_log-demo_f2617302-9d3a-48b5-b4e0-b0d59f1f0cd9/log-output/0.log`, but in the current environment, `/var/log/pods` is a soft link pointing to `/mnt/container_logs`, as shown below:

```shell
root@node-01:~# ls /var/log -lh
total 284K
lrwxrwxrwx 1 root root   20 Oct  8 10:06 pods -> /mnt/container_logs/
```

Datakit needs to mount the `/mnt/container_logs` hostPath to enable normal collection, for example by adding the following in `datakit.yaml`:

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

This situation is uncommon and is generally only executed when the soft link path is known in advance or errors are found in the Datakit logs.

### :material-chat-question: Setting the Source for Container Log Collection {#config-logging-source}

In a container environment, setting the log source (`source`) is an important configuration item that directly affects how it is displayed on the page. However, manually configuring the source for each container log can be cumbersome. If the container log source is not manually configured, DataKit uses the following rules (in decreasing order of priority) to automatically infer the source of the container logs:

> What is meant by not manually specifying the container log source is not specifying it in Pod Annotations or in `container.conf` (currently there is no configuration item in `container.conf` for specifying the container log source)

- The Kubernetes-specified container name: taken from the `io.kubernetes.container.name` label of the container
- The container’s own name: visible through `docker ps` or `crictl ps`
- `default`: default `source`

### :material-chat-question: Retaining Specific Fields Based on Whitelist {#field-whitelist}

The following basic fields are included in container log collection:

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

In special scenarios, many basic fields are unnecessary. A whitelist (whitelist) function is now provided to retain only the specified fields.

An example of a field whitelist configuration is `ENV_INPUT_CONTAINER_LOGGING_FIELD_WHITE_LIST = '["service", "filepath", "container_name"]'`, with specific details as follows:

- If the whitelist is empty, all basic fields are added.
- If the whitelist is not empty and valid, such as `["filepath", "container_name"]`, then only these two fields are retained.
- If the whitelist is not empty and all fields are invalid, such as `["no-exist"]` or `["no-exist-key1", "no-exist-key2"]`, then the data is discarded.

For tags fields from other sources, the following situations apply:

- The whitelist does not affect Datakit's global tags (`global tags`).
- Debug fields enabled by `ENV_ENABLE_DEBUG_FIELDS = "true"` are unaffected, including `log_read_offset` and `log_file_inode` fields for log collection, as well as debug fields for `pipeline`.

### :material-chat-question: Wildcard Collection for Internal Log Files in Containers {#config-logging-source}

To collect log files within containers, a configuration must be added in Annotations/Labels and specify `path`, as follows:

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

This `path` configuration item supports [glob rules](logging.md#glob-rules) for batch specification. For example, to collect `/var/top/mysql/1.log` and `/var/opt/mysql/errors/2.log`, it can be written as follows:

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

The `path` configuration item uses doublestar for multi-level directory wildcards, and `*.log` matches all files ending with `.log`. Thus, two different directories and named log files will be collected.

Note that the mounted directory for adding emptyDir volume must be higher than the directory to be wildcarded. Still taking `/tmp/opt/**/*.log` as an example, `/tmp/opt` or even higher `/tmp` must be mounted, otherwise the corresponding files will not be found.

## Further Reading {#more-reading}

- [Pipeline: Text Data Processing](../pipeline/use-pipeline/index.md)
- [DataKit Log Collection Overview](datakit-logging.md)