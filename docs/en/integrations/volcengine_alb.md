---
title: 'Volcengine ALB'
tags: 
  - Volcengine
summary: 'Collect Volcengine ALB Metrics data'
__int_icon: 'icon/volcengine_alb'
dashboard:

  - desc: 'Volcengine ALB built-in views'
    path: 'dashboard/en/volcengine_alb'

monitor:
  - desc: 'Volcengine ALB monitors'
    path: 'monitor/en/volcengine_alb'
---

Collect Volcengine ALB Metrics data

## Configuration {#config}

### Install Func

It is recommended to activate the Guance integration - extension - hosted Func: all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Volcengine AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of ALB cloud resources, we install the corresponding collection script: 「Guance Integration (Volcengine-ALB Collection)」(ID: `guance_volcengine_alb`)

After clicking 【Install】, input the corresponding parameters: Volcengine AK, Volcengine account name, regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】, and it will immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Volcengine ALB monitoring metrics, more metrics can be collected through configuration [Volcengine ALB Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ALB){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `listener_max_conn` | `listener` | Concurrent connections | Count | ResourceID,ListenerID |
| `listener_new_conn` | `listener` | New connections | Count/Second | ResourceID,ListenerID |
| `listener_active_conn` | `listener` | Active connections | Count | ResourceID,ListenerID |
| `listener_inactive_conn` | `listener` | Concurrent connections | Count | ResourceID,ListenerID |
| `listener_lost_conn` | `listener` | Lost connections | Count/Second | ResourceID,ListenerID |
| `listener_in_packets` | `listener` | Incoming packets | Packet/Second | ResourceID,ListenerID |
| `listener_out_packets` | `listener` | Outgoing packets | Packet/Second | ResourceID,ListenerID |
| `listener_in_drop_packets` | `listener` | Incoming dropped packets | Packet/Second | ResourceID,ListenerID |
| `listener_out_drop_packets` | `listener` | Outgoing dropped packets | Packet/Second | ResourceID,ListenerID |
| `listener_in_bytes` | `listener` | Incoming bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_bytes` | `listener` | Outgoing bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_in_drop_bytes` | `listener` | Incoming discarded bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_drop_bytes` | `listener` | Outgoing discarded bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_healthy_rs_count` | `listener` | Healthy backend servers count | Count | ResourceID,ListenerID |
| `listener_unhealthy_rs_count` | `listener` | Unhealthy backend servers count | Count | ResourceID,ListenerID |
| `listener_http_2xx_send_count` | `listener` | Sent 2xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_send_count` | `listener` | Sent 3xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_send_count` | `listener` | Sent 4xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_send_count` | `listener` | Sent 5xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_other_send_count` | `listener` | Sent other status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_404_send_count` | `listener` | Sent 404 status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_502_send_count` | `listener` | Sent 502 status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_2xx_recv_count` | `listener` | Received 2xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_recv_count` | `listener` | Received 3xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_recv_count` | `listener` | Received 4xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_recv_count` | `listener` | Received 5xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_other_recv_count` | `listener` | Received other status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_404_recv_count` | `listener` | Received 404 status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_502_recv_count` | `listener` | Received 502 status codes | Count/Second | ResourceID,ListenerID |
| `listener_qps` | `listener` | QPS | Count/Second | ResourceID,ListenerID |
| `listener_response_time` | `listener` | Average response time | Millisecond | ResourceID,ListenerID |
| `listener_ups_response_time` | `listener` | Average request time | Millisecond | ResourceID,ListenerID |
| `listener_http_500_send_count` | `listener` | Sent 500 status codes | Count/Second | ResourceID |
| `listener_http_503_send_count` | `listener` | Sent 503 status codes | Count/Second | ResourceID |
| `listener_http_504_send_count` | `listener` | Sent 504 status codes | Count/Second | ResourceID |
| `load_balancer_max_conn` | `loadbalancer` | Concurrent connections | Count | ResourceID |
| `load_balancer_new_conn` | `loadbalancer` | New connections | Count | ResourceID |
| `load_balancer_active_conn` | `loadbalancer` | Active connections | Count | ResourceID |
| `load_balancer_inactive_conn` | `loadbalancer` | Inactive connections | Count | ResourceID |
| `load_balancer_lost_conn` | `loadbalancer` | Lost connections | Count/Second | ResourceID |
| `load_balancer_in_packets` | `loadbalancer` | Incoming packets | Packet/Second | ResourceID |
| `load_balancer_out_packets` | `loadbalancer` | Outgoing packets | Packet/Second | ResourceID |
| `load_balancer_in_drop_packets` | `loadbalancer` | Incoming dropped packets | Packet/Second | ResourceID |
| `load_balancer_out_drop_packets` | `loadbalancer` | Outgoing dropped packets | Packet/Second | ResourceID |
| `load_balancer_in_bytes` | `loadbalancer` | Incoming bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_bytes` | `loadbalancer` | Outgoing bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_in_drop_bytes` | `loadbalancer` | Incoming discarded bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_drop_bytes` | `loadbalancer` | Outgoing discarded bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_http_2xx_send_count` | `loadbalancer` | Sent 2xx status codes | Count/Second | ResourceID |
| `load_balancer_http_3xx_send_count` | `loadbalancer` | Sent 3xx status codes | Count/Second | ResourceID |
| `load_balancer_http_4xx_send_count` | `loadbalancer` | Sent 4xx status codes | Count/Second | ResourceID |
| `load_balancer_http_5xx_send_count` | `loadbalancer` | Sent 5xx status codes | Count/Second | ResourceID |
| `load_balancer_http_other_send_count` | `loadbalancer` | Sent other status codes | Count/Second | ResourceID |
| `load_balancer_http_404_send_count` | `loadbalancer` | Sent 404 status codes | Count/Second | ResourceID |
| `load_balancer_http_502_send_count` | `loadbalancer` | Sent 502 status codes | Count/Second | ResourceID |
| `load_balancer_http_2xx_recv_count` | `loadbalancer` | Received 2xx status codes | Count/Second | ResourceID |
| `load_balancer_http_3xx_recv_count` | `loadbalancer` | Received 3xx status codes | Count/Second | ResourceID |
| `load_balancer_http_4xx_recv_count` | `loadbalancer` | Received 4xx status codes | Count/Second | ResourceID |
| `load_balancer_http_5xx_recv_count` | `loadbalancer` | Received 5xx status codes | Count/Second | ResourceID |
| `load_balancer_http_other_recv_count` | `loadbalancer` | Received other status codes | Count/Second | ResourceID |
| `load_balancer_http_404_recv_count` | `loadbalancer` | Received 404 status codes | Count/Second | ResourceID |
| `load_balancer_http_502_recv_count` | `loadbalancer` | Received 502 status codes | Count/Second | ResourceID |
| `load_balancer_qps` | `loadbalancer` | QPS | Count/Second | ResourceID |
| `load_balancer_qps_utilization` | `loadbalancer` | QPS utilization | Count/Second | ResourceID |
| `load_balancer_response_time` | `loadbalancer` | Average response time | Millisecond | ResourceID |
| `load_balancer_ups_response_time` | `loadbalancer` | Average request time | Millisecond | ResourceID |
| `load_balancer_http_500_send_count` | `loadbalancer` | Sent 500 status codes | Count/Second | ResourceID |
| `load_balancer_http_503_send_count` | `loadbalancer` | Sent 503 status codes | Count/Second | ResourceID |
| `load_balancer_http_504_send_count` | `loadbalancer` | Sent 504 status codes | Count/Second | ResourceID |

## Objects {#object}

The object data structure of the collected Volcengine ALB objects can be viewed in 「Infrastructure - Resource Catalog」

``` json
  {
    "measurement": "volcengine_alb",
    "tags": {
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "AccountId"       : "2102598xxxx",
    "LoadBalancerId"  : "LoadBalancerId:alb-3rfdnib02lzpc16nf3olxxxx",
    "LoadBalancerName": "ALB",
    "Type"            : "public",
    "Status"          : "Active"
    },
    "fileds": {
      "Listeners": "[{JSON data}]",
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