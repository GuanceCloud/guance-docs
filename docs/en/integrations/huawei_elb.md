---
title: 'Huawei Cloud ELB'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud ELB monitoring Metrics'
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

Collect Huawei Cloud ELB monitoring Metrics

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK in advance that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of ELB cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ELB Collection)" (ID: guance_huaweicloud_elb)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-ELB Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, respectively edit the content in `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】, and it can be executed immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can view the corresponding task records and log checks for any abnormalities.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud ELB Metrics, you can collect more metrics through configuration [Huawei Cloud ELB Metrics Details](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

| **Metric ID**                 | **Metric Name**          | **Metric Meaning**                                                 | **Value Range** | **Measurement Object**                                                 | **Monitoring Period** (Original Metric) |
| ---------------------------- | ------------------------ | ------------------------------------------------------------------ | --------------- | --------------------------------------------------------------------- | --------------------------------------- |
| `m1_cps`                     | Concurrent Connections   | In layer-four load balancers, it refers to the total number of TCP and UDP connections established from the measurement object to backend servers. In layer-seven load balancers, it refers to the total number of TCP connections established from clients to ELB. Unit: Count | ≥ 0 Counts        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m2_act_conn`                | Active Connections      | The total number of **ESTABLISHED** state TCP or UDP connections established from the measurement object to backend servers. Windows and Linux servers can use the following command to check. `netstat -an` Unit: Count | ≥ 0 Counts        |                                                              |                              |
| `m3_inact_conn`              | Inactive Connections    | The total number of TCP connections established from the measurement object to all backend servers except for the **ESTABLISHED** state. Windows and Linux servers can use the following command to check. `netstat -an` Unit: Count | ≥ 0 Counts        |                                                              |                              |
| `m4_ncps`                    | New Connections         | The number of new TCP and UDP connections established per second from clients to the measurement object. Unit: Count/sec    | ≥ 0 Counts/sec     |                                                              |                              |
| `m5_in_pps`                  | Incoming Packets       | The number of packets received per second by the measurement object. Unit: Count/sec                | ≥ 0 Counts/sec     |                                                              |                              |
| `m6_out_pps`                 | Outgoing Packets       | The number of packets sent per second by the measurement object. Unit: Count/sec                  | ≥ 0 Counts/sec     |                                                              |                              |
| `m7_in_Bps`                  | Network Ingress Rate    | The traffic consumed by accessing the measurement object from external sources. Unit: Bytes/sec                | ≥ 0 bytes/sec   |                                                              |                              |
| `m8_out_Bps`                 | Network Egress Rate     | The traffic consumed by the measurement object accessing external sources. Unit: Bytes/sec                  | ≥ 0 bytes/sec   |                                                              |                              |
| `m9_abnormal_servers`        | Abnormal Servers       | The number of abnormal hosts in the backend of the monitored object as determined by health checks. Unit: Count             | ≥ 0 Counts        | Dedicated Load Balancer Shared Load Balancer                             | 1 minute                        |
| `ma_normal_servers`          | Normal Servers         | The number of normal hosts in the backend of the monitored object as determined by health checks. Unit: Count             | ≥ 0 Counts        |                                                              |                              |
| `m1e_server_rps`             | Backend Server Resets   | TCP listener exclusive metric. The number of reset (RST) packets sent per second by the backend server through the measurement object to clients. Unit: Count/sec | ≥ 0 Counts/sec     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m21_client_rps`             | Client Resets          | TCP listener exclusive metric. The number of reset (RST) packets sent per second by the client through the measurement object to the backend server. Unit: Count/sec | ≥ 0 Counts/sec     |                                                              |                              |
| `m1f_lvs_rps`                | Load Balancer Resets    | TCP listener exclusive metric. The number of reset (RST) packets generated per second by the measurement object. Unit: Count/sec | ≥ 0 Counts/sec     |                                                              |                              |
| `m22_in_bandwidth`           | Ingress Bandwidth      | The bandwidth consumed by accessing the measurement object from external sources. Unit: Bits/sec                | ≥ 0 bits/sec     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m23_out_bandwidth`          | Egress Bandwidth       | The bandwidth consumed by the measurement object accessing external sources. Unit: Bits/sec                  | ≥ 0 bits/sec     |                                                              |                              |
| `mb_l7_qps`                  | Layer-7 Query Rate     | The current layer-seven query rate of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Times/sec. | ≥ 0 Times/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `md_l7_http_3xx`             | Layer-7 Protocol Code (3XX) | The current number of 3XX series status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `mc_l7_http_2xx`             | Layer-7 Protocol Code (2XX) | The current number of 2XX series status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `me_l7_http_4xx`             | Layer-7 Protocol Code (4XX) | The current number of 4XX series status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `mf_l7_http_5xx`             | Layer-7 Protocol Code (5XX) | The current number of 5XX series status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m10_l7_http_other_status`  | Layer-7 Protocol Code (Others) | The current number of non-2XX, 3XX, 4XX, 5XX series status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m11_l7_http_404`            | Layer-7 Protocol Code (404) | The current number of 404 status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m12_l7_http_499`            | Layer-7 Protocol Code (499) | The current number of 499 status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m13_l7_http_502`            | Layer-7 Protocol Code (502) | The current number of 502 status response codes of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m14_l7_rt`                  | Layer-7 RT Average      | The current average response time of layer-seven protocol of the measurement object. (HTTP and HTTPS listeners only have this metric) From when the measurement object receives a client request until it returns all responses to the client. Unit: Milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In websocket scenarios, the average RT value may be very large, so this metric cannot be used as a latency reference. | ≥ 0 ms        |                                                              |                              |
| `m15_l7_upstream_4xx`       | Layer-7 Backend Code (4XX) | The current number of 4XX series status response codes from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m16_l7_upstream_5xx`       | Layer-7 Backend Code (5XX) | The current number of 5XX series status response codes from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m17_l7_upstream_rt`        | Layer-7 Backend RT Average | The current average response time from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) From when the measurement object forwards requests to the backend server until it receives the response from the backend server. Unit: Milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In websocket scenarios, the average RT value may be very large, so this metric cannot be used as a latency reference. | ≥ 0 ms        |                                                              |                              |
| `m1a_l7_upstream_rt_max`    | Layer-7 Backend RT Maximum | The current maximum response time from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) From when the measurement object forwards requests to the backend server until it receives the response from the backend server. Unit: Milliseconds. | ≥ 0 ms        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m1b_l7_upstream_rt_min`    | Layer-7 Backend RT Minimum | The current minimum response time from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) From when the measurement object forwards requests to the backend server until it receives the response from the backend server. Unit: Milliseconds. | ≥ 0 ms        |                                                              |                              |
| `l7_con_usage`               | Layer-7 Concurrent Connection Usage Rate | The concurrent connection usage rate of the ELB instance at layer seven. Unit: Percentage.             | ≥ 0 %         | Dedicated Load Balancer                                             | 1 minute                        |
| `l7_in_bps_usage`            | Layer-7 Ingress Bandwidth Usage Rate | The ingress bandwidth usage rate of the ELB instance at layer seven. Unit: Percentage **Note:** If the ingress bandwidth usage rate reaches 100%, it means the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability indicators. | ≥ 0 %         |                                                              |                              |
| `l7_out_bps_usage`           | Layer-7 Egress Bandwidth Usage Rate | The egress bandwidth usage rate of the ELB instance at layer seven. Unit: Percentage **Note:** If the egress bandwidth usage rate reaches 100%, it means the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability indicators. | ≥ 0 %         |                                                              |                              |
| `l7_ncps_usage`              | Layer-7 New Connection Usage Rate | The new connection usage rate of the ELB instance at layer seven. Unit: Percentage               | ≥ 0 %         |                                                              |                              |
| `l7_qps_usage`               | Layer-7 Query Rate Usage Rate | The query rate usage rate of the ELB instance at layer seven. Unit: Percentage                 | ≥ 0 %         |                                                              |                              |
| `m18_l7_upstream_2xx`        | Layer-7 Backend Code (2XX) | The current number of 2XX series status response codes from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     | Dedicated Backend Server Group Shared Backend Server Group         | 1 minute                        |
| `m19_l7_upstream_3xx`        | Layer-7 Backend Code (3XX) | The current number of 3XX series status response codes from the backend of the measurement object. (HTTP and HTTPS listeners only have this metric) Unit: Count/sec. | ≥ 0 Counts/sec     |                                                              |                              |
| `m25_l7_resp_Bps`            | Layer-7 Response Bandwidth | Unit: Bits/sec                                                | ≥ 0 bits/sec     |                                                              |                              |
| `m24_l7_req_Bps`             | Layer-7 Request Bandwidth | Unit: Bits/sec                                                | ≥ 0 bits/sec     |                                                              |                              |
| `l4_con_usage`               | Layer-4 Concurrent Connection Usage Rate | The concurrent connection usage rate of the ELB instance at layer four. Unit: Percentage               | ≥ 0 %         | Dedicated Load Balancer                                             | 1 minute                        |
| `l4_in_bps_usage`            | Layer-4 Ingress Bandwidth Usage Rate | The ingress bandwidth usage rate of the ELB instance at layer four. Unit: Percentage **Note:** If the ingress bandwidth usage rate reaches 100%, it means the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability indicators. | ≥ 0 %         |                                                              |                              |
| `l4_out_bps_usage`           | Layer-4 Egress Bandwidth Usage Rate | The egress bandwidth usage rate of the ELB instance at layer four. Unit: Percentage **Note:** If the egress bandwidth usage rate reaches 100%, it means the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability indicators. | ≥ 0 %         |                                                              |                              |
| `l4_ncps_usage`              | Layer-4 New Connection Usage Rate | The new connection usage rate of the ELB instance at layer four. Unit: Percentage               | ≥ 0 %         |                                                              |                              |

## Objects {#object}

The collected Huawei Cloud ELB object data structure can be seen in the "Infrastructure - Resource Catalog".

```json
{
  "measurement": "huaweicloud_elb",
  "tags": { 
    "RegionId"              : "cn-north-4",
    "project_id"            : "c631f046252d4ebdaxxxxxxxxxx",
    "enterprise_project_id" : "0824ss-xxxx-xxxx-xxxx-12334fedffg",
    "instance_id"           : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "instance_name"         : "elb-xxxx"
  },
  "fields": {
    "vip_subnet_id"   : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961",
    "vip_port_id"     : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vip_address"     : "7aa51dbfxxxxxxxxxdad3c4828b58",
    "operating_status": "ONLINE",
    "created_at"      : "2022-06-22T02:41:57",
    "listeners"       : "{Instance JSON Data}",
    "updated_at"      : "2022-06-22T02:41:57",
    "description"     : ""
  }
}
```

> *Note: Fields in `tags` and `fields` may vary with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, which serves as unique identification.
>
> Tip 2:
>
> - `fields.listeners` is a string after JSON serialization.
> - `fields.operating_status` is the operational status of the load balancer. Possible values: ONLINE and FROZEN.