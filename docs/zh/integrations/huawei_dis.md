---
title: '华为云 DIS'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_dis'
dashboard:

  - desc: '华为云 DIS 内置视图'
    path: 'dashboard/zh/huawei_dis'

monitor:
  - desc: '华为云 DIS 监控器'
    path: 'monitor/zh/huawei_dis'

---


<!-- markdownlint-disable MD025 -->
# 华为云 DIS
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 DIS 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-DIS采集）」(ID：`guance_huaweicloud_dis`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云-DIS采集）」，展开修改此脚本，找到`collector_configs`和`monitor_configs`分别编辑下面`region_projects`中的内容，将地域和Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-dis/dis_01_0131.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象（维度） | 监控周期（原始指标）|
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| dis01_stream_put_bytes_rate   | 总输入流量             | 该指标用于统计指定时间范围内，通道上传数据量。 单位：byte/s。 | ≥ 0 bytes/s | 通道                              | 1分钟                                             |
| dis02_stream_get_bytes_rate              | 总输出流量             | 该指标用于统计指定时间范围内，通道下载数据量。单位：byte/s。 | ≥ 0 bytes/s | 通道                              | 1分钟                    |
| dis03_stream_put_records                 | 总输入记录数           | 该指标用于统计指定时间范围内，通道上传记录数。单位：Count/s。 | ≥ 0 Count/s | 通道                              | 1分钟                    |
| dis04_stream_get_records                 | 总输出记录数           | 该指标用于统计指定时间范围内，通道下载记录数。  单位：Count/s。 | ≥ 0 Count/s | 通道                              | 1分钟                    |
| dis05_stream_put_requests_succeed        | 上传请求成功数         | 该指标用于统计指定时间范围内，通道上传请求成功次数。 单位：Count/s。 | ≥ 0 Count/s | 通道                              | 1分钟                    |
| dis06_stream_get_requests_succeed        | 下载请求成功数         | 该指标用于统计指定时间范围内，通道下载请求成功次数。 单位：Count/s。 | ≥ 0 Count/s | 通道                              | 1分钟                    |
| dis07_stream_put_req_average_latency     | 上传请求平均处理时间   | 该指标用于统计指定时间范围内，通道上传请求平均时延。单位：ms。 | 0~50ms      | 通道                              | 1分钟                    |
| dis08_stream_get_req_average_latency     | 下载请求平均处理时间   | 该指标用于统计指定时间范围内，通道下载请求平均时延。 单位：ms。 | 0~50ms      | 通道                              | 1分钟                    |
| dis09_stream_traffic_control_put_records | 因流控拒绝的上传请求数 | 该指标用于统计指定时间范围内，通道由于流控而拒绝的上传请求数。 单位：Count/s。 | 0~1Count/s  | 通道                              | 1分钟                    |
| dis10_stream_traffic_control_get_records | 因流控拒绝的下载请求数 | 该指标用于统计指定时间范围内，通道由于流控而拒绝的下载请求数。 单位：Count/s。 | 0~1Count/s  | 通道                              | 1分钟                    |

## 对象 {#object}

采集到的华为云 DIS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_dis",
  "tags": {
    "RegionId"    : "cn-north-4",
    "data_type"   : "BLOB",
    "name"        : "dis-YoME",
    "project_id"  : "c631f04625xxxxexxxxxx253c62d48585",
    "status"      : "RUNNING",
    "stream_name" : "dis-YoME",
    "stream_type" : "COMMON"
  },
  "fields": {
    "partition_count"    : 1,
    "retention_period"   : 24,
    "auto_scale_enabled" : false,
    "create_time"        : 1691484876645,
    "message"            : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下：

| 字段                  | 类型                   |   说明                  |
| :------------------- | :--------------------- | :---------------------  |
| `create_time`        | integer | 通道创建的时间，13位时间戳。|
| `retention_period`  | integer | 数据保留时长，单位是小时。 |
| `status`  | str | 通道的当前状态。 CREATING：创建中  RUNNING：运行中  TERMINATING：删除中  TERMINATED：已删除 |
| `stream_type`  | str | 通道类型。 COMMON：普通通道，表示1MB带宽。 ADVANCED：高级通道，表示5MB带宽。 |
| `data_type`  | str | 源数据类型。 BLOB：存储在数据库管理系统中的一组二进制数据。 JSON：一种开放的文件格式，以易读的文字为基础，用来传输由属性值或者序列性的值组成的数据对象。 CSV：纯文本形式存储的表格数据，分隔符默认采用逗号。 缺省值：BLOB。 |
| `auto_scale_enabled`  | bool | 是否开启自动扩缩容。 true：开启自动扩缩容。 false：关闭自动扩缩容。 默认不开启。 缺省值：false |



> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：以下字段均为 JSON 序列化后字符串
>
> - fields.message




