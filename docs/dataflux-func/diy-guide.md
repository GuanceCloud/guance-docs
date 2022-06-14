# DIY手册
---


本文档主要面向对观测云有进一步DIY需求（如：编写自定义检测）时，「DataFlux 支持」脚本集的使用介绍

## 1. 版本及系统要求

要求DataFlux Func `v1.19.62`（2021-06-08发布）及以上版本。

> 提示：版本信息可以在「管理 - 关于」中查看

*注意：独立部署版的DataFlux Func 由于不存在与观测云直接联动的部分，因此不存在DIY 的概念*



## 2. 导入DIY函数包

与观测云对接的函数都已经经过预先封装，可以在「脚本库 - DataFlux 支持 - DIY函数包」中找到。

*注意：不要将自行下载的脚本直接加入「DataFlux 支持」脚本集中，也不要修改「DataFlux 支持」中的任何脚本*

导入DIY函数包和导入其他脚本相同，直接使用`import`语句即可。

示例如下：

```python
import dataflux__diy as diy
```

## 3. 使用DIY函数包

DIY函数包中提供了与观测云对接最常用的一组函数。

### diy.dql_query(...)

`dql_query(...)`方法用于执行DQL语句，参数如下：

|           参数           |  类型  | 是否必须 | 默认值  |                                                                                说明                                                                               |
|--------------------------|--------|----------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `workspace_uuid`         | str    | 必须     |         | 工作空间ID                                                                                                                                                        |
| `dql`                    | str    | 必须     |         | DQL语句                                                                                                                                                           |
| `echo_explain`           | bool   |          | `False` | 是否返回原始查询语句                                                                                                                                              |
| `dict_output`            | bool   |          | `False` | 是否自动转换数据为`dict`                                                                                                                                          |
| `raw`                    | bool   |          | `False` | 是否返回原始响应。开启后`dict_output`参数无效。                                                                                                                   |
| `all_series`             | bool   |          | `False` | 是否自动通过`slimit`和`soffset`翻页以获取全部时间线。                                                                                                             |
| `conditions`             | str    |          | `None`  | 【Kodo原生参数】额外添加DQL语法的条件表达式。<br>与原查询语句的条件表达式成`AND`关系，且会在最外层添加括号避免与其混乱。                                          |
| `time_range`             | [int]  |          | `None`  | 【Kodo原生参数】限制时间范围，格式为`[{开始时间戳}, {结束时间戳}]`，单位为`毫秒`。<br>如果只有一个元素则认为是起始时间。此参数会覆盖原查询语句中的查询时间区间。  |
| `max_duration`           | str    |          | `"1y"`  | 【Kodo原生参数】限制最大查询时间，支持单位 `ns`/`us`/`ms`/`s`/`m`/`h`/`d`/`w`/`y` 。<br>如：`3d`表示3天，`2w`表示2周，`1y`表示1年。此参数会限制`time_range`参数。 |
| `max_point`              | int    |          | `None`  | 【Kodo原生参数】限制聚合最大点数。<br>在使用聚合函数时，如果聚合密度过小导致点数太多，则会以`({结束时间} - {开始时间}) / max_point`得到新的聚合间隔将其替换。     |
| `orderby`                | [dict] |          | `None`  | 【Kodo原生参数】指定`order by`参数，格式为 `[{"字段名":"ASC/DESC"}]`<br>此参数会替换原查询语句中的 order by。                                                     |
| `disable_slimit`         | bool   |          | `False` | 【Kodo原生参数】是否禁用默认`SLimit`。<br>当为`True`时，将不添加默认`SLimit`值，否则会强制添加`SLimit 20`。                                                       |
| `disable_multiple_field` | bool   |          | `False` | 【Kodo原生参数】是否禁用多字段。<br>当为`True`时，只能查询单个字段的数据（不包括`time`字段）。                                                                    |

```python
import time
import json

import dataflux__diy as diy

@DFF.API('查询最近1小时的数据')
def test_dql_query():
    # 使用time_range参数，限制最近1小时数据
    time_range = [
        int(time.time() - 3600) * 1000,
        int(time.time()) * 1000,
    ]
    res = diy.dql_query(dql='O::HOST:(host,load,create_time)', time_range=time_range, dict_output=True)
    print(json.dumps(res))
```

