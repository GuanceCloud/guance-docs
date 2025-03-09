# Infrastructure Liveness Detection V2
---

You can set conditions based on infrastructure object data to monitor the reporting stability of critical objects, including hosts, containers, Pods, Deployments, and Nodes. This ensures timely detection and handling of anomalies.

## Detection Configuration {#config}

![](../img/monitor18.png)

### Detection Frequency

This is the execution frequency of the detection rules; the default is 5 minutes.

### Detection Interval

This is the time range for querying detection metrics each time a task is executed. Depending on the detection frequency, selectable intervals will vary.

### Detection Metrics

These are the monitored metric data.

:material-numeric-1-circle-outline: Infrastructure Type: Includes host, process, container, Pod, Service, Deployment, Node, ReplicaSet, Job, CronJob;

| Type | Detection Object | Wildcard Filtering | Fixed Filtering | DQL Query |
| --- | --- | --- | --- | --- |
| Host | All hosts | / | / | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) by cmdline |
|  | Custom | host: host | df_label: label ; os: operating system | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by host |
| Process | All processes | / | / | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) by host |
|  | Custom | cmdline: command line | host: host ; process_name: process name | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by cmdline |
| Container | All containers | / | / | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) by container_name |
|  | Custom | container_name: container name | host: host ; namespace: namespace | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by container_name |
| Pod | All Pods | / | / | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) by pod_name |
|  | Custom | pod_name: Pod name | host: host ; namespace: namespace | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by pod_name |
| Service | All Services | / | / | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) by service_name |
|  | Custom | service_name: Service name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by service_name |
| Deployment | All Deployments | / | / | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) by deployment_name |
|  | Custom | deployment_name: Deployment name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by deployment_name |
| Node | All Nodes | / | / | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) by node_name |
|  | Custom | node_name: Node name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by node_name |
| ReplicaSet | All ReplicaSets | / | / | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) by replicaset_name |
|  | Custom | replicaset_name: ReplicaSet name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by replicaset_name |
| Job | All Jobs | / | / | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) by job_name |
|  | Custom | job_name: Job name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by job_name |
| CronJob | All CronJobs | / | / | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) by cron_job_name |
|  | Custom | cron_job_name: CronJob name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) {filter conditions} by cron_job_name |

:material-numeric-2-circle-outline: Detection Object: Supports selecting **all** or **custom**;

| Detection Object | Description |
| --- | --- |
| All | Evaluates whether the last update time of all objects within the workspace has triggered the threshold. |
| Custom | Retrieves the scope of objects to be detected through wildcard matching or precise filtering conditions, evaluating whether the last update time of the selected infrastructure objects has triggered the threshold. |

:material-numeric-3-circle-outline: Additional Information: After selecting fields, the system performs additional queries but does not use them for condition triggering. These fields can be configured in event notifications. If multiple matches are detected, one event record is returned randomly.

### Trigger Conditions

You can set trigger conditions for critical, major, minor, and normal alert levels. Configuring multiple trigger conditions and severity levels, an event is generated if any of the queried values meet the trigger conditions.

> For more details, refer to [Event Level Description](event-level-description.md).

???+ abstract "Alert Levels"

    1. **Critical (Red), Major (Orange), Minor (Yellow) Alert Levels**: Based on the configuration, it evaluates whether the last update time of the detected object data has triggered an alert.

    2. **Normal (Green) Alert Level**: After the detection rule takes effect, if critical, major, or minor anomaly events occur, and the data returns to normal within the custom detection count, a recovery alert event is generated.

    Based on the configured detection count, the following applies:

    - Each execution of a detection task counts as 1 detection, e.g., if the **Detection Frequency = 5 minutes**, then 1 detection = 5 minutes.
    - You can customize the detection count, e.g., if the **Detection Frequency = 5 minutes**, then 3 detections = 15 minutes.
    - If no anomaly events occur within the detection count, a normal event is generated.

    **Note**: The input value range for trigger conditions for **critical, major, minor** levels is 5～999. If the input value is less than 5, a prompt will appear to adjust the value to avoid false alarms.