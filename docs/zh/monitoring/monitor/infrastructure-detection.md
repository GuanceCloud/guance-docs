# 基础设施存活检测 V2
---


您可以基于基础设施对象数据，在存活检测中设置条件，监控包括主机、容器、Pod、Deployment 和 Node 在内的关键对象的数据上报稳定性，确保及时发现并处理异常情况。


## 检测配置 {#config}

![](../img/monitor18.png)

### 检测频率

即检测规则的执行频率；默认选中 5 分钟。

### 检测区间

即每次执行任务时，检测指标查询的时间范围。受检测频率影响，可选检测区间会有不同。

### 检测指标

即监控的指标数据。

:material-numeric-1-circle-outline: 基础设施类型：包含主机、进程、容器、Pod、Service、Deployment、Node、ReplicaSet、Job、CronJob；

| 类型 | 检测对象 | Wildcard 筛选 | 固定筛选 | DQL 查询 |
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

:material-numeric-2-circle-outline: 检测对象：支持选择**所有**或**自定义**；

| 检测对象 | 说明 |
| --- | --- |
| 全部 | 即针对工作空间内所有对象判断对象数据的最后上报更新时间是否触发了阈值。 |
| 自定义 | 即通过 wildcard 模糊匹配名称或者精准匹配的筛选条件获取需检测的范围，检测所选范围内的基础设施对象判断对象数据的最后上报更新时间是否触发了阈值。 |

:material-numeric-3-circle-outline: 附加信息：选定字段后，系统会做额外查询，但不会用于触发条件的判断。将这些字段配置到事件通知中，如果检测到多个匹配值，则会随机返回一条事件信息的纪录。
  
### 触发条件

可设置紧急、重要、警告、正常告警级别的触发条件。配置多个触发条件及严重程度，多个值查询结果值任一满足触发条件则产生事件。

> 更多详情，可参考 [事件等级说明](event-level-description.md)。 

???+ abstract "告警级别"

	1. **告警级别紧急（红色）、重要（橙色）、警告（黄色）**：基于配置条件判断检测对象数据的最后上报更新时间是否触发告警。

    2. **告警级别正常（绿色）**：检测规则生效后，产生紧急、重要、警告异常事件后，在配置的自定义检测次数内，数据检测结果恢复正常，则产生恢复告警事件。

    基于配置的检测次数，说明如下：

    - 每执行一次检测任务即为 1 次检测，如【检测频率 = 5 分钟】，则 1 次检测= 5 分钟；  
    - 可以自定义检测次数，如【检测频率 = 5 分钟】，则 3 次检测 = 15 分钟。  

    - 检测次数内无异常事件产生，则产生正常事件。  

    **注意**：触发条件支持配置**紧急、重要、警告**输入值范围为 5～999，若输入值小于 5 则提示调整，避免检测误报。


