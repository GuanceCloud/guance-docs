---
title: '华为云 OBS'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_obs'
dashboard:

  - desc: '华为云 OBS 内置视图'
    path: 'dashboard/zh/huawei_obs'

monitor:
  - desc: '华为云 OBS 监控器'
    path: 'monitor/zh/huawei_obs'

---


<!-- markdownlint-disable MD025 -->
# 华为云 OBS
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 OBS 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-OBS采集）」(ID：`guance_huaweicloud_obs`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云-OBS采集）」，展开修改此脚本，找到`collector_configs`将`regions`后的地域换成自己实际的地域，再找到`monitor_configs`下面的`region_projects`,更改为实际的地域和Project ID。再点击保存发布

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-obs/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html){:target="_blank"}

| 指标ID                          | 指标名称                | 指标含义                                                     | 取值范围   | 测量对象         | 监控周期（原始指标） |
| ------------------------------- | ----------------------- | ------------------------------------------------------------ | ---------- | ---------------- | -------------------- |
| `get_request_count`             | GET类请求次数           | 该指标用于统计所有桶及桶中对象的GET请求次数。单位：次        | ≥ 0 counts | 桶               | 1分钟                |
| `put_request_count`             | PUT类请求次数           | 该指标用于统计所有桶及桶中对象的PUT请求次数。单位：次        | ≥ 0 counts | 桶               | 1分钟                |
| `first_byte_latency`            | GET类请求首字节平均时延 | 该指标用于统计GET操作，在一个统计周期内从系统收到完整请求到开始返回响应的耗时平均值。单位：毫秒 | ≥ 0 ms     | 桶               | 1分钟                |
| `request_count_4xx`             | 4xx状态码个数           | 该指标用于统计服务端响应状态码为4xx的请求数。单位：次        | ≥ 0 counts | 用户桶接口       | 1分钟                |
| `request_count_5xx`             | 5xx状态码个数           | 该指标用于统计服务端响应状态码为5xx的请求数。单位：次        | ≥ 0 counts | 用户桶接口       | 1分钟                |
| `total_request_latency`         | 总请求平均时延          | 该指标用于统计所有桶的所有操作，在一个统计周期内从系统收到完整请求到结束返回响应的耗时平均值。单位：毫秒 | ≥ 0 ms     | 用户桶接口       | 1分钟                |
| `request_count_per_second`     | 总TPS                   | 当前统计周期内平均每秒请求数。单位：次                       | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `request_count_get_per_second`  | GET类请求TPS            | 当前统计周期内所有GET类平均每秒请求数。单位：次              | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `request_count_put_per_second`  | PUT类请求TPS            | 当前统计周期内所有PUT类平均每秒请求数。单位：次              | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `request_count_delete_per_second` | DELETE类请求TPS         | 当前统计周期内所有DELETE类平均每秒请求数。单位：次           | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `request_success_rate`          | 请求成功率              | 该指标用于衡量存储服务的系统的可用性。非服务端错误请求（返回状态码为5xx）占总请求的百分比，计算方式：(1-5XX数量/总请求数量)*100%单位：% | ≥ 0，≤100  | 用户桶接口域名   | 1分钟                |
| `effective_request_rate`        | 有效请求率              | 该指标用于衡量客户端请求的有效性。有效请求占总请求数的百分比，计算方式：(客户端返回2XX、3XX数量/总请求数量)*100%单位：% | ≥ 0，≤100  | 用户桶接口       | 1分钟                |
| `request_break_rate`            | 请求中断率              | 该指标用于衡量因客户端中断请求的而导致的失败占比，计算方式：(客户端中断请求数量/总请求数量)*100%单位：% | ≥ 0，≤100  | 用户桶接口       | 1分钟                |
| `request_code_count`            | HTTP状态码次数          | 该指标用于统计服务端响应状态码的请求数。服务端响应状态码见[HTTP状态码](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section5){:target="_blank"}。单位：次 | ≥ 0 counts | 桶接口HTTP状态码 | 1分钟                |
| `api_request_count_per_second`  | 接口请求TPS             | 该指标用于统计当前租户所有桶及桶中对象的特定接口的请求，在一个统计周期内每秒请求数的平均值。支持的接口类型见[请求接口](https://support.huaweicloud.com/usermanual-obs/obs_03_0010.html#section4){:target="_blank"}。 | ≥ 0 counts | 桶接口           | 1分钟                |
| `request_count_monitor_2XX`     | 2xx状态码个数           | 该指标用于统计服务端响应状态码为2xx的请求数。单位：次        | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `request_count_monitor_3XX`     | 3xx状态码个数           | 该指标用于统计服务端响应状态码为3xx的请求数。单位：次        | ≥ 0 counts | 用户桶域名       | 1分钟                |
| `download_bytes`                | 总下载带宽              | 该指标用于统计周期内平均每秒下载对象大小总和。单位：字节/s   | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `download_bytes_extranet`       | 外网下载带宽            | 该指标用于统计周期内平均每秒外网下载对象大小总和。单位：字节/s | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `download_bytes_intranet`       | 内网下载带宽            | 该指标用于统计周期内平均每秒内网下载对象大小总和。单位：字节/s | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `upload_bytes`                  | 总上传带宽              | 该指标用于统计周期内平均每秒上传对象大小总和。单位：字节/s   | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `upload_bytes_extranet`         | 外网上传带宽            | 该指标用于统计周期内平均每秒外网上传对象大小总和。单位：字节/s | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `upload_bytes_intranet`         | 内网上传带宽            | 该指标用于统计周期内平均每秒内网上传对象大小总和。单位：字节/s | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `cdn_bytes`                     | cdn回源带宽             | 该指标用于统计周期内cdn回源请求对象大小的每秒平均值，当前只统计公网流出。单位：字节/s | ≥ 0 byte/s | 用户桶           | 1分钟                |
| `download_traffic`              | 总下载流量              | 该指标用于统计周期内下载对象大小总和。单位：字节             | ≥ 0 byte/s | 用户桶域名       | 1分钟                |
| `download_traffic_extranet`     | 外网下载流量            | 该指标用于统计周期内外网下载对象大小总和。单位：字节         | ≥ 0 bytes  | 用户桶域名       | 1分钟                |
| `download_traffic_intranet`     | 内网下载流量            | 该指标用于统计周期内内网下载对象大小总和。单位：字节         | ≥ 0 bytes  | 用户桶域名       | 1分钟                |
| `upload_traffic`                | 总上传流量              | 该指标用于统计周期内上传对象大小总和。单位：字节             | ≥ 0 bytes  | 用户桶域名       | 1分钟                |
| `upload_traffic_extranet`       | 外网上传流量            | 该指标用于统计周期内外网上传对象大小总和。单位：字节         | ≥ 0 bytes  | 用户桶域名       | 1分钟                |
| `upload_traffic_intranet`       | 内网上传流量            | 该指标用于统计周期内内网上传对象大小总和。单位：字节         | ≥ 0 bytes  | 用户桶域名       | 1分钟                |
| `cdn_traffic`                   | cdn回源流量             | 该指标用于统计周期内cdn回源请求的流量的总和，当前只统计公网流出。单位：字节 | ≥ 0 bytes  | 用户桶           | 1分钟                |
| `capacity_total`                   | 存储总用量         | 该指标用于统计所有数据所占用的存储空间容量。单位：字节       | ≥ 0 bytes | 用户桶   | 30分钟               |
| `capacity_standard`                | 标准存储用量       | 该指标用于统计标准存储数据所占用的存储空间容量。单位：字节   | ≥ 0 bytes | 用户桶   | 30分钟               |
| `capacity_infrequent_access`       | 低频存储用量       | 该指标用于统计低频访问存储数据所占用的存储空间容量。单位：字节 | ≥ 0 bytes | 用户桶   | 30分钟               |
| `capacity_archive`                 | 归档存储用量       | 该指标用于统计归档存储数据所占用的存储空间容量。单位：字节   | ≥ 0 bytes | 用户桶   | 30分钟               |
| `capacity_deep_archive`            | 深度归档存储用量   | 该指标用于统计深度归档存储数据所占用的存储空间容量。单位：字节 | ≥ 0 bytes | 用户桶   | 30分钟               |
| `object_num_all`                   | 存储对象总数       | 该指标用于统计所有类型存储的对象数总量，对象数量是桶内文件夹、当前版本文件和历史版本文件的总和。单位：个 | ≥ 0个     | 用户桶   | 30分钟               |
| `object_num_standard_total`        | 标准存储对象总数   | 该指标用于统计标准存储所存储的对象数总量，对象数量是桶内文件夹、当前版本文件和历史版本文件的总和。单位：个 | ≥ 0个     | 用户桶   | 30分钟               |
| `object_num_infrequent_access_total` | 低频存储对象总数   | 该指标用于统计低频访问存储所存储的对象数总量，对象数量是桶内文件夹、当前版本文件和历史版本文件的总和。单位：个 | ≥ 0个     | 用户桶   | 30分钟               |
| `object_num_archive_total`         | 归档存储对象总数   | 该指标用于统计归档存储所存储的对象数总量，对象数量是桶内文件夹、当前版本文件和历史版本文件的总和。单位：个 | ≥ 0个     | 用户桶   | 30分钟               |
| `object_num_deep_archive_total`    | 深度归档存储对象数 | 该指标用于统计深度归档存储所存储的对象数总量，对象数量是桶内文件夹、当前版本文件和历史版本文件的总和。单位：个 | ≥ 0个     | 用户桶   | 30分钟               |

## 对象 {#object}

采集到的华为云 OBS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_obs",
  "tags": {
    "name"       : "test0-6153",
    "RegionId"   : "cn-north-4",
    "bucket_type": "OBJECT",
    "location"   : "cn-north-4"
  },
  "fields": {
    "create_date": "2022/06/16 10:51:16",
    "message"    : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下

bucket_type（桶类型）取值含义

| 取值     | 说明         |
| :------- | :----------- |
| `OBJECT` | 对象存储桶   |
| `POSIX`  | 并行文件系统 |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为桶名称，作为唯一识别提示：`tags.name`值为桶名称，作为唯一识别
