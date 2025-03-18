---
title: 'HUAWEI ELB'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_elb'
dashboard:

  - desc: 'HUAWEI CLOUD ELB application Monitoring View'
    path: 'dashboard/zh/huawei_elb_application'
  - desc: 'HUAWEI CLOUD ELB network Monitoring View'
    path: 'dashboard/zh/huawei_elb_network'

monitor:
  - desc: 'HUAWEI CLOUD ELB Monitor'
    path: 'monitor/zh/huawei_elb'

---
<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD ELB
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD ELB cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-ELBCollect）」(ID：guance_huaweicloud_elb)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click【Run】,you can immediately execute once, without waiting for a regular time.After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.


We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-elb/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

| **Metric****ID**           | **Metric Name** | **Metric Meaning**                               | **Value Range** | **Measured Objec**                               | **Monitoring Period****(Raw Metric)** |
| ------------------------ | --------------------- | ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ | ---------------------------- |
| m1_cps                   | Concurrent Connections | In Layer 4 load balancers, it refers to the total number of TCP and UDP connections established from the measured object to the backend servers. In Layer 7 load balancers, it refers to the total number of TCP connections established from the clients to the ELB (Elastic Load Balancer). Unit: Count. | ≥ 0        | Dedicated Load Balancer Shared Load Balancer Dedicated Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| m2_act_conn              | Active Connections | The total number of **ESTABLISHED** TCP or UDP connections from the measured object to the backend servers. Both Windows and Linux servers can use the following command to view the connections: `netstat -an`. Unit: Count. | ≥ 0        |                                                              |                              |
| m3_inact_conn            | Inactive Connections | The total number of TCP connections, excluding those in **ESTABLISHED** state, from the measured object to all backend servers. Both Windows and Linux servers can use the following command to view the connections: `netstat -an`. Unit: Count. | ≥ 0        |                                                              |                              |
| **m4_ncps**                  | New Connections | The number of new TCP and UDP connections established per second from clients to the measured object. Unit: connections per second (cps) or count per second (cps). | ≥ 0/秒     |                                                              |                              |
| m5_in_pps                | Incoming Packet Count | The number of packets received per second by the measured object. Unit: packets per second (pps) or count per second (cps). | ≥ 0/second     |                                                              |                              |
| m6_out_pps               | Outgoing Packet Count | The number of packets sent per second by the measured object. Unit: packets per second (pps) or count per second (cps). | ≥ 0/second     |                                                              |                              |
| m7_in_Bps                | Incoming Network Rate | The traffic consumed when accessing the measured object from external sources. Unit: bytes per second (B/s). | ≥ 0bytes/s   |                                                              |                              |
| m8_out_Bps               | Outgoing Network Rate | The traffic consumed when the measured object accesses external sources. Unit: bytes per second (B/s). | ≥ 0bytes/s   |                                                              |                              |
| m9_abnormal_servers      | Number of Abnormal Hosts | Health check statistics monitor the number of backend hosts that are in an unhealthy state. Unit: Count. | ≥ 0        | Exclusive load balancer Shared load balancer | 1 minute                        |
| ma_normal_servers        | Number of Normal Hosts | Health check statistics monitor the number of backend hosts that are in a healthy state. Unit: Count. | ≥ 0        |                                                              |                              |
| m1e_server_rps           | Number of Backend Server Resets | TCP Listener exclusive metric. The number of reset (RST) packets sent from backend servers to clients through the measured object per second. Unit: packets per second (pps) or count per second (cps). | ≥ 0 /second     | Shared Load Balancer Shared Load Balancer Listener | 1 minute                        |
| m21_client_rps           | Number of Client Resets | TCP Listener exclusive metric. The number of reset (RST) packets sent from clients to backend servers through the measured object per second. Unit: packets per second (pps) or count per second (cps). | ≥ 0/second     |                                                              |                              |
| m1f_lvs_rps              | Number of Load Balancer Resets | TCP Listener exclusive metric. The number of reset (RST) packets generated by the measured object per second. Unit: packets per second (pps) or count per second (cps). | ≥ 0 /second     |                                                              |                              |
| m22_in_bandwidth         | Inbound Bandwidth | The bandwidth consumed when accessing the measured object from external sources. Unit: bits per second (bps). | ≥ 0bit/s     | Shared Load Balancer Shared Load Balancer Listener | 1 minute                        |
| m23_out_bandwidth        | Outbound Bandwidth | The bandwidth consumed when the measured object accesses external sources. Unit: bits per second (bps). | ≥ 0bit/s     |                                                              |                              |
| mb_l7_qps                | Layer 7 Query Rate | Statistic the current Layer 7 query rate of the measured object. (This metric is available only for HTTP and HTTPS listeners). Unit: queries per second (QPS) or count per second (cps). | ≥ 0 query/s     | Exclusive Load Balancer Shared Load Balancer Exclusive Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| md_l7_http_3xx           | Layer 7 Protocol Return Code (3XX) | Statistic the current number of 3XX series status response codes from backend servers of the measured object. (This metric is available only for HTTP and HTTPS listeners). Unit: count per second (cps) or number per second (NPS). | ≥ 0/second     | Exclusive Load Balancer Shared Load Balancer Exclusive Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| mc_l7_http_2xx           | Layer 7 Protocol Return Code(2XX) | Count the number of 2XX series status response codes for the current 7-layer measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     | Exclusive Load Balancer Shared Load Balancer Exclusive Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| me_l7_http_4xx           | Layer 7 Protocol Return Code(4XX) | Count the number of 4XX series status response codes for the current 7-layer measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| mf_l7_http_5xx           | Layer 7 Protocol Return Code(5XX) | Count the number of current 7-layer 5XX series status response codes for the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m10_l7_http_other_status | Layer 7 Protocol Return Code(Others) | Count the number of non 2XX, 3XX, 4XX, 5XX series status response codes for the current 7 layers of the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m11_l7_http_404          | Layer 7 Protocol Return Code(404) | Count the number of current 7-layer 404 state response codes for the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m12_l7_http_499          | Layer 7 Protocol Return Code(499) | Count the number of 499 state response codes on the current 7 layers of the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m13_l7_http_502          | Layer 7 Protocol Return Code(502) | Count the number of current 7-layer 502 state response codes for the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m14_l7_rt                | Layer 7 Protocol Average Response Time (RT) | Calculate the average response time of the current 7 layers of the measurement object. (Only HTTP and HTTPS listeners have this metric) From the moment the measurement object receives a client request, until the measurement object returns all responses to the client. Unit: milliseconds** Explanation: In the scenario of * * websocket, the average RT value may be very large, and this metric cannot be used as a reference for latency metrics. | ≥ 0ms        |                                                              |                              |
| m15_l7_upstream_4xx      | Layer 7 Backend Return Code(4XX) | Count the number of 4XX series status response codes on the current 7-layer backend of the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     | Exclusive Load Balancer Shared Load Balancer Exclusive Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| m16_l7_upstream_5xx      | Layer 7 Backend Return Code(5XX) | Count the number of 5XX series status response codes on the current 7-layer backend of the measurement object. (Only HTTP and HTTPS listeners have this metric) Unit: pieces/second. | ≥ 0/second     |                                                              |                              |
| m17_l7_upstream_rt       | Layer 7 Backend Average Response Time (RT) | Calculate the average response time of the current 7-layer backend of the measurement object. (Only HTTP and HTTPS listeners have this metric) Starting from the measurement object forwarding the request to the backend server, until the measurement object receives a response from the backend server. Unit: milliseconds** Explanation: In the scenario of * * websocket, the average RT value may be very large, and this metric cannot be used as a reference for latency metrics. | ≥ 0ms        |                                                              |                              |
| m1a_l7_upstream_rt_max   | Layer 7 Backend Maximum Response Time (RT) | Calculate the maximum response time of the current 7-layer backend of the measurement object. (Only HTTP and HTTPS listeners have this metric) Starting from the measurement object forwarding the request to the backend server, until the measurement object receives a response from the backend server. Unit: milliseconds. | ≥ 0ms        | Exclusive Load Balancer Shared Load Balancer Exclusive Load Balancer Listener Shared Load Balancer Listener | 1 minute                        |
| m1b_l7_upstream_rt_min   | Layer 7 Backend Minimum Response Time (RT) | Statistic the current minimum response time from backend servers of the measured object. (This metric is available only for HTTP and HTTPS listeners). It measures the time from the moment the measured object forwards the request to the backend server until it receives the response from the backend server. Unit: milliseconds (ms). | ≥ 0ms        |                                                              |                              |
| l7_con_usage             | Layer 7 Concurrent Connection Usage Rate | Statistic the 7-layer ELB (Elastic Load Balancer) instance's concurrent connection usage rate. Unit: percentage (%). | ≥ 0%         | Exclusive load balancer                      | 1 minute                        |
| l7_in_bps_usage          | Layer 7 Inbound Bandwidth Usage Rate | Statistic the 7-layer ELB (Elastic Load Balancer) instance's inbound bandwidth usage rate. Unit: percentage (%). **Note:** If the inbound bandwidth usage rate reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue to use higher bandwidth, but for the part exceeding the bandwidth limit, the ELB cannot guarantee the service availability metrics. | ≥ 0%         |                                                              |                              |
| l7_out_bps_usage         | Layer 7 Outbound Bandwidth Usage Rate | Statistic the 7-layer ELB (Elastic Load Balancer) instance's outbound bandwidth usage rate. Unit: percentage (%). **Note:** If the outbound bandwidth usage rate reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue to use higher bandwidth, but for the part exceeding the bandwidth limit, the ELB cannot guarantee the service availability metrics. | ≥ 0%         |                                                              |                              |
| l7_ncps_usage            | Layer 7 New Connection Rate Usage Rate | Statistic the 7-layer ELB (Elastic Load Balancer) instance's new connection rate usage. Unit: percentage (%). | ≥ 0%         |                                                              |                              |
| l7_qps_usage             | Layer 7 Query Rate Usage Rate | Statistic the 7-layer ELB (Elastic Load Balancer) instance's query rate usage rate. Unit: percentage (%). | ≥ 0%         |                                                              |                              |
| m18_l7_upstream_2xx      | Layer 7 Backend Return Code(2XX) | Statistic the current number of 2XX series status response codes from backend servers of the measured object. (This metric is available only for HTTP and HTTPS listeners). Unit: count per second (cps) or number per second (NPS). | ≥ 0/second     | Exclusive load balancing backend server group Shared load balancing backend server group | 1 minute                        |
| m19_l7_upstream_3xx      | Layer 7 Backend Return Code(3XX) | Statistic the current number of 3XX series status response codes from backend servers of the measured object. (This metric is available only for HTTP and HTTPS listeners). Unit: count per second (cps) or number per second (NPS). | ≥ 0/second     |                                                              |                              |
| m25_l7_resp_Bps          | Layer 7 Response Bandwidth | Unit: bits per second (bps).                    | ≥ 0 bit/s     |                                                              |                              |
| m24_l7_req_Bps           | Layer 7 Request Bandwidth | Unit: bits per second (bps).                    | ≥ 0 bit/s     |                                                              |                              |
| l4_con_usage             | Layer 4 Concurrent Connection Usage Rate | Statistic the 4-layer ELB (Elastic Load Balancer) instance's concurrent connection usage rate. Unit: percentage (%). | ≥ 0%         | Exclusive load balancer                      | 1 minute                        |
| l4_in_bps_usage          | Layer 4 Inbound Bandwidth Usage Rate | Statistic the 4-layer ELB (Elastic Load Balancer) instance's inbound bandwidth usage rate. Unit: percentage (%). **Note:** If the inbound bandwidth usage rate reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue to use higher bandwidth, but for the part exceeding the bandwidth limit, the ELB cannot guarantee the service availability metrics. | ≥ 0%         |                                                              |                              |
| l4_out_bps_usage         | Layer 4 Outbound Bandwidth Usage Rate | Statistic the 4-layer ELB (Elastic Load Balancer) instance's outbound bandwidth usage rate. Unit: percentage (%). **Note:** If the outbound bandwidth usage rate reaches 100%, it indicates that the performance guarantee provided by the ELB specification has been exceeded. Your business can continue to use higher bandwidth, but for the part exceeding the bandwidth limit, the ELB cannot guarantee the service availability metrics. | ≥ 0%         |                                                              |                              |
| l4_ncps_usage            | Layer 4 New Connection Rate Usage Rate | Statistic the 4-layer ELB (Elastic Load Balancer) instance's new connection rate usage. Unit: percentage (%). | ≥ 0%         |                                                              |                              |

## Object {#object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "listeners" : "{Instance JSON data}",
    "updated_at": "2022-06-22T02:41:57",
    "message"   : "{Instance JSON data}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：
>
> - `fields.message`、`fields.listeners` are JSON-serialized strings.
> - `tags.operating_status`represents the operating status of the load balancer. It can have the values "ONLINE" and "FROZEN".

