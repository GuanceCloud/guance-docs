---
title: 'Alibaba Cloud AnalyticDB PostgreSQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud AnalyticDB PostgreSQL Metrics Display, including CPU, memory, disk, coordination nodes, instance queries, etc.'
__int_icon: 'icon/aliyun_analyticdb_postgresql'
dashboard:
  - desc: 'Alibaba Cloud AnalyticDB PostgreSQL Built-in Views'
    path: 'dashboard/en/aliyun_analyticdb_postgresql/'
monitor:
  - desc: 'Alibaba Cloud AnalyticDB PostgreSQL Monitors'
    path: 'monitor/en/aliyun_analyticdb_postgresql/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud AnalyticDB PostgreSQL
<!-- markdownlint-enable -->


Alibaba Cloud AnalyticDB PostgreSQL metrics display, including CPU, memory, disk, coordination nodes, instance queries, etc.

## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for Alibaba Cloud AnalyticDB PostgreSQL, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-AnalyticDB PostgreSQL Collection)" (ID: `guance_aliyun_analyticdb_postgresql`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately run it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations; for more details, see the metrics section.

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-analyticdb-postgresql/){:target="_blank"}




### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have been configured with automatic triggers. You can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there are asset information entries.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud AnalyticDB PostgreSQL, the default metric sets are as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_hybriddb/gpdb?spm=a2c4g.11186623.0.0.5da976abPs9zNS){:target="_blank"}

| MetricName                   |         MetricCategory         | MetricDescribe                          | Dimensions                                    | Statistics              | Unit  | MinPeriods |
| ---- | :----: | ---- | ---- | ---- | ---- | ---- |
| node_cpu_used_percent        |              `gpdb`              | 【Storage Elastic & Serverless】Node CPU Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s       |
| node_mem_used_percent        |              `gpdb`              | 【Storage Elastic & Serverless】Node Memory Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s    |
| node_disk_used_percent       |              `gpdb`              | 【Storage Elastic & Serverless】Node Disk Usage Rate | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | %     | 60 s        |
| `adbpg_conn_count`             |              `gpdb`              | 【Storage Elastic & Serverless】Total Number of Coordination Node Connections | userId,instanceId,instance_component,hostname | Average,Maximum,Minimum | count | 60 s        |
| `adbpg_master_cnt_unhealth`    |              `gpdb`              | 【Storage Elastic & Serverless】Number of Unhealthy Coordination Nodes | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_blocked`          |              `gpdb`              | 【Storage Elastic & Serverless】Number of Blocked Instance Queries | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |
| `adbpg_query_queued`           |              `gpdb`              | 【Storage Elastic & Serverless】Number of Queued Instance Queries | userId,instanceId                             | Average,Maximum,Minimum | count | 60 s    |



## Objects {#object}

The collected Alibaba Cloud AnalyticDB PostgreSQL object data structure can be viewed from "Infrastructure - Custom"

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