---
title: 'Kubernetes'
summary: 'Collect metrics, objects, and logs from Containers and Kubernetes, and report them to Guance.'
__int_icon:    'icon/kubernetes/'  
tags:
  - 'KUBERNETES'
  - 'Container'
dashboard:
  - desc: 'Kubernetes Monitoring View'
    path: 'dashboard/en/kubernetes'
  - desc: 'Kubernetes Services Monitoring View'
    path: 'dashboard/en/kubernetes_services'
  - desc: 'Kubernetes Nodes Overview Monitoring View'
    path: 'dashboard/en/kubernetes_nodes_overview'
  - desc: 'Kubernetes Pods Overview Monitoring View'
    path: 'dashboard/en/kubernetes_pods_overview'
  - desc: 'Kubernetes Events Monitoring View'
    path: 'dashboard/en/kubernetes_events'
 
monitor:
  - desc: 'Kubernetes'
    path: 'monitor/en/kubernetes'
---



:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

Collect metrics, objects, and logs from Containers and Kubernetes, and report them to Guance.

## Collector Configuration {#config}

### Prerequisites {#requirements}

- Currently supports Docker, Containerd, and CRI-O container runtimes.
    - Version requirements: Docker v17.04 and above, Containerd v1.5.1 and above, CRI-O 1.20.1 and above.
- Collecting Kubernetes data requires DataKit to be deployed as a [DaemonSet](../datakit/datakit-daemonset-deploy.md).

<!-- markdownlint-disable MD046 -->
???+ info

    - Container collection supports Docker and Containerd runtimes [:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7), both enabled by default.

