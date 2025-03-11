# How to Collect Host Objects
---

## Introduction

<<< custom_key.brand_name >>> can help you easily monitor any host facility, whether it is a traditional host, server, or public cloud or private cloud object. By installing DataKit, you can monitor the host's status, name, operating system, processor, memory, network, disk, connection tracking, files, and more in real-time on the dashboard. With rich features such as associated queries, custom labels, interactive host distribution maps, and more, you can not only manage hosts uniformly but also observe the overall state of the hosts.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/).
- [Install DataKit](../datakit/datakit-install.md)
- Supported operating systems: `windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64, darwin/amd64`

## Methods/Steps

### Step 1: Enable the Host Object Collector

After completing the installation of DataKit on the host/server, you can enable host object data collection by following these steps:

1. Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. After configuration, use the command `datakit --restart` to restart DataKit.

3. After configuration, the system will automatically enable a set of collectors related to the host and proactively report data to the "<<< custom_key.brand_name >>>" workspace. The default enabled collectors are listed below:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage information from the host |
| `disk` | Collects disk usage information |
| `diskio` | Collects disk IO information from the host |
| `mem` | Collects memory usage information from the host |
| `swap` | Collects Swap memory usage information |
| `system` | Collects operating system load information from the host |
| `net` | Collects network traffic information from the host |
| `host_processes` | Collects a list of long-running (surviving over 10 minutes) processes on the host |
| `hostobject` | Collects basic information about the host (e.g., OS information, hardware information, etc.) |
| `container` | Collects container objects and container logs on the host |

For more host object data collection, refer to the documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 2: Enable Cloud Sync

If the host where DataKit is installed is a **cloud host**, you can enable cloud sync using the `cloud_provider` tag. Follow these steps:

1. Navigate to the `conf.d/host` directory under `/usr/local/datakit`, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. Open the `hostobject.conf` file and enable the following configurations:
   - Enable `inputs.hostobject.tags`
   - Enable `cloud_provider = "aliyun"`

![](img/2.host_2.png)

3. After configuration, use the command `datakit --restart` to restart DataKit for changes to take effect.

4. After enabling cloud sync, the system will proactively report the following fields to the "<<< custom_key.brand_name >>>" workspace (based on synchronized fields):

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
| `security_group_id` | Instance security group |
| `private_ip` | Instance private IP |
| `zone_id` | Instance Zone ID |
| `region` | Instance Region ID |

For more host object data collection, refer to the documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 3: View Host Data

In the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Host", you can view each host's data information within the last 24 hours via the **Host Object List**, including host names and tags, CPU usage rate, MEM usage rate, single-core CPU load, etc.

![](img/image111.png)

Clicking on a host name in the host object list will pull out the **Host Detail Page** where you can view detailed information about the host, such as hardware model, resource consumption, associated logs, processes, events, etc.

![](img/1.png)

For more host object analysis, refer to the documentation [Host](../infrastructure/host.md).

## Advanced References

### Correlation Analysis

- **Mining Correlated Data**

To build comprehensive observability for hosts, after enabling other data collectors related to hosts, you can dig into correlated logs, processes, incidents, containers, networks, and security checks through the <<< custom_key.brand_name >>> dashboard with one click.

![](img/2.png)

Enabling other data collectors related to hosts can be found in [Logs](../integrations/logging.md), [Processes](../integrations/host_processes.md), [Containers](../integrations/container.md), [Network](../integrations/net.md), [Security Check](../integrations/sec-checker.md).

- **Custom Built-in Views**

Custom built-in views allow you to [bind associated views](../scene/built-in-view/bind-view.md) to the host detail page, enabling linked data viewing. Based on your analysis needs, you can choose official system views or user-defined views as built-in views. This not only helps you quickly expand the scope of host correlation analysis using official templates but also supports you in creating new monitoring views.

For example, to add the system view "CPU Monitoring View" as a built-in view for a host object labeled "test" and link it to query the host's CPU status, follow these steps:

1. In the <<< custom_key.brand_name >>> workspace under "Manage" - "Built-in Views," select the system view "CPU Monitoring View."

2. Click "Edit" and bind the object with the label "test".

3. Click "Confirm" to create the binding relationship.

![](img/3.png)

4. View this built-in view on the corresponding Explorer detail page.

![](img/4.png)

For more configuration details, refer to [Binding Built-in Views](../scene/built-in-view/bind-view.md).

### Interactive Host Topology Map

To achieve observability in multi-host environments, an intuitive topology map that clearly displays the data center operations environment is essential. In the <<< custom_key.brand_name >>> dashboard, switching the Explorer in the top-left corner to "Host Topology Map" allows you to visualize and query the size of metrics for hosts, helping you quickly analyze the operational status of hosts under different systems, statuses, versions, regions, and custom labels.

![](img/5.png)

Learn more at [Host Topology Map](../infrastructure/host.md).

### Custom Metrics Set

To facilitate the classification of familiar metrics, <<< custom_key.brand_name >>> supports defining new characteristics for host objects by configuring `[inputs.hostobject.tags]` in the host collector. This characteristic can be used to filter related host objects.

![](img/6.png)

For detailed configuration methods, refer to [DataKit Host Object Collector](../integrations/hostobject.md).

### Custom Labels

To help you manage IT infrastructure environments more flexibly and effectively, <<< custom_key.brand_name >>> provides the functionality of infrastructure labels. This allows you to categorize, search, filter, and centrally manage hosts based on label tags.

![](img/7.png)