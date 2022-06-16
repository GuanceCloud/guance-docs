# 阿里云数据同步
---


##### 旧版提示: 本脚本包可以继续使用，但建议迁移至新版「观测云集成」系列脚本。

---

本文档主要介绍如何使用脚本市场中「阿里云数据同步」脚本包同步阿里云平台的相关数据。

> 提示：请始终使用最新版DataFlux Func 进行操作。

## 1. 背景

在使用观测云的过程中，云平台的一些数据可能无法通过DataKit 直接采集。

因此，DataFlux Func 提供了与各云平台对应的数据同步脚本包。用户可以从脚本市场安装相关的数据同步脚本包，进行简单的配置后，即可同步云平台的数据。

本文假设用户已经了解并安装了相关脚本包。
有关如何在DataFlux Func 的脚本市场中安装脚本版，请参考：

- [脚本市场基本操作](/dataflux-func/script-market-basic-usage)

本文假设用户已经在DataFlux Func 中正确连接了DataKit。
有关如何在DataFlux Func 中连接DataKit，请参考：

- [连接并操作DataKit](/dataflux-func/connect-to-datakit)

## 2. 关于本脚本包

本脚本包主要用于阿里云平台数据的获取并同步至观测云。

使用本脚本包，需要阿里云平台具有对应权限的AK。您可在阿里云「访问控制」中创建RAM 账号，并为RAM 账号创建AK 并授予所需权限。

*注意：为了您的账号安全，请勿直接使用账号AK，或为RAM账号AK分配过大的权限*

所需权限如下：

| 阿里云产品       | AK所需权限                         |
| ---------------- | ---------------------------------- |
| 云监控（Metric） | `AliyunCloudMonitorReadOnlyAccess` |
| 日志服务（SLS）  | `AliyunLogReadOnlyAccess`          |

也可以直接为RAM 账号授予全部云资源的只读权限`ReadOnlyAccess`。

## 3. 典型代码示例

通过简单的配置和极少量代码，即可实现相关数据的同步功能。

以下典型代码示例为实现同步功能的最简单配置。

### 3.1 云监控（Metric）

~~~python
import dataflux_aliyun__metric as metric

# 账号
ACCOUNTS = [
    {
        # 阿里云AK
        'akId'    : '阿里云AK ID',
        'akSecret': '阿里云AK Secret',

        # 来自本账号的数据都自动添加以下标签
        'extraTags': { 'account_name': 'metric_example' },
    },
]

# 配置
OPTIONS = {
    # 空配置表示获取所有指标数据
    'acs_ecs_dashboard': {},
    'acs_vpc_eip'      : {},
}

@DFF.API('同步阿里云监控数据', fixed_crontab='* * * * *')
def run():
    # 查询云监控数据
    data = metric.query(ACCOUNTS, OPTIONS)

    # 调用DataKit写入数据
    DFF.SRC('datakit').write_metric_many(data=data)
~~~

### 3.2 日志服务（SLS）

~~~python
import dataflux_aliyun__sls as sls

# 账号
ACCOUNTS = [
    {
        # 阿里云AK
        'akId'    : '阿里云AK ID',
        'akSecret': '阿里云AK Secret',

        # 来自本账号的数据都自动添加以下标签
        'extraTags': { 'account_name': 'sls_example' },
    },
]
# 配置
OPTIONS = {
    # 接入点
    'cn-hangzhou.log.aliyuncs.com': {
        # 项目名
        'slsaudit-region-1947705082861112-cn-hangzhou': [
            # 日志库
            'oss_log',
            'internal-etl-log',
        ],
    },
}

@DFF.API('同步阿里云日志数据', fixed_crontab='* * * * *')
def run():
    # 查询日志服务数据
    data = sls.query(ACCOUNTS, OPTIONS)

    # 调用DataKit写入数据
    DFF.SRC('datakit').write_logging_many(data=data)
~~~

## 4. 更复杂的代码示例

对于同步功能有进一步定制化要求的，可以根据如下的复杂示例编写。

### 4.1 云监控（Metric）

~~~python
import re
import json

import dataflux_aliyun__metric as metric

# 账号
ACCOUNTS = [
    {
        # 阿里云AK
        'akId'    : '阿里云AK ID',
        'akSecret': '阿里云AK Secret',

        # 来自本账号的数据都自动添加以下标签
        'extraTags': { 'account_name': 'metric_example' },
    },
]

