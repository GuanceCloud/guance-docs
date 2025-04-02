# Infrastructure Liveness Detection V2
---


Used to monitor the stability of data reporting for key objects in infrastructure (such as HOSTs, CONTAINERS, Pods, etc.). By setting detection conditions and alert levels, it helps promptly identify and address anomalies to ensure stable infrastructure operation.

## Detection Configuration {#config}


### Detection Frequency

The execution frequency of the detection rules.

The system defaults to the following frequencies:

- 5m (default display)
- 15m 
- 30m 
- 1h 
- 6h 
- 12h 
- 24h

It also supports custom input for detection frequency, such as: 20m (20 minutes), 2h (2 hours), 1d (1 day).

???+ warning "Note"

    Since object data reporting updates every 5 minutes, the detection frequency should be greater than 5 minutes and less than 1 day.

### Detection Interval

The time range for querying detection metrics each time a task is executed, influenced by the detection frequency.

You can choose the default interval range provided by the system, with the corresponding relationship between the detection frequency as follows:

| Detection Frequency | Detection Interval | 
| --- | --- | 
| 5m | 5m<br />15m<br />30m<br />1h<br />6h<br />12h<br />24h | 
| 15m | 15m<br />30m<br />1h<br />6h<br />12h<br />24h | 
| 30m | 30m<br />1h<br />6h<br />12h<br />24h | 
| 1h | 1h<br />6h<br />12h<br />24h | 
| 6h | 6h<br />12h<br />24h | 
| 12h | 12h<br />24h | 
| 24h | 24h | 


???+ warning "Note"

    The time range for custom input detection intervals must be ≥ the time range of the detection frequency.

### Detection Metrics

Monitored metric data, covering various types of infrastructure:

1. Infrastructure Types: Includes HOSTs, processes, CONTAINERS, Pods, Services, Deployments, Nodes, ReplicaSets, Jobs, CronJobs;
2. Detection Objects: Supports selecting "all" or "custom" objects;

    - All: Detects all objects within the workspace, judging whether the last update time of the data triggers the threshold.
    - Custom: Limits the scope of infrastructure objects within the detection range using wildcard fuzzy matching or precise matching filtering conditions, judging whether their data's last update time triggers the threshold.

3. Additional Information: After selecting fields, the system performs additional queries, but these are not used for triggering condition judgments.

<!--
| Type | Detection Object | Wildcard Filtering | Fixed Filtering | DQL Query |
| --- | --- | --- | --- | --- | 
| HOST | All HOSTs | / | / | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) by cmdline |
|  | Custom | host: HOST | df_label: label ; os: operating system | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by host |
| Process | All Processes | / | / | O::`HOST`:((now()-last_update_time)/1000 AS `Result`) by host |
|  | Custom | cmdline: command line | host: HOST ; process_name: process name | O::`host_processes`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by cmdline |
| CONTAINER | All CONTAINERS | / | / | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) by container_name |
|  | Custom | container_name: CONTAINER name | host: HOST ; namespace: namespace | O::`docker_containers`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by container_name |
| Pod | All Pods | / | / | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) by pod_name |
|  | Custom | pod_name: Pod name | host: HOST ; namespace: namespace | O::`kubelet_pod`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by pod_name |
| Service | All Services | / | / | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) by service_name |
|  | Custom | pservice_name: Service name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_services`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by service_name |
| Deployment | All Deployments | / | / | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) by deployment_name |
|  | Custom | deployment_name: Deployment name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_deployments`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by deployment_name |
| Node | All Nodes | / | / | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) by node_name |
|  | Custom | node_name: Node name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_nodes`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by node_name |
| ReplicaSet | All ReplicaSets | / | / | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) by replicaset_name |
|  | Custom | replicaset_name: ReplicaSet name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_replica_sets`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by replicaset_name |
| Job | All Jobs | / | / | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) by job_name |
|  | Custom | job_name: Job name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_jobs`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by job_name |
| CronJob | All CronJobs | / | / | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) by cron_job_name |
|  | Custom | cron_job_name: CronJob name | cluster_name_k8s: K8s cluster ; namespace: namespace | O::`kubernetes_cron_jobs`:((now()-last_update_time)/1000 AS `Result`) {filtering conditions} by cron_job_name |
-->

  
### Trigger Conditions

You can set trigger conditions for four alert levels: urgent, important, warning, and normal. Configure multiple trigger conditions and severity levels, any one of which being met will generate an event.

#### Alert Levels

- **Urgent (red), Important (orange), Warning (yellow)**: Based on configuration conditions, judge whether the last update time of the detection object's data triggers an alert.

- **Normal (green)**: After the detection rule takes effect, if abnormal events occur and data returns to normal within a custom number of detections, then a recovery alert event is generated.

> For more details, refer to [Event Level Description](event-level-description.md). 

#### Detection Counts

Based on configured detection counts, the explanation is as follows:

- Each execution of a detection task counts as 1 detection, for example, if the detection frequency is 5 minutes, then 1 detection = 5 minutes.
- You can customize the number of detections, for instance, if the detection frequency is 5 minutes, 3 detections = 15 minutes.
- If no abnormal events occur within the number of detections, then a normal event is generated.  

???+ warning "Note"

    The input value range supported for trigger conditions for urgent, important, and warning levels is 5～999. When the input value is less than 5, adjustments are needed to avoid false alarms during detection.