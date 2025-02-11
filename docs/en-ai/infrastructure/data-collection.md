# Data Collection
---

Guance supports collecting data from objects including hosts, cloud hosts, containers, processes, and other cloud services, and actively reports it to the workspace.

## Prerequisites

[Install DataKit](../datakit/datakit-install.md).

## Data Collection

### Hosts

After completing the installation of DataKit on the host that needs to be monitored, the system will automatically enable a set of collectors related to the host and report data to the Guance workspace.

> For more details, refer to [DataKit Collector Usage](../datakit/datakit-input-conf.md) and [Host Objects](../integrations/hostobject.md).

**Note**: After enabling host collection, changing the hostname `host_name` will default to adding a new host. The original hostname will continue to display in the **Infrastructure > Hosts** list for one hour and then stop reporting data until 24 hours have passed without reporting data, after which it will be removed from the list. Since the number of DataKits is calculated based on the maximum value within 24 hours, it will be charged as two hosts during this billing cycle.

The default enabled collectors are listed below:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage on the host |
| `disk` | Collects disk usage |
| `diskio` | Collects disk IO usage on the host |
| `mem` | Collects memory usage on the host |
| `swap` | Collects Swap memory usage |
| `system` | Collects operating system load on the host |
| `net` | Collects network traffic on the host |
| `host_process` | Collects a list of resident (alive for more than 10 minutes) processes on the host |
| `hostobject` | Collects basic information about the host (such as OS information, hardware information, etc.) |
| container | Collects container or Kubernetes data on the host; if no containers exist on the host, the collector will exit directly |

### Cloud Hosts

If the host where DataKit resides is a cloud host, you can enable cloud synchronization via the `cloud_provider` label. After configuration, restart DataKit.

> For more details, refer to [Enable Cloud Synchronization](../integrations/hostobject.md).

### Containers

To enable container data collection, there are two methods:

1. Start the [container](../integrations/container.md) collector after installing DataKit on the host;

2. Install DataKit using the [DaemonSet method](../datakit/datakit-daemonset-deploy.md).

???+ warning

    - Installing DataKit on the host and enabling the container collector only supports collecting Containers and Pods data;

    - Installing DataKit via the DaemonSet method supports collecting all container component data such as Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc., and the collected data can be viewed and analyzed in the corresponding Explorer.

### Processes

To enable process data collection, navigate to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and rename it to `host_processes.conf`. After configuration, restart DataKit.

**Note**: The process collector is enabled by default but does not collect process Metrics data by default. If you need to collect Metrics-related data, set `open_metric` to `true` in `host_processes.conf`.

> For more details, refer to [Processes](../integrations/host_processes.md).

### Resource Catalog

Guance supports you reporting Resource Catalog data to the workspace and synchronizing object data to specified Resource Classes.

- Through **Infrastructure > Custom**, you can create new Resource Classes and Resource Catalog fields;

- When reporting Resource Catalog data, you need to install and connect DataKit and DataFlux Func first, then report data to DataKit via DataFlux Func, which will finally report object data to the Guance workspace.

> For specific operation steps, refer to [Reporting Resource Catalog Data](custom/data-reporting.md).