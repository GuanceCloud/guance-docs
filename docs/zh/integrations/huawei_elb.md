---
title: '华为云 ELB'
tags: 
  - 华为云
summary: '采集 华为云 ELB 监控指标'
__int_icon: 'icon/huawei_elb'
dashboard:

  - desc: '华为云 ELB application 内置视图'
    path: 'dashboard/zh/huawei_elb_application'
  - desc: '华为云 ELB network 内置视图'
    path: 'dashboard/zh/huawei_elb_network'

monitor:
  - desc: '华为云 ELB 监控器'
    path: 'monitor/zh/huawei_elb'

---

采集 华为云 ELB 监控指标

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ELB 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（华为云-ELB采集）」(ID：guance_huaweicloud_elb)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-ELB采集）」，展开修改此脚本，找到`collector_configs`和`monitor_configs`分别编辑下面`region_projects`中的内容，将地域和Project ID,更改为实际的地域和Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置华为云 ELB 指标, 可以通过配置的方式采集更多的指标 [华为云 ELB 指标详情](https://support.huaweicloud.com/usermanual-elb/elb_ug_jk_0001.html){:target="_blank"}

| **指标ID**                 | **指标名称**          | **指标含义**                                                 | **取值范围** | **测量对象**                                                 | **监控周期****（原始指标）** |
| -------------------------- | --------------------- | ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ | ---------------------------- |
| `m1_cps`                   | 并发连接数            | 在四层负载均衡器中，指从测量对象到后端服务器建立的所有TCP和UDP连接的数量。在七层负载均衡器中，指从客户端到ELB建立的所有TCP连接的数量。单位：个 | ≥ 0个        | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `m2_act_conn`              | 活跃连接数            | 从测量对象到后端服务器建立的所有**ESTABLISHED**状态的TCP或UDP连接的数量。Windows和Linux服务器都可以使用如下命令查看。`netstat -an`单位：个 | ≥ 0个        |                                                              |                              |
| `m3_inact_conn`            | 非活跃连接数          | 从测量对象到所有后端服务器建立的所有除**ESTABLISHED**状态之外的TCP连接的数量。Windows和Linux服务器都可以使用如下命令查看。`netstat -an`单位：个 | ≥ 0个        |                                                              |                              |
| `m4_ncps`                  | 新建连接数            | 从客户端到测量对象每秒新建立的TCP和UDP连接数。单位：个/秒    | ≥ 0个/秒     |                                                              |                              |
| `m5_in_pps`                | 流入数据包数          | 测量对象每秒接收到的数据包的个数。单位：个/秒                | ≥ 0个/秒     |                                                              |                              |
| `m6_out_pps`               | 流出数据包数          | 测量对象每秒发出的数据包的个数。单位：个/秒                  | ≥ 0个/秒     |                                                              |                              |
| `m7_in_Bps`                | 网络流入速率          | 从外部访问测量对象所消耗的流量。单位：字节/秒                | ≥ 0bytes/s   |                                                              |                              |
| `m8_out_Bps`               | 网络流出速率          | 测量对象访问外部所消耗的流量。单位：字节/秒                  | ≥ 0bytes/s   |                                                              |                              |
| `m9_abnormal_servers`      | 异常主机数            | 健康检查统计监控对象后端异常的主机个数。单位：个             | ≥ 0个        | 独享型负载均衡器共享型负载均衡器                             | 1分钟                        |
| `ma_normal_servers`        | 正常主机数            | 健康检查统计监控对象后端正常的主机个数。单位：个             | ≥ 0个        |                                                              |                              |
| `m1e_server_rps`           | 后端服务器重置数量    | TCP监听器专属指标。后端服务器每秒通过测量对象发给客户端的重置（RST）数据包数。单位：个/秒 | ≥ 0个/秒     | 共享型负载均衡器共享型负载均衡监听器                         | 1分钟                        |
| `m21_client_rps`           | 客户端重置数量        | TCP监听器专属指标。客户端每秒通过测量对象发送给后端服务器的重置（RST）数据包数。单位：个/秒 | ≥ 0个/秒     |                                                              |                              |
| `m1f_lvs_rps`              | 负载均衡器重置数量    | TCP监听器专属指标。测量对象每秒生成的重置（RST）数据包数。单位：个/秒 | ≥ 0个/秒     |                                                              |                              |
| `m22_in_bandwidth`         | 入网带宽              | 从外部访问测量对象所消耗的带宽。单位：比特/秒                | ≥ 0bit/s     | 共享型负载均衡器共享型负载均衡监听器                         | 1分钟                        |
| `m23_out_bandwidth`        | 出网带宽              | 测量对象访问外部所消耗的带宽。单位：比特/秒                  | ≥ 0bit/s     |                                                              |                              |
| `mb_l7_qps`                | 7层查询速率           | 统计测量对象当前7层查询速率。（HTTP和HTTPS监听器才有此指标）单位：次/秒。 | ≥ 0次/秒     | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `md_l7_http_3xx`           | 7层协议返回码(3XX)    | 统计测量对象当前7层3XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `mc_l7_http_2xx`           | 7层协议返回码(2XX)    | 统计测量对象当前7层2XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `me_l7_http_4xx`           | 7层协议返回码(4XX)    | 统计测量对象当前7层4XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `mf_l7_http_5xx`           | 7层协议返回码(5XX)    | 统计测量对象当前7层5XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m10_l7_http_other_status` | 7层协议返回码(Others) | 统计测量对象当前7层非2XX,3XX,4XX,5XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m11_l7_http_404`          | 7层协议返回码(404)    | 统计测量对象当前7层404状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m12_l7_http_499`          | 7层协议返回码(499)    | 统计测量对象当前7层499状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m13_l7_http_502`          | 7层协议返回码(502)    | 统计测量对象当前7层502状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m14_l7_rt`                | 7层协议RT平均值       | 统计测量对象当前7层平均响应时间。（HTTP和HTTPS监听器才有此指标）从测量对象收到客户端请求开始，到测量对象将所有响应返回给客户端为止。单位：毫秒。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**websocket场景下RT平均值可能会非常大，此时该指标无法作为时延指标参考。 | ≥ 0ms        |                                                              |                              |
| `m15_l7_upstream_4xx`      | 7层后端返回码(4XX)    | 统计测量对象当前7层后端4XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `m16_l7_upstream_5xx`      | 7层后端返回码(5XX)    | 统计测量对象当前7层后端5XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m17_l7_upstream_rt`       | 7层后端的RT平均值     | 统计测量对象当前7层后端平均响应时间。（HTTP和HTTPS监听器才有此指标）从测量对象将请求转发给后端服务器开始，到测量对象收到后端服务器返回响应为止。单位：毫秒。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**websocket场景下RT平均值可能会非常大，此时该指标无法作为时延指标参考。 | ≥ 0ms        |                                                              |                              |
| `m1a_l7_upstream_rt_max`   | 7层后端的RT最大值     | 统计测量对象当前7层后端最大响应时间。（HTTP和HTTPS监听器才有此指标）从测量对象将请求转发给后端服务器开始，到测量对象收到后端服务器返回响应为止。单位：毫秒。 | ≥ 0ms        | 独享型负载均衡器共享型负载均衡器独享型负载均衡监听器共享型负载均衡监听器 | 1分钟                        |
| `m1b_l7_upstream_rt_min`   | 7层后端的RT最小值     | 统计测量对象当前7层后端最小响应时间。（HTTP和HTTPS监听器才有此指标）从测量对象将请求转发给后端服务器开始，到测量对象收到后端服务器返回响应为止。单位：毫秒。 | ≥ 0ms        |                                                              |                              |
| `l7_con_usage`             | 7层并发连接使用率     | 统计7层的ELB实例并发连接数使用率。单位：百分比。             | ≥ 0%         | 独享型负载均衡器                                             | 1分钟                        |
| `l7_in_bps_usage`          | 7层入带宽使用率       | 统计7层的ELB实例入带宽使用率。单位：百分比**注意：**若入带宽使用率达到100%，说明已经超出ELB规格所提供的性能保障，您的业务可以继续使用更高带宽，但对于带宽超出的部分，ELB无法承诺服务可用性指标。 | ≥ 0%         |                                                              |                              |
| `l7_out_bps_usage`         | 7层出带宽使用率       | 统计7层的ELB实例出带宽使用率。单位：百分比**注意：**若出带宽使用率达到100%，说明已经超出ELB规格所提供的性能保障，您的业务可以继续使用更高带宽，但对于带宽超出的部分，ELB无法承诺服务可用性指标。 | ≥ 0%         |                                                              |                              |
| `l7_ncps_usage`            | 7层新建连接数使用率   | 统计7层的ELB实例新建连接数使用率。单位：百分比               | ≥ 0%         |                                                              |                              |
| `l7_qps_usage`             | 7层查询速率使用率     | 统计7层的ELB实例查询速率使用率。单位：百分比                 | ≥ 0%         |                                                              |                              |
| `m18_l7_upstream_2xx`      | 7层后端返回码(2XX)    | 统计测量对象当前7层后端2XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     | 独享型负载均衡后端服务器组共享型负载均衡后端服务器组         | 1分钟                        |
| `m19_l7_upstream_3xx`      | 7层后端返回码(3XX)    | 统计测量对象当前7层后端3XX系列状态响应码的数量。（HTTP和HTTPS监听器才有此指标）单位：个/秒。 | ≥ 0个/秒     |                                                              |                              |
| `m25_l7_resp_Bps`          | 7层响应带宽           | 单位：比特/秒                                                | ≥ 0bit/s     |                                                              |                              |
| `m24_l7_req_Bps`           | 7层请求带宽           | 单位：比特/秒                                                | ≥ 0bit/s     |                                                              |                              |
| `l4_con_usage`             | 4层并发连接使用率     | 统计4层的ELB实例并发连接数使用率。单位：百分比               | ≥ 0%         | 独享型负载均衡器                                             | 1分钟                        |
| `l4_in_bps_usage`          | 4层入带宽使用率       | 统计4层的ELB实例入带宽使用率。单位：百分比**注意：**若入带宽使用率达到100%，说明已经超出ELB规格所提供的性能保障，您的业务可以继续使用更高带宽，但对于带宽超出的部分，ELB无法承诺服务可用性指标。 | ≥ 0%         |                                                              |                              |
| `l4_out_bps_usage`         | 4层出带宽使用率       | 统计4层的ELB实例出带宽使用率。单位：百分比**注意：**若出带宽使用率达到100%，说明已经超出ELB规格所提供的性能保障，您的业务可以继续使用更高带宽，但对于带宽超出的部分，ELB无法承诺服务可用性指标。 | ≥ 0%         |                                                              |                              |
| `l4_ncps_usage`            | 4层新建连接数使用率   | 统计4层的ELB实例新建连接数使用率。单位：百分比               | ≥ 0%         |                                                              |                              |

## 对象 {#object}

采集到的华为云 ELB 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

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
    "listeners"       : "{实例 JSON 数据}",
    "updated_at"      : "2022-06-22T02:41:57",
    "description"     : ""
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.instance_id`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - `fields.listeners` 为 JSON 序列化后字符串。
> - `fields.operating_status` 为负载均衡器的操作状态。取值范围：可以为 ONLINE 和 FROZEN。
