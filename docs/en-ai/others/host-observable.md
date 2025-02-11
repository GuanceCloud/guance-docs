# How to Collect Host Objects
---

## Introduction

Guance helps you easily monitor any host facility, whether it is a traditional host, server, or public cloud or private cloud object. By installing DataKit, you can monitor the host's status, name, operating system, processor, memory, network, disk, connection tracking, files, and more in real-time on the dashboard. Additionally, there are rich features such as associated queries, custom labels, interactive host distribution maps, and more. You can not only manage hosts uniformly but also observe the overall state of the hosts.

## Prerequisites

- You need to create a [Guance account](https://www.guance.com/) first.
- [Install DataKit](../datakit/datakit-install.md)
- Supported operating systems: `windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## Methods/Steps

### Step 1: Enable Host Object Collector

After completing the installation of DataKit on the host/server, you can enable the collection of host object data by following these steps:

1. Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. After configuration, use the command `datakit --restart` to restart DataKit.

3. Once configured, the system will automatically enable a batch of collectors related to the host and proactively report data to the Guance workspace. The default list of enabled collectors is as follows:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage of the host |
| `disk` | Collects disk usage |
| `diskio` | Collects disk I/O usage of the host |
| `mem` | Collects memory usage of the host |
| `swap` | Collects swap memory usage |
| `system` | Collects operating system load of the host |
| `net` | Collects network traffic of the host |
| `host_processes` | Collects a list of long-running (surviving over 10 minutes) processes on the host |
| `hostobject` | Collects basic information about the host (such as OS information, hardware information, etc.) |
| `container` | Collects container objects and container logs on the host |

For more information on collecting host object data, refer to the help documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 2: Enable Cloud Sync

If the host where DataKit is installed is a **cloud host**, you can enable cloud sync via the `cloud_provider` tag. The specific steps are as follows:

1. Navigate to the `conf.d/host` directory under `/usr/local/datakit`, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. Open the `hostobject.conf` file and enable the following configurations:
   - Enable `inputs.hostobject.tags`
   - Set `cloud_provider = "aliyun"`

![](img/2.host_2.png)

3. After configuration, use the command `datakit --restart` to restart DataKit for changes to take effect.

4. After enabling cloud sync, the system will proactively report the following fields to the Guance workspace (based on synchronized fields):

| Field Name | Description |
| --- | --- |
| `cloud_provider` | Cloud service provider |
| `description` | Description |
| `instance_id` | Instance ID |
| `instance_name` | Instance name |
| `instance_type` | Instance type |
| `instance_charge_type` | Instance billing type |
| `instance_network_type` | Instance network type |
| `instance_status` | Instance status |
| `security_group_id` | Security group ID |
| `private_ip` | Private IP of the instance |
| `zone_id` | Zone ID of the instance |
| `region` | Region ID of the instance |

For more information on collecting host object data, refer to the help documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 3: View Host Data

In the Guance workspace under **Infrastructure** -> **Host**, you can view data information for each host within the last 24 hours through the **Host Object List**, including host names and tags, CPU usage rate, memory usage rate, single-core CPU load, etc.

![](img/image111.png)

Clicking on the host name in the host object list will open the **Host Detail Page** where you can view detailed information such as hardware model, basic resource consumption, associated logs, processes, events, etc.

![](img/1.png)

For more information on analyzing host objects, refer to the help documentation [Host](../infrastructure/host.md).

## Advanced References

### Correlation Analysis

- **Mining Associated Data**

To build comprehensive and deep observability for hosts, after enabling other data collectors related to the host, you can instantly mine associated logs, processes, incident events, containers, networks, security checks, etc., via the Guance dashboard.

![](img/2.png)

Enabling other data collectors related to the host can be done by referring to [Logging](../integrations/logging.md), [Processes](../integrations/host_processes.md), [Containers](../integrations/container.md), [Network](../datakit/net.md), [Security Check](../integrations/sec-checker.md).

- **Custom Built-in Views**

Custom built-in views help you [bind associated views](../scene/built-in-view/bind-view.md) to the host detail page, enabling linked data viewing. Based on your analysis needs, you can choose official system views or user-defined views as built-in views. This not only allows you to quickly expand the scope of host correlation analysis using official templates but also supports you in creating new monitoring views.

For example, to add the system view "CPU Monitoring View" as a built-in view for host objects labeled with "test", follow these steps:

1. In the Guance workspace under **Management** -> **Built-in Views**, select the system view "CPU Monitoring View".

2. Click "Edit," and choose objects with the label `test` for binding.

3. Click "Confirm" to create the binding relationship.

![](img/3.png)

4. View this built-in view on the corresponding Explorer detail page.

![](img/4.png)

For more configuration details, refer to [Binding Built-in Views](../scene/built-in-view/bind-view.md).

### Interactive Host Topology Map

Achieving observability in a multi-host environment requires a clear topology map that visualizes the IT operations environment. In the Guance dashboard, switching the Explorer in the top-left corner to **Host Topology Map** allows you to visually query the size of metrics data for hosts, thereby quickly analyzing the operational status of hosts under different systems, statuses, versions, regions, and custom tags.

![](img/5.png)

Learn more at [Host Topology Map](../infrastructure/host.md).

### Custom Metric Sets

To facilitate familiar metric categorization, Guance supports configuring `[inputs.hostobject.tags]` in the host collector to assign a new characteristic to the host object via custom tags. This characteristic can then be used to filter related host objects.

![](img/6.png)

For detailed configuration methods, refer to [DataKit Host Object Collector](../integrations/hostobject.md).

### Custom Labels

To better manage your IT infrastructure environment flexibly and effectively, Guance provides the infrastructure label feature, allowing you to classify, search, filter, and centrally manage hosts based on label tags.

![](img/7.png)