# Official Monitoring Templates Library
---

<<< custom_key.brand_name >>> includes various ready-to-use monitoring templates, supporting one-click creation of monitors for hosts, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, and dozens of other services through the **+ Create from Template** option. After successfully creating a template, the corresponding official monitor is automatically added to the current workspace.

**Note**: Before creating a template, you need to [install DataKit](../../datakit/datakit-install.md) on the host and enable the relevant collectors; otherwise, the monitor will not generate alert events.

## Create a Template {#create}

In **Monitors**, select **+ Create from Template** to add the specified official monitoring template to the current space.

You can choose to create any single template or create multiple templates in bulk. A wide variety of monitoring templates are available, requiring no manual configuration and are ready-to-use out-of-the-box.

![](../img/monitoring-0725.png)

On the **+ Create from Template** page, <u>the left side lists all template types, while the right side shows all detection rules under each template type</u>. You can perform the following actions:

- In the **Template Library** on the left, check specific libraries to filter templates;
- You can paginate through all detection rules and use the 🔍 search bar to search by name in real-time;
- Select multiple detection rules on the right to create multiple monitors in bulk. After successful creation, return to the monitors list. Clicking on a specific monitor allows you to edit the detection rules within that monitor, and saving changes will create a new monitor.

![](../img/0710-template.gif)

## Template List

