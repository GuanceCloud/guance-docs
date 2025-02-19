---
title: '火山引擎 ALB'
tags: 
  - 火山引擎
summary: '采集火山引擎 ALB 指标数据'
__int_icon: 'icon/volcengine_alb'
dashboard:

  - desc: '火山引擎 ALB 内置视图'
    path: 'dashboard/zh/volcengine_alb'

monitor:
  - desc: '火山引擎 ALB 监控器'
    path: 'monitor/zh/volcengine_alb'
---

采集火山引擎 ALB 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ALB 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（火山引擎-ALB采集）」(ID：`guance_volcengine_alb`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名、地域Regions。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置火山引擎 ALB 监控指标，可以通过配置的方式采集更多的指标 [火山引擎 ALB 指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_ALB){:target="_blank"}

|`MetricName` |`Subnamespace` |指标名称 |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `listener_max_conn` | `listener` | 并发连接数 | Count | ResourceID,ListenerID |
| `listener_new_conn` | `listener` | 新建连接数 | Count/Second | ResourceID,ListenerID |
| `listener_active_conn` | `listener` | 活跃连接数 | Count | ResourceID,ListenerID |
| `listener_inactive_conn` | `listener` | 并发连接数 | Count | ResourceID,ListenerID |
| `listener_lost_conn` | `listener` | 丢失连接数 | Count/Second | ResourceID,ListenerID |
| `listener_in_packets` | `listener` | 入方向数据包数 | Packet/Second | ResourceID,ListenerID |
| `listener_out_packets` | `listener` | 出方向数据包数 | Packet/Second | ResourceID,ListenerID |
| `listener_in_drop_packets` | `listener` | 入方向丢包数 | Packet/Second | ResourceID,ListenerID |
| `listener_out_drop_packets` | `listener` | 出方向丢包数 | Packet/Second | ResourceID,ListenerID |
| `listener_in_bytes` | `listener` | 入方向带宽 | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_bytes` | `listener` | 出方向带宽 | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_in_drop_bytes` | `listener` | 入方向丢弃带宽 | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_out_drop_bytes` | `listener` | 出方向丢弃带宽 | Bits/Second(SI) | ResourceID,ListenerID |
| `listener_healthy_rs_count` | `listener` | 后端服务器健康个数 | Count | ResourceID,ListenerID |
| `listener_unhealthy_rs_count` | `listener` | 后端服务器异常个数 | Count | ResourceID,ListenerID |
| `listener_http_2xx_send_count` | `listener` | 发送的 2xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_send_count` | `listener` | 发送的 3xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_send_count` | `listener` | 发送的 4xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_send_count` | `listener` | 发送的 5xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_other_send_count` | `listener` | 发送的 other 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_404_send_count` | `listener` | 发送的 404 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_502_send_count` | `listener` | 发送的 502 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_2xx_recv_count` | `listener` | 收到的 2xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_3xx_recv_count` | `listener` | 收到的 3xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_4xx_recv_count` | `listener` | 收到的 4xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_5xx_recv_count` | `listener` | 收到的 5xx 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_other_recv_count` | `listener` | 收到的other状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_404_recv_count` | `listener` | 收到的 404 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_http_502_recv_count` | `listener` | 收到的 502 状态码 | Count/Second | ResourceID,ListenerID |
| `listener_qps` | `listener` | QPS | Count/Second | ResourceID,ListenerID |
| `listener_response_time` | `listener` | 平均响应时间 | Millisecond | ResourceID,ListenerID |
| `listener_ups_response_time` | `listener` | 平均请求时间 | Millisecond | ResourceID,ListenerID |
| `listener_http_500_send_count` | `listener` | 发送的 500 状态码 | Count/Second | ResourceID |
| `listener_http_503_send_count` | `listener` | 发送的 503 状态码 | Count/Second | ResourceID |
| `listener_http_504_send_count` | `listener` | 发送的 504 状态码 | Count/Second | ResourceID |
| `load_balancer_max_conn` | `loadbalancer` | 并发连接数 | Count | ResourceID |
| `load_balancer_new_conn` | `loadbalancer` | 新建连接数 | Count | ResourceID |
| `load_balancer_active_conn` | `loadbalancer` | 活跃连接数 | Count | ResourceID |
| `load_balancer_inactive_conn` | `loadbalancer` | 非活跃连接数 | Count | ResourceID |
| `load_balancer_lost_conn` | `loadbalancer` | 丢失连接数 | Count/Second | ResourceID |
| `load_balancer_in_packets` | `loadbalancer` | 入方向数据包数 | Packet/Second | ResourceID |
| `load_balancer_out_packets` | `loadbalancer` | 出方向数据包数 | Packet/Second | ResourceID |
| `load_balancer_in_drop_packets` | `loadbalancer` | 入方向丢包数 | Packet/Second | ResourceID |
| `load_balancer_out_drop_packets` | `loadbalancer` | 出方向丢包数 | Packet/Second | ResourceID |
| `load_balancer_in_bytes` | `loadbalancer` | 入方向带宽 | Bits/Second(SI) | ResourceID |
| `load_balancer_out_bytes` | `loadbalancer` | 出方向带宽 | Bits/Second(SI) | ResourceID |
| `load_balancer_in_drop_bytes` | `loadbalancer` | 入方向丢弃带宽 | Bits/Second(SI) | ResourceID |
| `load_balancer_out_drop_bytes` | `loadbalancer` | 出方向丢弃带宽 | Bits/Second(SI) | ResourceID |
| `load_balancer_http_2xx_send_count` | `loadbalancer` | 发送的 2xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_3xx_send_count` | `loadbalancer` | 发送的 3xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_4xx_send_count` | `loadbalancer` | 发送的 4xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_5xx_send_count` | `loadbalancer` | 发送的 5xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_other_send_count` | `loadbalancer` | 发送的 other 状态码 | Count/Second | ResourceID |
| `load_balancer_http_404_send_count` | `loadbalancer` | 发送的 404 状态码 | Count/Second | ResourceID |
| `load_balancer_http_502_send_count` | `loadbalancer` | 发送的 502 状态码 | Count/Second | ResourceID |
| `load_balancer_http_2xx_recv_count` | `loadbalancer` | 收到的 2xx 状态码| Count/Second | ResourceID |
| `load_balancer_http_3xx_recv_count` | `loadbalancer` | 收到的 3xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_4xx_recv_count` | `loadbalancer` | 收到的 4xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_5xx_recv_count` | `loadbalancer` | 收到的 5xx 状态码 | Count/Second | ResourceID |
| `load_balancer_http_other_recv_count` | `loadbalancer` | 收到的other状态码 | Count/Second | ResourceID |
| `load_balancer_http_404_recv_count` | `loadbalancer` | 收到的 404 状态码 | Count/Second | ResourceID |
| `load_balancer_http_502_recv_count` | `loadbalancer` | 收到的 502 状态码 | Count/Second | ResourceID |
| `load_balancer_qps` | `loadbalancer` | QPS | Count/Second | ResourceID |
| `load_balancer_qps_utilization` | `loadbalancer` | QPS 使用率 | Count/Second | ResourceID |
| `load_balancer_response_time` | `loadbalancer` | 平均响应时间 | Millisecond | ResourceID |
| `load_balancer_ups_response_time` | `loadbalancer` | 平均请求时间 | Millisecond | ResourceID |
| `load_balancer_http_500_send_count` | `loadbalancer` | 发送的 500 状态码 | Count/Second | ResourceID |
| `load_balancer_http_503_send_count` | `loadbalancer` | 发送的 503 状态码 | Count/Second | ResourceID |
| `load_balancer_http_504_send_count` | `loadbalancer` | 发送的 504 状态码 | Count/Second | ResourceID |

## 对象 {#object}

采集到的火山引擎 ALB 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

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
