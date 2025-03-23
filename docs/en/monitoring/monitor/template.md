# Official Monitor Template Library
---


<<< custom_key.brand_name >>> provides a variety of ready-to-use monitoring templates, supporting one-click creation for HOST, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, and dozens of other monitoring templates. After creating a new template, the corresponding official monitors will be automatically added to the current workspace.

**Note**: Before creating a new template, you need to [install DataKit](../../datakit/datakit-install.md) on the host and enable the relevant collectors; otherwise, the monitors corresponding to the template will not generate alert events.

## Create Template {#create}

![](../img/monitor_template.png)

On the monitor page, select **Create from Template** to add the specified official monitoring template. You can choose to create a single or batch of templates without manual configuration, allowing quick deployment.

On the left are all monitoring template types, and on the right are all detection rules under the template type. On this page, you can perform the following actions:

- Select specific detection libraries in the **Detection Library** on the left for filtering;
- Paginate through detection rules or input a name in the search bar for real-time searching;
- Multi-select detection rules on the right to batch-create monitors;
- After successful creation, return to the monitor list, click to open a specific monitor, and then edit the detection rules and save.



<!--
## Template List

| **Template (Group)** | **Monitors** |
| --- | --- |
| HOST Detection Library | Host CPU IOwait too high<br>Host file system remaining inode too low<br>Host memory Swap usage too high<br>Host remaining disk space too low<br>Host CPU average load too high<br>Host memory less than 100M<br>Host CPU usage too high<br>Host memory usage too high |
| Docker Detection Library | Docker container CPU usage too high<br>Docker container memory usage too high<Docker container status detection> |
| Elasticsearch Detection Library | Elasticsearch average JVM heap memory usage too high<br>Elasticsearch search query load anomaly<br>Elasticsearch merge index thread pool rejected threads abnormally increasing<br>Elasticsearch transform index thread pool rejected threads abnormally increasing<br>Elasticsearch search thread pool rejected threads abnormally increasing<br>Elasticsearch merge thread pool rejected threads abnormally increasing<br>Elasticsearch cluster status anomaly<br>Elasticsearch average CPU usage too high<br>Elasticsearch query rejection rate too high |
| Redis Detection Library | Redis waiting blocked command client connections abnormally increasing |
| Alibaba Cloud RDS Mysql Detection Library | Alibaba Cloud RDS Mysql slow queries per second too high<br>Alibaba Cloud RDS Mysql disk usage too high<br>Alibaba Cloud RDS Mysql IOPS usage too high<br>Alibaba Cloud RDS Mysql connection usage too high<br>Alibaba Cloud RDS Mysql memory usage too high<br>Alibaba Cloud RDS Mysql CPU usage too high |
| Alibaba Cloud SLB Detection Library | Alibaba Cloud SLB instance QPS usage too high<br>Alibaba Cloud SLB backend ECS abnormal |
| Alibaba Cloud ECS Detection Library | Alibaba Cloud ECS CPU usage too high<br>Alibaba Cloud ECS memory usage too high<br>Alibaba Cloud ECS disk usage too high<br>Alibaba Cloud ECS Inode usage too high<br>Alibaba Cloud ECS CPU load too high |
| Alibaba Cloud Elasticsearch Detection Library | Alibaba Cloud Elasticsearch instance node CPU usage too high<br>Alibaba Cloud Elasticsearch instance node memory usage too high<br>Alibaba Cloud Elasticsearch instance node disk usage too high<br>Alibaba Cloud Elasticsearch instance node CPU load too high<br>Alibaba Cloud Elasticsearch cluster status anomaly |
| Alibaba Cloud EIP Detection Library | Alibaba Cloud EIP network inbound bandwidth utilization too high<br>Alibaba Cloud EIP network outbound bandwidth utilization too high |
| Alibaba Cloud MongoDB Replica Set Detection Library | Alibaba Cloud MongoDB (Replica Set) CPU usage too high<br>Alibaba Cloud MongoDB (Replica Set) connection usage too high<br>Alibaba Cloud MongoDB (Replica Set) disk usage too high<br>Alibaba Cloud MongoDB (Replica Set) IOPS usage too high<br>Alibaba Cloud MongoDB (Replica Set) memory usage too high |
| Alibaba Cloud Redis Standard Edition Detection Library | Alibaba Cloud Redis (Standard Edition) CPU usage too high<br>Alibaba Cloud Redis (Standard Edition) memory usage too high<br>Alibaba Cloud Redis (Standard Edition) connection usage too high<br>Alibaba Cloud Redis (Standard Edition) QPS usage too high<br>Alibaba Cloud Redis (Standard Edition) average response time too high<br>Alibaba Cloud Redis (Standard Edition) hit rate too low |
| Flink Monitoring | All buffers in output buffer pool are full<br>TaskManager heap memory insufficient |
| Fluentd Detection Library | Too many retries of Fluentd plugin<br>Available space of Fluentd remaining buffer |
| Aerospike Detection Library | Aerospike Storage space remaining insufficient<br>Aerospike Memory space remaining insufficient |
| Kubernetes Detection Library | Pod status abnormal<br>Pod startup timeout failure<br>Pod frequent restarts<br>Job execution failure |
| Logstash Detection Library | Logstash configuration reload failed<br>Logstash Pipeline configuration reload failed<br>Logstash Java heap memory usage too high |
| PHP FPM Detection Library | PHP-FPM request queue too high<br>PHP-FPM process maximum limit exceeded |
| Ping Status Detection Library | Detected address Ping unreachable<br>Detected address Ping packet loss rate too high<br>Detected address Ping response time too long |
| Port Detection Library | Host port status abnormal<br>Host port response time too slow |
| Procstat Detection Library | Host process status abnormal |
| RocketMQ Detection Library | RocketMQ cluster send tps too high<br>RocketMQ cluster send tps too low<br>RocketMQ cluster consume tps too high<br>RocketMQ cluster consume tps too low<br>RocketMQ cluster consume delay too high<br>RocketMQ cluster consume backlog too high |
| Tencent Cloud CDB Detection Library | Tencent Cloud CDB CPU usage too high<br>Tencent Cloud CDB memory usage too high<br>Tencent Cloud CDB disk usage too high<br>Tencent Cloud CDB connection usage too high<br>Tencent Cloud CDB master-slave delay time too high<br>Tencent Cloud CDB Slave IO thread status anomaly<br>Tencent Cloud CDB Slave SQL thread status anomaly<br>Tencent Cloud CDB slow query count too high |
| Tencent Cloud CLB Private Detection Library | Tencent Cloud CLB Public health check anomaly<br>Tencent Cloud CLB Public inbound bandwidth utilization too high<br>Tencent Cloud CLB Public outbound bandwidth utilization too high |
| Tencent Cloud CLB Public Detection Library | Tencent Cloud CLB Private inbound bandwidth utilization too high<br>Tencent Cloud CLB Private outbound bandwidth utilization too high<br>Tencent Cloud CLB Private health check anomaly |
| Tencent Cloud CVM Detection Library | Tencent Cloud CVM CPU load too high<br>Tencent Cloud CVM CPU usage too high<br>Tencent Cloud CVM memory usage too high<br>Tencent Cloud CVM disk usage too high<br>Tencent Cloud CVM system time deviation too high |
| Zookeeper Detection Library | Zookeeper accumulated requests too large<br>Zookeeper average response delay too high<br>Zookeeper server down |

-->