# 配置
OPTIONS = {
    # ECS
    'acs_ecs_dashboard': {
        # 可以指定仅提取部分监控项目
        'only': [
            'CPUUtilization',            # 直接指定需要的监控项（默认取第一个数值项，此处将获取Average）
            lambda m: m.endswith('BPS'), # 使用函数指定（返回True表示需要提取，默认取第一个数值项，此处将获取Average）
            re.compile('^Disk.+IOPS$'),  # 使用正则表达式指定（能够匹配表示需要提取，默认取第一个数值项，此处将获取Average）
            {
                # 支持复杂配置
                'metric'   : 'TotalCredit',    # 指定需要提取的监控项目（同样支持直接指定、正则表达式、函数）
                'statistic': 'Minimum',        # 指定监控项值的统计方法
                'convert'  : lambda x: int(x), # 对监控项值进行处理
            },
        ],
    },

    # 弹性公网IP
    'acs_vpc_eip': {
        # 可以指定忽略的监控项
        'ignore': [
            'out_ratelimit_drop_speed',               # 直接指定需要忽略的监控项
            lambda m: m.endswith('.rate_percentage'), # 使用函数忽略（返回True表示忽略）
            re.compile('^net\.tx'),                   # 使用正则表达式忽略（能够匹配表示忽略）
        ],
    },

    # CDN
    'acs_cdn': {}, # 空配置，取所有监控项第一个数值项
}

@DFF.API('同步阿里云监控数据', fixed_crontab='* * * * *')
def run():
    # 查询云监控数据
    data = metric.query(ACCOUNTS, OPTIONS)

    if _DFF_ORIGIN != 'crontab':
        # 调试运行时：打印部分数据
        print('Data to write:', json.dumps(data[0:3], indent=2))
    else:
        # 自动触发运行时：写入DataKit
        if not data:
            return print('No data')

        dk_res = DFF.SRC('datakit').write_metric_many(data=data)
        print('DataKit response:', dk_res)
~~~

### 4.2 日志服务（SLS）

~~~python
import json

import dataflux_aliyun__sls as sls

# 账号
ACCOUNTS = [
    {
        # 阿里云AK
        'akId'    : '阿里云AK ID',
        'akSecret': '阿里云AK Secret',

        # 来自本账号的数据都自动添加以下标签
        'extraTags': { 'account_name': 'sls_example' },
    },
]
# 配置
OPTIONS = {
    # 接入点
    'cn-hangzhou.log.aliyuncs.com': {
        # 项目名
        'slsaudit-region-1947705082861112-cn-hangzhou': [
            # 日志库
            'oss_log', # 直接指定日志库（默认原样获取）
            {
                # 支持复杂配置
                'logstore': 'internal-etl-log',
                'topic': None, # 指定topic
                'query': 'SELECT COUNT(*) AS count', # 指定query

                # 对日志内容进行处理
                'convert': lambda s: { 'logCount': 'nodata' if not s else s.get('count') },
            },
        ],
    },
}

@DFF.API('同步阿里云日志数据', fixed_crontab='* * * * *')
def run():
    # 查询日志服务数据
    data = sls.query(ACCOUNTS, OPTIONS)

    if _DFF_ORIGIN != 'crontab':
        # 调试运行时：打印部分数据
        print('Data to write:', json.dumps(data[0:3], indent=2))
    else:
        # 自动触发运行时：写入DataKit
        if not data:
            return print('No data')

        dk_res = DFF.SRC('datakit').write_logging_many(data=data)
        print('DataKit response:', dk_res)
~~~

## 5. 创建自动触发配置

在完成代码编写后，发布脚本。

之后在「管理」-「自动触发配置」中，为已编写的脚本创建自动触发配置即可。

## X. 附录

本脚本中所涉及的相关配置项目，根据本附录查询。

### X.1 可用的阿里云监控项

完整列表索引请参考阿里云官方文档：

[阿里云监控 - 附录1 云服务监控项 - 概览](https://help.aliyun.com/document_detail/163515.html)

如上述阿里云官方文档地址发生改变，可尝试使用以下关键字搜索此文档：

```
概览 监控项索引表 site:help.aliyun.com
```

- [通过百度搜索](https://www.baidu.com/s?wd=%E6%A6%82%E8%A7%88%20%E7%9B%91%E6%8E%A7%E9%A1%B9%E7%B4%A2%E5%BC%95%E8%A1%A8%20site%3Ahelp.aliyun.com)
- [通过必应搜索](https://cn.bing.com/search?q=%E6%A6%82%E8%A7%88+%E7%9B%91%E6%8E%A7%E9%A1%B9%E7%B4%A2%E5%BC%95%E8%A1%A8+site%3Ahelp.aliyun.com&qs=n&form=QBLH&sp=-1&pq=%E6%A6%82%E8%A7%88+%E7%9B%91%E6%8E%A7%E9%A1%B9%E7%B4%A2%E5%BC%95%E8%A1%A8+site%3Ahelp.aliyun.com)

