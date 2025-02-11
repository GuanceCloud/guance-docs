# Official Monitoring Templates Library
---

Guance provides a variety of ready-to-use monitoring templates, supporting one-click creation of monitoring for hosts, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, and dozens of other services through **+ Create from Template**. After successfully creating a template, the corresponding official monitors are automatically added to the current workspace.

**Note**: Before creating a template, you need to [install DataKit](../../datakit/datakit-install.md) on the host and enable the relevant collectors; otherwise, the monitors associated with the template will not generate alert events.

## Creating Templates {#create}

In **Monitors**, select **+ Create from Template** to add specified official monitoring templates to the current space.

You can choose to create any individual template or create multiple templates in bulk. A wide range of monitoring templates are available without manual configuration, ready-to-use out-of-the-box.

![](../img/monitoring-0725.png)

On the **+ Create from Template** page, <u>the left side lists all template types, while the right side shows all detection rules under each template type</u>. You can perform the following actions:

- In the **Detection Library** on the left, check specific libraries to filter by type;
- You can browse detection rules page by page and use the 🔍 search bar to enter names for real-time searching;
- Select multiple detection rules on the right to batch-create multiple monitors. After successful creation, return to the monitor list. Click to open a specific monitor, and you can edit the detection rules within that monitor. Saving changes is equivalent to creating a new monitor.

![](../img/0710-template.gif)

## Template List

