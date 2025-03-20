---
title: 'Alibaba Cloud SLB'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud SLB Metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc.'
__int_icon: 'icon/aliyun_slb'
dashboard:
  - desc: 'Alibaba Cloud SLB built-in views'
    path: 'dashboard/en/aliyun_slb/'

monitor:
  - desc: 'Alibaba Cloud SLB monitors'
    path: 'monitor/en/aliyun_slb/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SLB
<!-- markdownlint-enable -->


Alibaba Cloud SLB Metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc.

## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of SLB cloud resources, we install the corresponding collection script: 「<<< custom_key.brand_name >>> Integration (Alibaba Cloud-)」(ID: `guance_aliyun_slb`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After it is enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations; for more details, see the metrics section.


[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | **Description** |              Dimensions               | Statistics | **Unit** |
| ---- | :---:    | :----: | ------ | ------ |
| ActiveConnection           |        TCP active connections per second       |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| DropConnection             |       Listener dropped connections per second   |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketRX               |       Listener dropped inbound packets per second |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketTX               |       Listener dropped outbound packets per second |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropTrafficRX              |       Listener dropped inbound bits per second   |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| DropTrafficTX              |       Listener dropped outbound bits per second   |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| GroupActiveConnection      |   (Group dimension) TCP active connections per second |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupNewConnection         |     (Group dimension) TCP new connections       |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupTotalTrafficRX        |         TotalTrafficRX                         |                groupId                | Value                       | bits/s   |
| GroupTotalTrafficTX        |         TotalTrafficTX                         |                groupId                | Value                       | bits/s   |
| GroupTrafficRX             |       (Group dimension) Inbound bandwidth       |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupTrafficTX             |       (Group dimension) Outbound bandwidth      |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupUnhealthyServerCount  |  (Group dimension) Number of unhealthy ECS instances |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| HealthyServerCountWithRule | Number of healthy ECS instances after layer seven forwarding rules | userId,instanceId,port,vip,domain,url | Average,Maximum,Minimum     | Count    |
| HeathyServerCount          |   Number of healthy ECS instances after health checks |      userId,instanceId,port,vip       | Average,Minimum,Maximum     | Count    |
| InactiveConnection         |         TCP inactive connections               |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| InstanceActiveConnection   |       Instance active connections per second    |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropConnection     |       Instance dropped connections per second    |           userId,instanceId           | Average,Minimum,Maximum,Sum | Count/s  |
| InstanceDropPacketRX       |       Instance dropped inbound packets per second |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropPacketTX       |       Instance dropped outbound packets per second |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropTrafficRX      |       Instance dropped inbound bits per second   |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceDropTrafficTX      |       Instance dropped outbound bits per second   |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceInactiveConnection |      Instance inactive connections per second     |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceMaxConnection      |     Instance maximum concurrent connections per second |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed under "Infrastructure - Custom".

```json
{
  "measurement": "aliyun_slb",
  "tags": {
    "name"              : "lb.xxxxxxxx",
    "LoadBalancerId"    : "lb.xxxxxxxxx",
    "RegionId"          : "cn-shanghai",
    "SlaveZoneId"       : "cn-shanghai-i",
    "MasterZoneId"      : "cn-shanghai",
    "Address"           : "172.xxx.xxx.xxx",
    "PayType"           : "PayOnDemand",
    "InternetChargeType": "paybytraffic",
    "LoadBalancerName"  : "Business System",
    "LoadBalancerStatus": "active",
    "AutoReleaseTime"   : "1513947075000",
    "RenewalStatus"     : "AutoRenewal",
    "AddressType"       : "Internet",
    "NetworkType"       : "vpc",
},
  "fields": {
    "CreateTime"              : "2020-11-18T08:47:11Z",
    "ListenerPortsAndProtocol": "{Listener Port JSON Data}",
    "ServerHealthStatus"      : "{Instance Health Status JSON Data}",
    "ServerCertificates"      : "{Certificate Information JSON Data}",
    "Bandwidth"               : "5120",
    "EndTimeStamp"            : "32493801600000",
    "message"                 : "{Instance JSON Data}",
  }
}
```