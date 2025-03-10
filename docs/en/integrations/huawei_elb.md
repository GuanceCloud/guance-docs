---
title: 'Huawei Cloud ELB'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_elb'
dashboard:

  - desc: 'Huawei Cloud ELB application built-in view'
    path: 'dashboard/en/huawei_elb_application'
  - desc: 'Huawei Cloud ELB network built-in view'
    path: 'dashboard/en/huawei_elb_network'

monitor:
  - desc: 'Huawei Cloud ELB monitor'
    path: 'monitor/en/huawei_elb'

---
<!-- markdownlint-disable MD025 -->
# Huawei Cloud ELB
<!-- markdownlint-enable -->


Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of ELB cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ELB Collection)" (ID: guance_huaweicloud_elb)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script installation is complete, find the script "Guance Integration (Huawei Cloud-ELB Collection)" under "Development" in Func, expand and modify this script, find `collector_configs` and `monitor_configs`, respectively edit the content of `region_projects` below, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, you can check the execution task records and corresponding logs.

By default, we collect some configurations, see the Metrics section for details [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-elb/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have corresponding automatic trigger configurations, and you can also check the corresponding task records and logs to inspect for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud-Cloud Monitoring, the default metric sets are as follows. More metrics can be collected through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

| **Metric ID**                 | **Metric Name**          | **Metric Meaning**                                                 | **Value Range** | **Measurement Object**                                                 | **Monitoring Period** |
| -------------------------- | --------------------- | ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ | ---------------------------- |
| `m1_cps`                   | Concurrent Connections | The number of all TCP and UDP connections established from the measurement object to backend servers in Layer 4 Load Balancers. For Layer 7 Load Balancers, it refers to the number of all TCP connections established from clients to ELB. Unit: count | ≥ 0 | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m2_act_conn`              | Active Connections    | The number of all TCP or UDP connections in **ESTABLISHED** state established from the measurement object to backend servers. Windows and Linux servers can use the following command to check. `netstat -an` Unit: count | ≥ 0 |                                                              |                              |
| `m3_inact_conn`            | Inactive Connections  | The number of all TCP connections except **ESTABLISHED** state established from the measurement object to all backend servers. Windows and Linux servers can use the following command to check. `netstat -an` Unit: count | ≥ 0 |                                                              |                              |
| `m4_ncps`                  | New Connections       | The number of new TCP and UDP connections established per second from clients to the measurement object. Unit: count/sec    | ≥ 0/sec     |                                                              |                              |
| `m5_in_pps`                | Incoming Packets      | The number of packets received per second by the measurement object. Unit: count/sec                | ≥ 0/sec     |                                                              |                              |
| `m6_out_pps`               | Outgoing Packets      | The number of packets sent per second by the measurement object. Unit: count/sec                  | ≥ 0/sec     |                                                              |                              |
| `m7_in_Bps`                | Network Ingress Rate  | Traffic consumed by external access to the measurement object. Unit: bytes/sec                | ≥ 0bytes/s   |                                                              |                              |
| `m8_out_Bps`               | Network Egress Rate   | Traffic consumed by the measurement object accessing externally. Unit: bytes/sec                  | ≥ 0bytes/s   |                                                              |                              |
| `m9_abnormal_servers`      | Abnormal Host Count   | The number of abnormal hosts in the backend of the monitored object counted by health checks. Unit: count             | ≥ 0        | Dedicated Load Balancer Shared Load Balancer                             | 1 minute                        |
| `ma_normal_servers`        | Normal Host Count     | The number of normal hosts in the backend of the monitored object counted by health checks. Unit: count             | ≥ 0        |                                                              |                              |
| `m1e_server_rps`           | Backend Server Resets | A TCP listener-specific metric. The number of reset (RST) packets sent per second from backend servers through the measurement object to clients. Unit: count/sec | ≥ 0/sec     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m21_client_rps`           | Client Resets         | A TCP listener-specific metric. The number of reset (RST) packets sent per second from clients through the measurement object to backend servers. Unit: count/sec | ≥ 0/sec     |                                                              |                              |
| `m1f_lvs_rps`              | Load Balancer Resets  | A TCP listener-specific metric. The number of reset (RST) packets generated per second by the measurement object. Unit: count/sec | ≥ 0/sec     |                                                              |                              |
| `m22_in_bandwidth`         | Ingress Bandwidth     | The bandwidth consumed by external access to the measurement object. Unit: bits/sec                | ≥ 0bit/s     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m23_out_bandwidth`        | Egress Bandwidth      | The bandwidth consumed by the measurement object accessing externally. Unit: bits/sec                  | ≥ 0bit/s     |                                                              |                              |
| `mb_l7_qps`                | L7 Query Rate         | The current L7 query rate of the measurement object. (HTTP and HTTPS listeners only) Unit: times/sec. | ≥ 0/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `md_l7_http_3xx`           | L7 HTTP Status Code (3XX) | The current number of L7 3XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `mc_l7_http_2xx`           | L7 HTTP Status Code (2XX) | The current number of L7 2XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `me_l7_http_4xx`           | L7 HTTP Status Code (4XX) | The current number of L7 4XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `mf_l7_http_5xx`           | L7 HTTP Status Code (5XX) | The current number of L7 5XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m10_l7_http_other_status` | L7 HTTP Status Code (Others) | The current number of non-2XX, 3XX, 4XX, 5XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m11_l7_http_404`          | L7 HTTP Status Code (404) | The current number of L7 404 status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m12_l7_http_499`          | L7 HTTP Status Code (499) | The current number of L7 499 status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m13_l7_http_502`          | L7 HTTP Status Code (502) | The current number of L7 502 status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m14_l7_rt`                | L7 RT Average          | The current average response time of L7. (HTTP and HTTPS listeners only) From when the measurement object receives a client request to when it returns all responses to the client. Unit: milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In WebSocket scenarios, the RT average may be very large, making this metric unsuitable as a latency reference. | ≥ 0ms        |                                                              |                              |
| `m15_l7_upstream_4xx`      | L7 Backend Response Code (4XX) | The current number of L7 backend 4XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m16_l7_upstream_5xx`      | L7 Backend Response Code (5XX) | The current number of L7 backend 5XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m17_l7_upstream_rt`       | L7 Backend RT Average  | The current average response time of the L7 backend. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In WebSocket scenarios, the RT average may be very large, making this metric unsuitable as a latency reference. | ≥ 0ms        |                                                              |                              |
| `m1a_l7_upstream_rt_max`   | L7 Backend RT Maximum | The current maximum response time of the L7 backend. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. | ≥ 0ms        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m1b_l7_upstream_rt_min`   | L7 Backend RT Minimum | The current minimum response time of the L7 backend. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. | ≥ 0ms        |                                                              |                              |
| `l7_con_usage`             | L7 Concurrent Connection Usage | The concurrent connection usage rate of the L7 ELB instance. Unit: percentage.             | ≥ 0%         | Dedicated Load Balancer                                             | 1 minute                        |
| `l7_in_bps_usage`          | L7 Ingress Bandwidth Usage | The ingress bandwidth usage rate of the L7 ELB instance. Unit: percentage**Note:** If the ingress bandwidth usage reaches 100%, it indicates that it has exceeded the performance guarantee provided by the ELB specification. Your business can continue to use higher bandwidth, but ELB cannot commit to service availability for the portion exceeding the specified bandwidth. | ≥ 0%         |                                                              |                              |
| `l7_out_bps_usage`         | L7 Egress Bandwidth Usage | The egress bandwidth usage rate of the L7 ELB instance. Unit: percentage**Note:** If the egress bandwidth usage reaches 100%, it indicates that it has exceeded the performance guarantee provided by the ELB specification. Your business can continue to use higher bandwidth, but ELB cannot commit to service availability for the portion exceeding the specified bandwidth. | ≥ 0%         |                                                              |                              |
| `l7_ncps_usage`            | L7 New Connection Usage Rate | The new connection usage rate of the L7 ELB instance. Unit: percentage               | ≥ 0%         |                                                              |                              |
| `l7_qps_usage`             | L7 Query Rate Usage   | The query rate usage rate of the L7 ELB instance. Unit: percentage                 | ≥ 0%         |                                                              |                              |
| `m18_l7_upstream_2xx`      | L7 Backend Response Code (2XX) | The current number of L7 backend 2XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     | Dedicated Load Balancer Backend Server Group Shared Load Balancer Backend Server Group         | 1 minute                        |
| `m19_l7_upstream_3xx`      | L7 Backend Response Code (3XX) | The current number of L7 backend 3XX status response codes. (HTTP and HTTPS listeners only) Unit: count/sec. | ≥ 0/sec     |                                                              |                              |
| `m25_l7_resp_Bps`          | L7 Response Bandwidth | Unit: bits/sec                                                | ≥ 0bit/s     |                                                              |                              |
| `m24_l7_req_Bps`           | L7 Request Bandwidth  | Unit: bits/sec                                                | ≥ 0bit/s     |                                                              |                              |
| `l4_con_usage`             | L4 Concurrent Connection Usage | The concurrent connection usage rate of the L4 ELB instance. Unit: percentage               | ≥ 0%         | Dedicated Load Balancer                                             | 1 minute                        |
| `l4_in_bps_usage`          | L4 Ingress Bandwidth Usage | The ingress bandwidth usage rate of the L4 ELB instance. Unit: percentage**Note:** If the ingress bandwidth usage reaches 100%, it indicates that it has exceeded the performance guarantee provided by the ELB specification. Your business can continue to use higher bandwidth, but ELB cannot commit to service availability for the portion exceeding the specified bandwidth. | ≥ 0%         |                                                              |                              |
| `l4_out_bps_usage`         | L4 Egress Bandwidth Usage | The egress bandwidth usage rate of the L4 ELB instance. Unit: percentage**Note:** If the egress bandwidth usage reaches 100%, it indicates that it has exceeded the performance guarantee provided by the ELB specification. Your business can continue to use higher bandwidth, but ELB cannot commit to service availability for the portion exceeding the specified bandwidth. | ≥ 0%         |                                                              |                              |
| `l4_ncps_usage`            | L4 New Connection Usage Rate | The new connection usage rate of the L4 ELB instance. Unit: percentage               | ≥ 0%         |                                                              |                              |

## Objects {#object}

The structure of the collected Huawei Cloud ELB object data can be viewed under "Infrastructure-Custom"

```shell
{
  "measurement": "huaweicloud_elb",
  "tags": {
    "name"            : "e9cb54b0-63e0-46c5xxxxxxxx",
    "description"     : "",
    "id"              : "e9cb54b0-63e0-46c5xxxxxxxxxx",
    "RegionId"        : "cn-north-4",
    "instance_name"   : "elb-xxxx",
    "operating_status": "ONLINE",
    "project_id"      : "c631f046252d4ebdaxxxxxxxxxx"
  },
  "fields": {
    "created_at": "2022-06-22T02:41:57",
    "listeners" : "{instance JSON data}",
    "updated_at": "2022-06-22T02:41:57",
    "message"   : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Tip 2:
>
> - `fields.message` and `fields.listeners` are serialized JSON strings.
> - `tags.operating_status` represents the operational status of the load balancer. Possible values: ONLINE and FROZEN.