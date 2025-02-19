---
title: '华为云 FunctionGraph'
tags: 
  - 华为云
summary: '华为云 FunctionGraph的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了FunctionGraph函数运行情况。'
__int_icon: 'icon/huawei_functiongraph'
dashboard:

  - desc: '华为云 FunctionGraph 内置视图'
    path: 'dashboard/zh/huawei_functiongraph'

monitor:
  - desc: '华为云 FunctionGraph 监控器'
    path: 'monitor/zh/huawei_functiongraph'

---


<!-- markdownlint-disable MD025 -->
# 华为云 FunctionGraph
<!-- markdownlint-enable -->

华为云 FunctionGraph的展示指标包括调用次数,错误次数,被拒绝次数,并发数,预留实例个数，运行时间（包括最大运行时间、最小运行时间、平均运行时间）等，这些指标反映了FunctionGraph函数运行情况。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 HUAWEI FunctionGraph 的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（华为云-FunctionGraph采集）」(ID：`guance_huaweicloud_functiongraph`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-functiongraph/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 HUAWEI SYS.FunctionGraph ,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-functiongraph/functiongraph_01_0213.html){:target="_blank"}

| 指标ID        | 指标名称     | 指标含义                                      | 取值范围      | 测量对象   | **监控周期（原始指标）** |
| ---- -------- | ----------- | -------------------------------------------- | ------------- | --------- | ---------------------- |
| `count`        | 调用次数      | 该指标用于统计函数调用次数。单位：次            | ≥ 0 counts   | 函数       | 1分钟                   |
| `failcount`    | 错误次数      | 该指标用于统计函数调用错误次数。以下两种情况都会记入错误次数：函数请求异常，导致无法执行完成且返回200。函数自身语法错误或者自身执行错误。单位：次          | ≥ 0 counts   | 函数       | 1分钟                   |
| `rejectcount`        | 被拒绝次数      | 该指标用于统计函数调用被拒绝次数。被拒绝次数是指并发请求太多，系统流控而被拒绝的请求次数。单位：次   | ≥ 0 counts   | 函数       | 1分钟                   |
| `concurrency`        | 并发数      | 该指标用于统计函数同时调用处理的最大并发请求个数。单位：个            | ≥ 0 counts   | 函数       | 1分钟                   |
| `reservedinstancenum`        | 预留实例个数      | 该指标用于统计函数配置的预留实例个数。单位：个           | ≥ 0 counts   | 函数       | 1分钟                   |
| `duration`        | 平均运行时间      | 该指标用于统计函数调用平均运行时间。单位：毫秒           | ≥ 0 ms   | 函数       | 1分钟                   |
| `maxDuration`        | 最大运行时间      | 该指标用于统计函数调用最大运行时间。单位：毫秒           | ≥ 0 ms   | 函数       | 1分钟                   |
| `minDuration`        | 最小运行时间      | 该指标用于统计函数最小运行时间。单位：毫秒           | ≥ 0 ms   | 函数       | 1分钟                   |

## 对象 {#object}

采集到的 HUAWEI SYS.FunctionGraph 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_functiongraph",
  "tags": {
    "code_type"    : "inline",
    "domain_id"    : "1e1fed98168XXXXXX0e285140c83",
    "func_name"    : "XXXXX",
    "func_urn"     : "urn:fss:cn-north-4:c631f046252d4ebda45f253c62d48585:function:default:Helloworld2",
    "handler"      : "index.handler",
    "image_name"   : "latest-230718XXXXX@fikfe",
    "namespace"    : "c631f04625XXXXXX45f253c62d48585",
    "package"      : "default",
    "project_name" : "cn-north-4",
    "runtime"      : "Python3.9"
  },
  "fields": {
    "code_size"       : 286,
    "cpu"             : 300,
    "last_modified"   : "2023-07-18TXX:XX:XX+08:00",
    "memory_size"     : 128,
    "timeout"         : 3,
    "strategy_config" : "{函数策略配置}",
    "message"         : "{实例 JSON 数据}"
  }
}

```


> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.last_modified`、`fields.message`、`fields.strategy_config`均为 JSON 序列化后字符串

