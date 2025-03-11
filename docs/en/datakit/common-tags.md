# Common Tag Organization
---

In DataKit collected data, tags are key fields for all data. They affect data filtering and grouping. Incorrect tag data can lead to incorrect data display on the Web page. Additionally, tagging affects the usage statistics of time series data. Therefore, during the design and modification of tags, one should carefully consider whether the changes will cause related issues. This document primarily lists common tags currently in DataKit to clarify the specific meaning of each tag and to ensure that any new tags added in the future follow these naming conventions and tagging practices to avoid inconsistencies.

The following list is organized into two dimensions: global tags and specific data type-specific tags.

## Global Tags {#global-tags}

These tags are not tied to specific data types and can be appended to any data type.

| Tag                | Description                                                                                       |
| ---                | ---                                                                                               |
| host               | Hostname; this tag can be added by DaemonSet installation or host installation. In certain cases, users can rename this tag's value. |
| project            | Project name, generally set by the user.                                                          |
| cluster            | Cluster name, usually set by the user during DaemonSet installation.                              |
| election_namespace | Namespace where elections occur. Not appended by default; see [documentation](datakit-daemonset-deploy.md#env-elect). |
| version            | Version number. All tags involving version information should use this tag.                       |

### Common Kubernetes/Container Tags {#k8s-tags}

These tags are typically added to collected data but are ignored by default for time series collection to save on time series costs (e.g., `pod_name`).

| Tag              | Description                     |
| ---              | ---                             |
| `pod_name`       | Pod name                        |
| `deployment`     | K8s Deployment name             |
| `service`        | K8s Service name                |
| `namespace`      | K8s Namespace name              |
| `job`            | K8s Job name                    |
| `image`          | Full image name in K8s          |
| `image_name`     | Short image name in K8s         |
| `container_name` | Container name within K8s/containers |
| `cronjob`        | K8s CronJob name                |
| `daemonset`      | K8s DaemonSet name              |
| `replica_set`    | K8s ReplicaSet name             |
| `node_name`      | K8s Node name                   |
| `node_ip`        | K8s Node IP                     |

## Tags Categorized by Specific Data Types {#tag-classes}

### Logs {#L}

| Tag     | Description                                                                                                         |
| ---     | ---                                                                                                                 |
| source  | Log source. In line protocol, it is not a tag but used as a measurement name, stored as the log's source field.     |
| service | Log service name. If not specified, its value defaults to the source field.                                         |
| status  | Log level. If not specified, the collector defaults it to `unknown`. Common statuses are listed [here](../integrations/logging.md#status). |

### Objects {#O}

| Tag   | Description                                                                                                        |
| ---   | ---                                                                                                                |
| class | Object classification. In line protocol, it is not a tag but used as a measurement name, stored as the object's class field. |
| name  | Object name. The system combines hash(class + name) to uniquely identify an object within a workspace.             |

### Metrics {#M}

Metrics, due to diverse data sources, do not have fixed tags besides the global tags.

### APM {#T}

Tracing data tags are unified [here](../integrations/ddtrace.md#measurements).

### RUM {#R}

Refer to RUM documentation:

- [Web](../real-user-monitoring/web/app-data-collection.md)
- [Android](../real-user-monitoring/android/app-data-collection.md)
- [iOS](../real-user-monitoring/ios/app-data-collection.md)
- [Miniapp](../real-user-monitoring/miniapp/app-data-collection.md)
- [Flutter](../real-user-monitoring/flutter/app-data-collection.md)
- [React Native](../real-user-monitoring/react-native/app-data-collection.md)

### Scheck {#S}

Refer to [Scheck documentation](../scheck/scheck-how-to.md)

### Profile {#P}

Refer to [collector documentation](../integrations/profile.md#measurements)

### Network {#N}

Refer to [collector documentation](../integrations/ebpf.md#measurements)

### Event {#E}

Refer to [design documentation](../events/index.md)