=== "Host Installation"

    If it is a pure Docker or Containerd environment, then DataKit can only be installed on the host machine.
    
    Enter the *conf.d/container* directory under the DataKit installation directory, copy *container.conf.sample* and rename it to *container.conf*. Example:
    
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

    You can inject collector configurations via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or set [ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable collectors.

    Environment variables can also modify configuration parameters (they need to be added as default collectors in ENV_DEFAULT_ENABLED_INPUTS):

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
    
        Whether to enable Node-based collection mode, where each Node’s DataKit collects resources independently. [:octicons-tag-24: Version-1.19.0](../datakit/changelog.md#cl-1.19.0) requires additional `RABC` permissions, see [here](#rbac-nodes-stats)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_node_local`
    
        **Default Value**: true
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS**
    
        Whether to append resource labels to collected tags. Only Pod metrics, objects, and Node objects add labels; container logs also add their Pod labels. If a label key has a dot character, it will be changed to a hyphen.
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `extract_k8s_label_as_tags`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2**
    
        Append resource labels to tags in data (excluding metric data). Specify label keys; if there's only one key and it's an empty string (e.g., [""]), all labels are added to tags. Containers inherit Pod labels. If a label key has a dot character, it will be changed to a hyphen.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `extract_k8s_label_as_tags_v2`
    
        **Example**: `["app","name"]`
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC**
    
        Append resource labels to metric data tags. Specify label keys; if there's only one key and it's an empty string (e.g., [""]), all labels are added to tags. Containers inherit Pod labels. If a label key has a dot character, it will be changed to a hyphen.
    
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
    
        Whether to enable automatic discovery of Prometheus Pod Monitor CRD and collect metrics, see [Prometheus-Operator CRD Documentation](kubernetes-prometheus-operator-crd.md#config)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_pod_monitors`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS**
    
        Whether to enable automatic discovery of Prometheus ServiceMonitor CRD and collect metrics, see [Prometheus-Operator CRD Documentation](kubernetes-prometheus-operator-crd.md#config)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_auto_discovery_of_prometheus_service_monitors`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_KEEP_EXIST_PROMETHEUS_METRIC_NAME**
    
        Deprecated. Whether to retain original Prometheus field names, see [Kubernetes Prometheus](kubernetes-prom.md#measurement-and-tags)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `keep_exist_prometheus_metric_name`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG**
    
        Container log whitelist, filtered by image
    
        **Field Type**: List
    
        **Collector Configuration Field**: `container_include_log`
    
        **Example**: `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`
    
    - **ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG**
    
        Container log blacklist, filtered by image
    
        **Field Type**: List
    
        **Collector Configuration Field**: `container_exclude_log`
    
        **Example**: `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`
    
    - **ENV_INPUT_CONTAINER_KUBERNETES_URL**
    
        k8s API service access address
    
        **Field Type**: String
    
        **Collector Configuration Field**: `kubernetes_url`
    
        **Example**: `https://kubernetes.default:443`
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN**
    
        Path to the token file required to access k8s services
    
        **Field Type**: String
    
        **Collector Configuration Field**: `bearer_token`
    
        **Example**: `/run/secrets/kubernetes.io/serviceaccount/token`
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN_STRING**
    
        Token string required to access k8s services
    
        **Field Type**: String
    
        **Collector Configuration Field**: `bearer_token_string`
    
        **Example**: `your-token-string`
    
    - **ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL**
    
        Interval for discovering logs, i.e., how often logs are searched. If the interval is too long, short-lived logs may be ignored.
    
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
    
        Whether to enable auto multiline mode for log collection, matches applicable multiline rules from patterns list
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `logging_auto_multiline_detection`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_EXTRA_PATTERNS_JSON**
    
        Patterns list for auto multiline mode in log collection, supports configuring multiple multiline rules
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `logging_auto_multiline_extra_patterns`
    
        **Example**: `["^\d{4}-\d{2}", "^[A-Za-z_]"]`
    
        **Default Value**: For more default rules, see [doc](logging.md#auto-multiline)
    
    - **ENV_INPUT_CONTAINER_LOGGING_MAX_MULTILINE_LIFE_DURATION**
    
        Maximum lifecycle duration for single multiline log entries. This ensures existing multiline data is cleared and uploaded to avoid buildup.
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `logging_max_multiline_life_duration`
    
        **Default Value**: 3s
    
    - **ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES**
    
        Remove color characters from logs, see [Special Characters Handling in Logs](logging.md#ansi-decode)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `logging_remove_ansi_escape_codes`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_FILE_FROM_BEGINNING_THRESHOLD_SIZE**
    
        Decide whether to start collecting logs from the beginning based on file size. If the file size is less than this value when discovered, it starts collecting from the beginning.
    
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
    
        Specify which fields to retain in the whitelist
    
        **Field Type**: List
    
        **Collector Configuration Field**: `logging_field_white_list`
    
        **Example**: `'["service","container_id"]'`
    
    - **ENV_INPUT_CONTAINER_CONTAINER_MAX_CONCURRENT**
    
        Maximum concurrency for collecting container data, recommended only when collection delay is significant
    
        **Field Type**: Int
    
        **Collector Configuration Field**: `container_max_concurrent`
    
        **Default Value**: cpu cores + 1
    
    - **ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB**
    
        Disable collection of Kubernetes Job resources (including metric data and object data)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `disable_collect_kube_job`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB**
    
        Disable collection of Kubernetes Job resources (including metric data and object data)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `disable_collect_kube_job`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM**
    
        Enable collection of Kubernetes Prometheus data, including APIServer, Scheduler, Etcd, etc. (Experimental)
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `enable_k8s_self_metric_by_prom`
    
        **Default Value**: false
    
    - **ENV_INPUT_CONTAINER_TAGS**
    
        Custom tags. If the configuration file has the same tag name, it will override it.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

    Additional notes on environment variables:
    
    - ENV_INPUT_CONTAINER_TAGS: If the configuration file (*container.conf*) has the same tag name, it will be overridden by this configuration.
    
    - ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP: Specifies the replacement source, parameter format is 「regex=new_source」. When a source matches the regex, it will be replaced by new_source. If the replacement is successful, it will not use the source configured in `annotations/labels` ([:octicons-tag-24: Version-1.4.7](../datakit/changelog.md#cl-1.4.7)). To achieve exact matching, use `^` and `$` around the content. For example, writing the regex as `datakit` can match `datakit` and `datakit123`, while writing it as `^datakit$` only matches `datakit`.
    
    - ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON: Used to specify the mapping from source to multiline configuration. If a log does not have `multiline_match` configured, it will look up and use the corresponding `multiline_match` based on its source. Since `multiline_match` values are complex regular expressions, the value format is a JSON string, which can be written and compressed into one line using [json.cn](https://www.json.cn/){:target="_blank"}.

???+ attention

    - Object data collection interval is 5 minutes, and metrics data collection interval is 60 seconds, and these intervals are not configurable.
    - Collected logs, including those processed by `multiline_match`, have a maximum length of 32MB per line, exceeding parts will be truncated and discarded.

### Docker and Containerd sock File Configuration {#sock-config}

If the Docker or Containerd sock paths are not the default, you need to specify the sock file path. Depending on the deployment method of DataKit, the approach varies. Taking Containerd as an example:

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

The environment variable `ENV_INPUT_CONTAINER_ENDPOINTS` appends to the existing endpoints configuration. The final actual endpoints configuration may have multiple items, and the collector will deduplicate and connect to each one for collection.

The default endpoints configuration is:

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
  ] 
```

Using the environment variable `ENV_INPUT_CONTAINER_ENDPOINTS` with `["unix:///path/to/new//run/containerd.sock"]`, the final endpoints configuration becomes:

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
    "unix:///path/to/new//run/containerd.sock",
  ] 
```

The collector will connect and collect from these container runtimes. If the sock file does not exist, it will output an error log on the first connection failure without affecting subsequent collections.

### Prometheus Exporter Metrics Collection {#k8s-prom-exporter}

<!-- markdownlint-disable MD024 -->
If Pods/containers expose Prometheus metrics, there are two ways to collect them, see [here](kubernetes-prom.md)


### Log Collection {#logging-config}

Log collection-related configurations are detailed [here](container-log.md).

---

## Metrics {#metric}

All collected data will default to appending a global tag named `host` (the tag value is the hostname where DataKit resides). Other tags can be specified in the configuration through `[inputs.container.tags]`:

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

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (only supported docker).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (only supported docker).|int|B|
|`cpu_numbers`|The number of the CPU core.|int|count|
|`cpu_usage`|The percentage usage of CPU on system host.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The limit memory in the container.|int|B|
|`mem_usage`|The usage of the memory.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes send to the network (only count the usage of the main process in the container, excluding loopback).|int|B|














### `kubernetes`

Count of Kubernetes resources.

- Tags


| Tag | Description |
|  ----  | --------|
|`namespace`|namespace|
|`node_name`|NodeName is a request to schedule this pod onto a specific node (only supported Pod and Container).|

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


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

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_limit_millicores`|Max limits for CPU resources.|int|ms|
|`cpu_usage`|The sum of the cpu usage of all containers in this Pod.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%. (Experimental)|float|percent|
|`cpu_usage_millicores`|Total CPU usage (sum of all cores) averaged over the sample window.|int|ms|
|`ephemeral_storage_available_bytes`|The storage space available (bytes) for the filesystem.|int|B|
|`ephemeral_storage_capacity_bytes`|The total capacity (bytes) of the filesystems underlying storage.|int|B|
|`ephemeral_storage_used_bytes`|The bytes used for a specific task on the filesystem.|int|B|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The sum of the memory limit of all containers in this Pod.|int|B|
|`mem_usage`|The sum of the memory usage of all containers in this Pod.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`memory_capacity`|The total memory in the host machine (Deprecated use `mem_capacity`).|int|B|
|`memory_usage_bytes`|The sum of the memory usage of all containers in this Pod (Deprecated use `mem_usage`).|int|B|
|`memory_used_percent`|The percentage usage of the memory (refer from `mem_used_percent`|float|percent|
|`network_bytes_rcvd`|Cumulative count of bytes received.|int|B|
|`network_bytes_sent`|Cumulative count of bytes transmitted.|int|B|
|