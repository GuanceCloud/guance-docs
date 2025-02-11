# Infrastructure Liveness Detection V2
---

You can set conditions based on infrastructure object data to monitor the reporting stability of critical objects, including hosts, containers, Pods, Deployments, and Nodes. This ensures timely detection and handling of anomalies.

## Detection Configuration {#config}

![](../img/monitor18.png)

### Detection Frequency

This is the execution frequency of the detection rule; the default is 5 minutes.

### Detection Interval

This is the time range for querying detection metrics each time the task is executed. Depending on the detection frequency, the available detection intervals may vary.

### Detection Metrics

These are the monitored metric data.

:material-numeric-1-circle-outline: Infrastructure Type: Includes host, process, container, Pod, Service, Deployment, Node, ReplicaSet, Job, CronJob;

| Type | Detection Object | Wildcard Filtering | Fixed Filtering | DQL Query |
| --- | --- | --- | --- | --- |
| Host | All Hosts | / | / | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) by cmdline |
|  | Custom | host: Host | df_label: Label ; os: Operating System | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by host |
| Process | All Processes | / | / | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) by host |
|  | Custom | cmdline: Command Line | host: Host ; process_name: Process Name | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by cmdline |
| Container | All Containers | / | / | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) by container_name |
|  | Custom | container_name: Container Name | host: Host ; namespace: Namespace | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by container_name |
| Pod | All Pods | / | / | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) by pod_name |
|  | Custom | pod_name: Pod Name | host: Host ; namespace: Namespace | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by pod_name |
| Service | All Services | / | / | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) by service_name |
|  | Custom | service_name: Service Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by service_name |
| Deployment | All Deployments | / | / | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) by deployment_name |
|  | Custom | deployment_name: Deployment Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by deployment_name |
| Node | All Nodes | / | / | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) by node_name |
|  | Custom | node_name: Node Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by node_name |
| ReplicaSet | All ReplicaSets | / | / | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) by replicaset_name |
|  | Custom | replicaset_name: ReplicaSet Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by replicaset_name |
| Job | All Jobs | / | / | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) by job_name |
|  | Custom | job_name: Job Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by job_name |
| CronJob | All CronJobs | / | / | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) by cron_job_name |
|  | Custom | cron_job_name: CronJob Name | cluster_name_k8s: K8s Cluster ; namespace: Namespace | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) {filter condition} by cron_job_name |

:material-numeric-2-circle-outline: Detection Object: Supports selecting **all** or **custom**;

| Detection Object | Description |
| --- | --- |
| All | It evaluates whether the last update time of the object data in the workspace has triggered a threshold. |
| Custom | It retrieves the scope that needs to be detected through wildcard fuzzy matching or precise filtering conditions, then evaluates whether the last update time of the selected infrastructure object's data has triggered a threshold. |

:material-numeric-3-circle-outline: Additional Information: After selecting fields, the system will perform additional queries but will not use them to determine triggering conditions. These fields can be configured in event notifications. If multiple matching values are detected, one event information record will be returned randomly.

### Trigger Conditions

You can set trigger conditions for emergency, critical, warning, and normal alert levels. Multiple trigger conditions and severity levels can be configured. An event is generated if any of the queried results meet the trigger conditions.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

	1. **Alert Levels Emergency (Red), Critical (Orange), Warning (Yellow)**: Based on the configuration, it determines whether the last update time of the object data has triggered an alert.

    2. **Alert Level Normal (Green)**: After the detection rule takes effect, if an emergency, critical, or warning anomaly event occurs, and within the configured custom detection count, the data detection result returns to normal, a recovery alert event is generated.

    Based on the configured detection count, as follows:

    - Each execution of a detection task counts as 1 detection. For example, if the detection frequency is 5 minutes, then 1 detection = 5 minutes.
    - The detection count can be customized. For example, if the detection frequency is 5 minutes, then 3 detections = 15 minutes.
    - If no abnormal events occur within the detection count, a normal event is generated.

    **Note**: The trigger conditions support configuring **emergency, critical, warning** input value ranges from 5 to 999. If the input value is less than 5, a prompt will appear to adjust the value to avoid false positives.