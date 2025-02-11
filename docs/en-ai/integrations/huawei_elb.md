---
title: 'Huawei Cloud ELB'
tags: 
  - Huawei Cloud
summary: 'Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_elb'
dashboard:

  - desc: 'Built-in view for Huawei Cloud ELB application'
    path: 'dashboard/en/huawei_elb_application'
  - desc: 'Built-in view for Huawei Cloud ELB network'
    path: 'dashboard/en/huawei_elb_network'

monitor:
  - desc: 'Huawei Cloud ELB monitor'
    path: 'monitor/en/huawei_elb'

---
<!-- markdownlint-disable MD025 -->
# Huawei Cloud ELB
<!-- markdownlint-enable -->


Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of ELB cloud resources, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ELB Collection)" (ID: guance_huaweicloud_elb)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After the script is installed, find the script "Guance Integration (Huawei Cloud-ELB Collection)" under "Development" in Func, expand and modify this script. Find `collector_configs` and `monitor_configs` and edit the content of `region_projects`, changing the region and Project ID to the actual ones, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-elb/){:target="_blank"}


### Verification

1. Under "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

| **Metric ID**                 | **Metric Name**          | **Metric Description**                                                 | **Value Range** | **Measurement Object**                                                 | **Monitoring Period (Original Metric)** |
| -------------------------- | --------------------- | ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ | ---------------------------- |
| `m1_cps`                   | Concurrent Connections            | In Layer 4 load balancers, it refers to the total number of TCP and UDP connections established from the measurement object to backend servers. In Layer 7 load balancers, it refers to the total number of TCP connections established from clients to ELB. Unit: count | ≥ 0 count        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m2_act_conn`              | Active Connections            | The total number of TCP or UDP connections in the **ESTABLISHED** state from the measurement object to backend servers. Windows and Linux servers can use the following command to view. `netstat -an` Unit: count | ≥ 0 count        |                                                              |                              |
| `m3_inact_conn`            | Inactive Connections          | The total number of TCP connections in states other than **ESTABLISHED** from the measurement object to all backend servers. Windows and Linux servers can use the following command to view. `netstat -an` Unit: count | ≥ 0 count        |                                                              |                              |
| `m4_ncps`                  | New Connections per Second            | The number of new TCP and UDP connections established from clients to the measurement object per second. Unit: count/second    | ≥ 0 count/second     |                                                              |                              |
| `m5_in_pps`                | Incoming Packets per Second          | The number of packets received by the measurement object per second. Unit: count/second                | ≥ 0 count/second     |                                                              |                              |
| `m6_out_pps`               | Outgoing Packets per Second          | The number of packets sent by the measurement object per second. Unit: count/second                  | ≥ 0 count/second     |                                                              |                              |
| `m7_in_Bps`                | Incoming Network Rate          | Traffic consumed by external access to the measurement object. Unit: bytes/second                | ≥ 0 bytes/second   |                                                              |                              |
| `m8_out_Bps`               | Outgoing Network Rate          | Traffic consumed by the measurement object accessing externally. Unit: bytes/second                  | ≥ 0 bytes/second   |                                                              |                              |
| `m9_abnormal_servers`      | Abnormal Host Count            | Number of abnormal hosts detected by health checks in the backend of the monitored object. Unit: count             | ≥ 0 count        | Dedicated Load Balancer Shared Load Balancer                             | 1 minute                        |
| `ma_normal_servers`        | Normal Host Count            | Number of normal hosts detected by health checks in the backend of the monitored object. Unit: count             | ≥ 0 count        |                                                              |                              |
| `m1e_server_rps`           | Backend Server Resets per Second    | TCP listener specific metric. The number of reset (RST) packets sent by the backend server to the client via the measurement object per second. Unit: count/second | ≥ 0 count/second     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m21_client_rps`           | Client Resets per Second        | TCP listener specific metric. The number of reset (RST) packets sent by the client to the backend server via the measurement object per second. Unit: count/second | ≥ 0 count/second     |                                                              |                              |
| `m1f_lvs_rps`              | Load Balancer Resets per Second    | TCP listener specific metric. The number of reset (RST) packets generated by the measurement object per second. Unit: count/second | ≥ 0 count/second     |                                                              |                              |
| `m22_in_bandwidth`         | Inbound Bandwidth              | Bandwidth consumed by external access to the measurement object. Unit: bits/second                | ≥ 0 bits/second     | Shared Load Balancer Shared Load Balancer Listener                         | 1 minute                        |
| `m23_out_bandwidth`        | Outbound Bandwidth              | Bandwidth consumed by the measurement object accessing externally. Unit: bits/second                  | ≥ 0 bits/second     |                                                              |                              |
| `mb_l7_qps`                | Layer 7 Query Rate           | Current Layer 7 query rate of the measurement object. (HTTP and HTTPS listeners only) Unit: requests/second. | ≥ 0 requests/second     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `md_l7_http_3xx`           | Layer 7 HTTP Status Code (3XX)    | Current number of Layer 7 3XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `mc_l7_http_2xx`           | Layer 7 HTTP Status Code (2XX)    | Current number of Layer 7 2XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `me_l7_http_4xx`           | Layer 7 HTTP Status Code (4XX)    | Current number of Layer 7 4XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `mf_l7_http_5xx`           | Layer 7 HTTP Status Code (5XX)    | Current number of Layer 7 5XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m10_l7_http_other_status` | Layer 7 HTTP Status Code (Others)    | Current number of non-2XX, 3XX, 4XX, 5XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m11_l7_http_404`          | Layer 7 HTTP Status Code (404)    | Current number of Layer 7 404 status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m12_l7_http_499`          | Layer 7 HTTP Status Code (499)    | Current number of Layer 7 499 status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m13_l7_http_502`          | Layer 7 HTTP Status Code (502)    | Current number of Layer 7 502 status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m14_l7_rt`                | Layer 7 RT Average       | Current average response time of Layer 7 of the measurement object. (HTTP and HTTPS listeners only) From when the measurement object receives a client request to when it returns all responses to the client. Unit: milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In WebSocket scenarios, the average RT value may be very large, making this metric unsuitable as a latency reference. | ≥ 0 ms        |                                                              |                              |
| `m15_l7_upstream_4xx`      | Layer 7 Backend Status Code (4XX)    | Current number of Layer 7 backend 4XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m16_l7_upstream_5xx`      | Layer 7 Backend Status Code (5XX)    | Current number of Layer 7 backend 5XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m17_l7_upstream_rt`       | Layer 7 Backend RT Average     | Current average response time of Layer 7 backend of the measurement object. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. ![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**Note:** In WebSocket scenarios, the average RT value may be very large, making this metric unsuitable as a latency reference. | ≥ 0 ms        |                                                              |                              |
| `m1a_l7_upstream_rt_max`   | Layer 7 Backend RT Maximum     | Current maximum response time of Layer 7 backend of the measurement object. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. | ≥ 0 ms        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| `m1b_l7_upstream_rt_min`   | Layer 7 Backend RT Minimum     | Current minimum response time of Layer 7 backend of the measurement object. (HTTP and HTTPS listeners only) From when the measurement object forwards the request to the backend server to when it receives the response from the backend server. Unit: milliseconds. | ≥ 0 ms        |                                                              |                              |
| `l7_con_usage`             | Layer 7 Concurrent Connection Usage     | Statistics on the concurrent connection usage rate of Layer 7 ELB instances. Unit: percentage.             | ≥ 0%         | Dedicated Load Balancer                                             | 1 minute                        |
| `l7_in_bps_usage`          | Layer 7 Inbound Bandwidth Usage       | Statistics on the inbound bandwidth usage rate of Layer 7 ELB instances. Unit: percentage **Note:** If the inbound bandwidth usage reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability metrics. | ≥ 0%         |                                                              |                              |
| `l7_out_bps_usage`         | Layer 7 Outbound Bandwidth Usage       | Statistics on the outbound bandwidth usage rate of Layer 7 ELB instances. Unit: percentage **Note:** If the outbound bandwidth usage reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability metrics. | ≥ 0%         |                                                              |                              |
| `l7_ncps_usage`            | Layer 7 New Connection Usage Rate   | Statistics on the new connection usage rate of Layer 7 ELB instances. Unit: percentage               | ≥ 0%         |                                                              |                              |
| `l7_qps_usage`             | Layer 7 Query Rate Usage Rate     | Statistics on the query rate usage rate of Layer 7 ELB instances. Unit: percentage                 | ≥ 0%         |                                                              |                              |
| `m18_l7_upstream_2xx`      | Layer 7 Backend Status Code (2XX)    | Current number of Layer 7 backend 2XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     | Dedicated Load Balancer Backend Server Group Shared Load Balancer Backend Server Group         | 1 minute                        |
| `m19_l7_upstream_3xx`      | Layer 7 Backend Status Code (3XX)    | Current number of Layer 7 backend 3XX status response codes of the measurement object. (HTTP and HTTPS listeners only) Unit: count/second. | ≥ 0 count/second     |                                                              |                              |
| `m25_l7_resp_Bps`          | Layer 7 Response Bandwidth           | Unit: bits/second                                                | ≥ 0 bits/second     |                                                              |                              |
| `m24_l7_req_Bps`           | Layer 7 Request Bandwidth           | Unit: bits/second                                                | ≥ 0 bits/second     |                                                              |                              |
| `l4_con_usage`             | Layer 4 Concurrent Connection Usage     | Statistics on the concurrent connection usage rate of Layer 4 ELB instances. Unit: percentage               | ≥ 0%         | Dedicated Load Balancer                                             | 1 minute                        |
| `l4_in_bps_usage`          | Layer 4 Inbound Bandwidth Usage       | Statistics on the inbound bandwidth usage rate of Layer 4 ELB instances. Unit: percentage **Note:** If the inbound bandwidth usage reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability metrics. | ≥ 0%         |                                                              |                              |
| `l4_out_bps_usage`         | Layer 4 Outbound Bandwidth Usage       | Statistics on the outbound bandwidth usage rate of Layer 4 ELB instances. Unit: percentage **Note:** If the outbound bandwidth usage reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue using higher bandwidth, but for the part exceeding the bandwidth, ELB cannot guarantee service availability metrics. | ≥ 0%         |                                                              |                              |
| `l4_ncps_usage`            | Layer 4 New Connection Usage Rate   | Statistics on the new connection usage rate of Layer 4 ELB instances. Unit: percentage               | ≥ 0%         |                                                              |                              |

## Objects {#object}

The structure of the collected Huawei Cloud ELB objects can be viewed under "Infrastructure - Custom"

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
    "listeners" : "{Instance JSON Data}",
    "updated_at": "2022-06-22T02:41:57",
    "message"   : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2:
>
> - `fields.message`, `fields.listeners` are JSON serialized strings.
> - `tags.operating_status` represents the operational status of the load balancer. Possible values: ONLINE, FROZEN.