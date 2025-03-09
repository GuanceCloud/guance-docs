# How to Collect Host Objects
---

## Introduction

<<< custom_key.brand_name >>> can help you easily monitor any host facility, whether it is a traditional host, server, or public cloud or private cloud objects. By installing DataKit, you can monitor the host's status, name, operating system, processor, memory, network, disk, connection tracking, files, and more in real-time on the dashboard. With rich features such as associated queries, custom labels, interactive host distribution maps, and more, you can not only manage hosts uniformly but also observe the overall state of the hosts.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/).
- [Install DataKit](../datakit/datakit-install.md)
- Supported operating systems: `windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## Methods/Steps

### Step 1: Enable Host Object Collector

After completing the installation of DataKit on the host/server, you can enable host object data collection by following these steps:

1. Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. After configuration, use the command `datakit --restart` to restart DataKit.

3. Once configured, the system will automatically enable a set of host-related collectors and report data to the "<<< custom_key.brand_name >>>" workspace. The default enabled collectors are listed below:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage statistics |
| `disk` | Collects disk usage statistics |
| `diskio` | Collects disk I/O statistics |
| `mem` | Collects memory usage statistics |
| `swap` | Collects swap memory usage statistics |
| `system` | Collects operating system load statistics |
| `net` | Collects network traffic statistics |
| `host_processes` | Collects a list of long-running (more than 10 minutes) processes on the host |
| `hostobject` | Collects basic information about the host (such as OS and hardware details) |
| `container` | Collects container objects and container logs on the host |

For more host object data collection, refer to the [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 2: Enable Cloud Sync

If the host where DataKit is installed is a **cloud host**, you can enable cloud sync using the `cloud_provider` tag. Follow these steps:

1. Navigate to the `conf.d/host` directory under `/usr/local/datakit`, copy `hostobject.conf.sample`, and rename it to `hostobject.conf`.

2. Open the `hostobject.conf` file and enable the following configurations:

   - Enable `inputs.hostobject.tags`
   - Set `cloud_provider = "aliyun"`

![](img/2.host_2.png)

3. After configuration, use the command `datakit --restart` to restart DataKit for changes to take effect.

4. After enabling cloud sync, the system will report the following fields to the "<<< custom_key.brand_name >>>" workspace (based on synchronized fields):

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
| `private_ip` | Private IP address |
| `zone_id` | Zone ID |
| `region` | Region ID |

For more host object data collection, refer to the [DataKit Host Object Collector](../integrations/hostobject.md).

### Step 3: View Host Data

In the <<< custom_key.brand_name >>> workspace under **Infrastructure** - **Host**, you can view data information for each host within the last 24 hours via the **Host Object List**, including host names and tags, CPU usage, memory usage, single-core CPU load, etc.

![](img/image111.png)

Clicking on a host name in the host object list will display the **Host Details Page**, showing detailed information such as hardware model, resource consumption, associated logs, processes, events, etc.

![](img/1.png)

For more host object analysis, refer to the [Host](../infrastructure/host.md) documentation.

## Advanced References

### Correlation Analysis

- **Discover Correlated Data**

To build comprehensive observability for hosts, after enabling other data collectors related to the host, you can use the <<< custom_key.brand_name >>> dashboard to easily discover correlated logs, processes, incidents, containers, networks, and security checks.

![](img/2.png)

To enable other data collectors related to the host, refer to [Logs](../integrations/logging.md), [Processes](../integrations/host_processes.md), [Containers](../integrations/container.md), [Network](../datakit/net.md), and [Security Checks](../integrations/sec-checker.md).

- **Customize Built-in Views**

Customizing built-in views allows you to [bind associated views](../scene/built-in-view/bind-view.md) to the host detail page, enabling linked data viewing. Based on your analysis needs, select official system views or custom user views as built-in views. This not only helps you quickly expand the scope of host correlation analysis using official templates but also supports you in creating new monitoring views.

For example, to add the system view "CPU Monitoring View" as an embedded view for hosts labeled "test," follow these steps:

1. In the <<< custom_key.brand_name >>> workspace under **Management** - **Built-in Views**, select the system view "CPU Monitoring View."

2. Click "Edit" and choose objects with the label `test` for binding.

3. Click "Confirm" to create the binding relationship.

![](img/3.png)

4. View this embedded view on the corresponding Explorer detail page.

![](img/4.png)

For more configuration details, refer to [Bind Built-in Views](../scene/built-in-view/bind-view.md).

### Interactive Host Topology Map

To achieve observability in multi-host environments, a clear topology map that displays the operation environment is essential. In the <<< custom_key.brand_name >>> dashboard, switching the viewer in the top-left corner to **Host Topology Map** allows you to visualize query metrics for hosts, helping you quickly analyze the operational status of hosts across different systems, states, versions, regions, and custom tags.

![](img/5.png)

Learn more at [Host Topology Map](../infrastructure/host.md).

### Custom Metrics Sets

To facilitate familiar metric categorization, <<< custom_key.brand_name >>> supports custom tags in the host collector configuration `[inputs.hostobject.tags]`, allowing you to assign a new characteristic to host objects and filter related hosts based on this characteristic.

![](img/6.png)

For detailed configuration methods, refer to [DataKit Host Object Collector](../integrations/hostobject.md).

### Custom Labels

To better manage IT infrastructure environments flexibly and effectively, <<< custom_key.brand_name >>> provides infrastructure label functionality, supporting you in classifying, searching, filtering, and centrally managing hosts based on label tags.

![](img/7.png)