# Common Tag Organization
---

In DataKit-collected data, Tags are key fields for all data. They influence data filtering and grouping. Incorrect Tag data can lead to errors in Web page data display. Additionally, the designation of Tags affects the usage statistics of time series data. Therefore, during the design and modification of Tags, one should carefully consider whether the changes might cause related issues. This document primarily lists common Tags currently in DataKit to clarify the specific meanings of each Tag. Secondly, when adding new Tags in the future, one should follow these naming conventions to ensure consistency.

Below, we will list Tags from two dimensions: global Tags and specific data type-specific Tags.

## Global Tags {#global-tags}

These Tags are not tied to any specific data type and can be appended to any data type.

| Tag                | Description                                                                                              |
| ---                | ---                                                                                                      |
| host               | Hostname; this tag is included with both DaemonSet installations and host installations. In certain cases, users can rename the value of this tag. |
| project            | Project name, generally set by the user.                                                                 |
| cluster            | Cluster name, usually set by the user during DaemonSet installation.                                      |
| election_namespace | Namespace where elections occur. Not added by default; see [documentation](datakit-daemonset-deploy.md#env-elect). |
| version            | Version number; all tags involving version information should use this tag.                              |

### Common Kubernetes/Container Tags {#k8s-tags}

These tags are generally appended to collected data but are ignored by default in time series collection (e.g., `pod_name`) to save on time series storage.

| Tag              | Description                   |
| ---              | ---                           |
| `pod_name`       | Pod name                      |
| `deployment`     | K8s Deployment name           |
| `service`        | K8s Service name              |
| `namespace`      | K8s Namespace name            |
| `job`            | K8s Job name                  |
| `image`          | Full image name in K8s        |
| `image_name`     | Short image name in K8s       |
| `container_name` | Container name in K8s/container |
| `cronjob`        | K8s CronJob name              |
| `daemonset`      | K8s DaemonSet name            |
| `replica_set`    | K8s ReplicaSet name           |
| `node_name`      | K8s Node name                 |
| `node_ip`        | K8s Node IP                   |

## Tags Classified by Specific Data Type {#tag-classes}

### Logs {#L}

| Tag     | Description                                                                                                         |
| ---     | ---                                                                                                                 |
| source  | Log source; in line protocol, it is not a tag but is used as the measurement name. The center treats it as a tag stored in the log's source field. |
| service | Service name for logs; if not specified, its value defaults to the source field.                                     |
| status  | Log level; if not specified, the collector sets it to `unknown`. Common statuses are listed [here](../integrations/logging.md#status). |

### Objects {#O}

| Tag   | Description                                                                                                        |
| ---   | ---                                                                                                                |
| class | Object classification; in line protocol, it is not a tag but is used as the measurement name. The center treats it as a tag stored in the object's class field. |
| name  | Object name; the center combines hash(class + name) to uniquely identify an object within a workspace.             |

### Metrics {#M}

Metrics, due to their varied sources, do not have fixed tags beyond the global tags.

### APM {#T}

Tracing data tags are unified [here](../integrations/ddtrace.md#measurements).

### RUM {#R}

Refer to the RUM documentation:

- [Web](../real-user-monitoring/web/app-data-collection.md)
- [Android](../real-user-monitoring/android/app-data-collection.md)
- [iOS](../real-user-monitoring/ios/app-data-collection.md)
- [Mini Program](../real-user-monitoring/miniapp/app-data-collection.md)
- [Flutter](../real-user-monitoring/flutter/app-data-collection.md)
- [React Native](../real-user-monitoring/react-native/app-data-collection.md)

### Scheck {#S}

Refer to the [Scheck documentation](../scheck/scheck-how-to.md).

### Profile {#P}

Refer to the [collector documentation](../integrations/profile.md#measurements).

### Network {#N}

Refer to the [collector documentation](../integrations/ebpf.md#measurements).

### Events {#E}

Refer to the [design documentation](../events/index.md).