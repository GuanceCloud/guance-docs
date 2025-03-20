---
title: 'Volcengine CLB'
tags: 
  - Volcengine
summary: 'Collect Volcengine CLB Metrics data'
__int_icon: 'icon/volcengine_clb'
dashboard:

  - desc: 'Volcengine CLB built-in views'
    path: 'dashboard/en/volcengine_clb'

monitor:
  - desc: 'Volcengine CLB monitors'
    path: 'monitor/en/volcengine_clb'
---

Collect Volcengine CLB Metrics data

## Configuration {#config}

### Install Func

It is recommended to activate Guance integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of CLB cloud resources, we install the corresponding collection script: "Guance Integration (Volcengine-CLB Collection)" (ID: `guance_volcengine_clb`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK, Volcengine account name, Regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Volcengine CLB monitoring metrics. You can collect more metrics through configuration [Volcengine CLB Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_CLB){:target="_blank"}

|`MetricName` |`Subnamespace` | Metric Name | MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `listener_max_conn` | `listener` | Concurrent Connections | Count | ResourceID,ListenerID |
| `listener_new_conn` | `listener` | New Connections | Count/Second | ResourceID,ListenerID |
| `listener_active_conn` | `listener` | Active Connections | Count | ResourceID,ListenerID |
| `listener_inactive_conn` | `listener` | Concurrent Connections | Count | ResourceID,ListenerID |
| `listener_lost_conn` | `listener` | Lost Connections | Count/Second | ResourceID,ListenerID |
| `listener_in_packets` | `listener` | Incoming Packets | Packet/Second | ResourceID,ListenerID |
| `listener_out_packets` | `listener` | Outgoing Packets | Packet/Second | ResourceID,ListenerID |
| `listener_in_drop_packets` | `listener` | Incoming Dropped Packets | Packet/Second | ResourceID,ListenerID |
| `listener_out_drop_packets` | `listener` | Outgoing Dropped Packets | Packet/Second | ResourceID,ListenerID |
| `listener_in_bytes` | `listener` | Incoming Bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_bytes` | `listener` | Outgoing Bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_in_drop_bytes` | `listener` | Incoming Dropped Bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_drop_bytes` | `listener` | Outgoing Dropped Bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_healthy_rs_count` | `listener` | Healthy Backend Servers | Count | ResourceID,ListenerID |
| `listener_unhealthy_rs_count` | `listener` | Unhealthy Backend Servers | Count | ResourceID,ListenerID |
| `listener_http_2xx_send_count` | `listener` | Sent 2xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_send_count` | `listener` | Sent 3xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_send_count` | `listener` | Sent 4xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_send_count` | `listener` | Sent 5xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_other_send_count` | `listener` | Sent Other Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_404_send_count` | `listener` | Sent 404 Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_502_send_count` | `listener` | Sent 502 Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_2xx_recv_count` | `listener` | Received 2xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_recv_count` | `listener` | Received 3xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_recv_count` | `listener` | Received 4xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_recv_count` | `listener` | Received 5xx Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_other_recv_count` | `listener` | Received Other Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_404_recv_count` | `listener` | Received 404 Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_http_502_recv_count` | `listener` | Received 502 Status Codes | Count/Second | ResourceID,ListenerID |
| `listener_qps` | `listener` | QPS | Count/Second | ResourceID,ListenerID |
| `listener_response_time` | `listener` | Average Response Time | Millisecond | ResourceID,ListenerID |
| `load_balancer_max_conn` | `loadbalancer` | Concurrent Connections | Count | ResourceID |
| `load_balancer_new_conn` | `loadbalancer` | New Connections | Count | ResourceID |
| `load_balancer_active_conn` | `loadbalancer` | Active Connections | Count | ResourceID |
| `load_balancer_inactive_conn` | `loadbalancer` | Inactive Connections | Count | ResourceID |
| `load_balancer_lost_conn` | `loadbalancer` | Lost Connections | Count/Second | ResourceID |
| `load_balancer_max_conn_utilization` | `loadbalancer` | Maximum Connection Utilization | Percent | ResourceID |
| `load_balancer_new_conn_utilization` | `loadbalancer` | New Connection Utilization | Percent | ResourceID |
| `load_balancer_in_packets` | `loadbalancer` | Incoming Packets | Packet/Second | ResourceID |
| `load_balancer_out_packets` | `loadbalancer` | Outgoing Packets | Packet/Second | ResourceID |
| `load_balancer_in_drop_packets` | `loadbalancer` | Incoming Dropped Packets | Packet/Second | ResourceID |
| `load_balancer_out_drop_packets` | `loadbalancer` | Outgoing Dropped Packets | Packet/Second | ResourceID |
| `load_balancer_in_bytes` | `loadbalancer` | Incoming Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_bytes` | `loadbalancer` | Outgoing Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_in_drop_bytes` | `loadbalancer` | Incoming Dropped Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_drop_bytes` | `loadbalancer` | Outgoing Dropped Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_http_2xx_send_count` | `loadbalancer` | Sent 2xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_3xx_send_count` | `loadbalancer` | Sent 3xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_4xx_send_count` | `loadbalancer` | Sent 4xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_5xx_send_count` | `loadbalancer` | Sent 5xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_other_send_count` | `loadbalancer` | Sent Other Status Codes | Count/Second | ResourceID |
| `load_balancer_http_404_send_count` | `loadbalancer` | Sent 404 Status Codes | Count/Second | ResourceID |
| `load_balancer_http_502_send_count` | `loadbalancer` | Sent 502 Status Codes | Count/Second | ResourceID |
| `load_balancer_http_2xx_recv_count` | `loadbalancer` | Received 2xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_3xx_recv_count` | `loadbalancer` | Received 3xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_4xx_recv_count` | `loadbalancer` | Received 4xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_5xx_recv_count` | `loadbalancer` | Received 5xx Status Codes | Count/Second | ResourceID |
| `load_balancer_http_other_recv_count` | `loadbalancer` | Received Other Status Codes | Count/Second | ResourceID |
| `load_balancer_http_404_recv_count` | `loadbalancer` | Received 404 Status Codes | Count/Second | ResourceID |
| `load_balancer_http_502_recv_count` | `loadbalancer` | Received 502 Status Codes | Count/Second | ResourceID |
| `load_balancer_qps` | `loadbalancer` | QPS | Count/Second | ResourceID |
| `load_balancer_qps_utilization` | `loadbalancer` | QPS Utilization | Count/Second | ResourceID |
| `load_balancer_response_time` | `loadbalancer` | Average Response Time | Millisecond | ResourceID |
| `load_balancer_ups_response_time` | `loadbalancer` | Average Request Time | Millisecond | ResourceID |
| `load_balnacer_in_out_bandwidth_utilization` | `loadbalancer` | In/Out Bandwidth Utilization | Percent | ResourceID |

## Objects {#object}

The collected Volcengine CLB object data structure can be viewed in "Infrastructure - Resource Catalog".

``` json
  {
    "measurement": "volcengine_clb",
    "tags": {
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "AccountId"       : "2102598xxxx",
    "LoadBalancerId"  : "LoadBalancerId:clb-3rfdnib02lzpc16nf3olxxxx",
    "LoadBalancerName": "CLB",
    "Type"            : "public",
    "Status"          : "Active"
    },
    "fileds": {
      "Listeners": "[{JSON data}]",
      "MasterZoneId": "cn-guangzhou-b",
      "SlaveZoneId": "cn-guangzhou-a",
      "VpcId": "vpc-11vrlrg75588w40yrhbxxxx",
      "EniAddress": "172.31.0.xx",
      "EipAddress": "118.145.xxx.170",
      "LoadBalancerBillingType": "2",
      "LoadBalancerSpec": "small_1",
      "Description": "xxxxxx",
      "CreateTime": "2024-12-11T02:43:11Z",
      "UpdateTime": "2024-12-11T06:33:36Z",
      "ExpiredTime": "xxxxxxxx",
      "Tags": "[]"
    }
  }

```