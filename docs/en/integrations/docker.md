---
title: 'Docker'
summary: 'Collect metrics, objects, and log data from Docker Container'
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

Collect metrics, objects, and log data from Docker Container.

## Collector Configuration {#config}

### Prerequisites {#requirements}

- Currently, container supports Docker, Containerd, and CRI-O container runtimes.
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

In most cases, you only need to adjust `endpoints`.


### Log Collection Configuration {#logging-config}

For detailed configuration related to log collection, see [here](container-log.md).

---

## Metrics {#metric}

All collected data will append a global tag named `host` (tag value is the hostname of the DataKit host) by default, or you can specify other tags through `[inputs.container.tags]` in the configuration:

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

`docker_containers`

The metric of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|Kubernetes cluster name (default is `default`). It can be renamed in datakit.yaml using ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from Kubernetes (label `io.kubernetes.container.name`). If empty, use `$container_runtime_name`.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty, use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|Type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|Name of the DaemonSet which the object belongs to.|
|`deployment`|Name of the Deployment which the object belongs to.|
|`image`|Full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|Name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|Short name of the container image, example `nginx`.|
|`image_tag`|Tag of the container image, example `1.21.0`.|
|`namespace`|Namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|Pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|Pod UID of the container (label `io.kubernetes.pod.uid`).|
|`state`|Container status (only Running).|
|`statefulset`|Name of the StatefulSet which the object belongs to.|
|`task_arn`|Task ARN of the AWS Fargate.|
|`task_family`|Task family of the AWS Fargate.|
|`task_version`|Task version of the AWS Fargate.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (only supported by Docker).|int|B|
|`block_write_byte`|Total number of bytes written to the container file system (only supported by Docker).|int|B|
|`cpu_numbers`|Number of CPU cores.|int|count|
|`cpu_usage`|Percentage usage of CPU on the system host.|float|percent|
|`cpu_usage_base100`|Normalized CPU usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|Total memory in the host machine.|int|B|
|`mem_limit`|Memory limit in the container.|int|B|
|`mem_usage`|Memory usage.|int|B|
|`mem_used_percent`|Percentage usage of memory calculated based on the capacity of the host machine.|float|percent|
|`mem_used_percent_base_limit`|Percentage usage of memory calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only count the usage of the main process in the container, excluding loopback).|int|B|


## Objects {#object}

`docker_containers`

The object of containers, only supported Running status.

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|Kubernetes cluster name (default is `default`). It can be renamed in datakit.yaml using ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from Kubernetes (label `io.kubernetes.container.name`). If empty, use `$container_runtime_name`.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty, use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|Type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|Name of the DaemonSet which the object belongs to.|
|`deployment`|Name of the Deployment which the object belongs to.|
|`image`|Full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|Name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|Short name of the container image, example `nginx`.|
|`image_tag`|Tag of the container image, example `1.21.0`.|
|`name`|ID of the container.|
|`namespace`|Namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|Pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|Pod UID of the container (label `io.kubernetes.pod.uid`).|
|`state`|State of the Container (only Running).|
|`statefulset`|Name of the StatefulSet which the object belongs to.|
|`status`|Status of the container, example `Up 5 hours`.|
|`task_arn`|Task ARN of the AWS Fargate.|
|`task_family`|Task family of the AWS Fargate.|
|`task_version`|Task version of the AWS Fargate.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`block_read_byte`|Total number of bytes read from the container file system (only supported by Docker).|int|B|
|`block_write_byte`|Total number of bytes written to the container file system (only supported by Docker).|int|B|
|`cpu_numbers`|Number of CPU cores.|int|count|
|`cpu_usage`|Percentage usage of CPU on the system host.|float|percent|
|`cpu_usage_base100`|Normalized CPU usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|Total memory in the host machine.|int|B|
|`mem_limit`|Memory limit in the container.|int|B|
|`mem_usage`|Memory usage.|int|B|
|`mem_used_percent`|Percentage usage of memory calculated based on the capacity of the host machine.|float|percent|
|`mem_used_percent_base_limit`|Percentage usage of memory calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes sent to the network (only count the usage of the main process in the container, excluding loopback).|int|B|