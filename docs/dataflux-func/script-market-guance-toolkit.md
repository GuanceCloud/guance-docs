# 观测云工具包
---


本文档主要介绍如何使用脚本市场中的「观测云工具包」脚本包进行一些无法直接在观测云平台中操作的工作。

> 提示：请始终使用最新版 DataFlux Func 进行操作。

> 提示 2: 本脚本包会不断加入新功能，请随时关注本文档页。

## 1. 背景

在用户使用观测云平台的过程中，存在一些工作无法直接在观测云平台中操作。用户可以从脚本市场安装本脚本包，进行简单的配置后，即可完成相应的工作。

本文假设用户已经了解并安装了相关脚本包。
有关如何在 DataFlux Func 的脚本市场中安装脚本版，请参考：

- [脚本市场基本操作](/dataflux-func/script-market-basic-usage)

本文假设用户已经了解如何使用 DQL。
有关如何编写 DQL 语句，请参考：

- [观测云文档 / DQL](/dql/)

## 2. 可用组件

可用组件是一些针对观测云最常用、最基础的组件。这些组件一般并不会直接实现你的需求，而作为方便函数为各种代码实现提供帮助。

### 2.1 OpenWay

OpenWay 操作组件，可实现通过工作空间 Token 查询对应工作空间内的数据。

> 有关 OpenWay.dql_query(...) 的更多参数，请参考 [观测云文档 / DataKit / DataKit 开发 / DataKit API](/datakit/apis/#api-raw-query)

示例代码如下：

```python
import json
from guance_toolkit__guance import OpenWay

def run():
    openway = OpenWay('tkn_xxxxx')

    # 典型使用方式
    dql = '''M::cpu:(load5s)'''
    dql_res = openway.dql_query(dql, limit=1)
    print('典型使用方式：\n', json.dumps(dql_res, indent=2))

    # 日志类通过 time_range, search_after 翻页
    search_after = []
    time_range = [
        '2022-09-14T12:00:00+08:00',
        '2022-09-14T12:00:01+08:00',
    ]
    for i in range(2):
        dql = '''L::re(`.*`):(message){ `source` IN ['gin'] }'''
        dql_res = openway.dql_query(dql, limit=1, time_range=time_range, search_after=search_after)
        print(f'日志类第【{i+1}】页：\n', json.dumps(dql_res, indent=2))

        # 下一页开始标志
        search_after = dql_res['content'][0]['search_after']
```

输出如下：

```
[2022-09-20 17:37:05.707] [+0ms] 典型使用方式：
 {
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "load5s"
          ],
          "values": [
            [
              1663027200056,
              10
            ]
          ]
        }
      ],
      "points": "",
      "cost": "19.265169ms",
      "is_running": false,
      "async_id": ""
    }
  ]
}
[2022-09-20 17:37:05.908] [+201ms] 日志类第【1】页：
 {
  "content": [
    {
      "series": [
        {
          "columns": [
            "time",
            "message"
          ],
          "values": [
            [
              1663128000997,
              "[GIN] 2022/09/14 - 04:00:00 | 200 |    3.317484ms |     10.120.0.70 | GET      \"/v1/datakit/pull?token=****************24f2f97128a9c6813289c&filters=true\""
            ]
          ]
        }
      ],
      "points": "",
      "cost": "63ms",
      "total_hits": 1697,
      "search_after": [
        1663128000997,
        "L_1663128000997_ccgl3h2rnkq7doms8f10"
      ],
      "is_running": false,
      "async_id": ""
    }
  ]
}
[2022-09-20 17:37:06.060] [+151ms] 日志类第【2】页：
 {
  "content": [
    {
      "series": [
        {
          "columns": [
            "time",
            "message"
          ],
          "values": [
            [
              1663128000997,
              "[GIN] 2022/09/14 - 04:00:00 | 200 |   13.559498ms |      10.120.0.6 | POST     \"/v1/election?token=****************24f2f97128a9c6813289c&namespace=k8s-03&id=k8s03-node08\""
            ]
          ]
        }
      ],
      "points": "",
      "cost": "67ms",
      "total_hits": 1697,
      "search_after": [
        1663128000997,
        "L_1663128000997_ccgl3h2rnkq7doms8f0g"
      ],
      "is_running": false,
      "async_id": ""
    }
  ]
}
```

## 3. 现成工具

现成工具是使用上述「可用组件」已经实现的工具类函数。

- 如果你的需求正好可以使用「现成工具」满足，可直接使用。
- 如果您的需求与现成功能有所出入，可以参考类似的函数自行实现所需功能

### 3.1 导出日志为 CSV 文件

具体实现所在脚本：`guance_toolkit__export_impl`

可以从观测云将大量日志导出，并保存在 DataFlux Func 的资源目录下。
导出成功后，用户可以前往 DataFlux Func「管理 - 文件管理器」下载 CSV 文件。

> 如果找不到「文件管理器」，可以在「管理 - 实验性功能」中开启。

典型使用代码如下：

```python
import guance_toolkit__api as guance_toolkit

@DFF.API('导出 gin 日志')
def run():
    # DQL 语句（注意不要指定时间范围）
    dql = '''L::re(`.*`):(log_time,message,message_length){ `source` IN ['gin'] }'''

    # 时间范围
    start_time = '2022-09-14T12:00:00+08:00'
    end_time   = '2022-09-14T12:00:10+08:00'

    # 工作空间 Token
    workspace_token = 'tkn_xxxxx'

    # 输出地址（资源目录下相对地址，不要以/开头）
    # 默认输出地址为：
    #   guance_toolkit/gaunce-export-data-<执行时间>.csv
    file_path = 'export-data.csv'

    # 启动执行
    guance_toolkit.export_logging(dql=dql,
                                  start_time=start_time,
                                  end_time=end_time,
                                  workspace_token=workspace_token,
                                  file_path=file_path)
```

> 提示：您在实现自己的代码时，可以根据需要将部分导出参数作为函数的输入参数，实现更通用的导出函数或接口

完成代码后，在「管理 - 批处理」中为此函数创建一个「批处理」，并根据示例调用即可。

创建批处理并调用：

![](script-market-guance-toolkit/logging-export-1.png)

查看批处理执行日志：

![](script-market-guance-toolkit/logging-export-2.png)
![](script-market-guance-toolkit/logging-export-3.png)

获取批处理执行生成的文件：

![](script-market-guance-toolkit/logging-export-4.png)