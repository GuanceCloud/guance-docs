---
title: 'OpenAI'
summary: 'OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。'
__int_icon: 'icon/openai'
dashboard:

  - desc: 'OpenAI 内置视图'
    path: 'dashboard/zh/openai'

monitor:
  - desc: 'OpenAI 监控器'
    path: 'monitor/zh/openai'

---

<!-- markdownlint-disable MD025 -->

# OpenAI

<!-- markdownlint-enable -->

OpenAI的展示指标包括请求总数，响应时间，，请求数量，请求错误数和消耗token数。

## 配置{#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装 DataKit

安装 DataKit 数据采集器，在{{{ custom_key.brand_name }}}空间内，点击 集成 -- Datakit，复制安装命令行安装 Datakit

**注**：安装好 DataKit 之后，修改一个配置：

- root 用户登录后打开 DataKit 配置：`vim /usr/local/datakit/conf.d/datakit.conf`
- 将 http_listen = "localhost:9529" 修改为 http_listen = "0.0.0.0:9529"
- 重启 DataKit 服务：`datakit service -R`

更多信息请参考：

- <https://func.guance.com/doc/practice-connect-to-datakit/>
- <https://docs.guance.com/datakit/datakit-service-how-to/>

### 安装脚本

安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（ChatGpt监控）」(ID：`guance_chatgpt_monitor`)

点击【安装】后，输入相应的参数：OpenAI key。

点击【管理】-‘授权链接’ -‘新建‘，给该函数创建一个授权链接，创建好后，在授权链接列表里，可以找到这个函数。 点击这个函数右侧的“示例”， 选择’POST 简化形式 （**Json**）‘， 会得到一个链接，将该链接填入代码 'url' 处。

我们默认采集了一些配置, 具体见指标一栏

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

| Metric        | Description   | Type  | Unit  |
| ------------- | ------------- | ----- | ----- |
| question      | 请求总数      | float | count |
| response_time | 响应时间      | float | s     |
| create_time   | 请求数量      | float | count |
| res_status    | 请求错误数    | float | count |
| total_tokens  | 消耗总token数 | float | count |
