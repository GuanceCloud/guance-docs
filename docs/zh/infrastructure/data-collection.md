# 数据采集
---


观测云支持采集包括主机、云主机、容器、进程和其他云服务的对象数据，并主动上报到工作空间。

## 前置条件

[安装 DataKit](../datakit/datakit-install.md)。

## 数据采集

### 主机

在需要被观测的主机上完成 DataKit 安装后，系统会默认开启一批与主机相关的采集器，并主动上报数据至观测云工作空间。

> 更多详情，可参考 [DataKit 采集器使用](../datakit/datakit-input-conf.md) 、[主机对象](../integrations/hostobject.md)。

**注意**：主机采集开启后，变更主机名 `host_name` 会默认新增加一台主机，原主机名会继续在**基础设施 > 主机**列表中显示，一个小时后不会继续上报数据，直到24小时未上报数据后从列表中移除。由于 DataKit 数量是在 24 小时内取最大值，故在这个计费周期内会被统计为2台主机进行收费。

默认开启的采集器列表如下：

| 采集器名称 | 说明 |
| --- | --- |
| `cpu` | 采集主机的 CPU 使用情况 |
| `disk` | 采集磁盘占用情况 |
| `diskio` | 采集主机的磁盘 IO 情况 |
| `mem` | 采集主机的内存使用情况 |
| `swap` | 采集 Swap 内存使用情况 |
| `system` | 采集主机操作系统负载 |
| `net` | 采集主机网络流量情况 |
| `host_process` | 采集主机上常驻（存活 10min 以上）进程列表 |
| `hostobject` | 采集主机基础信息（如操作系统信息、硬件信息等） |
| container | 采集主机上可能的容器或 Kubernetes 数据，假定主机上没有容器，则采集器会直接退出 |


### 云主机

假如 DataKit 所在的主机是云主机，通过 `cloud_provider` 标签即可开启云同步。配置完成后，重启 DataKit 即可。

> 更多详情，可参考[开启云同步](../integrations/hostobject.md)。

### 容器

开启容器数据采集，有两种方式：

1、在主机安装 DataKit 以后开始[容器](../integrations/container.md)采集器；

2、通过 [DaemonSet 方式安装](../datakit/datakit-daemonset-deploy.md) DataKit。

???+ warning

    - 通过主机安装 DataKit，开启容器采集器仅支持采集 Containers、Pods 数据；

    - 通过 DaemonSet 方式安装 DataKit ，支持采集 Containers、Pods、Services、Deployments、Clusters、Nodes、Replica Sets、Jobs、Cron Jobs 等所有容器组件的数据，采集的数据可在对应的查看器中查看和分析。

### 进程

开启进程数据采集，需要进入 DataKit 安装目录下的`conf.d/host` 目录，复制 `host_processes.conf.sample` 并命名为 `host_processes.conf`。配置完成后，重启 DataKit 即可。

**注意**：进程采集器默认开启，但是默认不采集进程指标数据，如需采集指标相关数据，可在 `host_processes.conf` 中 将 `open_metric` 设置为 `true`。

> 更多详情，可参考[进程](../integrations/host_processes.md)。

### 资源目录

观测云支持您上报资源目录数据到工作空间，并同步对象数据到指定的对象分类。

- 通过**基础设施 > 自定义**，您可以创建新的对象分类并资源目录字段；

- 上报资源目录数据时，您需要先安装并连通 DataKIt 和 DataFlux Function，再通过 DataFlux Function 上报数据到 DataKit，最终由 DataKit 上报对象数据到观测云工作空间。

> 具体操作过程，可参考[资源目录数据上报](custom/data-reporting.md)。 
