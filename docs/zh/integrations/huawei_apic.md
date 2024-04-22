---
title: '华为云 API'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_apic'
dashboard:

  - desc: 'HUAWEI APIC 专享版网关 监控视图'
    path: 'dashboard/zh/huawei_api'

monitor:
  - desc: '华为云 APIC 监控器'
    path: 'monitor/zh/huawei_api'

---


<!-- markdownlint-disable MD025 -->
# 华为云 API
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 API 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云 - **APIG** 采集）」(ID：`guance_huaweicloud_apig`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云 - **APIG** 采集）」，展开修改此脚本，找到`collector_configs`将`regions`后的地域换成自己实际的地域，再找到`monitor_configs`下面的`region_projects`,更改为实际的地域和Project ID。再点击保存发布

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-apig/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-apig/apig-ug-180427085.html){:target="_blank"}

| 指标ID                                 | 指标名称  | 指标含义                                                 | 取值范围     | 测量对象        | 监控周期（原始指标） |
|--------------------------------------|-------| -------------------------------------------------------- |----------| --------------- | -------------------- |
| `requests`                           | 接口调用次数 | 统计测量api接口被调用的次数。| ≥0       | 专享版API网关实例              | 1分钟                |
| `error_4xx`                          | 4xx异常次数 | 统计测量api接口返回4xx错误的次数。   | ≥0       | 专享版API网关实例              | 1分钟                |
| `error_5xx`                          | 5xx异常次数 | 统计测量api接口返回5xx错误的次数 | ≥0       | 专享版API网关实例              | 1分钟                |
| `throttled_calls`                    | 被流控的调用次数 | 统计测量api被流控的调用次数    | ≥0       | 专享版API网关实例     | 1分钟                |
| `avg_latency`                        | 平均延迟毫秒数| 统计测量api接口平均响应延时时间    | ≥0 单位：毫秒| 专享版API网关实例      | 1分钟                |
| `max_latency`                        | 最大延迟毫秒数|统计测量api接口最大响应延时时间|  ≥0 单位：毫秒  | 专享版API网关实例      | 1分钟                |
| `req_count`                          | 接口调用次数 | 该指标用于统计测量api接口调用次数                |≥0|单个API     | 1分钟                |
| `req_count_2xx`                      | 2xx调用次数 | 该指标用于统计测量api接口调用2xx的次数          | ≥ 0  | 单个API       | 1分钟                |
| `req_count_4xx`                      | 4xx异常次数| 该指标用于统计测量api接口返回4xx错误的次数          | ≥ 0 | 单个API      | 1分钟                |
| `req_count_5xx`                      | 5xx异常次数| 该指标用于统计测量api接口返回5xx错误的次数       | ≥ 0  | 单个API      | 1分钟                |
| `req_count_error`               | 异常次数 | 该指标用于统计测量api接口总的错误次数 | ≥ 0| 单个API  | 1分钟                |
| `avg_latency`             | 平均延迟毫秒数| 该指标用于统计测量api接口平均响应延时时间| ≥0 单位：毫秒 | 单个API      | 1分钟                |
| `max_latency`                 | 最大延迟毫秒数 | 该指标用于统计测量api接口最大响应延时时间 | ≥0 单位：毫秒 | 单个API      | 1分钟                |
| `input_throughput`                 | 流入流量 | 该指标用于统计测量api接口请求流量 | ≥0。单位：Byte/KB/MB/GB| 单个API | 1分钟                |
| `output_throughput`       | 流出流量| 该指标用于统计测量api接口返回流量 | ≥0。单位：Byte/KB/MB/GB | 单个API          | 1分钟                |

## 对象 {#object}

采集到的华为云 API 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_apig",
  "tags": {
            "account_name":"Huawei",
            "class":"huaweicloud_apig",
            "cloud_provider":"huaweicloud",
            "instance_name":"apig-d0m1",
            "instance_status":"6",
            "loadbalancer_provider":"elb",
            "RegionId":"cn-north-4",
            "spec":"BASIC",
            "status":"Running",
            "type":"apig"
          },
}
```


> *注意：`tags`中的字段可能会随后续更新有所变动*
>
> 提示 1：`instance_name`值为名称，作为唯一识别.
