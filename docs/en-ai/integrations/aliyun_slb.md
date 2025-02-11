---
title: 'Alibaba Cloud SLB'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud SLB metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc.'
__int_icon: 'icon/aliyun_slb'
dashboard:
  - desc: 'Alibaba Cloud SLB built-in views'
    path: 'dashboard/en/aliyun_slb/'

monitor:
  - desc: 'Alibaba Cloud SLB monitor'
    path: 'monitor/en/aliyun_slb/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SLB
<!-- markdownlint-enable -->


Alibaba Cloud SLB metrics display, including backend ECS instance status, port connection count, QPS, network traffic, status codes, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for SLB cloud resources, we install the corresponding collection script:「Guance Integration (Alibaba Cloud-)」(ID: `guance_aliyun_slb`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.

By default, we collect some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding tasks have the appropriate automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric | **Description** |              Dimensions               | Statistics | **Unit** |
| ---- | :---:    | :----: | ------ | ------ |
| ActiveConnection           |        TCP active connections per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| DropConnection             |       Listener dropped connections per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketRX               |       Listener dropped incoming packets per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropPacketTX               |       Listener dropped outgoing packets per second        |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count/s  |
| DropTrafficRX              |       Listener dropped incoming bits per second       |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| DropTrafficTX              |       Listener dropped outgoing bits per second       |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | bits/s   |
| GroupActiveConnection      |   (Group dimension)TCP active connections per second   |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupNewConnection         |     (Group dimension)TCP new connections     |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| GroupTotalTrafficRX        |         TotalTrafficRX          |                groupId                | Value                       | bits/s   |
| GroupTotalTrafficTX        |         TotalTrafficTX          |                groupId                | Value                       | bits/s   |
| GroupTrafficRX             |       (Group dimension)inbound bandwidth        |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupTrafficTX             |       (Group dimension)outbound bandwidth        |                groupId                | Average,Minimum,Maximum,Sum | bits/s   |
| GroupUnhealthyServerCount  |  (Group dimension)number of unhealthy backend ECS instances  |                groupId                | Average,Maximum,Minimum,Sum | Count    |
| HealthyServerCountWithRule | Number of healthy backend ECS instances after Layer 7 forwarding rules | userId,instanceId,port,vip,domain,url | Average,Maximum,Minimum     | Count    |
| HeathyServerCount          |   Number of healthy backend ECS instances after health checks   |      userId,instanceId,port,vip       | Average,Minimum,Maximum     | Count    |
| InactiveConnection         |         TCP inactive connections         |    userId,instanceId,port,protocol    | Average,Minimum,Maximum     | Count    |
| InstanceActiveConnection   |       Active connections per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropConnection     |       Dropped connections per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum,Sum | Count/s  |
| InstanceDropPacketRX       |       Dropped incoming packets per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropPacketTX       |       Dropped outgoing packets per second for the instance        |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceDropTrafficRX      |       Dropped incoming bits per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceDropTrafficTX      |       Dropped outgoing bits per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | bits/s   |
| InstanceInactiveConnection |      Inactive connections per second for the instance       |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |
| InstanceMaxConnection      |     Maximum concurrent connections per second for the instance      |           userId,instanceId           | Average,Minimum,Maximum     | Count/s  |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed under 「Infrastructure - Custom」

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