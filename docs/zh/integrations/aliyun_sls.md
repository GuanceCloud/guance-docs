---
title: '阿里云 SLS'
tags: 
  - 阿里云
summary: '阿里云 SLS 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。'
__int_icon: 'icon/aliyun_sls'
dashboard:
  - desc: '阿里云 SLS 内置视图'
    path: 'dashboard/zh/aliyun_sls/'

---

<!-- markdownlint-disable MD025 -->
# 阿里云 SLS
<!-- markdownlint-enable -->

阿里云 SLS 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 SLS 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（阿里云-云监控）」(ID：`guance_aliyun_monitor`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏



[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               |    Metric Name     |                  Dimensions                  | Statistics | Unit         |
| ---- | :---:    | :----: | ---- | ---- |
| `AlarmIPCount`          |   发生错误IP统计   | `userId,project,logstore,alarm_type,source_ip` | Count      | Frequency    |
| `AlarmPV`               |   客户端错误次数   |           `userId,project,logstore`           | Sum        | Frequency    |
| `AlarmUV`               |  客户端错误机器数  |           `userId,project,logstore`           | Count      | Frequency    |
| `ConsumerGroupFallBehind` |    消费落后时长    |    `userId,project,logstore,consumerGroup`    | Maximum    | Second       |
| `FailedLines`           | 客户端解析失败行数 |           `userId,project,logstore`           | Sum        | Lines        |
| `InflowLine`            |      写入行数      |           `userId,project,logstore`           | Sum        | Lines/Minute |
| `LogCodeQPS`            |      服务状态      |        `userId,project,logstore,status`        | Count      | Count        |
| `LogInflow`             |      流入流量      |           `userId,project,logstore`           | Sum        | bytes        |
| `LogMethodQPS`          |      操作次数      |        `userId,project,logstore,method`        | Count      | Count        |
| `LogOutflow`            |      流出流量      |           `userId,project,logstore`           | Sum        | bytes        |
| `NetFlow`               |    网络流入流量    |           `userId,project,logstore`           | Sum        | bytes        |
| `SuccessdByte`          | 客户端解析成功流量 |           `userId,project,logstore`           | Sum        | bytes        |
| `SuccessdLines`         | 客户端解析成功行数 |           `userId,project,logstore`           | Sum        | Lines        |
| `SumQPS`                |      总体QPS       |           `userId,project,logstore`           | Count      | Count        |
