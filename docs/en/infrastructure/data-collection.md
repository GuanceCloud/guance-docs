# Data Collection
---

Guance supports collecting data from hosts, cloud hosts, containers, processes and other cloud services, and then actively reports them to the workspace.

## Preconditions

- [Install DataKit](../datakit/datakit-install.md)

## Data Collection

### Host

After the DataKit installation is completed on the host to be observed, the system will open a batch of collectors related to the host by default, and actively report the data to the Guance workspace. 

> See [DataKit Collector Use](../datakit/datakit-input-conf.md); [Host](../datakit/hostobject.md).

**Note**: After enabling host collection, changing the hostname `host_name` will automatically add a new host. The original hostname will continue to be displayed in the **Infrastructure > Hosts** list. However, one hour after the change, the host will stop reporting data until it has not reported any data for 24 hours, at which point it will be removed from the list. Since the maximum number of DataKit instances within a 24-hour period is used for billing purposes, during this billing cycle, it will be counted as two hosts for billing purposes.

The list of collectors turned on by default is as follows:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collect the CPU usage of the host |
| `disk` | Collection disk occupancy |
| `diskio` | Collect the disk IO status of the host |
| `mem` | Collect the memory usage of the host |
| `swap` | Collect Swap memory usage |
| `system` | Collect the load of host operating system |
| `net` | Collect host network traffic |
| `host_process` | Collect the list of resident (surviving for more than 10min) processes on the host |
| `hostobject` | Collect basic information of host computer (such as operating system information and hardware information.) |
| container | Collect possible containers or Kubernetes data on the host. Assuming there are no containers on the host, the collector will exit directly.|


### Cloud Host

If the host on which the DataKit is located is a cloud host, cloud synchronization can be started by using the `cloud_provider` tag. After configuration, restart datakit. 

> See [Turn on Cloud Synchronization](../datakit/hostobject.md).

### Container

There are two ways to start container data collection:

1. To start the [Container](../datakit/container.md) collector after the host installs the datakit.
2. Install DataKit using the [DaemonSet method](../datakit/datakit-daemonset-deploy.md).

**Note**:

- Install DataKit through the host, and open the container collector to support collecting Containers and Pods data only;
- DataKit is installed in DaemonSet mode, which supports collecting data of all container components such as Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs and Cron Jobs. The collected data can be viewed and analyzed in corresponding explorers.

### Process

To start process data collection, you need to go to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and name it `host_processes.conf`. After configuration, restart datakit.

**Note**: The process collector is turned on by default, but it does not collect process metric data by default. If you need to collect metric related data, you can set `open_metric` to `true` in `host_processes.conf`. 

> See [Process](../datakit/host_processes.md).

### Custom

Guance enables you to report custom data to the workspace and synchronize the data to the specified classification.

- You can create new classes and customize fields through the path Infrastructure-Customization.
- When reporting custom data, you need to install and connect DataKit and DataFlux Function first, then report data to DataKit through DataFlux Function, and finally report data to Guance Clou workspace by DataKit. 

> For the specific operation process, see [Custom Data Reporting](custom/data-reporting.md). 
