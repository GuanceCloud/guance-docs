# How to Collect Host Objects
---

## Introduction

<<< custom_key.brand_name >>> can help you easily monitor any host facility, whether it is a traditional host, server, or public cloud or private cloud object. By installing DataKit, you can monitor the status, name, operating system, processor, memory, network, disk, connection tracking, files, etc., of the host in real-time on the dashboard. There are also rich features such as associated queries, custom labels, and interactive host distribution maps. You can not only manage hosts uniformly but also observe the overall state of the hosts.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).
- [Install DataKit](../datakit/datakit-install.md)
- Supported operating systems: `windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## Methods/Steps

### Step1: Enable the Host Object Collector

After completing the installation of DataKit on the host/server, you can enable the collection of host object data according to the following steps:

1. Go to the `conf.d/host` directory under the DataKit installation directory, copy `hostobject.conf.sample` and rename it to `hostobject.conf`.

2. After configuration, use the command `datakit --restart` to restart DataKit.

3. After the configuration is complete, the system will automatically enable a batch of collectors related to the host and actively report data to the "<<< custom_key.brand_name >>>" workspace. The default enabled collector list is as follows:

| Collector Name | Description |
| --- | --- |
| `cpu` | Collects CPU usage of the host |
| `disk` | Collects disk usage |
| `diskio` | Collects disk IO conditions of the host |
| `mem` | Collects memory usage of the host |
| `swap` | Collects swap memory usage |
| `system` | Collects host operating system load |
| `net` | Collects host network traffic conditions |
| `host_processes` | Collects processes resident (alive for more than 10 minutes) on the host |
| `hostobject` | Collects basic information about the host (such as operating system information, hardware information, etc.) |
| `container` | Collects possible container objects and container logs on the host |

For more host object data collection, refer to the help documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step2: Enable Cloud Synchronization

If the host where DataKit resides is a **cloud host**, you can enable cloud synchronization via the `cloud_provider` tag. The specific steps are as follows:

1. Go to the `conf.d/host` directory under `/usr/local/datakit`, copy `hostobject.conf.sample` and rename it to `hostobject.conf`.

2. Open the `hostobject.conf` file and enable the following configurations:

   - Enable `inputs.hostobject.tags`
   - Enable `cloud_provider = "aliyun"`

![](img/2.host_2.png)

3. After the configuration is complete, use the command `datakit --restart` to restart DataKit for the changes to take effect.

4. After enabling cloud synchronization, the system will actively report the following fields to the "<<< custom_key.brand_name >>>" workspace (based on synchronized fields):

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
| `security_group_id` | Instance group |
| `private_ip` | Instance private IP |
| `zone_id` | Instance Zone ID |
| `region` | Instance Region ID |

For more host object data collection, refer to the help documentation [DataKit Host Object Collector](../integrations/hostobject.md).

### Step3: View Host Data

In the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Host", you can view the data information of each host in the current space within the last 24 hours through the **host object list**, including host names and tags, CPU usage rates, MEM usage rates, single-core CPU loads, etc.

![](img/image111.png)

Clicking on the host name in the host object list will display the **host details page** where you can view detailed information about the host, such as hardware model, basic resource consumption, associated logs, processes, events, etc.

![](img/1.png)

For more host object analysis, refer to the help documentation [Host](../infrastructure/host.md).

## Advanced Reference

### Correlation Analysis

- **Discover Associated Data**

If you need to build a comprehensive and deep observability for the host, enabling other data collectors related to the host allows you to instantly discover host-related logs, processes, abnormal events, containers, networks, security checks through the "<<< custom_key.brand_name >>>" dashboard.

![](img/2.png)

To enable other data collectors related to the host, refer to [Logs](../integrations/logging.md), [Processes](../integrations/host_processes.md), [Containers](../integrations/container.md), [Networks](../integrations/net.md), [Security Checks](../integrations/sec-checker.md).

- **Custom Built-in Views**

Custom built-in views can help you [bind associated views](../scene/built-in-view/bind-view.md) to the host detail page, enabling linked data viewing. Based on your analysis needs, by selecting official system views or custom user views as built-in views, you can not only quickly expand the scope of host correlation analysis using official templates but also support editing new monitoring views.

Taking the observation of label-tagged "Test" host objects' CPU as an example, adding the system view "CPU Monitoring View" as a built-in view to the host details page allows you to query the CPU status of the host. The specific steps are as follows:

1. In the <<< custom_key.brand_name >>> workspace under "Management" - "Built-in Views," select the system view "CPU Monitoring View."

2. Click "Edit" and choose objects with the field label: Test as the binding relationship.

3. Click "Confirm" to create the binding relationship.

![](img/3.png)

4. View this built-in view on the corresponding Explorer detail page.

![](img/4.png)

For more configuration details, refer to [Bind Built-in Views](../scene/built-in-view/bind-view.md).

### Interactive Host Topology Map

Achieving observability in a multi-host environment requires a topology map that clearly displays the operations and maintenance environment of the data center. On the "<<< custom_key.brand_name >>>" dashboard, switching the viewer in the top-left corner of the page to "Host Topology Map" helps you visually query the size of host metric data, allowing you to quickly analyze the operational status of hosts under different systems, statuses, versions, regions, and custom tags.

![](img/5.png)

Learn more by referring to [Host Topology Map](../infrastructure/host.md).

### Custom Measurement Sets

To make it easier for you to classify familiar metrics, "<<< custom_key.brand_name >>>" supports you in defining custom tags for host objects in the host collector through the configuration `[inputs.hostobject.tags]`. This characteristic can then be used to filter relevant host objects.

![](img/6.png)

Detailed configuration methods can be found at: [DataKit Host Object Collector](../integrations/hostobject.md).

### Custom Labels

To allow you to manage IT infrastructure environments more flexibly and effectively, <<< custom_key.brand_name >>> provides the infrastructure label feature, supporting you in categorizing, searching, filtering, and centrally managing hosts based on label tags.

![](img/7.png)