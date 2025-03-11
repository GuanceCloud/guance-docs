---
title: 'Kubernetes'
summary: 'Collect metrics, objects, and log data from Container and Kubernetes and report to Guance.'
__int_icon:    'icon/kubernetes/'  
tags:
  - 'KUBERNETES'
  - 'Container'
dashboard:
  - desc: 'Kubernetes Cluster Overview Monitoring View'
    path: 'dashboard/en/kubernetes'
  - desc: 'Kubernetes Nodes Overview Monitoring View'
    path: 'dashboard/en/kubernetes_nodes_overview'
  - desc: 'Kubernetes Services Monitoring View'
    path: 'dashboard/en/kubernetes_services'
  - desc: 'Kubernetes Deployments Monitoring View'
    path: 'dashboard/en/kubernetes_deployment'
  - desc: 'Kubernetes DaemonSets Monitoring View'
    path: 'dashboard/en/kubernetes_daemonset'
  - desc: 'Kubernetes StatefulSets Monitoring View'
    path: 'dashboard/en/kubernetes_statefulset'
  - desc: 'Kubernetes Pods Overview Monitoring View'
    path: 'dashboard/en/kubernetes_pods_overview'
  - desc: 'Kubernetes Pods Detail Monitoring View'
    path: 'dashboard/en/kubernetes_pod_detail'
  - desc: 'Kubernetes Events Monitoring View'
    path: 'dashboard/en/kubernetes_events'
 
monitor:
  - desc: 'Kubernetes'
    path: 'monitor/en/kubernetes'
---



:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

Collect metrics, objects, and log data from Container and Kubernetes and report to Guance.

## Collector Configuration {#config}

### Prerequisites {#requrements}

- Currently, container supports Docker, Containerd, and CRI-O container runtimes.
    - Version requirements: Docker v17.04 and above, Containerd v1.5.1 and above, CRI-O 1.20.1 and above.
- Collecting Kubernetes data requires DataKit to be deployed in [DaemonSet mode](../datakit/datakit-daemonset-deploy.md).

<!-- markdownlint-disable MD046 -->
???+ info

    - Container collection supports Docker and Containerd runtimes [:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7), and both are enabled by default.

