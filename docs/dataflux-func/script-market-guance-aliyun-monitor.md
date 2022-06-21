# 采集器「阿里云-云监控」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                    | 类型 | 是否必须 | 说明                                                                                                                                         |
| ----------------------- | ---- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `targets`               | list | 必须     | 云监控采集对象配置列表<br>相同命名空间的多个配置之间逻辑关系为「且」                                                                         |
| `targets[#].namespace`  | str  | 必须     | 所需采集的云监控命名空间。如：`'acs_ecs_dashboard'`<br>总表见附录                                                                            |
| `targets[#].metrics`    | list | 必须     | 所需采集的云监控指标名列表<br>总表见附录                                                                                                     |
| `targets[#].metrics[#]` | str  | 必须     | 指标名模式，支持`"NOT"`、通配符方式匹配<br>正常情况下，多个之间逻辑关系为「或」<br>包含`"NOT"`标记时，多个之间逻辑关系为「且」。<br>详见下文 |

## 2. 配置示例

### 指定特定指标

采集 ECS 中名称为`CPUUtilization`、`concurrentConnections`的 2 个指标

~~~python
collector_configs = {
    'targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['CPUUtilization', 'concurrentConnections'],
        },
    ],
}
~~~

### 通配符匹配指标

指标名可以使用`*`通配符来匹配。

本例中以下指标会被采集：

- 名称为`CPUUtilization`的指标
- 名称以`CPU`开头的指标
- 名称以`Connections`结尾的指标
- 名称中包含`Conn`的指标

~~~python
collector_configs = {
    'targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['CPUUtilization', 'CPU*', '*Connections', '*Conn*'],
        },
    ],
}
~~~

### 剔除部分指标

在开头添加`"NOT"`标记表示去除后面的指标。

本例中，以下指标【不会】被采集：

- 名称为`CPUUtilization`的指标
- 名称以`CPU`开头的指标
- 名称以`Connections`结尾的指标
- 名称中包含`Conn`的指标

~~~python
collector_configs = {
    'targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['NOT', 'CPUUtilization', 'CPU*', '*Connections', '*Conn*'],
        },
    ],
}
~~~

### 多重过滤指定所需指标

相同的命名空间可以指定多次，从上到下依次按照指标名进行过滤。

本例中，相当于对指标名进行了如下过滤步骤：

1. 选择所有名称中包含`CPU`的指标
2. 在上一步结果中，去除名称为`CPUUtilization`的指标

~~~python
collector_configs = {
    'targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['*CPU*'],
        },
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['NOT', 'CPUUtilization'],
        },
    ],
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「指标」中查看数据。

以如下采集器配置为例：

~~~python
collector_configs = {
    'targets': [
        {
            'namespace': 'acs_ecs_dashboard',
            'metrics'  : ['CPUUtilization'],
        },
    ],
}
~~~

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_acs_ecs_dashboard",
  "tags": {
    "instanceId": "i-xxxxx",
    "userId"    : "xxxxx"
  },
  "fields": {
    "CPUUtilization_Average": 1.23,
    "CPUUtilization_Maximum": 1.23,
    "CPUUtilization_Minimum": 1.23
  }
}
~~~

> 提示：所有的指标值都会以`float`类型上报

## 4. 与自定义对象采集器联动

当同一个 DataFlux Func 中运行了其他自定义对象采集器（如 ECS、RDS）时，本采集器会自动根据`tags.instanceId`等字段尝试匹配自定义对象中的`tags.name`字段。

由于需要先获知自定义对象信息才能在云监控类采集器中进行联动，因此一般建议将云监控的采集器放置在列表末尾，如：

~~~python
    # 创建采集器
    collectors = [
        aliyun_ecs.DataCollector(account, common_aliyun_configs),
        aliyun_rds.DataCollector(account, common_aliyun_configs),
        aliyun_slb.DataCollector(account, common_aliyun_configs),
        aliyun_oss.DataCollector(account, common_aliyun_configs),
        aliyun_monitor.DataCollector(account, monitor_collector_configs), # 云监控类采集器一般放在最末尾
    ]
~~~

当成功匹配后，会将所匹配的自定义对象`tags`中除`name`以外的字段加入到监控数据的`tags`中，以此实现在使用实例名称筛选云监控的指标数据等效果。具体效果如下：

假设云监控采集到的原始数据如下：

~~~json
{
  "measurement": "aliyun_acs_ecs_dashboard",
  "tags": {
    "instanceId": "i-001",
    "{其他字段}": "{略}"
  },
  "fields": {
    "{指标}": "{指标值}"
  }
}
~~~

同时，阿里云 ECS 采集器采集到的自定义对象数据如下：

~~~json
{
  "measurement": "aliyun_ecs",
  "tags": {
    "name"      : "i-001",
    "InstanceId": "i-001",
    "RegionId"  : "cn-hangzhou",
    "{其他字段}": "{略}"
  },
  "fields": {
    "{其他字段}": "{略}"
  }
}
~~~

那么，最终上报的云监控数据如下：

~~~json
{
"measurement": "aliyun_acs_ecs_dashboard",
  "tags": {
    "instanceId": "i-001",
    "RegionId"  : "cn-hangzhou",
    "{其他字段}": "{略}"
  },
  "fields": {
    "{指标}": "{指标值}"
  }
}
~~~

## X. 附录

请参考阿里云官方文档：

- [云监控 / 附录 1 云服务监控项 / 概览](https://help.aliyun.com/document_detail/163515.html)
