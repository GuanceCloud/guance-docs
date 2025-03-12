# 自建巡检

<<< custom_key.brand_name >>>支持通过 DataFlux Func 自定义智能巡检，基于智能算法，自动检测基础设施、应用程序问题，帮助用户发现 IT 系统运行过程中已经发生的问题和潜在的问题，通过根因分析，快速定位异常问题原因。

DataFlux Func 是一款函数开发、管理、执行平台。简单易用、无需从零搭建 Web 服务，无需管理服务器等基础设施，只需编写代码并发布，简单配置即可为函数生成 HTTP API 接口。

本文档主要介绍如何使用 DataFlux Func 脚本市场中的「<<< custom_key.brand_name >>>自建巡检 Core 核心包」脚本包在自建 DataFlux Func 中实现巡检函数的工作。

> 提示 1：请始终使用最新版 DataFlux Func 进行操作。

> 提示 2：本脚本包会不断加入新功能，请随时关注文档更新。

## 1. 前提条件

- [安装 DataFlux Func](https://<<< custom_key.func_domain >>>/doc/quick-start/) 

- [安装脚本包](https://<<< custom_key.func_domain >>>/doc/script-market-basic-usage/) 

## 2. 快速开始

要实现自建巡检的搭建，需要进行如下步骤：

1. 在<<< custom_key.brand_name >>>「管理 / API Key 管理」中创建用于进行操作的 API Key
2. 在自建的 DataFlux Func 中，通过「脚本市场」安装「<<< custom_key.brand_name >>>自建巡检 Core 核心包」
3. 在自建的 DataFlux Func 中，编写自建巡检处理函数
4. 在自建的 DataFlux Func 中，通过「管理 / 自动触发配置」，为所编写的函数创建自动触发配置

### 2.1 编写代码

一个典型的自建巡检处理函数如下：

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter

API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# 注册自建巡检
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('自建巡检示例')
def run(param1=1, param2=True, param3=None):
    '''
    这是一个示例自建巡检
    参数：
        param1 {int}  参数 1
        param2 {bool} 参数 2
        param3 {str}  参数 3
    '''
    # 生成事件报告器
    event_reporter = EventReporter()

    # ... 执行巡检处理，并生成数据
    event = {
        'title'  : '自建巡检示例',
        'message': f'''
            自建巡检内容支持 Markdown 格式，如：

            1. 参数`param1`值为`{param1}`
            2. 参数`param2`值为`{param2}`
            3. 参数`param3`值为`{param3}`
            ''',
        'status'        : 'error',
        'dimension_tags': { 'host': 'my_host' },
    }

    # 使用事件报告器报告事件
    event_reporter.report(event)
```

在脚本发布后，对应的函数即被注册到<<< custom_key.brand_name >>>，并可以在<<< custom_key.brand_name >>>平台「监控 / 智能巡检」中看到。

![](img/self-hosted-monitor-list.png)

### 2.2 代码详解

以下为本例中代码的分步解释。

#### import 部分

为了正常使用脚本市场提供的脚本，在安装脚本包后，需要通过`import`方式来引入这些组件。

~~~python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter
~~~

`self_hosted_monitor`是自建巡检函数装饰器，添加此装饰器的函数才会被注册到<<< custom_key.brand_name >>>。

`EventReporter`是事件报告器，用于上报事件数据。

#### 自建巡检注册、函数定义部分

需要注册到<<< custom_key.brand_name >>>的自建巡检，必须同时满足：

1. *先*使用`@self_hosted_monitor`装饰器装饰
2. *后*使用`@DFF.API(...)`装饰器装饰

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# 注册自建巡检
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('自建巡检示例')
def run(param1=1, param2=True, param3=None):
    '''
    这是一个示例自建巡检
    参数：
        param1 {int}  参数 1
        param2 {bool} 参数 2
        param3 {str}  参数 3
    '''
~~~

其中：

装饰器`@self_hosted_monitor`需要传入在<<< custom_key.brand_name >>>「管理 / API Key 管理」创建的 API Key ID 和 API Key。

装饰器`@DFF.API(...)`中指定的标题，在注册后会作为自建巡检的标题出现。

函数文档中的内容，在注册后会作为自建巡检配置页面中的文档出现。

#### 其他<<< custom_key.brand_name >>>节点

如果需要连接到非默认节点（杭州）的<<< custom_key.brand_name >>>，则需要额外传入<<< custom_key.brand_name >>>节点名参数，具体代码示例如下：

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = 'aws'

@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
# 下略。..
~~~

> 关于 `GUANCE_NODE` 可选值，可参考 [可用的<<< custom_key.brand_name >>>节点](https://<<< custom_key.func_domain >>>/doc/ui-guide-development-module-guance-node/)

<!-- 
`GUANCE_NODE`可选值如下：

| <<< custom_key.brand_name >>>节点         | `GUANCE_NODE`取值 |
| ------------------ | ----------------- |
| 中国区 1（杭州）   | `None`            |
| 中国区 2（宁夏）   | `aws`             |
| 中国区 3（张家口） | `cn3`             |
| 海外区 1（俄勒冈） | `us1`             |
-->


#### 事件部分

需要上报的事件数据为简单的`dict`，如：

~~~python
    event = {
        'dimension_tags': { 'host': 'my_host' },

        'status' : 'error',
        'title'  : '自建巡检示例',
        'message': f'''
            自建巡检内容支持 Markdown 格式，如：

            1. 参数`param1`值为`{param1}`
            2. 参数`param2`值为`{param2}`
            3. 参数`param3`值为`{param3}`
            ''',
    }
~~~

具体字段定义如下：

| 字段             | 类型 | 是否必须 | 说明                                                             |
| ---------------- | ---- | -------- | ---------------------------------------------------------------- |
| `title`          | str  | 必须     | 事件标题，单行纯文本                                             |
| `message`        | str  | 必须     | 事件内容，支持 Markdown 基础语法                                 |
| `status`         | str  | 必须     | 事件级别<br>可选值：`info`, `warning`, `error`, `critical`, `ok` |
| `dimension_tags` | dict |          | 检测维度，如：`{ "host": "my_host" }`                            |

*注意：由于钉钉机器人、飞书机器人、企业微信机器人并不支持 Markdown 的全部语法，在指定 message 字段时请做好取舍*

#### EventReporter 使用部分

事件报告器的使用非常简单，但需要注意的是，*必须在函数体内部实例化`EventReporter`对象*。

正确示例：

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('自建巡检示例')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter() # 正确示例

    event = { ... }

    event_reporter.report(event)
~~~

*错误示例：*

~~~python
event_reporter = EventReporter() # 错误示例

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('自建巡检示例')
def run(param1=1, param2=True, param3=None):
    event = { ... }

    event_reporter.report(event)
~~~

此外，`EventReporter.report(...)`方法也支持一次上报多个事件，如：

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('自建巡检示例')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter()

    events = [ { ... } ] # 多个事件数据称为数组

    event_reporter.report(events)
~~~

## 3. 在<<< custom_key.brand_name >>>配置自建巡检

已经注册到<<< custom_key.brand_name >>>的自建巡检函数，可以在<<< custom_key.brand_name >>>平台中进行配置运行参数、告警策略。

并且函数的文档也会一并展示，方便使用者参考。

![](img/self-hosted-monitor-edit.png)

## 4. 在自建 DataFlux Func 中配置自动触发配置

完成代码，并发布后，需要前往自建 DataFlux Func「管理 / 自动触发配置」，为函数创建自动触发配置后，函数才会实际运行。

![](img/self-hosted-monitor-cron-config.png)

*注意：自建巡检的参数在<<< custom_key.brand_name >>>中配置，「自动触发配置」中的参数指定不起作用*

执行一段时间后，即可在<<< custom_key.brand_name >>>查看生成的事件。

![](img/self-hosted-monitor-event.png)

## 5. 注意事项

使用自建巡检时，需要注意以下几个事项。

### 5.1 函数与<<< custom_key.brand_name >>>自建巡检的关联

自建 DataFlux Func 中的自建巡检函数会按照「函数 ID + DataFlux Func Secret 配置」生成关联 Key 与<<< custom_key.brand_name >>>平台的自建巡检关联。

因此，如果修改了以下任意一项，函数都会关联到不同的自建巡检上：

- 函数名称（`def xxxx`部分）
- 函数所在脚本 ID
- 函数所在脚本集 ID
- 不同的 DataFlux Func（即不同的 Secret）

### 5.2 函数注册

添加了`@self_hosted_monitor`装饰器的函数，在每次执行时都会尝试访问<<< custom_key.brand_name >>>并进行函数注册。

注册同时，函数的标题、文档、参数列表也会更新到<<< custom_key.brand_name >>>。

注册完成后，装饰器会从<<< custom_key.brand_name >>>下载对应自建巡检的配置（参数指定），并以自建巡检配置中指定的参数运行函数，而自动触发中配置的参数不会起作用。

### 5.3 在<<< custom_key.brand_name >>>禁用自建巡检

在<<< custom_key.brand_name >>>平台中可以禁用自建巡检。

但由于<<< custom_key.brand_name >>>并不能反向控制 DataFlux Func 的数据，因此自建 DataFlux Func 中的自动触发配置依然会照常执行。

函数执行后，`@self_hosted_monitor`装饰器会访问<<< custom_key.brand_name >>>并检查对应的自建巡检是否已被禁用，从而决定是否需要实际执行用户编写的函数。

因此在自建 DataFlux Func 中，自建巡检函数的自动触发配置始终都会运行。只在遇到对应<<< custom_key.brand_name >>>自建巡检被禁用时，立刻结束处理。

![](img/self-hosted-monitor-disabled.png)

### 5.4 在<<< custom_key.brand_name >>>删除自建巡检

<<< custom_key.brand_name >>>中的自建巡检可以删除，但如果实际的自建巡检存在，那么只要发布或者运行，都会再次自动在<<< custom_key.brand_name >>>创建自建巡检。

同时，由于自建巡检删除后重新创建后，UUID 会发生变化，因此实际上前后两个自建巡检并不是同一个，所产生的事件之间也不会关联。

## X. 附录

### X.1 各 IM 平台机器人 Markdown 支持文档

- [钉钉自定义机器人 / 自定义机器人接入](https://open.dingtalk.com/document/group/custom-robot-access)
- [飞书机器人 / 消息卡片 / 构造卡片内容 / Markdown 模块](https://open.feishu.cn/document/ukTMukTMukTM/uADOwUjLwgDM14CM4ATN)
- [企业微信机器人 / 群机器人配置说明 / markdown 类型](https://developer.work.weixin.qq.com/document/path/91770#markdown%E7%B1%BB%E5%9E%8B)
