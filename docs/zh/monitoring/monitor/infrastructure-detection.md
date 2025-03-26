# 基础设施存活检测 V2
---


用于监控基础设施中关键对象（如主机、容器、Pod 等）数据上报的稳定性。通过设置检测条件和告警级别，及时发现并处理异常，确保基础设施稳定运行。

## 检测配置 {#config}


### 检测频率

检测规则的执行频率。

系统默认包含以下频率：

- 5m（默认显示）
- 15m 
- 30m 
- 1h 
- 6h 
- 12h 
- 24h

同时支持自定义输入检测频率，格式如：20m（20 分钟）、2h（2 小时）、1d（1 天）。

???+ warning "注意"

    由于对象数据上报每 5 分钟更新一次，因此检测频率应大于 5 分钟且小于 1 天。

### 检测区间

每次执行任务时，检测指标查询的时间范围，受检测频率影响。

可选择系统默认的区间范围，与检测频率之间的对应关系如下：

| 检测频率 | 检测区间 | 
| --- | --- | 
| 5m | 5m<br />15m<br />30m<br />1h<br />6h<br />12h<br />24h | 
| 15m | 15m<br />30m<br />1h<br />6h<br />12h<br />24h | 
| 30m | 30m<br />1h<br />6h<br />12h<br />24h | 
| 1h | 1h<br />6h<br />12h<br />24h | 
| 6h | 6h<br />12h<br />24h | 
| 12h | 12h<br />24h | 
| 24h | 24h | 


???+ warning "注意"

    自定义输入检测区间的时间范围需 ≥ 检测频率的时间范围。

### 检测指标

监控的指标数据，涵盖多种基础设施类型：

1. 基础设施类型：包含主机、进程、容器、Pod、Service、Deployment、Node、ReplicaSet、Job、CronJob；
2. 检测对象：支持选择“所有”或“自定义”对象；

    - 全部：针对工作空间内所有对象进行检测，判断数据的最后上报更新时间是否触发阈值。
    - 自定义：通过 wildcard 模糊匹配或精准匹配的筛选条件，限定检测范围内的基础设施对象，判断其数据的最后上报更新时间是否触发阈值。

3. 附加信息：选定字段后，系统会做额外查询，但不用于触发条件判断。

<!--
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
-->

  
### 触发条件

可设置紧急、重要、警告、正常四个告警级别的触发条件。配置多个触发条件及严重程度，任一满足即产生事件。

#### 告警级别

- **紧急（红色）、重要（橙色）、警告（黄色）**：基于配置条件判断检测对象数据的最后上报更新时间是否触发告警。

- **正常（绿色）**：检测规则生效后，产生异常事件后，在自定义检测次数内数据恢复正常，则产生恢复告警事件。

> 更多详情，可参考 [事件等级说明](event-level-description.md)。 

#### 检测次数

基于配置的检测次数，说明如下：

- 每执行一次检测任务即为 1 次检测，如检测频率为 5 分钟，则 1 次检测 = 5 分钟。
- 可自定义检测次数，如检测频率为 5 分钟，3 次检测 = 15 分钟。
- 检测次数内无异常事件产生，则产生正常事件。  

???+ warning "注意"

    触发条件支持配置紧急、重要、警告的输入值范围为 5～999，输入值小于 5 时需调整，以避免检测误报。


