
# Container Data Collection
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

Collect indicators, objects and log data of container and Kubernetes and report them to Guance Cloud.

## Preconditions {#requrements}

- At present, container will connect to Docker service by default, and Docker v17.04 and above should be installed.
- Collecting Kubernetes data requires the DataKit to [be deployed as a DaemonSet](datakit-daemonset-deploy.md).
- Collecting Kubernetes Pod metric data [requires Kubernetes to install the Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation){:target="_blank"}.

???+ info

    - Container collection supports both Docker and Containerd runtimes[:octicons-tag-24: Version-1.5.7](changelog.md#cl-1.5.7), and both are enabled by default.

## Configuration {#config}

=== "host installation"

    In the case of a pure Docker or Containerd environment, the DataKit can only be installed on the host machine.
    
    Go to the *conf.d/container* directory under the DataKit installation directory, copy *container.conf.sample* and name it *container.conf*. Examples are as follows:
    
    ``` toml
        
    [inputs.container]
      docker_endpoint = "unix:///var/run/docker.sock"
      containerd_address = "/var/run/containerd/containerd.sock"
    
      enable_container_metric = true
      enable_k8s_metric = true
      enable_pod_metric = false
      extract_k8s_label_as_tags = false
    
      ## Auto-Discovery of PrometheusMonitoring Annotations/CRDs
      enable_auto_discovery_of_prometheus_pod_annotations = false
      enable_auto_discovery_of_prometheus_service_annotations = false
      enable_auto_discovery_of_prometheus_pod_monitors = false
      enable_auto_discovery_of_prometheus_service_monitors = false
    
    
      ## Containers logs to include and exclude, default collect all containers. Globs accepted.
      container_include_log = []
      container_exclude_log = ["image:*logfwd*", "image:*datakit*"]
    
      exclude_pause_container = true
    
      ## Removes ANSI escape codes from text strings
      logging_remove_ansi_escape_codes = false
      ## Search logging interval, default "60s"
      #logging_search_interval = ""
    
      ## If the data sent failure, will retry forevery
      logging_blocking_mode = true
    
      kubernetes_url = "https://kubernetes.default:443"
    
      ## Authorization level:
      ##   bearer_token -> bearer_token_string -> TLS
      ## Use bearer token for authorization. ('bearer_token' takes priority)
      ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
      ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
      bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      # bearer_token_string = "<your-token-string>"
    
      logging_auto_multiline_detection = true
      logging_auto_multiline_extra_patterns = []
    
      ## Set true to enable election for k8s metric collection
      election = true
    
      [inputs.container.logging_extra_source_map]
        # source_regexp = "new_source"
    
      [inputs.container.logging_source_multiline_map]
        # source = '''^\d{4}'''
    
      [inputs.container.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```



=== "Kubernetes"

    Container collectors in Kubernetes generally turn on automatically by default and do not need to be configured through *container.conf*. However, the configuration parameters can be adjusted by the following environment variables:
    
    | Environment Variable Name                                                     | Descrition                                                                                                                                                                          | Default Value                                                | Parameter example (need to be enclosed in double quotation marks when configuring yaml)               |
    | ----:                                                                         | ----:                                                                                                                                                                               | ----:                                                        | ----                                                                                                  |
    | `ENV_INPUT_CONTAINER_DOCKER_ENDPOINT`                                         | Specify the enpoint of Docker Engine                                                                                                                                                | "unix:///var/run/docker.sock"                                | `"unix:///var/run/docker.sock"`                                                                       |
    | `ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS`                                      | Specify the enpoint of Containerd                                                                                                                                                   | "/var/run/containerd/containerd.sock"                        | `"/var/run/containerd/containerd.sock"`                                                               |
    | `ENV_INPUT_CONTIANER_EXCLUDE_PAUSE_CONTAINER`                                 | Wether to ignore pause container for k8s                                                                                                                                            | true                                                         | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_CONTAINER_METRIC`                                 | Start container index collection                                                                                                                                                    | true                                                         | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_K8S_METRIC`                                       | Start k8s index collection                                                                                                                                                          | true                                                         | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS`                               | Whether to append pod label to the collected indicator tag                                                                                                                          | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_ANNOTATIONS`     | Whether to turn on Prometheuse Pod Annotations and collect metrics automatically                                                                                                    | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_ANNOTATIONS` | Whether to turn on Prometheuse Service Annotations and collect metrics automatically                                                                                                | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_MONITORS`        | Whether to turn on automatic discovery of Prometheuse PodMonitor CRD and collection of metrics, see [Prometheus-Operator CRD doc](kubernetes-prometheus-operator-crd.md#config)     | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS`    | Whether to turn on automatic discovery of Prometheuse ServiceMonitor CRD and collection of metrics, see [Prometheus-Operator CRD doc](kubernetes-prometheus-operator-crd.md#config) | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_ENABLE_POD_METRIC`                                       | Turn on Pod index collection                                                                                                                                                        | true                                                         | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG`                                   | include condition of container log, filtering with image                                                                                                                            | None                                                         | `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`                                                       |
    | `ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG`                                   | exclude condition of container log, filtering with image                                                                                                                            | None                                                         | `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`                                                       |
    | `ENV_INPUT_CONTAINER_KUBERNETES_URL`                                          | k8s api-server access address                                                                                                                                                       | "https://kubernetes.default:443"                             | `"https://kubernetes.default:443"`                                                                    |
    | `ENV_INPUT_CONTAINER_BEARER_TOKEN`                                            | The path to the token file required to access k8s api-server                                                                                                                        | "/run/secrets/kubernetes.io/serviceaccount/token"            | `"/run/secrets/kubernetes.io/serviceaccount/token"`                                                   |
    | `ENV_INPUT_CONTAINER_BEARER_TOKEN_STRING`                                     | Token string required to access k8s api-server                                                                                                                                      | None                                                         | `"<your-token-string>"`                                                                               |
    | `ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL`                                 | The time interval of log discovery, that is, how often logs are retrieved. If the interval is too long, some logs with short survival will be ignored                               | "60s"                                                        | `"30s"`                                                                                               |
    | `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES`                        | Log collection deletes included color characters.                                                                                                                                   | false                                                        | `"true"`/`"false"`                                                                                    |
    | `ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP`                                | Log collection configures additional source matching, and the regular source will be renamed.                                                                                       | None                                                         | `"source_regex*=new_source,regex*=new_source2"`  multiple "key=value" separated by English commas     |
    | `ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON`                       | For multi-row configuration of source, log collection can automatically select multiple rows using source.                                                                          | None                                                         | `'{"source_nginx":"^\\d{4}", "source_redis":"^[A-Za-z_]"}'` JSON 格式的 map                           |
    | `ENV_INPUT_CONTAINER_LOGGING_BLOCKING_MODE`                                   | Whether log collection is in blocking mode, if data transmission fails, it will continue to try, and it will not be collected again until the transmission is successful.           | true                                                         | `"true"/"false"`                                                                                      |
    | `ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_DETECTION`                        | Whether the automatic multi-line mode is turned on for log collection; the applicable multi-line rules will be matched in the patterns list after it is turned on.                  | true                                                         | `"true"/"false"`                                                                                      |
    | `ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_EXTRA_PATTERNS_JSON`              | Automatic multi-line pattern pattens list for log collection, supporting manual configuration of multiple multi-line rules.                                                         | For more default rules, see [doc](logging.md#auto-multiline) | `'["^\\d{4}-\\d{2}", "^[A-Za-z_]"]'`an array of strings in JSON format                                |
    | `ENV_INPUT_CONTAINER_LOGGING_MIN_FLUSH_INTERVAL`                              | Minimum upload interval for log collection. If there is no new data during this period, the cached data will be emptied and uploaded to avoid accumulation.                         | "5s"                                                         | `"10s"`                                                                                               |
    | `ENV_INPUT_CONTAINER_LOGGING_MAX_MULTILINE_LIFE_DURATION`                     | Maximum single multi-row life cycle of log collection. At the end of this cycle, existing multi-row data will be emptied and uploaded to avoid accumulation.                        | "3s"                                                         | `"5s"`                                                                                                |
    | `ENV_INPUT_CONTAINER_TAGS`                                                    | add extra tags                                                                                                                                                                      | None                                                         | `"tag1=value1,tag2=value2"`       multiple "key=value" separated by English commas                    |
    | `ENV_INPUT_CONTAINER_PROMETHEUS_MONITORING_MATCHES_CONFIG`                    | Add additional config for Prometheus-Operator CRD                                                                                                                                   | None                                                         | For more JSON format，see [Prometheus-Operator CRD doc](kubernetes-prometheus-operator-crd.md#config) |
    
    Additional description of environment variables:
    
    - ENV_INPUT_CONTAINER_TAGS: If there is a tag with the same name in the configuration file (*container.conf*), it will be overwritten by the configuration here.
    
    - ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP: Specifying the replacement source with the argument format `regular expression=new_source`, which is replaced by new_source when a source matches the regular expression. If the replacement is successful, the source（[:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)）configured in `annotations/labels` is no longer used. If you want to make an exact match, you need to use `^` and `$` to enclose the content. For example, if a regular expression is written as `datakit`, it can not only match the word `datakit` , but also match `datakit123`; Written as `^datakit$` , you can only match `datakit`.
    
    - ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON: Used to specify the mapping of source to multi-row configuration. If a log is not configured with `multiline_match`, the corresponding `multiline_match` is found and used here based on its source. Because the `multiline_match` value is a regular expression, it is more complex, so the value format is a JSON string that can be coded and compressed into a single line using [json.cn](https://www.json.cn/){:target="_blank"}.


???+ attention

    - Object data collection interval is 5 minutes and metric data collection interval is 20 seconds. Configuration is not supported for the time being.
    - Acquired log has a maximum length of 32MB per line (including after `multiline_match` processing), the excess will be truncated and discarded.

#### Docker and Containerd Sock File Configuration {#docker-containerd-sock}

If the sock path of Docker or Containerd is not the default, you need to specify the sock file path. According to different deployment methods of DataKit, the methods are different. Take Containerd as an example:

=== "Host deployment"

    Modify the `containerd_address` configuration entry of container.conf to set it to the corresponding sock path.

=== "Kubernetes"

    Change the volumes `containerd-socket` of DataKit.yaml, mount the new path into the DataKit, and configure the environment variables`ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS`：
    
    ``` yaml hl_lines="3 4 7 14"
    # add envs
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS
        value: /path/to/new/containerd/containerd.sock
    
    # modify mountPath
      - mountPath: /path/to/new/containerd/containerd.sock
        name: containerd-socket
        readOnly: true
    
    # modify volumes
    volumes:
    - hostPath:
        path: /path/to/new/containerd/containerd.sock
      name: containerd-socket
    ```
---

## Log Collection {#logging-config}

See [here](container-log.md) for the relevant configuration of log collection.

### Prometheuse Exporter Metrics Collection {#k8s-prom-exporter}

If the Pod/container has exposed Prometheuse metrics, there are two ways to collect them, see [here](kubernetes-prom.md).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.container.tags]`:

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Metrics {#metrics}













#### `docker_containers`

The metric of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown' ([:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)).|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/containerd).|
|`deployment`|The deployment name of the container's pod (unsupported containerd).|
|`docker_image`|The full name of the container image, example `nginx.org/nginx:1.21.0` (Deprecated: use image).|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`linux_namespace`|The [Linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html){:target="_blank"} where this container is located.|
|`namespace`|The pod namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`state`|Container status (only Running, unsupported containerd).|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (unsupported containerd).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (unsupported containerd).|int|B|
|`cpu_delta`|The delta of the CPU (unsupported containerd).|int|ns|
|`cpu_numbers`|The number of the CPU core (unsupported containerd).|int|count|
|`cpu_system_delta`|The delta of the system CPU, only supported Linux (unsupported containerd).|int|ns|
|`cpu_usage`|The percentage usage of CPU on system host.|float|percent|
|`mem_failed_count`|The count of memory allocation failures (unsupported containerd).|int|B|
|`mem_limit`|The available usage of the memory, if there is container limit, use host memory.|int|B|
|`mem_usage`|The usage of the memory.|int|B|
|`mem_used_percent`|The percentage usage of the memory.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (unsupported containerd).|int|B|
|`network_bytes_sent`|Total number of bytes send to the network (unsupported containerd).|int|B| 









#### `kubernetes`

The count of the Kubernetes resource.

- Tags


| Tag | Description |
|  ----  | --------|
|`namespace`|namespace|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cronjob`|Cronjob count|int|-|
|`deployment`|Deployment count|int|-|
|`job`|Job count|int|-|
|`node`|Node count|int|-|
|`pod`|Pod count|int|-|
|`replica_set`|Replica_set count|int|-|
|`service`|Service count|int|-| 





#### `kube_cronjob`

The metric of the Kubernetes CronJob.

- Tags


| Tag | Description |
|  ----  | --------|
|`cronjob`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Number of cronjobs|int|count|
|`duration_since_last_schedule`|The duration since the last time the cronjob was scheduled.|int|s|
|`spec_suspend`|This flag tells the controller to suspend subsequent executions.|bool|-| 









#### `kube_daemonset`

The metric of the Kubernetes DaemonSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`daemonset`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Number of daemonsets|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count| 













#### `kube_deployment`

The metric of the Kubernetes Deployment.

- Tags


| Tag | Description |
|  ----  | --------|
|`deployment`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`condition`|The current status conditions of a deployment|int|count|
|`count`|Number of deployments|int|count|
|`paused`|Indicates that the deployment is paused (true or false).|bool|-|
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count| 





#### `kube_endpoint`

The metric of the Kubernetes Endpoints.

- Tags


| Tag | Description |
|  ----  | --------|
|`endpoint`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`address_available`|Number of addresses available in endpoint.|int|count|
|`address_not_ready`|Number of addresses not ready in endpoint.|int|count|
|`count`|Number of endpoints|int|count| 









#### `kube_job`

The metric of the Kubernetes Job.

- Tags


| Tag | Description |
|  ----  | --------|
|`job`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`completion_failed`|The job has failed its execution.|int|count|
|`completion_succeeded`|The job has completed its execution.|int|count|
|`count`|Number of jobs|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count| 









#### `kube_node`

The metric of the Kubernetes Node.

- Tags


| Tag | Description |
|  ----  | --------|
|`node`|Name must be unique within a namespace. (Deprecated)|
|`node_name`|Name must be unique within a namespace.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Number of nodes|int|count|
|`cpu_allocatable`|The allocatable CPU of a node that is available for scheduling.|int|-|
|`cpu_capacity`|The CPU capacity of a node.|int|-|
|`ephemeral_storage_allocatable`|The allocatable ephemeral-storage of a node that is available for scheduling.|int|-|
|`memory_allocatable`|The allocatable memory of a node that is available for scheduling.|int|-|
|`memory_capacity`|The memory capacity of a node.|int|-|
|`pods_allocatable`|The allocatable pods of a node that is available for scheduling.|int|-|
|`pods_capacity`|The pods capacity of a node.|int|-| 









#### `kube_pod`

The metric of the Kubernetes Pod.

- Tags


| Tag | Description |
|  ----  | --------|
|`[POD_LABEL]`|The pod labels will be extracted as tags if `extract_k8s_label_as_tags` is enabled.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`pod`|Name must be unique within a namespace.|
|`pod_name`|Name must be unique within a namespace. (Deprecated)|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Number of pods|int|count|
|`cpu_usage`|The percentage of cpu used|float|percent|
|`memory_capacity`|The memory capacity.|int|B|
|`memory_usage_bytes`|The number of memory used in bytes|int|B|
|`memory_used_percent`|The percentage usage of the memory.|float|percent|
|`ready`|Describes whether the pod is ready to serve requests.|int|count| 









#### `kube_replicaset`

The metric of the Kubernetes ReplicaSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`deployment`|The name of the deployment which the object belongs to.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set`|Name must be unique within a namespace.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`count`|Number of replicasets|int|count|
|`fully_labeled_replicas`|The number of fully labeled replicas per ReplicaSet.|int|count|
|`replicas`|Replicas is the most recently observed number of replicas.|int|count|
|`replicas_desired`|Replicas is the number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count| 











### Objects {#objects}

















#### `docker_containers`

The object of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`container_host`|The name of the container host (unsupported containerd).|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown' ([:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)).|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/containerd).|
|`deployment`|The deployment name of the container's pod (unsupported containerd).|
|`docker_image`|The full name of the container image, example `nginx.org/nginx:1.21.0` (Deprecated: use image).|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`linux_namespace`|The [Linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html){:target="_blank"} where this container is located.|
|`name`|The ID of the container.|
|`namespace`|The pod namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`state`|The state of the Container (only Running, unsupported containerd).|
|`status`|The status of the container，example `Up 5 hours` (unsupported containerd).|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`block_read_byte`|Total number of bytes read from the container file system (unsupported containerd).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (unsupported containerd).|int|B|
|`cpu_delta`|The delta of the CPU (unsupported containerd).|int|ns|
|`cpu_numbers`|The number of the CPU core (unsupported containerd).|int|count|
|`cpu_system_delta`|The delta of the system CPU, only supported Linux (unsupported containerd).|int|ns|
|`cpu_usage`|The percentage usage of CPU on system host.|float|percent|
|`from_kubernetes`|Is the container created by k8s (deprecated).|bool|-|
|`mem_failed_count`|The count of memory allocation failures (unsupported containerd).|int|B|
|`mem_limit`|The available usage of the memory, if there is container limit, use host memory.|int|B|
|`mem_usage`|The usage of the memory.|int|B|
|`mem_used_percent`|The percentage usage of the memory.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (unsupported containerd).|int|B|
|`network_bytes_sent`|Total number of bytes send to the network (unsupported containerd).|int|B|
|`process`|List processes running inside a container (like `ps -ef`, unsupported containerd).|string|-|














#### `kubernetes_cron_jobs`

The object of the Kubernetes CronJob.

- Tags


| Tag | Description |
|  ----  | --------|
|`cron_job_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_jobs`|The number of pointers to currently running jobs.|int|count|
|`age`|Age (seconds)|int|s|
|`message`|Object details|string|-|
|`schedule`|The schedule in Cron format, see [docs](https://en.wikipedia.org/wiki/Cron){:target="_blank"}|string|-|
|`suspend`|This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.|bool|-|










#### `kubernetes_daemonset`

The object of the Kubernetes DaemonSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`daemonset_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`count`|Number of daemonsets|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`message`|Object details|string|-|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|






#### `kubernetes_deployments`

The object of the Kubernetes Deployment.

- Tags


| Tag | Description |
|  ----  | --------|
|`deployment_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|-|
|`max_surge`|The maximum number of pods that can be scheduled above the desired number of pods|int|count|
|`max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|
|`message`|Object details|string|-|
|`ready`|Total number of ready pods targeted by this deployment.|string|-|
|`strategy`|Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.|string|-|
|`unavailable`|Total number of unavailable pods targeted by this deployment.|int|-|
|`up_dated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|-|






















#### `kubernetes_jobs`

The object of the Kubernetes Job.

- Tags


| Tag | Description |
|  ----  | --------|
|`job_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- Metrics


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










#### `kubernetes_nodes`

The object of the Kubernetes Node.

- Tags


| Tag | Description |
|  ----  | --------|
|`internal_ip`|Node internal IP|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_ip`|Node IP (Deprecated)|
|`node_name`|Name must be unique within a namespace.|
|`role`|Node role. (master/node)|
|`status`|NodePhase is the recently observed lifecycle phase of the node. (Pending/Running/Terminated)|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`kubelet_version`|Kubelet Version reported by the node.|string|-|
|`message`|Object details|string|-|










#### `kubelet_pod`

The object of the Kubernetes Pod.

- Tags


| Tag | Description |
|  ----  | --------|
|`deployment`|The name of the deployment which the object belongs to. (Probably empty)|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`phase`|The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle.(Pending/Running/Succeeded/Failed/Unknown)|
|`pod_name`|Name must be unique within a namespace.|
|`qos_class`|The Quality of Service (QOS) classification assigned to the pod based on resource requirements|
|`replica_set`|The name of the replicaSet which the object belongs to. (Probably empty)|
|`state`|Reason the container is not yet running. (Deprecated: use status)|
|`status`|Reason the container is not yet running.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Number of containers|int|count|
|`cpu_usage`|The percentage of cpu used|float|percent|
|`create_time`|CreationTimestamp is a timestamp representing the server time when this object was created.(milliseconds)|int|msec|
|`memory_capacity`|The memory capacity.|int|B|
|`memory_usage_bytes`|The number of memory used in bytes|int|B|
|`memory_used_percent`|The percentage usage of the memory.|float|percent|
|`message`|Object details|string|-|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|
|`restart`|The number of times the container has been restarted. (Deprecated: use restarts)|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










#### `kubernetes_replica_sets`

The object of the Kubernetes ReplicaSet.

- Tags


| Tag | Description |
|  ----  | --------|
|`deployment`|The name of the deployment which the object belongs to.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set_name`|Name must be unique within a namespace.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|-|
|`message`|Object details|string|-|
|`ready`|The number of ready replicas for this replica set.|int|-|






#### `kubernetes_services`

The object of the Kubernetes Service.

- Tags


| Tag | Description |
|  ----  | --------|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service_name`|Name must be unique within a namespace.|
|`type`|type determines how the Service is exposed. Defaults to ClusterIP. (ClusterIP/NodePort/LoadBalancer/ExternalName)|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`cluster_ip`|clusterIP is the IP address of the service and is usually assigned randomly by the master.|string|-|
|`external_ips`|externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.|string|-|
|`external_name`|externalName is the external reference that Kube-DNS or equivalent will return as a CNAME record for this service.|string|-|
|`external_traffic_policy`|externalTrafficPolicy denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints.|string|-|
|`message`|Object details|string|-|
|`session_affinity`|Supports "ClientIP" and "None".|string|-|




### Logs {#logging}





#### `Use Logging Source`

The logging of the container.

- Tags


| Tag | Description |
|  ----  | --------|
|`[POD_LABEL]`|The pod labels will be extracted as tags if `extract_k8s_label_as_tags` is enabled.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown' ([:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)).|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/containerd).|
|`deployment`|The deployment name of the container's pod (unsupported containerd).|
|`namespace`|The pod namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`service`|The name of the service, if `service` is empty then use `source`.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_read_lines`|The lines of the read file ([:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)).|int|count|
|`log_read_offset`|The offset of the read file ([:octicons-tag-24: Version-1.4.8](changelog.md#cl-1.4.8) · [:octicons-beaker-24: Experimental](index.md#experimental)).|int|-|
|`log_read_time`|The timestamp of the read file.|s|-|
|`message`|The text of the logging.|string|-|
|`message_length`|The length of the message content.|B|count|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-| 

















































#### `kubernetes_events`

The logging of the Kubernetes Event.

- Tags


| Tag | Description |
|  ----  | --------|
|`kind`|Kind of the referent.|
|`name`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within which each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`reason`|This should be a short, machine understandable string that gives the reason, for the transition into the object's current status.|
|`status`|log status|
|`type`|Type of this event (Normal, Warning), new types could be added in the future.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|event log details|string|-| 







































## FAQ {#faq}

### Kubernetes YAML Sensitive Field Mask {#yaml-secret}

Datakit collects yaml configurations for resources such as Kubernetes Pod or Service and stores them in the `yaml` field of the object data. If the yaml contains sensitive data (such as passwords), Datakit does not support manually configuring and shielding sensitive fields for the time being. It is recommended to use Kubernetes' official practice, that is, to use ConfigMap or Secret to hide sensitive fields.

For example, you now need to add a password to the env, which would normally be like this:

```yaml
    containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_PASSWORD
	  value: password123
```

When orchestrating yaml configuration, passwords will be stored in clear text, which is very unsafe. You can use Kubernetes Secret to implement hiding as follows:

Create a Secret：

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: username123
  password: password123
```

Execute:

```shell
kubectl apply -f mysecret.yaml
```

Using Secret in env:

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

See [doc](https://kubernetes.io/zh-cn/docs/concepts/configuration/secret/#using-secrets-as-environment-variables){:target="_blank"}.

## More Readings {#more-reading}

- [eBPF Collector: Support flow collection in container environment](ebpf.md)
- [Proper use of regular expressions to configure](datakit-input-conf.md#debug-regex) 
- [Several configurations of DataKit under Kubernetes](k8s-config-how-to.md)