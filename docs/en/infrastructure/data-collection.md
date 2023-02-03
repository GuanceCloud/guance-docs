# Data Collection
---

## Introduction

Guance supports collecting object data including hosts, cloud hosts, containers, processes and other cloud services, and then actively reports them to the workspace.

## Preconditions

- To install DataKit, see ([DataKit installation doc](../datakit/datakit-install.md)).

## Data Collection

### Host

After the DataKit installation is completed on the host to be observed, the system will open a batch of collectors related to the host by default, and actively report the data to the Guance workspace. Refer to [DataKit collector use](../datakit/datakit-input-conf.md) / [host object](../datakit/hostobject.md).

Note: After host collection is started, changing the host name `host_name` will add a new host by default, and the original host name will continue to be displayed in the "Infrastructure"-"Host" list. Data will not continue to be reported after one hour until it is removed from the list after 24 hours of unreported data. Since the number of DataKits is the maximum within 24 hours, it will be counted as 2 hosts for charging in this charging cycle.

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

If the host on which the DataKit is located is a cloud host, cloud synchronization can be started by using the `cloud_provider` tag. After configuration, restart datakit. See the documentation [turn on cloud synchronization](../datakit/hostobject.md).

### Container

There are two ways to start container data collection:

1. To start the container collector after the host installs the datakit, refer to the document [Container](../datakit/container.md).
1. To install datakit as a DaemonSet, refer to the documentation [DaemonSet installation](../datakit/datakit-daemonset-deploy.md).

Notes:

- Install DataKit through the host, and open the container collector to support collecting Containers and Pods data only;
- DataKit is installed in DaemonSet mode, which supports collecting data of all container components such as Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs and Cron Jobs. The collected data can be viewed and analyzed in corresponding explorers.

### Process

To start process data collection, you need to go to the `conf.d/host` directory under the DataKit installation directory, copy `host_processes.conf.sample` and name it `host_processes.conf`. After configuration, restart datakit.

Note: The process collector is turned on by default, but it does not collect process metric data by default. If you need to collect metric related data, you can set `open_metric` to `true` in `host_processes.conf`. See the documentation [process](../datakit/host_processes.md).

### Custom Object

Guance enables you to report custom object data to the workspace and synchronize the object data to the specified object classification.

- You can create new object classes and customize object fields through the path Infrastructure-Customization.
- When reporting custom object data, you need to install and connect DataKit and DataFlux Function first, then report data to DataKit through DataFlux Function, and finally report object data to Guance Clou workspace by DataKit. For the specific operation process, please refer to the document [custom object data reporting](custom/data-reporting.md). 
