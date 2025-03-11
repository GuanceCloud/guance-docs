---
title: 'VolcEngine ALB'
tags: 
  - VolcEngine
summary: 'Collect VolcEngine ALB Metrics Data'
__int_icon: 'icon/volcengine_alb'
dashboard:

  - desc: 'VolcEngine ALB Built-in Views'
    path: 'dashboard/en/volcengine_alb'

monitor:
  - desc: 'VolcEngine ALB Monitor'
    path: 'monitor/en/volcengine_alb'
---

Collect VolcEngine ALB Metrics Data

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extensions - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a qualified VolcEngine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize ALB cloud resource monitoring data, install the corresponding collection script: "Guance Integration (VolcEngine-ALB Collection)" (ID: `guance_volcengine_alb`)

After clicking 【Install】, enter the corresponding parameters: VolcEngine AK, VolcEngine account name, regions.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」 that the corresponding task has an automatic trigger configuration. You can also view the task records and logs to check for any anomalies.
2. In the Guance platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

Configure VolcEngine ALB monitoring metrics. You can collect more metrics through configuration [VolcEngine ALB Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ALB){:target="_blank"}

| `MetricName` | `Subnamespace` | Metric Name | Metric Unit | Dimension |
| ----------- |---------------| :----: |:--------: |:-------: |
| `listener_max_conn` | `listener` | Concurrent Connections | Count | ResourceID, ListenerID |
| `listener_new_conn` | `listener` | New Connections | Count/Second | ResourceID, ListenerID |
| `listener_active_conn` | `listener` | Active Connections | Count | ResourceID, ListenerID |
| `listener_inactive_conn` | `listener` | Inactive Connections | Count | ResourceID, ListenerID |
| `listener_lost_conn` | `listener` | Lost Connections | Count/Second | ResourceID, ListenerID |
| `listener_in_packets` | `listener` | Incoming Packets | Packet/Second | ResourceID, ListenerID |
| `listener_out_packets` | `listener` | Outgoing Packets | Packet/Second | ResourceID, ListenerID |
| `listener_in_drop_packets` | `listener` | Dropped Incoming Packets | Packet/Second | ResourceID, ListenerID |
| `listener_out_drop_packets` | `listener` | Dropped Outgoing Packets | Packet/Second | ResourceID, ListenerID |
| `listener_in_bytes` | `listener` | Incoming Bandwidth | Bits/Second(SI) | ResourceID, ListenerID |
| `listener_out_bytes` | `listener` | Outgoing Bandwidth | Bits/Second(SI) | ResourceID, ListenerID |
| `listener_in_drop_bytes` | `listener` | Dropped Incoming Bandwidth | Bits/Second(SI) | ResourceID, ListenerID |
| `listener_out_drop_bytes` | `listener` | Dropped Outgoing Bandwidth | Bits/Second(SI) | ResourceID, ListenerID |
| `listener_healthy_rs_count` | `listener` | Healthy Backend Servers | Count | ResourceID, ListenerID |
| `listener_unhealthy_rs_count` | `listener` | Unhealthy Backend Servers | Count | ResourceID, ListenerID |
| `listener_http_2xx_send_count` | `listener` | Sent 2xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_3xx_send_count` | `listener` | Sent 3xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_4xx_send_count` | `listener` | Sent 4xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_5xx_send_count` | `listener` | Sent 5xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_other_send_count` | `listener` | Sent Other Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_404_send_count` | `listener` | Sent 404 Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_502_send_count` | `listener` | Sent 502 Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_2xx_recv_count` | `listener` | Received 2xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_3xx_recv_count` | `listener` | Received 3xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_4xx_recv_count` | `listener` | Received 4xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_5xx_recv_count` | `listener` | Received 5xx Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_other_recv_count` | `listener` | Received Other Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_404_recv_count` | `listener` | Received 404 Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_http_502_recv_count` | `listener` | Received 502 Status Codes | Count/Second | ResourceID, ListenerID |
| `listener_qps` | `listener` | QPS | Count/Second | ResourceID, ListenerID |
| `listener_response_time` | `listener` | Average Response Time | Millisecond | ResourceID, ListenerID |
| `listener_ups_response_time` | `listener` | Average Request Time | Millisecond | ResourceID, ListenerID |
| `listener_http_500_send_count` | `listener` | Sent 500 Status Codes | Count/Second | ResourceID |
| `listener_http_503_send_count` | `listener` | Sent 503 Status Codes | Count/Second | ResourceID |
| `listener_http_504_send_count` | `listener` | Sent 504 Status Codes | Count/Second | ResourceID |
| `load_balancer_max_conn` | `loadbalancer` | Concurrent Connections | Count | ResourceID |
| `load_balancer_new_conn` | `loadbalancer` | New Connections | Count | ResourceID |
| `load_balancer_active_conn` | `loadbalancer` | Active Connections | Count | ResourceID |
| `load_balancer_inactive_conn` | `loadbalancer` | Inactive Connections | Count | ResourceID |
| `load_balancer_lost_conn` | `loadbalancer` | Lost Connections | Count/Second | ResourceID |
| `load_balancer_in_packets` | `loadbalancer` | Incoming Packets | Packet/Second | ResourceID |
| `load_balancer_out_packets` | `loadbalancer` | Outgoing Packets | Packet/Second | ResourceID |
| `load_balancer_in_drop_packets` | `loadbalancer` | Dropped Incoming Packets | Packet/Second | ResourceID |
| `load_balancer_out_drop_packets` | `loadbalancer` | Dropped Outgoing Packets | Packet/Second | ResourceID |
| `load_balancer_in_bytes` | `loadbalancer` | Incoming Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_bytes` | `loadbalancer` | Outgoing Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_in_drop_bytes` | `loadbalancer` | Dropped Incoming Bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_drop_bytes` | `loadbalancer` | Dropped Outgoing Bandwidth | Bits/Second(SI) | ResourceID |
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
| `load_balancer_http_500_send_count` | `loadbalancer` | Sent 500 Status Codes | Count/Second | ResourceID |
| `load_balancer_http_503_send_count` | `loadbalancer` | Sent 503 Status Codes | Count/Second | ResourceID |
| `load_balancer_http_504_send_count` | `loadbalancer` | Sent 504 Status Codes | Count/Second | ResourceID |

## Object {#object}

The structure of collected VolcEngine ALB object data can be seen in 「Infrastructure - Resource Catalog」

``` json
{
  "measurement": "volcengine_alb",
  "tags": {
    "RegionId": "cn-guangzhou",
    "ProjectName": "default",
    "AccountId": "2102598xxxx",
    "LoadBalancerId": "LoadBalancerId:alb-3rfdnib02lzpc16nf3olxxxx",
    "LoadBalancerName": "ALB",
    "Type": "public",
    "Status": "Active"
  },
  "fields": {
    "Listeners": "[{JSON Data}]",
    "VpcId": "vpc-11vrlrg75588w40yrhbxxxx",
    "EniAddress": "172.31.0.xx",
    "EipAddress": "118.145.xxx.170",
    "LoadBalancerBillingType": "2",
    "Description": "xxxxxx",
    "CreateTime": "2024-12-12T02:43:11Z",
    "UpdateTime": "2024-12-12T06:33:36Z",
    "ExpiredTime": "xxxxxxxx",
    "Tags": "[]"
  }
}
```