*注意：当使用「自动触发配置」周期性调用函数来查询DQL时，函数实际执行事件可能会因为任务量多而导致排队，`time.time()`所取得的时间未必是函数「计划启动的时间」，此时，应当使用内置变量`_DFF_TRIGGER_TIME`或`_DFF_TRIGGER_TIME_MS`来替代`time.time()`，如：*

```python
import time
import json

import dataflux__diy as diy

@DFF.API('每整点查询最近1小时的数据', fixed_crontab='0 * * * *')
def test_dql_query():
    # 使用_DFF_TRIGGER_TIME作为time_range参数基准，保证时间范围两端是整点
    time_range = [
        (_DFF_TRIGGER_TIME - 3600) * 1000,
        _DFF_TRIGGER_TIME * 1000,
    ]
    res = diy.dql_query(dql='O::HOST:(host,load,create_time)', time_range=time_range, dict_output=True)
    print(json.dumps(res))
```

输出示例：

```json
{
  "statement_id": 0,
  "series": [
    [
      {
        "time": 1622463105293,
        "host": "iZbp152ke14timzud0du15Z",
        "load": 2.18,
        "create_time": 1622429576363,
        "tags": {}
      },
      {
        "time": 1622462905921,
        "host": "ubuntu18-base",
        "load": 0.08,
        "create_time": 1622268259114,
        "tags": {}
      },
      {
        "time": 1622461264175,
        "host": "shenrongMacBook.local",
        "load": 2.395508,
        "create_time": 1622427320834,
        "tags": {}
      }
    ]
  ]
}
```

### diy.write_metric(...)

`write_metric(...)`方法用于写入指标数据，参数如下：

|        参数       |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token` | str            | 必须     |            | 工作空间Token                                                   |
| `measurement`     | str            | 必须     |            | 指标集名称                                                      |
| `tags`            | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `fields`          | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `timestamp`       | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_metric():
    workspace_token = 'tkn_xxxxx'
    measurement     = '指标'
    tags            = { '标签名': '标签值' }
    fields          = { '字段名': '字段值' }
    status_code, res = diy.write_metric(workspace_token, measurement, tags, fields)
```

### diy.write_metric_many(...)

`write_metric(...)`方法的批量版本，参数如下：

|           参数          |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token`       | str            | 必须     |            | 工作空间Token                                                   |
| `points`                | list           | 必须     |            | 数据点列表                                                      |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_metric_many():
    workspace_token = 'tkn_xxxxx'
    points = [
        {
            'measurement': '指标',
            'tags'       : { '标签名': '标签值' },
            'fields'     : { '字段名': '字段值' },
        }
    ]
    status_code, res = diy.write_metric_many(workspace_token, points)
```

### diy.write_log(...)

`write_log(...)`方法用于写入日志数据，参数如下：

|        参数       |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token` | str            | 必须     |            | 工作空间Token                                                   |
| `measurement`     | str            | 必须     |            | 指标集名称                                                      |
| `tags`            | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `fields`          | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `timestamp`       | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_log():
    workspace_token = 'tkn_xxxxx'
    measurement     = '日志'
    tags            = { '标签名':'标签值' }
    fields          = { 'title' :'标题', 'message':'内容' }
    status_code, res = diy.write_log(workspace_token, measurement, tags, fields)
```

### diy.write_log_many(...)

`write_log(...)`方法的批量版本，参数如下：

|           参数          |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token`       | str            | 必须     |            | 工作空间Token                                                   |
| `points`                | list           | 必须     |            | 数据点列表                                                      |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_log_many():
    workspace_token = 'tkn_xxxxx'
    points = [
        {
            'measurement': '日志',
            'tags'       : { '标签名':'标签值' },
            'fields'     : { 'title' :'标题', 'message':'内容' },
        }
    ]
    status_code, res = diy.write_log_many(workspace_token, points)
```

### diy.write_object(...)

`write_object(...)`方法用于写入对象数据，参数如下：

|        参数       |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token` | str            | 必须     |            | 工作空间Token                                                   |
| `measurement`     | str            | 必须     |            | 指标集名称                                                      |
| `tags`            | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `fields`          | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `timestamp`       | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_object():
    workspace_token = 'tkn_xxxxx'
    measurement     = '对象'
    tags            = { 'name': '我的对象', '标签名':'标签值' }
    fields          = { 'class': 'host', 'host' :'主机' }
    status_code, res = diy.write_object(workspace_token, measurement, tags, fields)
```

### diy.write_object_many(...)

`write_object(...)`方法的批量版本，参数如下：