=== "Host Installation"

    If it is a pure Docker or Containerd environment, then DataKit can only be installed on the host machine.
    
    Navigate to the *conf.d/container* directory under the DataKit installation directory, copy *container.conf.sample* and rename it to *container.conf*. An example is as follows:
    
    ``` toml
        
    [inputs.container]
      endpoints = [
        "unix:///var/run/docker.sock",
        "unix:///var/run/containerd/containerd.sock",
        "unix:///var/run/crio/crio.sock",
      ]
    
      enable_container_metric = true
      enable_k8s_metric       = true
      enable_pod_metric       = false
      enable_k8s_event        = true
      enable_k8s_node_local   = true
    
      ## Add resource Label as Tags (container uses Pod Label), need to specify Label keys.
      ## e.g. ["app", "name"]
      # extract_k8s_label_as_tags_v2            = []
      # extract_k8s_label_as_tags_v2_for_metric = []
    
      ## Containers logs to include and exclude, default collect all containers. Globs accepted.
      container_include_log = []
      container_exclude_log = ["image:*logfwd*", "image:*datakit*"]
    
      kubernetes_url = "https://kubernetes.default:443"
    
      ## Authorization level:
      ##   bearer_token -> bearer_token_string -> TLS
      ## Use bearer token for authorization. ('bearer_token' takes priority)
      ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
      bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      # bearer_token_string = "<your-token-string>"
    
      ## Set true to enable election for k8s metric collection
      election = true
    
      logging_enable_multiline             = true
      logging_auto_multiline_detection     = true
      logging_auto_multiline_extra_patterns = []
    
      ## Only retain the fields specified in the whitelist.
      logging_field_white_list = []
    
      ## Removes ANSI escape codes from text strings.
      logging_remove_ansi_escape_codes = false
    
      ## Whether to collect logs from the beginning of the file.
      logging_file_from_beginning = false
    
      ## The maximum allowed number of open files, default is 500. If it is -1, it means no limit.
      # logging_max_open_files = 500
    
      ## Search logging interval, default "60s".
      #logging_search_interval = ""
    
      ## Log collection configures additional source matching, and the regular source will be renamed.
      [inputs.container.logging_extra_source_map]
        # source_regexp = "new_source"
    
      ## Log collection with multiline configuration as specified by the source.
      [inputs.container.logging_source_multiline_map]
        # source = '''^\d{4}'''
    
      [inputs.container.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

=== "Kubernetes"

    You can enable the collector through [ConfigMap method injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables also support modifying configuration parameters (need to add as default collectors in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_CONTAINER_ENDPOINTS**
    
        Append multiple container runtime endpoints
    
        **Field Type**: List
    
        **Collector Configuration Field**: `endpoints`
    
        **Example**: "`unix:///var/run/docker.sock,unix:///var/run/containerd/containerd.sock,unix:///var/run/crio/crio.sock`"
    
    - **ENV_INPUT_CONTAINER_DOCKER_ENDPOINT**
    
        Deprecated, specifies Docker Engine's endpoint
    
        **Field Type**: String
    
        **Collector Configuration Field**: `docker_endpoint`
    
        **Example**: `unix:///var/run/docker.sock`
    
    - **ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS**
    
        Deprecated, specifies `Containerd`'s endpoint
    
        **Field Type**: String
    
        **Collector Configuration Field**: `containerd_address`
    
        **Example**: `/var/run/containerd/containerd.sock`
    
    - **ENV_INPUT_CONTAINER_ENABLE_CONTAINER_METRIC**
    
        Enable container metrics collection
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_container_metric`
    
        **Default Value**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_METRIC**
    
        Enable k8s metrics collection
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_metric`
    
        **Default Value**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_POD_METRIC**
    
        Whether to enable Pod metrics collection (CPU and memory usage)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_pod_metric`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_EVENT**
    
        Whether to enable time-based collection mode
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_event`
    
        **Default Value**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_NODE_LOCAL**
    
        Whether to enable Node-based collection mode, where Datakit deployed on each Node independently collects resources from the current Node. [:octicons-tag-24: Version-1.19.0](../datakit/changelog.md#cl-1.19.0) requires additional `RABC` permissions, see [here](#rbac-nodes-stats)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_node_local`
    
        **Default Value**: true
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS**
    
        Whether to append resource labels to collected tags. Only Pod metrics, objects, and Node objects will add labels, and container logs will also add their associated Pod labels. If the label key contains dot characters, it will be changed to hyphens.
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `extract_k8s_label_as_tags`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2**
    
        Append resource labels to tags in data (excluding metric data). Specify label keys; if only one key and an empty string (e.g., [""]), all labels will be added to the tag. Containers inherit Pod labels. If the label key contains dot characters, it will be changed to hyphens.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `extract_k8s_label_as_tags_v2`
    
        **Example**: `["app","name"]`
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC**
    
        Append resource labels to metric data tags. Specify label keys; if only one key and an empty string (e.g., [""]), all labels will be added to the tag. Containers inherit Pod labels. If the label key contains dot characters, it will be changed to hyphens.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `extract_k8s_label_as_tags_v2_for_metric`
    
        **Example**: `["app","name"]`
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_ANNOTATIONS**
    
        Whether to enable automatic discovery of Prometheus Pod Annotations and collect metrics
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_pod_annotations`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_ANNOTATIONS**
    
        Whether to enable automatic discovery of Prometheus Service Annotations and collect metrics
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_service_annotations`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_MONITORS**
    
        Whether to enable automatic discovery of Prometheus Pod Monitor CRD and collect metrics, see [Prometheus-Operator CRD documentation](kubernetes-prometheus-operator-crd.md#config)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_pod_monitors`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS**
    
        Whether to enable automatic discovery of Prometheus ServiceMonitor CRD and collect metrics, see [Prometheus-Operator CRD documentation](kubernetes-prometheus-operator-crd.md#config)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_service_monitors`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_KEEP_EXIST_PROMETHEUS_METRIC_NAME**
    
        Deprecated. Whether to retain original Prometheus field names, see [Kubernetes Prometheus](kubernetes-prom.md#measurement-and-tags)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_exist_prometheus_metric_name`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG**
    
        Container log whitelist, filtered using image/namespace
    
        **Field Type**: List
    
        **Collector Configuration Field**: `container_include_log`
    
        **Example**: `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`
    
    - **ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG**
    
        Container log blacklist, filtered using image/namespace
    
        **Field Type**: List
    
        **Collector Configuration Field**: `container_exclude_log`
    
        **Example**: `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`
    
    - **ENV_INPUT_CONTAINER_POD_INCLUDE_METRIC**
    
        Pod metrics whitelist, filtered using namespace
    
        **Field Type**: List
    
        **Collector Configuration Field**: `pod_include_metric`
    
        **Example**: `"namespace:datakit*"`
    
    - **ENV_INPUT_CONTAINER_POD_EXCLUDE_METRIC**
    
        Pod metrics blacklist, filtered using namespace
    
        **Field Type**: List
    
        **Collector Configuration Field**: `pod_exclude_metric`
    
        **Example**: `"namespace:kube-system"`
    
    - **ENV_INPUT_CONTAINER_KUBERNETES_URL**
    
        k8s API service access address
    
        **Field Type**: String
    
        **Collector Configuration Field**: `kubernetes_url`
    
        **Example**: `https://kubernetes.default:443`
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN**
    
        Path to the token file required for accessing k8s services
    
        **Field Type**: String
    
        **Collector Configuration Field**: `bearer_token`
    
        **Example**: `/run/secrets/kubernetes.io/serviceaccount/token`
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN_STRING**
    
        Token string required for accessing k8s services
    
        **Field Type**: String
    
        **Collector Configuration Field**: `bearer_token_string`
    
        **Example**: `your-token-string`
    
    - **ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL**
    
        Log discovery time interval, i.e., how often to search for logs. If the interval is too long, it may ignore some short-lived logs.
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `logging_search_interval`
    
        **Default Value**: 60s
    
    - **ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP**
    
        Additional source matching for log collection, sources that match the regex will be renamed
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `logging_extra_source_map`
    
        **Example**: `source_regex*=new_source,regex*=new_source2`
    
    - **ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON**
    
        Multiline configuration for log collection based on source
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `logging_source_multiline_map`
    
        **Example**: `{"source_nginx":"^\d{4}", "source_redis":"^[A-Za-z_]"}`
    
    - **ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_DETECTION**
    
        Whether to enable automatic multiline detection for log collection, which matches applicable multiline rules from the patterns list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `logging_auto_multiline_detection`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_EXTRA_PATTERNS_JSON**
    
        Automatic multiline detection patterns list for log collection, supporting manual configuration of multiple multiline rules
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `logging_auto_multiline_extra_patterns`
    
        **Example**: `["^\d{4}-\d{2}", "^[A-Za-z_]"]`
    
        **Default Value**: For more default rules, see [doc](logging.md#auto-multiline)
    
    - **ENV_INPUT_CONTAINER_LOGGING_MAX_MULTILINE_LIFE_DURATION**
    
        Maximum lifecycle for single multiline log collection, after this duration, existing multiline data will be cleared and uploaded to avoid accumulation
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `logging_max_multiline_life_duration`
    
        **Default Value**: 3s
    
    - **ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES**
    
        Remove color codes from log collection, see [Log Special Character Handling Documentation](logging.md#ansi-decode)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `logging_remove_ansi_escape_codes`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_FILE_FROM_BEGINNING_THRESHOLD_SIZE**
    
        Determine whether to start collecting from the beginning based on file size. If the file size is less than this value when discovered, it will use from_beginning to start collecting from the head.
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `logging_file_from_beginning_threshold_size`
    
        **Default Value**: 20,000,000
    
    - **ENV_INPUT_CONTAINER_LOGGING_FILE_FROM_BEGINNING**
    
        Whether to start collecting logs from the beginning of the file
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `logging_file_from_beginning`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_MAX_OPEN_FILES**
    
        Maximum number of open files for log collection, -1 means no limit
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `logging_max_open_files`
    
        **Default Value**: 500
    
    - **ENV_INPUT_CONTAINER_LOGGING_FIELD_WHITE_LIST**
    
        Specify fields to retain in the whitelist
    
        **Field Type**: List
    
        **Collector Configuration Field**: `logging_field_white_list`
    
        **Example**: `'["service","container_id"]'`
    
    - **ENV_INPUT_CONTAINER_CONTAINER_MAX_CONCURRENT**
    
        Maximum concurrency for collecting container data, recommended only when there is significant collection delay
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `container_max_concurrent`
    
        **Default Value**: cpu cores + 1
    
    - **ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB**
    
        Disable collection of Kubernetes Job resources (including metrics data and object data)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `disable_collect_kube_job`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB**
    
        Disable collection of Kubernetes Job resources (including metrics data and object data)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `disable_collect_kube_job`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM**
    
        Enable collection of Kubernetes Prometheus data, including APIServer, Scheduler, Etcd, etc. (experimental)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_self_metric_by_prom`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_TAGS**
    
        Custom tags. If the configuration file has the same named tag, it will be overridden by this configuration.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

    Additional notes on environment variables:
    
    - ENV_INPUT_CONTAINER_TAGS: If the configuration file (*container.conf*) has the same named tag, it will be overridden by this configuration.
    
    - ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP: Specifies replacement source, parameter format is "regex=new_source". When a source matches the regex, it will be replaced by new_source. If successful replacement occurs, it will not use the source configured in `annotations/labels` ([Version-1.4.7](../datakit/changelog.md#cl-1.4.7)). To achieve exact matching, enclose content with `^` and `$`. For example, regex `datakit` can match `datakit` and `datakit123`, while `^datakit$` only matches `datakit`.
    
    - ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON: Used to specify mapping from source to multiline configuration. If a log does not have a configured `multiline_match`, it will look up and use the corresponding `multiline_match` based on its source. Since `multiline_match` values are complex regular expressions, the value format is a JSON string, which can be written and compressed into one line using [json.cn](https://www.json.cn/){:target="_blank"}.

???+ attention

    - Object data collection interval is 5 minutes, and metrics data collection interval is 60 seconds, which are not configurable.
    - Collected logs have a maximum single-line length of 32MB (including after `multiline_match` processing), exceeding parts will be truncated and discarded.

### Docker and Containerd Sock File Configuration {#sock-config}

If the Docker or Containerd sock path is not the default, you need to specify the sock file path according to different deployment methods of DataKit. Taking Containerd as an example:

=== "Host Deployment"

    Modify the `endpoints` configuration item in *container.conf* to set it to the corresponding sock path.

=== "Kubernetes"

    Change the volumes `containerd-socket` in *datakit.yaml*, mount the new path to Datakit, and configure the environment variable `ENV_INPUT_CONTAINER_ENDPOINTS`:

    ``` yaml hl_lines="3 4 7 14"
    # Add env
    - env:
      - name: ENV_INPUT_CONTAINER_ENDPOINTS
        value: ["unix:///path/to/new/containerd/containerd.sock"]
    
    # Modify mountPath
      - mountPath: /path/to/new/containerd/containerd.sock
        name: containerd-socket
        readOnly: true
    
    # Modify volumes
    volumes:
    - hostPath:
        path: /path/to/new/containerd/containerd.sock
      name: containerd-socket
    ```
<!-- markdownlint-enable -->

The environment variable `ENV_INPUT_CONTAINER_ENDPOINTS` appends to the existing endpoints configuration. The final actual endpoints configuration may contain multiple items, and the collector will deduplicate and connect them sequentially.

The default endpoints configuration is:

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
  ] 
```

Using the environment variable `ENV_INPUT_CONTAINER_ENDPOINTS` as `["unix:///path/to/new//run/containerd.sock"]`, the final endpoints configuration becomes:

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
    "unix:///path/to/new//run/containerd.sock",
  ] 
```

The collector will connect and collect these container runtimes. If the sock file does not exist, it will output an error log on the first connection failure without affecting subsequent collections.

### Prometheus Exporter Metrics Collection {#k8s-prom-exporter}

<!-- markdownlint-disable MD024 -->
If Pods/containers expose Prometheus metrics, there are two ways to collect them, refer to [here](kubernetes-prom.md)


### Log Collection {#logging-config}

Refer to [here](container-log.md) for related log collection configurations.

---

## Metrics {#metric}

By default, all data collected will append a global tag named `host` (the tag value is the hostname of the DataKit host), and you can also specify other tags in the configuration via `[inputs.container.tags]`:

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `docker_containers`

Metrics of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|Container status (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`task_arn`|The task arn of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (only supported docker).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (only supported docker).|int|B|
|`cpu_limit_millicores`|The CPU limit of the container, measured in milli-cores.|int|m|
|`cpu_numbers`|The number of CPU cores on the system host.|int|count|
|`cpu_request_millicores`|The CPU request of the container, measured in milli-cores.|int|m|
|`cpu_usage`|The actual CPU usage on the system host (percentage).|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum value of 100%. It is calculated as the number of CPU cores multiplied by 100.|float|percent|
|`cpu_usage_base_limit`|The CPU usage based on the CPU limit (percentage).|float|percent|
|`cpu_usage_base_request`|The CPU usage based on the CPU request (percentage).|float|percent|
|`cpu_usage_millicores`|The CPU usage of the container, measured in milli-cores.|int|m|
|`mem_capacity`|The total memory on the system host.|int|B|
|`mem_limit`|The memory limit of the container.|int|B|
|`mem_request`|The memory request of the container.|int|B|
|`mem_usage`|The actual memory usage of the container.|int|B|
|`mem_used_percent`|The memory usage percentage based on the total memory of the system host.|float|percent|
|`mem_used_percent_base_limit`|The memory usage percentage based on the memory limit.|float|percent|
|`mem_used_percent_base_request`|The memory usage percentage based on the memory request.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only count the usage of the main process in the container, excluding loopback).|int|B|














### `kubernetes`

Count of Kubernetes resources.

- Tags


| Tag | Description |
|  ----  | --------|
|`namespace`|namespace|
|`node_name`|NodeName is a request to schedule this pod onto a specific node (only supported Pod and Container).|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`container`|Container count|int|-|
|`cronjob`|CronJob count|int|-|
|`daemonset`|Service count|int|-|
|`deployment`|Deployment count|int|-|
|`endpoint`|Endpoint count|int|-|
|`job`|Job count|int|-|
|`node`|Node count|int|-|
|`pod`|Pod count|int|-|
|`replicaset`|ReplicaSet count|int|-|
|`service`|Service count|int|-|
|`statefulset`|StatefulSet count|int|-|






### `kube_cronjob`

Metrics of the Kubernetes CronJob.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`cronjob`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of CronJob.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`spec_suspend`|This flag tells the controller to suspend subsequent executions.|bool|-|










### `kube_daemonset`

Metrics of the Kubernetes DaemonSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of DaemonSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`daemons_available`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|










### `kube_deployment`

Metrics of the Kubernetes Deployment.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Deployment.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_desired`|Number of desired pods for a Deployment.|int|count|
|`replicas_ready`|The number of pods targeted by this Deployment with a Ready Condition.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|










### `kube_dfpv`

Metrics of the Kubernetes PersistentVolume.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The dfpv name, consists of pvc name and pod name|
|`namespace`|The namespace of Pod and PVC.|
|`node_name`|Reference to the Node.|
|`pod_name`|Reference to the Pod.|
|`pvc_name`|Reference to the PVC.|
|`volume_mount_name`|The name given to the Volume.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|AvailableBytes represents the storage space available (bytes) for the filesystem.|int|B|
|`capacity`|CapacityBytes represents the total capacity (bytes) of the filesystems underlying storage.|int|B|
|`inodes`|Inodes represents the total inodes in the filesystem.|int|count|
|`inodes_free`|InodesFree represents the free inodes in the filesystem.|int|count|
|`inodes_used`|InodesUsed represents the inodes used by the filesystem.|int|count|
|`used`|UsedBytes represents the bytes used for a specific task on the filesystem.|int|B|










### `kube_endpoint`

Metrics of the Kubernetes Endpoints.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`endpoint`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`address_available`|Number of addresses available in endpoint.|int|count|
|`address_not_ready`|Number of addresses not ready in endpoint.|int|count|










### `kube_job`

Metrics of the Kubernetes Job.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`job`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Job.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of actively running pods.|int|count|
|`completion_failed`|The job has failed its execution.|int|count|
|`completion_succeeded`|The job has completed its execution.|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










### `kube_node`

Metrics of the Kubernetes Node.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`node`|Name must be unique within a namespace|
|`uid`|The UID of Node.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_allocatable`|The allocatable CPU of a node that is available for scheduling.|int|-|
|`cpu_capacity`|The CPU capacity of a node.|int|-|
|`ephemeral_storage_allocatable`|The allocatable ephemeral-storage of a node that is available for scheduling.|int|-|
|`ephemeral_storage_capacity`|The ephemeral-storage capacity of a node.|int|-|
|`memory_allocatable`|The allocatable memory of a node that is available for scheduling.|int|-|
|`memory_capacity`|The memory capacity of a node.|int|-|
|`pods_allocatable`|The allocatable pods of a node that is available for scheduling.|int|-|
|`pods_capacity`|The pods capacity of a node.|int|-|


















### `kube_pod`

Metrics of the Kubernetes Pod.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`pod`|Name must be unique within a namespace.|
|`pod_name`|Renamed from 'pod'.|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`uid`|The UID of pod.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_limit_millicores`|The total CPU limit (in millicores) across all containers in this Pod. Note: This value is the sum of all container limit values, as Pods do not have a direct limit value.|int|m|
|`cpu_number`|The total number of CPUs on the node where the Pod is running.|int|count|
|`cpu_request_millicores`|The total CPU request (in millicores) across all containers in this Pod. Note: This value is the sum of all container request values, as Pods do not have a direct request value.|int|m|
|`cpu_usage`|The total CPU usage across all containers in this Pod.|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum of 100%.|float|percent|
|`cpu_usage_base_limit`|The normalized CPU usage, with a maximum of 100%, based on the CPU limit.|float|percent|
|`cpu_usage_base_request`|The normalized CPU usage, with a maximum of 100%, based on the CPU request.|float|percent|
|`cpu_usage_millicores`|The total CPU usage (in millicores) averaged over the sample window for all containers.|int|m|
|`ephemeral_storage_available_bytes`|The storage space available (bytes) for the filesystem.|int|B|
|`ephemeral_storage_capacity_bytes`|The total capacity (bytes) of the filesystems underlying storage.|int|B|
|`ephemeral_storage_used_bytes`|The bytes used for a specific task on the filesystem.|int|B|
|`mem_capacity`|The total memory capacity of the host machine.|int|B|
|`mem_limit`|The total memory limit across all containers in this Pod. Note: This value is the sum of all container limit values, as Pods do not have a direct limit value.|int|B|
|`mem_request`|The total memory request across all containers in this Pod. Note: This value is the sum of all container request values, as Pods do not have a direct request value.|int|B|
|`mem_rss`|The total RSS memory usage of all containers in this Pod, which is not supported by metrics-server.|int|B|
|`mem_usage`|The total memory usage of all containers in this Pod.|int|B|
|`mem_used_percent`|The percentage of memory usage based on the host machine’s total memory capacity.|float|percent|
|`mem_used_percent_base_limit`|The percentage of memory usage based on the memory limit.|float|percent|
|`mem_used_percent_base_request`|The percentage of memory usage based on the memory request.|float|percent|
|`memory_capacity`|The total memory in the host machine (Deprecated use `mem_capacity`).|int|B|
|`memory_usage_bytes`|The sum of the memory usage of all containers in this Pod (Deprecated use `mem_usage`).|int|B|
|`memory_used_percent`|The percentage usage of the memory (refer from `mem_used_percent`).|float|percent|
|`network_bytes_rcvd`|Cumulative count of bytes received.|int|B|
|`network_bytes_sent`|Cumulative count of bytes transmitted.|int|B|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










### `kube_replicaset`

Metrics of the Kubernetes ReplicaSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replicaset`|Name must be unique within a namespace.|
|`uid`|The UID of ReplicaSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fully_labeled_replicas`|The number of fully labeled replicas per ReplicaSet.|int|count|
|`replicas`|The most recently observed number of replicas.|int|count|
|`replicas_available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|count|
|`replicas_desired`|The number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count|










### `kube_service`

Metrics of the Kubernetes Service.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service`|Name must be unique within a namespace.|
|`uid`|The UID of Service|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`ports`|Total number of ports that are exposed by this service.|int|count|










### `kube_statefulset`

Metrics of the Kubernetes StatefulSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`statefulset`|Name must be unique within a namespace.|
|`uid`|The UID of StatefulSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replicas`|The number of Pods created by the StatefulSet controller.|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this StatefulSet.|int|count|
|`replicas_current`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.|int|count|
|`replicas_desired`|The desired number of replicas of the given Template.|int|count|
|`replicas_ready`|The number of pods created for this StatefulSet with a Ready Condition.|int|count|
|`replicas_updated`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.|int|count|








## Objects {#object}









### `docker_containers`

Objects of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`name`|The ID of the container.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|The state of the Container (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`status`|The status of the container, example `Up 5 hours`.|
|`task_arn`|The task arn of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`block_read_byte`|Total number of bytes read from the container file system (only supported docker).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (only supported docker).|int|B|
|`cpu_limit_millicores`|The CPU limit of the container, measured in milli-cores.|int|m|
|`cpu_numbers`|The number of CPU cores on the system host.|int|count|
|`cpu_request_millicores`|The CPU request of the container, measured in milli-cores.|int|m|
|`cpu_usage`|The actual CPU usage on the system host (percentage).|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum value of 100%. It is calculated as the number of CPU cores multiplied by 100.|float|percent|
|`cpu_usage_base_limit`|The CPU usage based on the CPU limit (percentage).|float|percent|
|`cpu_usage_base_request`|The CPU usage based on the CPU request (percentage).|float|percent|
|`cpu_usage_millicores`|The CPU usage of the container, measured in milli-cores.|int|m|
|`mem_capacity`|The total memory on the system host.|int|B|
|`mem_limit`|The memory limit of the container.|int|B|
|`mem_request`|The memory request of the container.|int|B|
|`mem_usage`|The actual memory usage of the container.|int|B|
|`mem_used_percent`|The memory usage percentage based on the total memory of the system host.|float|percent|
|`mem_used_percent_base_limit`|The memory usage percentage based on the memory limit.|float|percent|
|`mem_used_percent_base_request`|The memory usage percentage based on the memory request.|float|percent|
|`message`|Object details|string|-|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only count the usage of the main process in the container, excluding loopback).|int|B|


















### `kubernetes_cron_jobs`

Objects of the Kubernetes CronJob.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`cron_job_name`|Name must be unique within a namespace.|
|`name`|The UID of CronJob.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of CronJob.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_jobs`|The number of pointers to currently running jobs.|int|count|
|`age`|Age (seconds)|int|s|
|`message`|Object details|string|-|
|`schedule`|The schedule in Cron format, see [doc](https://en.wikipedia.org/wiki/Cron){:target="_blank"}|string|-|
|`suspend`|This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.|bool|-|










### `kubernetes_daemonset`

Objects of the Kubernetes DaemonSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset_name`|Name must be unique within a namespace.|
|`name`|The UID of DaemonSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of DaemonSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`daemons_available`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`message`|Object details|string|-|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|










### `kubernetes_deployments`

Objects of the Kubernetes Deployment.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment_name`|Name must be unique within a namespace.|
|`name`|The UID of Deployment.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Deployment.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment. (Deprecated)|int|count|
|`max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. (Deprecated)|int|count|
|`max_unavailable`|The maximum number of pods that can be unavailable during the update. (Deprecated)|int|count|
|`message`|Object details|string|-|
|`paused`|Indicates that the deployment is paused (true or false).|bool|-|
|`ready`|The number of pods targeted by this Deployment with a Ready Condition. (Deprecated)|int|count|
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_desired`|Number of desired pods for a Deployment.|int|count|
|`replicas_ready`|The number of pods targeted by this Deployment with a Ready Condition.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|
|`strategy`|Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.|string|-|
|`unavailable`|Total number of unavailable pods targeted by this deployment. (Deprecated)|int|count|
|`up_dated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec. (Deprecated)|int|count|










### `kubernetes_dfpv`

Objects of the Kubernetes PersistentVolume.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The dfpv name, consists of pvc name and pod name|
|`namespace`|The namespace of Pod and PVC.|
|`node_name`|Reference to the Node.|
|`pod_name`|Reference to the Pod.|
|`pvc_name`|Reference to the PVC.|
|`volume_mount_name`|The name given to the Volume.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|AvailableBytes represents the storage space available (bytes) for the filesystem.|int|B|
|`capacity`|CapacityBytes represents the total capacity (bytes) of the filesystems underlying storage.|int|B|
|`inodes`|Inodes represents the total inodes in the filesystem.|int|count|
|`inodes_free`|InodesFree represents the free inodes in the filesystem.|int|count|
|`inodes_used`|InodesUsed represents the inodes used by the filesystem.|int|count|
|`message`|Object details|string|-|
|`used`|UsedBytes represents the bytes used for a specific task on the filesystem.|int|B|


















### `kubernetes_jobs`

Objects of the Kubernetes Job.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`job_name`|Name must be unique within a namespace.|
|`name`|The UID of Job.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Job.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of actively running pods.|int|count|
|`active_deadline`|Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it|int|s|
|`age`|Age (seconds)|int|s|
|`backoff_limit`|Specifies the number of retries before marking this job failed.|int|count|
|`completions`|Specifies the desired number of successfully finished pods the job should be run with.|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`message`|Object details|string|-|
|`parallelism`|Specifies the maximum desired number of pods the job should run at any given time.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










### `kubernetes_nodes`

Objects of the Kubernetes Node.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`internal_ip`|Node internal IP|
|`name`|The UID of Node.|
|`node_name`|Name must be unique within a namespace.|
|`role`|Node role. (master/node)|
|`status`|NodePhase is the recently observed lifecycle phase of the node. (Pending/Running/Terminated)|
|`uid`|The UID of Node.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds).|int|s|
|`kubelet_version`|Kubelet Version reported by the node.|string|-|
|`message`|Object details.|string|-|
|`node_ready`|NodeReady means kubelet is healthy and ready to accept pods (true/false/unknown).|string|-|
|`taints`|Node's taints.|string|-|
|`unschedulable`|Unschedulable controls node schedulability of new pods (yes/no).|string|-|






### `kubernetes_persistentvolumes`

Objects of the Kubernetes PersistentVolume.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of PersistentVolume.|
|`persistentvolume_name`|The name of PersistentVolume|
|`uid`|The UID of PersistentVolume.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`claimRef_name`|Name of the bound PersistentVolumeClaim.|string|-|
|`claimRef_namespace`|Namespace of the PersistentVolumeClaim.|string|-|
|`message`|Object details|string|-|
|`phase`|The phase indicates if a volume is available, bound to a claim, or released by a claim.(Pending/Available/Bound/Released/Failed)|string|-|






### `kubernetes_persistentvolumeclaims`

Objects of the Kubernetes PersistentVolumeClaim.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of PersistentVolume.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`persistentvolumeclaim_name`|Name must be unique within a namespace.|
|`uid`|The UID of PersistentVolume.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Object details|string|-|
|`phase`|The phase indicates if a volume is available, bound to a claim, or released by a claim.(Pending/Bound/Lost)|string|-|
|`storage_class_name`|StorageClassName is the name of the StorageClass required by the claim.|string|-|
|`volume_mode`|VolumeMode defines what type of volume is required by the claim.(Block/Filesystem)|string|-|
|`volume_name`|VolumeName is the binding reference to the PersistentVolume backing this claim.|string|-|










### `kubelet_pod`

Objects of the Kubernetes Pod.

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`name`|The UID of Pod.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`phase`|The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle.(Pending/Running/Succeeded/Failed/Unknown)|
|`pod_name`|Name must be unique within a namespace.|
|`qos_class`|The Quality of Service (QOS) classification assigned to the pod based on resource requirements|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`status`|Reason the container is not yet running.|
|`uid`|The UID of Pod.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Number of containers|int|count|
|`cpu_limit_millicores`|The total CPU limit (in millicores) across all containers in this Pod. Note: This value is the sum of all container limit values, as Pods do not have a direct limit value.|int|m|
|`cpu_number`|The total number of CPUs on the node where the Pod is running.|int|count|
|`cpu_request_millicores`|The total CPU request (in millicores) across all containers in this Pod. Note: This value is the sum of all container request values, as Pods do not have a direct request value.|int|m|
|`cpu_usage`|The total CPU usage across all containers in this Pod.|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum of 100%.|float|percent|
|`cpu_usage_base_limit`|The normalized CPU usage, with a maximum of 100%, based on the CPU limit.|float|percent|
|`cpu_usage_base_request`|The normalized CPU usage, with a maximum of 100%, based on the CPU request.|float|percent|
|`cpu_usage_millicores`|The total CPU usage (in millicores) averaged over the sample window for all containers.|int|m|
|`mem_capacity`|The total memory capacity of the host machine.|int|B|
|`mem_limit`|The total memory limit across all containers in this Pod. Note: This value is the sum of all container limit values, as Pods do not have a direct limit value.|int|B|
|`mem_request`|The total memory request across all containers in this Pod. Note: This value is the sum of all container request values, as Pods do not have a direct request value.|int|B|
|`mem_rss`|The total RSS memory usage of all containers in this Pod, which is not supported by metrics-server.|int|B|
|`mem_usage`|The total memory usage of all containers in this Pod.|int|B|
|`mem_used_percent`|The percentage of memory usage based on the host machine’s total memory capacity.|float|percent|
|`mem_used_percent_base_limit`|The percentage of memory usage based on the memory limit.|float|percent|
|`mem_used_percent_base_request`|The percentage of memory usage based on the memory request.|float|percent|
|`memory_capacity`|The total memory in the host machine (Deprecated use `mem_capacity`).|int|B|
|`memory_usage_bytes`|The sum of the memory usage of all containers in this Pod (Deprecated use `mem_usage`).|int|B|
|`memory_used_percent`|The percentage usage of the memory (refer from `mem_used_percent`).|float|percent|
|`message`|Object details|string|-|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










### `kubernetes_replica_sets`

Objects of the Kubernetes ReplicaSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`name`|The UID of ReplicaSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replicaset_name`|Name must be unique within a namespace.|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`uid`|The UID of ReplicaSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|The number of available replicas (ready for at least minReadySeconds) for this replica set. (Deprecated)|int|-|
|`message`|Object details|string|-|
|`ready`|The number of ready replicas for this replica set. (Deprecated)|int|-|
|`replicas`|The most recently observed number of replicas.|int|count|
|`replicas_available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|count|
|`replicas_desired`|The number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count|










### `kubernetes_services`

Objects of the Kubernetes Service.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector>`|Represents the selector for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of Service|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service_name`|Name must be unique within a namespace.|
|`type`|Type determines how the Service is exposed. Defaults to ClusterIP. (ClusterIP/NodePort/LoadBalancer/ExternalName)|
|`uid`|The UID of Service|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`cluster_ip`|ClusterIP is the IP address of the service and is usually assigned randomly by the master.|string|-|
|`external_ips`|ExternalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.|string|-|
|`external_name`|ExternalName is the external reference that kubedns or equivalent will return as a CNAME record for this service.|string|-|
|`external_traffic_policy`|ExternalTrafficPolicy denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints.|string|-|
|`message`|Object details|string|-|
|`session_affinity`|Supports "ClientIP" and "None".|string|-|










### `kubernetes_statefulsets`

Objects of the Kubernetes StatefulSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`<all_selector_matchlabels>`|Represents the selector.matchLabels for Kubernetes resources|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of StatefulSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`statefulset_name`|Name must be unique within a namespace.|
|`uid`|The UID of StatefulSet.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`message`|Object details|string|-|
|`replicas`|The number of Pods created by the StatefulSet controller.|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this StatefulSet.|int|count|
|`replicas_current`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.|int|count|
|`replicas_desired`|The desired number of replicas of the given Template.|int|count|
|`replicas_ready`|The number of pods created for this StatefulSet with a Ready Condition.|int|count|
|`replicas_updated`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.|int|count|




## Logs {#logging}













### `Use Logging Source`

Logs of the container.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_ip`|The pod ip of the container.|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`service`|The name of the service, if `service` is empty then use `source`.|

- Fields List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_read_lines`|The lines of the read file ([:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)).|int|count|
|`message`|The text of the logging.|string|-|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|














































### `kubernetes_events`

Logs of the Kubernetes Event.

- Tags


| Tag | Description |
|  ----  | --------|
|`reason`|This should be a short, machine understandable string that gives the reason, for the transition into the object's current status.|
|`type`|Type of this event.|
|`uid`|The UID of event.|

- Fields List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`involved_kind`|Kind of the referent for involved object.|string|-|
|`involved_name`|Name must be unique within a namespace for involved object.|string|-|
|`involved_namespace`|Namespace defines the space within which each name must be unique for involved object.|string|-|
|`involved_uid`|The UID of involved object.|string|-|
|`message`|Details of event log|string|-|



























































<!-- markdownlint-enable -->

## Link Dataway Sink Functionality {#link-dataway-sink}

Dataway Sink [see documentation](../deployment/dataway-sink.md).

All Kubernetes resource collection will add a Label matching the CustomerKey. For example, if the CustomerKey is `name`, DaemonSet, Deployment, Pod, etc., resources will find `name` in their current Labels and add it to tags.

Containers will add their associated Pod's Customer Labels.


## FAQ {#faq}

### Filter Metric Collection Based on Pod Namespace {#config-metric-on-pod-namespace}

After enabling Kubernetes Pod metrics collection (`enable_pod_metric = true`), DataKit will collect metric data from all Pods in the cluster. Since this might generate a large amount of data, you can filter metric collection based on the `namespace` field of the Pod, thus collecting metrics only from Pods in specific namespaces.

By configuring `pod_include_metric` and `pod_exclude_metric`, you can control which namespaces' Pods are included or excluded from metric collection.

<!-- markdownlint-disable md046 -->
=== "Host Installation"

    ``` toml
      ## When the Pod's namespace matches `datakit`, collect metrics for that Pod.
      pod_include_metric = ["namespace:datakit"]
    
      ## Ignore all Pods with namespace `kodo`.
      pod_exclude_metric = ["namespace:kodo"]
    ```
    
    - The `include` and `exclude` configuration items must start with the field name, formatted like a```toml
    - `include` and `exclude` configuration items must start with the field name, formatted like a [glob pattern](https://en.wikipedia.org/wiki/glob_(programming)): `"<field_name>:<glob_pattern>"`.
    - Currently, only the `namespace` field is supported for filtering. For example: `namespace:datakit-ns`.

    If both `include` and `exclude` configurations are set, Pods must meet the following conditions:

    - Must satisfy the `include` rules.
    - And not satisfy the `exclude` rules.

    For example, the following configuration will exclude all Pods:

    ```toml
      ## Only collect metrics from Pods in the `namespace:datakit`, but exclude all namespaces.
      pod_include_metric = ["namespace:datakit"]
      pod_exclude_metric = ["namespace:*"]
    ```

=== "Kubernetes"

    For Kubernetes environments, you can configure using the following environment variables:

    - `ENV_INPUT_CONTAINER_POD_INCLUDE_METRIC`
    - `ENV_INPUT_CONTAINER_POD_EXCLUDE_METRIC`

    For instance, if you want to collect metrics only from Pods in the `kube-system` namespace, set the `ENV_INPUT_CONTAINER_POD_INCLUDE_METRIC` environment variable as follows:

    ```yaml
      - env:
          - name: ENV_INPUT_CONTAINER_POD_INCLUDE_METRIC
            value: namespace:kube-system  # Specify the namespace to collect metrics from
    ```

    This method allows flexible control over the scope of Pod metrics collected by DataKit, avoiding unnecessary data collection to optimize system performance and resource utilization.

### :material-chat-question: NODE_LOCAL Requires New Permissions {#rbac-nodes-stats}

The `ENV_INPUT_CONTAINER_ENABLE_K8S_NODE_LOCAL` mode is recommended for DaemonSet deployment. This mode requires access to kubelet, so it needs additional RBAC permissions for `nodes/stats`. For example:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups: [""]
  resources: ["nodes", "nodes/stats"]
  verbs: ["get", "list", "watch"]
```

Additionally, the DataKit Pod needs to enable the `hostNetwork: true` configuration item.

### :material-chat-question: Collecting PersistentVolumes and PersistentVolumeClaims Requires New Permissions {#rbac-pv-pvc}

DataKit supports collecting object data from Kubernetes PersistentVolume and PersistentVolumeClaim starting from version 1.25.0[:octicons-tag-24: Version-1.25.0](../datakit/changelog.md#cl-1.25.0). Collecting these resources requires new RBAC permissions, detailed as follows:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups: [""]
  resources: ["persistentvolumes", "persistentvolumeclaims"]
  verbs: ["get", "list", "watch"]
```

### :material-chat-question: Masking Sensitive Fields in Kubernetes YAML {#yaml-secret}

DataKit collects the YAML configuration of Kubernetes Pods or Services and stores it in the `yaml` field of the object data. If the YAML contains sensitive data (such as passwords), DataKit does not currently support manually configuring the masking of sensitive fields. It is recommended to use Kubernetes's official approach, such as ConfigMap or Secret, to hide sensitive fields.

For example, if you need to add a password to the environment variables, normally it would look like this:

```yaml
    containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_PASSWORD
          value: password123
```

Storing the password in plain text within the orchestration YAML configuration is insecure. You can achieve hiding the password using a Kubernetes Secret as follows:

Create a Secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: dXNlcm5hbWUxMjM=  # Base64 encoded 'username123'
  password: cGFzc3dvcmQxMjM=  # Base64 encoded 'password123'
```

Apply the Secret:

```shell
kubectl apply -f mysecret.yaml
```

Use the Secret in the environment variables:

```yaml
    containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysecret
              key: password
              optional: false
```

Refer to the [official documentation](https://kubernetes.io/zh-cn/docs/concepts/configuration/secret/#using-secrets-as-environment-variables){:target="_blank"} for more details.

## Further Reading {#more-reading}

- [eBPF Collector: Support for Traffic Collection in Container Environments](ebpf.md)
- [Correctly Using Regular Expressions for Configuration](../datakit/datakit-input-conf.md#debug-regex)
- [Several Ways to Configure DataKit in Kubernetes](../datakit/k8s-config-how-to.md)
