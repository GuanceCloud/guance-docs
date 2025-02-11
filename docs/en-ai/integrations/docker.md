---
title: 'Docker'
summary: 'Collect metrics, objects, and log data from Docker Containers'
__int_icon:    'icon/docker'  
tags:
  - 'Container'
dashboard:
  - desc: 'Docker monitoring view'
    path: 'dashboard/en/docker'
monitor:
  - desc: 'Docker'
    path: 'monitor/en/docker'
---

Collect metrics, objects, and log data from Docker Containers.

## Collector Configuration {#config}

### Prerequisites {#requirements}

- Currently, containers support Docker, Containerd, and CRI-O container runtimes.
    - Version requirements: Docker v17.04 and above, Containerd v1.5.1 and above, CRI-O 1.20.1 and above

<!-- markdownlint-disable MD046 -->
???+ info

    - Container collection supports Docker and Containerd runtimes [:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7), and both are enabled by default.

- DataKit

DataKit for Docker environments can only be installed on the host machine.

Navigate to the *conf.d/container* directory under the DataKit installation directory, copy *container.conf.sample* and rename it to *container.conf*. Example:

``` toml
[inputs.container]
    endpoints = [
    "unix:///var/run/docker.sock"
    ]
```

In most cases, you only need to adjust the `endpoints`.


### Log Collection {#logging-config}

Refer to [this link](container-log.md) for log collection configuration details.

---

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (tag value is the hostname where DataKit resides). You can also specify other tags via `[inputs.container.tags]` in the configuration:

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

`docker_containers`

Metrics of containers, supporting only Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name (default is `default`). It can be renamed in datakit.yaml using ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty, use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty, use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, e.g., `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, e.g., `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, e.g., `nginx`.|
|`image_tag`|The tag of the container image, e.g., `1.21.0`.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|Container status (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`task_arn`|The task ARN of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (only supported by Docker).|int|B|
|`block_write_byte`|Total number of bytes written to the container file system (only supported by Docker).|int|B|
|`cpu_numbers`|The number of CPU cores.|int|count|
|`cpu_usage`|The percentage usage of CPU on the system host.|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The memory limit in the container.|int|B|
|`mem_usage`|The memory usage.|int|B|
|`mem_used_percent`|The percentage usage of memory calculated based on the capacity of the host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of memory calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only counts the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only counts the usage of the main process in the container, excluding loopback).|int|B|


## Objects {#object}

`docker_containers`

Objects of containers, supporting only Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name (default is `default`). It can be renamed in datakit.yaml using ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty, use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty, use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, e.g., `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, e.g., `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, e.g., `nginx`.|
|`image_tag`|The tag of the container image, e.g., `1.21.0`.|
|`name`|The ID of the container.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|The state of the container (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`status`|The status of the container, e.g., `Up 5 hours`.|
|`task_arn`|The task ARN of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`block_read_byte`|Total number of bytes read from the container file system (only supported by Docker).|int|B|
|`block_write_byte`|Total number of bytes written to the container file system (only supported by Docker).|int|B|
|`cpu_numbers`|The number of CPU cores.|int|count|
|`cpu_usage`|The percentage usage of CPU on the system host.|float|percent|
|`cpu_usage_base100`|The normalized CPU usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The memory limit in the container.|int|B|
|`mem_usage`|The memory usage.|int|B|
|`mem_used_percent`|The percentage usage of memory calculated based on the capacity of the host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of memory calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only counts the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only counts the usage of the main process in the container, excluding loopback).|int|B|
</section>