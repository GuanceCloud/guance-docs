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

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of SLB cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-)」(ID: `guance_aliyun_slb`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

We have collected some configurations by default, see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has the corresponding automatic trigger configuration. You can check the corresponding task records and logs to ensure there are no anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | **Description** |              Dimensions               | Statistics | **Unit** |
| ---- | :---:    | :----: | ------ | ------ |
| ActiveConnection           |        Number of active TCP connections per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| DropConnection             |       Number of dropped connections per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketRX               |       Number of lost inbound packets per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketTX               |       Number of lost outbound packets per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropTrafficRX              |       Number of lost inbound bits per second       |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| DropTrafficTX              |       Number of lost outbound bits per second       |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| GroupActiveConnection      |   (Group dimension)Number of active TCP connections per second   |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupNewConnection         |     (Group dimension)TCP new connections     |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupTotalTrafficRX        |         TotalTrafficRX          |                groupId                | Value                       | bits/s   |
| GroupTotalTrafficTX        |         TotalTrafficTX          |                groupId                | Value                       | bits/s   |
| GroupTrafficRX             |       (Group dimension)Inbound bandwidth        |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupTrafficTX             |       (Group dimension)Outbound bandwidth        |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupUnhealthyServerCount  |  (Group dimension)Number of unhealthy backend ECS instances  |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| HealthyServerCountWithRule | Number of healthy backend ECS instances for Layer 7 forwarding rules | userId,instanceId,port,vip,domain,url | Average,Maximum,Minimum     | Count    |
| HeathyServerCount          |   Number of healthy backend ECS instances after health checks   |      userId,instanceId,port,vip       | Average,Minimum,Maximum     | Count    |
| InactiveConnection         |         Number of inactive TCP connections         |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| InstanceActiveConnection   |       Number of active connections per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropConnection     |       Number of dropped connections per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum,Sum | Count/s  |
| InstanceDropPacketRX       |       Number of lost inbound packets per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropPacketTX       |       Number of lost outbound packets per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropTrafficRX      |       Number of lost inbound bits per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceDropTrafficTX      |       Number of lost outbound bits per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceInactiveConnection |      Number of inactive connections per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceMaxConnection      |     Maximum concurrent connections per second for the instance      |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |

## Objects {#object}

The structure of collected Alibaba Cloud SLB object data can be viewed in 「Infrastructure - Custom」

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