| **Template (Group)** | **Monitor** |
| --- | --- |
| Host Detection Library | Host CPU IOwait too high<br>Host file system remaining inode too low<br>Host memory Swap usage too high<br>Host remaining disk space too low<br>Host average CPU load too high<br>Host memory less than 100M<br>Host CPU usage too high<br>Host memory usage too high |
| Docker Detection Library | Docker container CPU usage too high<br>Docker container memory usage too high<br>Docker container status detection |
| Elasticsearch Detection Library | Elasticsearch average JVM heap memory usage too high<br>Elasticsearch search query load anomaly<br>Elasticsearch index merge thread pool rejected threads increase abnormally<br>Elasticsearch index conversion thread pool rejected threads increase abnormally<br>Elasticsearch search thread pool rejected threads increase abnormally<br>Elasticsearch merge thread pool rejected threads increase abnormally<br>Elasticsearch cluster status anomaly<br>Elasticsearch average CPU usage too high<br>Elasticsearch query rejection rate too high |
| Redis Detection Library | Number of client connections waiting for blocking commands in Redis increases abnormally |
| Alibaba Cloud RDS MySQL Detection Library | Alibaba Cloud RDS MySQL slow queries per second too high<br>Alibaba Cloud RDS MySQL disk usage too high<br>Alibaba Cloud RDS MySQL IOPS usage too high<br>Alibaba Cloud RDS MySQL connection usage too high<br>Alibaba Cloud RDS MySQL memory usage too high<br>Alibaba Cloud RDS MySQL CPU usage too high |
| Alibaba Cloud SLB Detection Library | Alibaba Cloud SLB instance QPS usage too high<br>Alibaba Cloud SLB backend ECS anomaly |
| Alibaba Cloud ECS Detection Library | Alibaba Cloud ECS CPU usage too high<br>Alibaba Cloud ECS memory usage too high<br>Alibaba Cloud ECS disk usage too high<br>Alibaba Cloud ECS inode usage too high<br>Alibaba Cloud ECS CPU load too high |
| Alibaba Cloud Elasticsearch Detection Library | Alibaba Cloud Elasticsearch instance node CPU usage too high<br>Alibaba Cloud Elasticsearch instance node memory usage too high<br>Alibaba Cloud Elasticsearch instance node disk usage too high<br>Alibaba Cloud Elasticsearch instance node CPU load too high<br>Alibaba Cloud Elasticsearch cluster status anomaly |
| Alibaba Cloud EIP Detection Library | Alibaba Cloud EIP inbound bandwidth utilization too high<br>Alibaba Cloud EIP outbound bandwidth utilization too high |
| Alibaba Cloud MongoDB Replica Set Detection Library | Alibaba Cloud MongoDB (replica set) CPU usage too high<br>Alibaba Cloud MongoDB (replica set) connection usage too high<br>Alibaba Cloud MongoDB (replica set) disk usage too high<br>Alibaba Cloud MongoDB (replica set) IOPS usage too high<br>Alibaba Cloud MongoDB (replica set) memory usage too high |
| Alibaba Cloud Redis Standard Edition Detection Library | Alibaba Cloud Redis (standard edition) CPU usage too high<br>Alibaba Cloud Redis (standard edition) memory usage too high<br>Alibaba Cloud Redis (standard edition) connection usage too high<br>Alibaba Cloud Redis (standard edition) QPS usage too high<br>Alibaba Cloud Redis (standard edition) average response time too high<br>Alibaba Cloud Redis (standard edition) hit rate too low |
| Flink Monitoring | All buffers in the output buffer pool are full<br>TaskManager heap memory insufficient |
| Fluentd Detection Library | Too many retries for Fluentd plugins<br>Available space in Fluentd's remaining buffer |
| Aerospike Detection Library | Insufficient remaining space in Aerospike storage<br>Insufficient remaining space in Aerospike memory |
| Kubernetes Detection Library | Pod status anomaly<br>Pod startup timeout failure<br>Frequent Pod restarts<br>Job execution failure |
| Logstash Detection Library | Logstash configuration reload failure<br>Logstash Pipeline configuration reload failure<br>Logstash Java heap memory usage too high |
| PHP FPM Detection Library | PHP-FPM request queue too high<br>PHP-FPM process maximum limit exceeded |
| Ping Status Detection Library | Address ping unreachable<br>Address ping packet loss rate too high<br>Address ping response time too long |
| Port Detection Library | Host port status anomaly<br>Host port response time too slow |
| Procstat Detection Library | Host process status anomaly |
| RocketMQ Detection Library | RocketMQ cluster send TPS too high<br>RocketMQ cluster send TPS too low<br>RocketMQ cluster consume TPS too high<br>RocketMQ cluster consume TPS too low<br>RocketMQ cluster consume delay too high<br>RocketMQ cluster consume backlog too high |
| Tencent Cloud CDB Detection Library | Tencent Cloud CDB CPU usage too high<br>Tencent Cloud CDB memory usage too high<br>Tencent Cloud CDB disk usage too high<br>Tencent Cloud CDB connection usage too high<br>Tencent Cloud CDB master-slave delay too high<br>Tencent Cloud CDB Slave IO thread status anomaly<br>Tencent Cloud CDB Slave SQL thread status anomaly<br>Tencent Cloud CDB slow queries too high |
| Tencent Cloud CLB Private Detection Library | Tencent Cloud CLB Public health check anomaly<br>Tencent Cloud CLB Public inbound bandwidth utilization too high<br>Tencent Cloud CLB Public outbound bandwidth utilization too high |
| Tencent Cloud CLB Public Detection Library | Tencent Cloud CLB Private inbound bandwidth utilization too high<br>Tencent Cloud CLB Private outbound bandwidth utilization too high<br>Tencent Cloud CLB Private health check anomaly |
| Tencent Cloud CVM Detection Library | Tencent Cloud CVM CPU load too high<br>Tencent Cloud CVM CPU usage too high<br>Tencent Cloud CVM memory usage too high<br>Tencent Cloud CVM disk usage too high<br>Tencent Cloud CVM system time deviation too high |
| Zookeeper Detection Library | Excessive pending requests in Zookeeper<br>Average response delay in Zookeeper too high<br>Zookeeper server downtime |

---

This document outlines the various monitoring templates provided by Guance, detailing the specific checks and alerts for different services and platforms.