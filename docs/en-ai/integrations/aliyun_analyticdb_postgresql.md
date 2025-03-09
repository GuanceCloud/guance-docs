---
title: 'Alibaba Cloud AnalyticDB PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud AnalyticDB PostgreSQL Metrics display, including CPU, memory, disk, coordinator node, instance queries, etc.'
__int_icon: 'icon/aliyun_analyticdb_postgresql'
dashboard:
  - desc: 'Alibaba Cloud AnalyticDB PostgreSQL built-in views'
    path: 'dashboard/en/aliyun_analyticdb_postgresql/'
monitor:
  - desc: 'Alibaba Cloud AnalyticDB PostgreSQL monitor'
    path: 'monitor/en/aliyun_analyticdb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud AnalyticDB PostgreSQL
<!-- markdownlint-enable -->


Alibaba Cloud AnalyticDB PostgreSQL Metrics display, including CPU, memory, disk, coordinator node, instance queries, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud AnalyticDB PostgreSQL, install the corresponding collection script: 「Guance Integration (Alibaba Cloud-AnalyticDB PostgreSQL Collection)」(ID: `guance_aliyun_analyticdb_postgresql`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

We collect some default configurations; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-analyticdb-postgresql/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding automatic trigger configuration exists for the task. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud AnalyticDB PostgreSQL, the default Metrics set is as follows. You can collect more Metrics through configuration. [Alibaba Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_hybriddb/gpdb?spm=a2c4g.11186623.0.0.5da976abPs9zNS){:target="_blank"}

| MetricName                   |         MetricCategory         | MetricDescription                          | Dimensions                                    | Statistics              | Unit  | MinPeriods |
| ---- | :----: | ---- | ---- | ---- | ---- | ---- |
| node_cpu_used_percent        |              `gpdb`              | 【Storage Elastic & Serverless】Node CPU Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s       |
| node_mem_used_percent        |              `gpdb`              | 【Storage Elastic & Serverless】Node Memory Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s    |
| node_disk_used_percent       |              `gpdb`              | 【Storage Elastic & Serverless】Node Disk Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s        |
| `adbpg_conn_count`             |              `gpdb`              | 【Storage Elastic & Serverless】Coordinator Node Total Connections | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | count | 60 s        |
| `adbpg_master_cnt_unhealth`    |              `gpdb`              | 【Storage Elastic & Serverless】Coordinator Node Unhealthy Count | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_blocked`          |              `gpdb`              | 【Storage Elastic & Serverless】Instance Blocked Query Count | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_queued`           |              `gpdb`              | 【Storage Elastic & Serverless】Instance Queued Query Count | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |



## Objects {#object}

The collected Alibaba Cloud AnalyticDB PostgreSQL object data structure can be viewed in 「Infrastructure - Custom」.

```json
{
  "measurement": "aliyun_analyticdb_postgresql",
  "tags": {
    "DBInstanceCategory"        : "Basic",
    "DBInstanceId"              : "gp-bp17993xt44lmgyga",
    "DBInstanceMode"            : "StorageElastic",
    "DBInstanceNetType"         : "2",
    "DBInstanceStatus"          : "CREATING",
    "Engine"                    : "gpdb",
    "EngineVersion"             : "6.0",
    "InstanceDeployType"        : "cluster",
    "InstanceNetworkType"       : "VPC",
    "LockMode"                  : "Unlock",
    "LockReason"                : "0",
    "PayType"                   : "Postpaid",
    "RegionId"                  : "cn-hangzhou",
    "ResourceGroupId"           : "rg-acfmv3ro3xnfwaa",
    "StorageType"               : "cloud_essd",
    "VSwitchId"                 : "vsw-bp1k8o6a4cb1pnq6ximgb",
    "VpcId"                     : "vpc-bp1pftfpllxna4t75e73v",
    "ZoneId"                    : "cn-hangzhou-j",
    "name"                      : "gp-bp17993xt44lmgyga"
  },
  "fields": {
    "CreateTime"            : "2023-08-16T03:07:45Z",
    "DBInstanceDescription" : "gp-bp17993xt44lmgyga",
    "ExpireTime"            : "2999-09-08T16:00:00Z",
    "MasterNodeNum"         : 1,
    "SegNodeNum"            : "2",
    "StorageSize"           : "50",
    "message"               : "{instance json data}}",
  }
}

```