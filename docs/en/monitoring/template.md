# Template
---

## Overview

A variety of out-of-the-box monitoring templates are built into the observation cloud, and dozens of templates such as host, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB and Flink monitoring can be created with one click of "+ New from Template". After successfully creating a new template, the corresponding official monitor will be automatically added to the current workspace.

???+ attention

    Before creating a new template, you need to [install DataKit ](../datakit/datakit-install.md) on the host, and turn on the relevant collector for configuration, otherwise the monitor corresponding to the template cannot generate alarm events.

## New Template

In "Monitor", select "+ New from Template" to add the specified official monitoring template to the current space. At present, it supports host, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB and Flink monitoring templates, which need not be configured manually and can be used out of the box.

![](img/monitor_sample1.png)

## Template List

Guance has provided official monitoring templates, including host, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink monitoring templates and so on.

| **Templates (grouping)** | **Monitor** |
| --- | --- |
| Host detection library | Host CPU IOwait too high<br>The remaining index nodes of the host file system are too low<br>Host memory Swap usage is too high<br>Low remaining disk space on the host<br>Host CPU average load is too high<br>Host memory is less than 100M<br>Host CPU utilization is too high<br>Host memory usage is too high |
| Docker Detection library |Docker container CPU overutilization<br>Docker Container Memory Utilization <Docker Container Status Detection> |
| Elasticsearch Detection library | Elasticsearch Average JVM Heap Memory Usage Excessive <br> Elasticsearch Search Query Load Exception <br> Elasticsearch Merge Index Thread Pool Denied Threads Exception Increase <br> Elasticsearch Convert Index Thread Pool Denied Threads Exception Increase <br> Elasticsearch Merge Thread Pool Denied Threads Exception Increase <br> Elasticsearch Cluster State Exception <br> Elasticsearch Average CPU Usage rate is too high <br> Elasticsearch query rejection rate is too high |
| Redis Detection library | The number of client connections waiting for the blocking command by Redis increased abnormally |
| Alibaba Cloud RDS Mysql Detection library | Alibaba Cloud RDS Mysql Slow Queries Too High <br> Alibaba Cloud RDS Mysql Disk Usage Too High <br> Alibaba Cloud RDS Mysql IOPS Utilization Too High <br> Alibaba Cloud RDS Mysql Connection Utilization Too High <br> Alibaba Cloud RDS Mysql Memory Utilization Too High <br> Alibaba Cloud RDS Mysql CPU Utilization Too High |
| Alibaba Cloud SLB Detection library |Alibaba Cloud SLB Instance QPS Overutilization <br> Alibaba Cloud SLB Backend ECS Exception |
| Alibaba Cloud ECS Detection library | Alibaba Cloud ECS CPU Overutilization <br> Alibaba Cloud ECS Memory Overutilization <br> Alibaba Cloud ECS Disk Overutilization <br> Alibaba Cloud ECS Inode Overutilization <br> Alibaba Cloud ECS CPU Overload |
| Alibaba Cloud Elasticsearch Detection library | Alibaba Cloud Elasticsearch Instance Node CPU Overutilization <br> Alibaba Cloud Elasticsearch Instance Node Memory Overutilization <br> Alibaba Cloud Elasticsearch Instance Node Disk Overutilization <br> Alibaba Cloud Elasticsearch Instance Node CPU Overload <br> Alibaba Cloud Elasticsearch Cluster State Exception |
| Alibaba Cloud EIP Detection library | The inbound bandwidth utilization of Alibaba Cloud EIP network is too high <br> The outbound bandwidth utilization of Alibaba Cloud EIP network is too high |
| Alibaba Cloud MongoDB replica set detection library | Alibaba Cloud MongoDB (Replica Set) CPU Overutilization <br> Alibaba Cloud MongoDB (Replica Set) Connection Overutilization <br> Alibaba Cloud MongoDB (Replica Set) Disk Overutilization <br> Alibaba Cloud MongoDB (Replica Set) IOPS Overutilization <br> Alibaba Cloud MongoDB (Replica Set) Memory Overutilization |
| Alibaba Cloud Redis standard version test library | Alibaba Cloud Redis (Standard Edition) CPU Overutilization<br>Alibaba Cloud Redis (Standard Edition) memory usage is too high<br>Overuse of Alibaba Cloud Redis (Standard Edition) Connections<br>Alibaba Cloud Redis (Standard Edition) QPS Overutilization<br>Average response time of Alibaba Cloud Redis (Standard Edition) is too high<br>Alibaba Cloud Redis (Standard Edition) hits too low |
| Flink monitoring | All buffers in the output buffer pool are full <br> TaskManager is out of heap memory |
| Fluentd Detection library |Fluentd has too many plugin retries <br> Free space for Fluentd's remaining buffer |
| Aerospike Detection library | Not enough space left in Aerospike space Storage <br> Not enough space left in Aerospike space Memory |
| Kubernetes Detection library | Pod state exception <br> Pod startup timeout failure <br> Pod frequent restart <br> Job execution failure |
| Logstash Detection library | Logstash configuration reload failed <br> Logstash Pipeline configuration reload failed <br> Logstash Java heap memory usage is too high |
| PHP FPM Detection library | PHP-FPM request waiting queue is too high <br> PHP-FPM process maximum number of times is too high |
| Ping state detection library |Detect address Ping impassable <br> Detect address Ping too high packet loss rate <br> Detect address Ping too long response time|
| Port Detection library | Host port status exception <br> Host port response time is too slow |
| Procstat Detection library | Host process state exception |
| RocketMQ Detection library | RocketMQ cluster sends tps too high <br> RocketMQ cluster sends tps too low <br> RocketMQ cluster consumes tps too high <br> RocketMQ cluster consumes tps too low <br> RocketMQ cluster consumes latency too high <br> RocketMQ cluster consumes stack too high <br> RocketMQ cluster consumes|
| Tencent Cloud CDB Detection library | Tencent Cloud CDB CPU utilization rate is too high <br> Tencent Cloud CDB memory utilization rate is too high <br> Tencent Cloud CDB disk utilization rate is too high <br> Tencent Cloud CDB connection number utilization rate is too high <br> Tencent Cloud CDB master-slave delay time is too high <br> Tencent Cloud CDB Slave IO thread state is abnormal <br> Tencent Cloud CDB Slave SQL thread state is abnormal <br> Tencent Cloud CDB Slave SQL thread state is abnormal <br> Tencent Cloud CDB slow query number is too high |
| Tencent Cloud CLB Private Detection library | Tencent Cloud CLB Public Health Check Abnormal <br> Tencent Cloud CLB Public Incoming Bandwidth Utilization Too High <br> Tencent Cloud CLB Public Outgoing Bandwidth Utilization Too High |
| Tencent Cloud CLB Public Detection library | Tengxun CLB Private incoming bandwidth utilization is too high <br> Tengxun CLB Private outgoing bandwidth utilization is too high <br> Tengxun CLB Private health check is abnormal |
| Tencent Cloud CVM Detection library |Tengxunyun CVM CPU overload <br> Tengxunyun CVM CPU overutilization <br> Tengxunyun CVM memory overutilization <br> Tengxunyun CVM disk overutilization <br> Tengxunyun CVM system time deviation is too high |
| Zookeeper Detection library | Zookeeper stacked requests too large<br>Zookeeper average response latency too high<br>Zookeeper server down |