| **Template (Group)** | **Monitor** |
| --- | --- |
| Host Detection Library | Host CPU IOwait too high<br>Host file system remaining inode too low<br>Host memory Swap usage too high<br>Host remaining disk space too low<br>Host average CPU load too high<br>Host memory less than 100M<br>Host CPU usage too high<br>Host memory usage too high |
| Docker Detection Library | Docker container CPU usage too high<br>Docker container memory usage too high<Docker container status detection> |
| Elasticsearch Detection Library | Elasticsearch average JVM heap memory usage too high<br>Elasticsearch search query load anomaly<br>Elasticsearch merge index thread pool rejected threads abnormally increased<br>Elasticsearch transform index thread pool rejected threads abnormally increased<br>Elasticsearch search thread pool rejected threads abnormally increased<br>Elasticsearch merge thread pool rejected threads abnormally increased<br>Elasticsearch cluster status anomaly<br>Elasticsearch average CPU usage too high<br>Elasticsearch query rejection rate too high |
| Redis Detection Library | Number of Redis clients waiting for blocking commands abnormally increased |
| Alibaba Cloud RDS MySQL Detection Library | Alibaba Cloud RDS MySQL slow queries per second too high<br>Alibaba Cloud RDS MySQL disk usage too high<br>Alibaba Cloud RDS MySQL IOPS usage too high<br>Alibaba Cloud RDS MySQL connection usage too high<br>Alibaba Cloud RDS MySQL memory usage too high<br>Alibaba Cloud RDS MySQL CPU usage too high |
| Alibaba Cloud SLB Detection Library | Alibaba Cloud SLB instance QPS usage too high<br>Alibaba Cloud SLB backend ECS anomaly |
| Alibaba Cloud ECS Detection Library | Alibaba Cloud ECS CPU usage too high<br>Alibaba Cloud ECS memory usage too high<br>Alibaba Cloud ECS disk usage too high<br>Alibaba Cloud ECS inode usage too high<br>Alibaba Cloud ECS CPU load too high |
| Alibaba Cloud Elasticsearch Detection Library | Alibaba Cloud Elasticsearch instance node CPU usage too high<br>Alibaba Cloud Elasticsearch instance node memory usage too high<br>Alibaba Cloud Elasticsearch instance node disk usage too high<br>Alibaba Cloud Elasticsearch instance node CPU load too high<br>Alibaba Cloud Elasticsearch cluster status anomaly |
| Alibaba Cloud EIP Detection Library | Alibaba Cloud EIP inbound bandwidth utilization too high<br>Alibaba Cloud EIP outbound bandwidth utilization too high |
| Alibaba Cloud MongoDB Replica Set Detection Library | Alibaba Cloud MongoDB (Replica Set) CPU usage too high<br>Alibaba Cloud MongoDB (Replica Set) connection usage too high<br>Alibaba Cloud MongoDB (Replica Set) disk usage too high<br>Alibaba Cloud MongoDB (Replica Set) IOPS usage too high<br>Alibaba Cloud MongoDB (Replica Set) memory usage too high |
| Alibaba Cloud Redis Standard Edition Detection Library | Alibaba Cloud Redis (Standard Edition) CPU usage too high<br>Alibaba Cloud Redis (Standard Edition) memory usage too high<br>Alibaba Cloud Redis (Standard Edition) connection usage too high<br>Alibaba Cloud Redis (Standard Edition) QPS usage too high<br>Alibaba Cloud Redis (Standard Edition) average response time too high<br>Alibaba Cloud Redis (Standard Edition) hit rate too low |
| Flink Monitoring | All buffers in output buffer pool are full<br>TaskManager heap memory insufficient |
| Fluentd Detection Library | Too many retries for Fluentd plugin<br>Available space in Fluentd remaining buffer |
| Aerospike Detection Library | Insufficient remaining space in Aerospike Storage<br>Insufficient remaining space in Aerospike Memory |
| Kubernetes Detection Library | Pod status anomaly<br>Pod startup timeout failure<br>Pod frequent restarts<br>Job execution failure |
| Logstash Detection Library | Logstash configuration reload failure<br>Logstash Pipeline configuration reload failure<br>Logstash Java heap memory usage too high |
| PHP FPM Detection Library | PHP-FPM request wait queue too high<br>PHP-FPM process maximum limit exceeded |
| Ping Status Detection Library | Ping address unreachable<br>Ping address packet loss rate too high<br>Ping address response time too long |
| Port Detection Library | Host port status anomaly<br>Host port response time too slow |
| Procstat Detection Library | Host process status anomaly |
| RocketMQ Detection Library | RocketMQ cluster send TPS too high<br>RocketMQ cluster send TPS too low<br>RocketMQ cluster consume TPS too high<br>RocketMQ cluster consume TPS too low<br>RocketMQ cluster consume delay too high<br>RocketMQ cluster consume backlog too high |
| Tencent Cloud CDB Detection Library | Tencent Cloud CDB CPU usage too high<br>Tencent Cloud CDB memory usage too high<br>Tencent Cloud CDB disk usage too high<br>Tencent Cloud CDB connection usage too high<br>Tencent Cloud CDB master-slave delay time too high<br>Tencent Cloud CDB Slave IO thread status anomaly<br>Tencent Cloud CDB Slave SQL thread status anomaly<br>Tencent Cloud CDB slow queries too high |
| Tencent Cloud CLB Private Detection Library | Tencent Cloud CLB Public health check anomaly<br>Tencent Cloud CLB Public inbound bandwidth utilization too high<br>Tencent Cloud CLB Public outbound bandwidth utilization too high |
| Tencent Cloud CLB Public Detection Library | Tencent Cloud CLB Private inbound bandwidth utilization too high<br>Tencent Cloud CLB Private outbound bandwidth utilization too high<br>Tencent Cloud CLB Private health check anomaly |
| Tencent Cloud CVM Detection Library | Tencent Cloud CVM CPU load too high<br>Tencent Cloud CVM CPU usage too high<br>Tencent Cloud CVM memory usage too high<br>Tencent Cloud CVM disk usage too high<br>Tencent Cloud CVM system time deviation too high |
| Zookeeper Detection Library | Excessive pending requests in Zookeeper<br>Zookeeper average response delay too high<br>Zookeeper server downtime |

---

Please ensure you have installed DataKit on your host and configured the necessary collectors before creating templates, as this is essential for generating alerts.