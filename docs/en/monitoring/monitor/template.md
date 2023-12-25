# Templates
---


Guance has built-in various ready-to-use monitoring templates, which support creating hosts, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink monitoring, and dozens of other templates with one-click using the + New from Template option. Once the template is successfully created, the corresponding official monitors are automatically added to the current workspace.

**Note**: Before creating a template, you need to [install DataKit ](../datakit/datakit-install.md) on the host and enable the configuration of relevant collectors. Otherwise, the monitor corresponding to the template will not generate alert events.

## Create {#create}

In the **Monitor** section, select **Create from Template** to add a specific official monitoring template to the current space.

You can choose to create any template or create them in bulk. Currently, there are multiple monitoring templates available, which can be used out of the box without manual configuration.

![](img/monitor_sample1.png)

On the creating page, the <u>left side shows all types of monitoring templates, and the right side shows all detection rules under each template type</u>. You can perform the following operations:

- In the left **Filter**, select specific monitors for corresponding filtering.
- You can paginate through all detection rules and use the search bar 🔍 to search by name in real time.
- Select multiple detection rules on the right side, and you can create multiple monitors in batch. After successful creation, you will return to the monitor list. After opening a specific monitor, you can edit the detection rules under the current monitor and save them, which is equivalent to creating a new monitor.

## Template List


