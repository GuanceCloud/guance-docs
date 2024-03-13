# 基础设施存活检测 V2
---


基于基础设施对象数据，您可以在基础设施存活检测设置判断条件，从而监控基础设施的的数据上报稳定性。


## 应用场景

监控基础设施上报数据是否异常，支持监控包括主机、容器、Pod、Deployment、Node 在内的对象数据上报情况。

## 新建

点击**监控器 > 新建监控器 > 基础设施存活检测 V2**，进入规则的配置页面。

### 步骤一：检测配置 {#config}

![](../img/monitor18.png)

1）**检测频率**：检测规则的执行频率，包含【5分钟/10分钟/15分钟/30分钟/1小时/12小时/24小时】，默认选中 5 分钟。

2）**检测指标**：监控的指标数据。

- 基础设施类型：包含主机、进程、容器、Pod、Service、Deployment、Node、ReplicaSet、Job、CronJob；

| 基础设施类型 | 检测对象 | Wildcard 筛选 | 固定筛选 | DQL 查询 |
| --- | --- | --- | --- | --- | 
| 主机 | 所有主机 | / | / | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) by cmdline |
|  | 自定义 | host：主机 | df_label：标签 ; os：操作系统 | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by host |
| 进程 | 所有进程 | / | / | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) by host |
|  | 自定义 | cmdline：命令行 | host：主机 ; process_name：进程名称 | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by cmdline |
| 容器 | 所有容器 | / | / | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) by container_name |
|  | 自定义 | container_name：容器名称 | host：主机 ; namespace：命名空间 | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by container_name |
| Pod | 所有 Pod | / | / | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) by pod_name |
|  | 自定义 | pod_name：Pod 名称 | host：主机 ; namespace：命名空间 | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by pod_name |
| Service | 所有 Service | / | / | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) by service_name |
|  | 自定义 | pservice_name：Service 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by service_name |
| Deployment | 所有 Deployment | / | / | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) by deployment_name |
|  | 自定义 | deployment_name：Deployment 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by deployment_name |
| Node | 所有 Node | / | / | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) by node_name |
|  | 自定义 | node_name：Node 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by node_name |
| ReplicaSet | 所有 ReplicaSet | / | / | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) by replicaset_name |
|  | 自定义 | replicaset_name：ReplicaSet 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by replicaset_name |
| Job | 所有 Job | / | / | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) by job_name |
|  | 自定义 | job_name：Job 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by job_name |
| CronJob | 所有 CronJob | / | / | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) by cron_job_name |
|  | 自定义 | cron_job_name：CronJob 名称 | cluster_name_k8s：K8s 集群 ; namespace：命名空间 | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) {筛选条件} by cron_job_name |

- 检测对象：支持选择**所有**或**自定义**；

| 检测对象 | 说明 |
| --- | --- |
| 所有 | 选择此范围后，针对工作空间内所有对象判断对象数据的最后上报更新时间是否触发了阈值。 |
| 自定义 | 选择此选项后，支持用户通过 wildcard 模糊匹配名称或者精准匹配的筛选条件获取需检测的范围，检测所选范围内的基础设施对象判断对象数据的最后上报更新时间是否触发了阈值。 |


3）**触发条件**：可设置紧急、重要、警告、正常告警级别的触发条件。配置多个触发条件及严重程度，多个值查询结果值任一满足触发条件则产生事件。

> 更多详情，可参考 [事件等级说明](event-level-description.md)。 

???- abstract "告警级别"

	1、**告警级别紧急（红色）、重要（橙色）、警告（黄色）**：基于配置条件判断检测对象数据的最后上报更新时间是否触发告警。

    2、**告警级别正常（绿色）**：检测规则生效后，产生紧急、重要、警告异常事件后，在配置的自定义检测次数内，数据检测结果恢复正常，则产生恢复告警事件。

    基于配置的检测次数，说明如下：

    - 每执行一次检测任务即为 1 次检测，如【检测频率 = 5 分钟】，则 1 次检测= 5 分钟；  
    - 可以自定义检测次数，如【检测频率 = 5 分钟】，则 3 次检测 = 15 分钟。  

    - 检测次数内无异常事件产生，则产生正常事件。  

    **注意**：触发条件支持配置**紧急、重要、警告**输入值范围为 5～999，若输入值小于 5 则提示调整，避免检测误报。


### 步骤二：事件通知

![](../img/8.monitor_1.png)

1）**事件标题**：设置告警触发条件的事件名称，支持使用预置的[模板变量](../event-template.md)。

**注意**：最新版本中监控器名称将由事件标题输入后同步生成。旧的监控器中可能存在监控器名称和事件标题不一致的情况，为了给您更好的使用体验，请尽快同步至最新。

2）**事件内容**：满足触发条件时发送的事件通知内容。支持输入 Markdown 格式文本信息并预览效果，支持使用预置的 关联链接，支持使用预置的[模板变量](../event-template.md)。

**注意**：不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。


3）**关联异常追踪**：开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。选择 Issue 的等级以及需要投递的目标频道，产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

在事件恢复后，可以同步关闭 Issue。

![](../img/issue-create.png)

### 步骤三：告警配置

[**告警策略**](../alert-setting.md)：监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。

告警策略支持单选或多选，点击策略名可展开详情页。若需修改策略点击**编辑告警策略**即可。

![](../img/policy-create.png)


### 步骤四：关联

![](../img/5.monitor_4.png)

**关联仪表板**：每一个监控器都支持关联一个仪表板，可快速跳转查看。

<!--
### 示例

假设您配置了主机存活检测，如果检测对象连续 15 分钟未上报数据，触发【紧急】告警。

![](../img/example02.png)
-->