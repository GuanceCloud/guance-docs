# 阿里云数据同步（云监控）
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

- [脚本市场简介](https://docs.guance.com/dataflux-func/script-market-intro)

本文假设用户已经在DataFlux Func 中正确连接了DataKit。
有关如何在DataFlux Func 中连接DataKit，请参考：

- [连接并操作DataKit](https://docs.guance.com/dataflux-func/connect-to-datakit)

## 2. 关于本脚本包

本脚本包主要用于阿里云平台数据的获取并同步至观测云。

使用本脚本包，需要阿里云平台具有对应权限的AK。您可在阿里云「访问控制」中创建RAM 账号，并为RAM 账号创建AK 并授予所需权限。

*注意：为了您的账号安全，请勿直接使用账号AK，或为RAM账号AK分配过大的权限*

所需权限如下：

| 阿里云产品       | AK所需权限                         |
| ---------------- | ---------------------------------- |
| 云监控（Metric） | `AliyunCloudMonitorReadOnlyAccess` |

也可以直接为RAM 账号授予全部云资源的只读权限`ReadOnlyAccess`。

## 3. 典型代码示例

通过简单的配置和极少量代码，即可实现相关数据的同步功能。

以下典型代码示例为实现同步功能的最简单配置。

```python
import dataflux_aliyun_metric__sync as metric

CONFIG = {
    'datakit_id': 'datakit', # 希望写入Datakit的ID

    # 阿里云账号配置
    'aliyun_ak_id'    : '<阿里云提供的akId>',
    'aliyun_ak_secret': '<阿里云提供的akSecret>',

    # 希望写入的自定义标签
    'extra_tags': { 'account': '示例账号'},

    # 云监控配置
    'metric_targets': [
        {
            # 云监控的namespace
            'namespace': 'acs_ecs_dashboard',

            # 云监控的监控项（不区分大小写）
            'metrics': 'CPUUtilization',                                     # 单个
            # 'metrics': ['CPUUtilization', 'concurrentConnections'],        # 多个
            # 'metrics': ['CPU*', '*Connections', '*Conn*'],                 # 前匹配，后匹配，前后匹配
            # 'metrics': ['NOT', 'CPUUtilization', 'concurrentConnections'], # 忽略
            # 'metrics': 'ALL',                                              # 全部
        },
    ],
}

@DFF.API('同步阿里云监控数据', fixed_crontab='* * * * *')
def metric_run():
    metric.config(**CONFIG)
    metric.metric_sync()
```

> 提示：监控项名称不区分大小写

## 3.1 监控项过滤

`metric_targets`中相同`namespace`的配置可以出现多次，其关系为从上到下不断筛选的过程。

如下两种配置方式的意义不同：

```python
{
    # 其他配置项略

    'metric_targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : 'disk*',
            # 从acs_ecs_dashboard中所有可用的监控项中，提取以"disk"开头的监控项
        },
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : '*iops',
            # 从上一步骤获得的监控项中，进一步筛选出以"iops"结尾的监控项
        },
    ]
    # 总结为获取所有以"disk"开头，并且以"iops"结尾的监控项。
    # 即：只有"diskXXXipos"的监控项才会被提取
}
```

```python
{
    # 其他配置项略

    'metric_targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['disk*', '*iops'],
        },
    ]
    # 总结为获取所有以"disk"开头，或者以"iops"结尾的监控项
    # 即："diskXXX"，"XXXiops"的监控项都会被提取
}
```

## 3.2 注意点

设置指标全获取会产生大量的阿里云API查询，极易触发平台限流。

配置时应当在了解具体云监控API调用规则，指标数量的基础上酌情处理

如由此产生任何经济损失，本脚本作者及相关方概不负责

## 4. 创建自动触发配置

在完成代码编写后，发布脚本。

之后在「管理」-「自动触发配置」中，为已编写的脚本创建自动触发配置即可。

## 5. 同步后数据

正常同步后，可在观测云平台的「指标」中查看数据。

以上述3. 中的代码为例，可搜集到的指标数据如下：

- 指标集：`aliyun_acs_ecs_dashboard`

> 「指标集」由前缀`aliyun`和指定的云监控Namespace组成（下划线分割）

- 标签：

| 标签             | 说明                               |
| ---------------- | ---------------------------------- |
| `account`        | 来自上述脚本中的配置项`extra_tags` |
| `cloud_provider` | 阿里云平台数据固定写入`"aliyun"`   |
| `instanceId`     | 云监控Dimensions                   |
| `userId`         | 云监控Dimensions                   |

> 「标签」由云监控平台提供的`Dimensions`和所配置的`extra_tags`组成

- 指标：

| 指标                     | 说明                                                            |
| ------------------------ | --------------------------------------------------------------- |
| `CPUUtilization_Average` | 即云监控Metric为`CPUUtilization`，Statistics为`Average`的监控值 |
| `CPUUtilization_Maximum` | 即云监控Metric为`CPUUtilization`，Statistics为`Maximum`的监控值 |
| `CPUUtilization_Minimum` | 即云监控Metric为`CPUUtilization`，Statistics为`Minimum`的监控值 |

> 「指标」由云监控平台的`Metric`和`Statistics`组成（下划线分割）

## X. 附录

本脚本中所涉及的相关配置项目，根据本附录查询。

### X.1 可用的阿里云监控项

完整列表索引请参考阿里云官方文档：

[阿里云监控 - 附录1 云服务监控项 - 概览](https://help.aliyun.com/document_detail/163515.html)

如上述阿里云官方文档地址发生改变，可尝试使用以下关键字搜索此文档：

```plain
概览 监控项索引表 site:help.aliyun.com
```

- [通过百度搜索](https://www.baidu.com/s?wd=概览+监控项索引表+site%3Ahelp.aliyun.com)

- [通过必应搜索](https://cn.bing.com/search?q=概览+监控项索引表+site%3Ahelp.aliyun.com&qs=n&form=QBLH&sp=-1&pq=概览+监控项索引表+site%3Ahelp.aliyun.com)