| Template (Group) | Monitor |
| --- | --- |
| Host Monitoring Library | Host CPU IOwait too high<br>Host file system has low remaining inodes<br> Host memory Swap usage is too high<br>Host has low remaining disk space<br>Host CPU average load is too high<br>Host memory is less than 100M<br>Host CPU usage is too high<br>Host memory usage is too high |
| Docker Monitoring Library | Docker container CPU usage is too high<br>Docker container memory usage is too high<br>Docker container status check  |
| Elasticsearch Monitoring Library | Elasticsearch average JVM heap memory usage is too high<br>Elasticsearch search query load is abnormal<br>Elasticsearch rejected threads in the merge index thread pool increased abnormally<br> Elasticsearch rejected threads in the translog index thread pool increased abnormally<br>Elasticsearch rejected threads in the search thread pool increased abnormally<br>Elasticsearch rejected threads in the merge thread pool increased abnormally<br> Elasticsearch cluster status is abnormal <br>Elasticsearch average CPU usage is too high<br> Elasticsearch query rejection rate is too high | 
| Redis Monitoring Library | Redis increasing number of client connections waiting for blocked commands |
| Alibaba Cloud RDS MySQL Monitoring Library | Alibaba Cloud RDS MySQL high number of slow queries per second <br> Alibaba Cloud RDS MySQL high disk usage<br>Alibaba Cloud RDS MySQL high IOPS usage<br> Alibaba Cloud RDS MySQL high connection count usage<br> Alibaba Cloud RDS MySQL high memory usage <br> Alibaba Cloud RDS MySQL high CPU usage  |
| Alibaba Cloud SLB Monitoring Library | Alibaba Cloud SLB instance high QPS usage rate <br>Alibaba Cloud SLB backend ECS is abnormal  |
| Alibaba Cloud ECS Monitoring Library | Alibaba Cloud ECS high CPU usage <br> Alibaba Cloud ECS high memory usage <br> Alibaba Cloud ECS high disk usage <br> Alibaba Cloud ECS high Inode usage <br> Alibaba Cloud ECS high CPU load  |
| Alibaba Cloud Elasticsearch Monitoring Library | Alibaba Cloud Elasticsearch instance node high CPU usage<br> Alibaba Cloud Elasticsearch instance node high memory usage <br> Alibaba Cloud Elasticsearch instance node high disk usage <br> Alibaba Cloud Elasticsearch instance node high CPU load <br> Alibaba Cloud Elasticsearch cluster status is abnormal   |
| Alibaba Cloud EIP Monitoring Library | Alibaba Cloud EIP high inbound network bandwidth utilization <br> Alibaba Cloud EIP high outbound network bandwidth utilization   |
| Alibaba Cloud MongoDB Replica Set Monitoring Library | Alibaba Cloud MongoDB (replica set) high CPU usage <br>Alibaba Cloud MongoDB (replica set) high connection count usage <br> Alibaba Cloud MongoDB (replica set) high disk usage <br> Alibaba Cloud MongoDB (replica set) high IOPS usage <br> Alibaba Cloud MongoDB (replica set) high memory usage   |
| Alibaba Cloud Redis Standard Edition Monitoring Library | Alibaba Cloud Redis (standard edition) high CPU usage <br> Alibaba Cloud Redis (standard edition) high memory usage <br> Alibaba Cloud Redis (standard edition) high connection count usage<br> Alibaba Cloud Redis (standard edition) high QPS usage <br> Alibaba Cloud Redis (standard edition) high average response time <br> Alibaba Cloud Redis (standard edition) low hit rate   |
| Flink Monitoring | All buffers in the output buffer pool are full<br> TaskManager is running out of heap memory  |
| Fluentd Monitoring Library | Fluentd plugin has too many retries <br>Available space in the remaining buffer of Fluentd   |
| Aerospike Monitoring Library | Aerospike Storage has insufficient remaining space <br> Aerospike Memory has insufficient remaining space   |
| Kubernetes Monitoring Library | Pod status is abnormal <br> Pod startup timeout failure <br> Pod restarts frequently <br>Job execution failure  |
| Logstash Monitoring Library | Logstash configuration reload failure <br> Logstash pipeline configuration reload failure <br> Logstash high Java heap memory usage   |
| PHP FPM Monitoring Library | PHP-FPM high request waiting queue <br> PHP-FPM excessive maximum limit of processes  |
| Ping Status Monitoring Library | Ping to the monitored address is unreachable <br> Ping to the monitored address has a high packet loss rate <br> Ping to the monitored address has a long response time   |
| Port Monitoring Library | Host port status is abnormal <br> Host port response time is too slow   |
| Procstat Monitoring Library | Host process status is abnormal |
| RocketMQ Monitoring Library | RocketMQ cluster high sending tps <br> RocketMQ cluster low sending tps <br> RocketMQ cluster high consuming tps<br> RocketMQ cluster low consuming tps <br> RocketMQ cluster high consuming delay <br> RocketMQ cluster high message backlog   |
| Tencent Cloud CDB Monitoring Library | Tencent Cloud CDB high CPU usage <br> Tencent Cloud CDB high memory usage<br> Tencent Cloud CDB high disk usage <br> Tencent Cloud CDB high connection count usage <br> Tencent Cloud CDB high master-slave delay time <br> Tencent Cloud CDB Slave IO thread status is abnormal <br> Tencent Cloud CDB Slave SQL thread status is abnormal <br> Tencent Cloud CDB high number of slow queries   |
| Tencent Cloud CLB Private Monitoring Library |  Tencent Cloud CLB Public health check is abnormal <br> Tencent Cloud CLB Public high inbound bandwidth utilization<br> Tencent Cloud CLB Public high outbound bandwidth utilization <br>Tencent Cloud CLB Public Monitoring Library<br> Tencent Cloud CLB Private high inbound bandwidth utilization <br> Tencent Cloud CLB Private high outbound bandwidth utilization <br> Tencent Cloud CLB Private health check is abnormal   |
| Tencent Cloud CVM Monitoring Library | Tencent Cloud CVM high CPU load <br>  Tencent Cloud CVM high CPU usage <br>Tencent Cloud CVM high memory usage <br> Tencent Cloud CVM high disk usage <br> Tencent Cloud CVM high system time deviation  |
| Zookeeper Monitoring Library | Zookeeper high accumulated request count <br> Zookeeper high average response delay <br> Zookeeper server is down   |