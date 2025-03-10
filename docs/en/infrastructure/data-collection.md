# Data Collection
---

<<< custom_key.brand_name >>> supports collecting object data from hosts, cloud hosts, containers, processes, and other cloud services, and actively reports it to the workspace.

## Prerequisites

[Install DataKit](../datakit/datakit-install.md).

## Data Collection

### Hosts

After completing the installation of DataKit on the host that needs to be observed, the system will automatically enable a batch of collectors related to the host and actively report data to the <<< custom_key.brand_name >>> workspace.

> For more details, refer to [DataKit Collector Usage](../datakit/datakit-input-conf.md) and [Host Object](../integrations/hostobject.md).

**Note**: After enabling host collection, changing the hostname `host_name` will add a new host by default. The original hostname will continue to be displayed in the **Infrastructure > Hosts** list but will stop reporting data after one hour. After 24 hours without reporting data, it will be removed from the list. Since the number of DataKits is calculated as the maximum value within 24 hours, it will be billed as two hosts during this billing cycle.

The list of collectors enabled by default is as follows:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage of the host |
| `disk` | Collects disk usage |
| `diskio` | Collects disk IO usage of the host |
| `mem` | Collects memory usage of the host |
| `swap` | Collects Swap memory usage |
| `system` | Collects operating system load of the host |
| `net` | Collects network traffic of the host |
| `host_process` | Collects a list of long-running (surviving more than 10 minutes) processes on the host |
| `hostobject` | Collects basic information about the host (such as OS information, hardware information, etc.) |
| container | Collects container or Kubernetes data on the host; if no containers exist on the host, the collector exits directly |

### Cloud Hosts

If the host where DataKit resides is a cloud host, cloud synchronization can be enabled via the `cloud_provider` label. After configuration, restart DataKit.

> For more details, refer to [Enabling Cloud Synchronization](../integrations/hostobject.md).

### Containers

To enable container data collection, there are two methods:

1. Start the [Container](../integrations/container.md) collector after installing DataKit on the host;

2. Install DataKit using the [DaemonSet method](../datakit/datakit-daemonset-deploy.md).

???+ warning

    - When installing DataKit on the host, enabling the container collector only supports collecting Containers and Pods data;

    - Installing DataKit via the DaemonSet method supports collecting all container component data such as Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc., which can be viewed and analyzed in the corresponding Explorer.

### Processes

To enable process data collection, navigate to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample`, and rename it to `host_processes.conf`. After configuration, restart DataKit.

**Note**: The process collector is enabled by default, but it does not collect process Metrics by default. If you need to collect Metrics-related data, set `open_metric` to `true` in `host_processes.conf`.

> For more details, refer to [Processes](../integrations/host_processes.md).

### Resource Catalog

<<< custom_key.brand_name >>> supports reporting Resource Catalog data to the workspace and synchronizing object data to specified Resource Classes.

- Through **Infrastructure > Custom**, you can create new Resource Classes and resource catalog fields;

- When reporting Resource Catalog data, you need to install and connect DataKit and DataFlux Func first, then report data to DataKit through DataFlux Func, which will ultimately report object data to the <<< custom_key.brand_name >>> workspace.

> For specific operation steps, refer to [Reporting Resource Catalog Data](custom/data-reporting.md).