|           参数          |      类型      | 是否必须 |   默认值   |                               说明                              |
|-------------------------|----------------|----------|------------|-----------------------------------------------------------------|
| `workspace_token`       | str            | 必须     |            | 工作空间Token                                                   |
| `points`                | list           | 必须     |            | 数据点列表                                                      |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

```python
def test_write_object_many():
    workspace_token = 'tkn_xxxxx'
    points = [
        {
            'measurement': '对象',
            'tags'       : { 'name': '我的对象', '标签名':'标签值' },
            'fields'     : { 'class': 'host', 'host' :'主机' },
        }
    ]
    status_code, res = diy.write_object_many(workspace_token, points)
```

### diy.send_mail(...)

`send_mail(...)`方法用于发送邮件，参数如下：

|    参数   | 类型 | 是否必须 | 默认值 |        说明        |
|-----------|------|----------|--------|--------------------|
| `to`      | str  | 必须     |        | 收件人邮箱地址     |
| `title`   | str  | 必须     |        | 邮件标题           |
| `content` | str  | 必须     |        | 邮件正文（纯文本） |

示例如下：

```python
import dataflux__diy as diy

def test_sending_mail():
    diy.send_mail(to='zhang3@jiagouyun.com', title='测试', content='这是一封测试邮件')
```

*注意：由于阿里云等对邮件发送存在限流、管控处理。频繁发送消息时应当使用缓冲合并发送版本`diy.send_mail_buff(...)`*

### diy.send_mail_buff(...)

`diy.send_mail(...)`的缓冲合并发送版本，参数如下：

|    参数   | 类型 | 是否必须 | 默认值 |        说明        |
|-----------|------|----------|--------|--------------------|
| `to`      | str  | 必须     |        | 收件人邮箱地址     |
| `title`   | str  | 必须     |        | 邮件标题           |
| `content` | str  | 必须     |        | 邮件正文（纯文本） |

### diy.send_dingtalk(...)

`send_dingtalk(...)`方法用于发送钉钉机器人消息，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 钉钉机器人调用地址       |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |
| `secret`   | str  |          |        | 钉钉机器人验签密钥       |

示例如下：

```python
import dataflux__diy as diy

def test_sending_dingtalk():
    diy.send_dingtalk(
        webhook='https://oapi.dingtalk.com/robot/send?access_token=xxxxx',
        title='测试',
        markdown='# 这是一条测试消息',
        secret='xxxxx')
```

*注意：由于钉钉对机器人消息发送存在限流处理。频繁发送消息时应当使用缓冲合并发送版本`diy.send_dingtalk_buff(...)`*

### diy.send_dingtalk_buff(...)

`diy.send_dingtalk(...)`的缓冲合并发送版本，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 钉钉机器人调用地址       |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |
| `secret`   | str  |          |        | 钉钉机器人验签密钥       |

### diy.send_wechat(...)

`send_wechat(...)`方法用于发送企业微信机器人消息，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 企业微信机器人调用地址   |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |

示例如下：

```python
import dataflux__diy as diy

def test_sending_wechat():
    diy.send_wechat(
        webhook='https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxxxx',
        title='测试',
        markdown='# 这是一条测试消息')
```

*注意：由于企业微信对机器人消息发送存在限流处理。频繁发送消息时应当使用缓冲合并发送版本`diy.send_wechat_buff(...)`*

### diy.send_wechat_buff(...)

`diy.send_wechat(...)`的缓冲合并发送版本，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 钉钉机器人调用地址       |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |
| `secret`   | str  |          |        | 钉钉机器人验签密钥       |

### diy.send_feishu(...)

`send_feishu(...)`方法用于发送飞书机器人消息，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 飞书机器人调用地址       |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |
| `secret`   | str  |          |        | 飞书机器人验签密钥       |

示例如下：

```python
import dataflux__diy as diy

def test_sending_feishu():
    diy.send_feishu(
        webhook='https://open.feishu.cn/open-apis/bot/v2/hook/xxxxx',
        title='测试',
        markdown='# 这是一条测试消息',
        secret='xxxxx')
```

*注意：由于飞书对机器人消息发送存在限流处理。频繁发送消息时应当使用缓冲合并发送版本`diy.send_feishu_buff(...)`*

### diy.send_feishu_buff(...)

`diy.send_feishu(...)`的缓冲合并发送版本，参数如下：

