---
title: 'Volcengine ALB'
tags: 
  - Volcengine
summary: 'Collect ALB metrics data of Volcengine'
__int_icon: 'icon/volcengine_alb'
dashboard:

  - desc: 'Volcengine ALB Built in View'
    path: 'dashboard/en/volcengine_alb'

monitor:
  - desc: 'Volcengine ALB Monitor'
    path: 'monitor/en/volcengine_alb'
---

Collect ALB metrics data of Volcengine

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ALB cloud resources, we install the corresponding collection script：「Guance Integration（Volcengine ALB Collect）」(ID：`guance_volcengine_alb`)

Click【Install】and enter the corresponding parameters: Volcenine AK, Volcenine account name, Volcenine regions.

Tap 【Deploy startup Script】, The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task. In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric  {#metric}

Configure the Volcengine ALB monitoring metric to collect more metrics through configuration [Volcengine ALB metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ALB){:target="_blank"}

|`MetricName` |`Subnamespace` | MetricName |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `listener_max_conn` | `listener` | Number of concurrent connections | Count | ResourceID,ListenerID |
| `listener_new_conn` | `listener` | Number of New Connections | Count/Second | ResourceID,ListenerID |
| `listener_active_conn` | `listener` | Number of active connections | Count | ResourceID,ListenerID |
| `listener_inactive_conn` | `listener` | Number of concurrent connections | Count | ResourceID,ListenerID |
| `listener_lost_conn` | `listener` | Number of lost connections | Count/Second | ResourceID,ListenerID |
| `listener_in_packets` | `listener` | Number of incoming data packets | Packet/Second | ResourceID,ListenerID |
| `listener_out_packets` | `listener` | Number of outbound data packets | Packet/Second | ResourceID,ListenerID |
| `listener_in_drop_packets` | `listener` | Number of incoming packet losses | Packet/Second | ResourceID,ListenerID |
| `listener_out_drop_packets` | `listener` | Number of outbound packet losses | Packet/Second | ResourceID,ListenerID |
| `listener_in_bytes` | `listener` | Entering direction bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_bytes` | `listener` | Output bandwidth | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_in_drop_bytes` | `listener` | Discard bandwidth in the incoming direction | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_drop_bytes` | `listener` | Discard bandwidth in the outgoing direction | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_healthy_rs_count` | `listener` | Number of healthy backend servers | Count | ResourceID,ListenerID |
| `listener_unhealthy_rs_count` | `listener` | Number of backend server exceptions | Count | ResourceID,ListenerID |
| `listener_http_2xx_send_count` | `listener` | 2xx status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_send_count` | `listener` | 3xx status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_send_count` | `listener` | 4xx status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_send_count` | `listener` | 5xx status code sent| Count/Second | ResourceID,ListenerID |
| `listener_http_other_send_count` | `listener` | other status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_404_send_count` | `listener` | 404 status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_502_send_count` | `listener` | 502 status code sent | Count/Second | ResourceID,ListenerID |
| `listener_http_2xx_recv_count` | `listener` | Received 2xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_recv_count` | `listener` | Received 3xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_recv_count` | `listener` | Received 4xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_recv_count` | `listener` | Received 5xx status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_other_recv_count` | `listener` | Received other status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_404_recv_count` | `listener` | Received 404 status codes | Count/Second | ResourceID,ListenerID |
| `listener_http_502_recv_count` | `listener` | Received 502 status codes | Count/Second | ResourceID,ListenerID |
| `listener_qps` | `listener` | QPS | Count/Second | ResourceID,ListenerID |
| `listener_response_time` | `listener` | Average response time | Millisecond | ResourceID,ListenerID |
| `listener_http_500_send_count` | `listener` | 500 status code sent | Count/Second | ResourceID |
| `listener_http_503_send_count` | `listener` | 503 status code sent | Count/Second | ResourceID |
| `listener_http_504_send_count` | `listener` | 504 status code sent | Count/Second | ResourceID |
| `load_balancer_max_conn` | `loadbalancer` | Number of concurrent connections | Count | ResourceID |
| `load_balancer_new_conn` | `loadbalancer` | Number of New Connections | Count | ResourceID |
| `load_balancer_active_conn` | `loadbalancer` | Number of active connections | Count | ResourceID |
| `load_balancer_inactive_conn` | `loadbalancer` | Number of inactive connections | Count | ResourceID |
| `load_balancer_lost_conn` | `loadbalancer` | Number of lost connections | Count/Second | ResourceID |
| `load_balancer_in_packets` | `loadbalancer` | Number of incoming data packets | Packet/Second | ResourceID |
| `load_balancer_out_packets` | `loadbalancer` | Number of outbound data packets | Packet/Second | ResourceID |
| `load_balancer_in_drop_packets` | `loadbalancer` | Number of incoming packet losses | Packet/Second | ResourceID |
| `load_balancer_out_drop_packets` | `loadbalancer` | Number of outbound packet losses | Packet/Second | ResourceID |
| `load_balancer_in_bytes` | `loadbalancer` | Entering direction bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_out_bytes` | `loadbalancer` | Output bandwidth | Bits/Second(SI) | ResourceID |
| `load_balancer_in_drop_bytes` | `loadbalancer` | Discard bandwidth in the incoming direction | Bits/Second(SI) | ResourceID |
| `load_balancer_out_drop_bytes` | `loadbalancer` | Discard bandwidth in the outgoing direction | Bits/Second(SI) | ResourceID |
| `load_balancer_http_2xx_send_count` | `loadbalancer` | 2xx status code sent | Count/Second | ResourceID |
| `load_balancer_http_3xx_send_count` | `loadbalancer` | 3xx status code sent | Count/Second | ResourceID |
| `load_balancer_http_4xx_send_count` | `loadbalancer` | 4xx status code sent | Count/Second | ResourceID |
| `load_balancer_http_5xx_send_count` | `loadbalancer` | 5xx status code sent | Count/Second | ResourceID |
| `load_balancer_http_other_send_count` | `loadbalancer` | other status code sent | Count/Second | ResourceID |
| `load_balancer_http_404_send_count` | `loadbalancer` | 404 status code sent | Count/Second | ResourceID |
| `load_balancer_http_502_send_count` | `loadbalancer` | 502 status code sent | Count/Second | ResourceID |
| `load_balancer_http_2xx_recv_count` | `loadbalancer` | Received 2xx status codes| Count/Second | ResourceID |
| `load_balancer_http_3xx_recv_count` | `loadbalancer` | Received 3xx status codes | Count/Second | ResourceID |
| `load_balancer_http_4xx_recv_count` | `loadbalancer` | Received 4xx status codes | Count/Second | ResourceID |
| `load_balancer_http_5xx_recv_count` | `loadbalancer` | Received 5xx status codes | Count/Second | ResourceID |
| `load_balancer_http_other_recv_count` | `loadbalancer` | Received other status codes | Count/Second | ResourceID |
| `load_balancer_http_404_recv_count` | `loadbalancer` | Received 404 status codes | Count/Second | ResourceID |
| `load_balancer_http_502_recv_count` | `loadbalancer` | Received 502 status codes | Count/Second | ResourceID |
| `load_balancer_qps` | `loadbalancer` | QPS | Count/Second | ResourceID |
| `load_balancer_qps_utilization` | `loadbalancer` | QPS utilization rate | Count/Second | ResourceID |
| `load_balancer_response_time` | `loadbalancer` | Average response time | Millisecond | ResourceID |
| `load_balancer_ups_response_time` | `loadbalancer` | Average request time | Millisecond | ResourceID |
| `load_balancer_http_500_send_count` | `loadbalancer` | 500 status code sent | Count/Second | ResourceID |
| `load_balancer_http_503_send_count` | `loadbalancer` | 503 status code sent | Count/Second | ResourceID |
| `load_balancer_http_504_send_count` | `loadbalancer` | 504 status code sent | Count/Second | ResourceID |

## Object  {#object}

The collected Volcengine ALB object data structure can see the object data from 「Infrastructure - Resource Catalog」

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
      "Listeners": "[{JSON 数据}]",
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