|    参数    | 类型 | 是否必须 | 默认值 |           说明           |
|------------|------|----------|--------|--------------------------|
| `webhook`  | str  | 必须     |        | 飞书机器人调用地址       |
| `title`    | str  | 必须     |        | 消息标题                 |
| `markdown` | str  | 必须     |        | 消息正文（Markdown格式） |
| `secret`   | str  |          |        | 飞书机器人验签密钥       |

### diy.create_event(...)

`diy.create_event(...)`方法用于生成事件对象，生成的事件对象可以使用`diy.send_event_to_dataflux(...)`发送至观测云，参数如下：

|        参数        | 类型 | 是否必须 | 默认值 |                            说明                            |
|--------------------|------|----------|--------|------------------------------------------------------------|
| `status`           | str  | 必须     |        | 事件级别，可选`ok`, `info`, `warning`, `error`, `critical` |
| `title`            | str  | 必须     |        | 事件标题                                                   |
| `message`          | str  | 必须     |        | 事件详情内容                                               |
| `diy_checker_ref`  | str  | 必须     |        | 此类事件所属的检测项编号，如：`check-001`                  |
| `diy_checker_name` | str  | 必须     |        | 此类事件所属的检测项名称，如：`DIY检测001`                 |
| `check_data`       | dict |          | `None` | 检测数据，如：`{ "cpu" : 100 }`                            |
| `date_range`       | int  |          | `0`    | 事件持续时间                                               |
| `dimension_tags`   | dict |          | `None` | 事件关联对象维度标签，如：`{ "host": "web01" }`            |

示例如下：

```python
import dataflux__diy as diy

def test_event_1():
    event = diy.create_event(
        status='critical',
        title='服务器A进程已退出',
        message='服务器A进程是常驻进程，但目前已退出，请尽快进行排查！',
        diy_checker_ref='check-001',
        diy_checker_name='DIY检测001',
        date_range=60 * 5,
        check_data={ "cpu" : 100 },
        dimension_tags={ "host": "web01" })
```

### diy.write_events(...)

`write_events(...)`方法用于发送事件对象至观测云，同时支持事件的告警提示，参数如下：

|         参数         |  类型 | 是否必须 | 默认值 |                    说明                   |
|----------------------|-------|----------|--------|-------------------------------------------|
| `workspace_uuid`     | str   | 必须     |        | 工作空间ID                                |
| `workspace_token`    | str   | 必须     |        | 工作空间Token                             |
| `events`             | list  | 必须     |        | 事件对象列表                              |
| `events[#]`          | Event | 必须     |        | 事件对象可通过`diy.create_event(...)`生成 |
| `alert_receivers`    | list  |          | `None` | 告警接受者列表                            |
| `alert_receivers[#]` | dict  | 必须     |        | 告警接收者配置（详情见示例）              |

示例如下：

```python
import dataflux__diy as diy

ALERT_RECEIVERS = [
    # 钉钉机器人告警
    {
        "type"       : "dingTalkRobot",  # 告警类型
        "name"       : "我的钉钉机器人", # 随意起个名称
        "minInterval": 300,              # 最短告警间隔（即沉默时长，单位秒）

        # 其他告警所需配置
        "webhook": "https://oapi.dingtalk.com/robot/send?access_token=xxxxx",
        "secret" : "xxxxx",
    },
    # 企业微信机器人告警
    {
        "type"       : "wechatRobot",        # 告警类型
        "name"       : "我的企业微信机器人", # 随意起个名称
        "minInterval": 300,                  # 最短告警间隔（即沉默时长，单位秒）

        # 其他告警所需配置
        "webhook": "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxxxx",
    },
]

def test_event_2():
    workspace_uuid  = 'wksp_xxxxx'
    workspace_token = 'tkn_xxxxx'

    events = []

    # 执行某些处理，得出需要产生的事件
    dimension_tags = { "host": "web01" }
    check_data     = { "cpu" : 100 }
    if check_value['cpu'] > 90:
        # 有故障
        event = diy.create_event(
            status='critical',
            title='服务器A进程已退出',
            message='服务器A进程是常驻进程，但目前已退出，请尽快进行排查！',
            diy_checker_ref='check-001',
            diy_checker_name='DIY检测001',
            date_range=60 * 5,
            check_data=check_data,
            dimension_tags=dimension_tags)
        events.append(event)

    # 发送事件至观测云
    if events:
        diy.write_events(
            workspace_uuid=workspace_uuid,
            workspace_token=workspace_token,
            events=events,
            alert_receivers=ALERT_RECEIVERS)
```
