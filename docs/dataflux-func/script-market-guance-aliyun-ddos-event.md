# 采集器「阿里云-DDoS 基础防护」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

> 提示 2：本脚本的代码运行依赖 ECS、EIP、SLB 实例对象采集，如果未配置对应实例对象的自定义对象采集，本脚本无法采集到对应实例数据

## 1. 配置结构

本采集器配置结构如下：

| 字段               | 类型 | 是否必须 | 说明                                              |
| ------------------ | ---- | -------- | ------------------------------------------------- |
| `regions`          | list | 必须     | 所需采集的地域列表                                |
| `regions[#]`       | str  | 必须     | 地域 ID。如：'cn-qingdao-cm5-a01'，查询方法见附录 |
| `instance_type`    | list | 必须     | 所需采集的实例类型                                |
| `instance_type[#]` | str  | 必须     | 实例类型，可选参数：'ecs','eip','slb'             |

## 2. 配置示例

### 指定地域

采集 DDoS 基础防护实例数据

~~~python
aliyun_configs = {
    'regions'      : ['cn-qingdao-cm5-a01'],
    'instance_type': ['ecs'],
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_ddos_event",
  "tags": {
    "DdosType"    : "blackhole",
    "DdosStatus"  : "mitigating",
    "InstanceId"  : "i-bp1jbf3zyzssbxxxxxxx",
    "RegionId"    : "cn-qingdao-cm5-a01",
    "InstanceType": "ecs"
  },
  "fields": {
    "StartTime"      : "1637812279000",
    "EndTime"        : "1637812279000",
    "UnBlackholeTime": "1637812279000",
    "DelayTime"      : "1637812279000",
    "message"        : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

*注意：若采集 ecs 实例时，日志信息报错信息为`HTTP Status: 400 Error:NotHasInternetIp this instance not has internet`时，表示 ecs 实例无公网 IP 无法采集 DDoS 基础防护信息*

> 提示：`fields.message`为 JSON 序列化后字符串

> 提示 2：时间参数均使用时间戳表示 单位：毫秒

## X. 附录

### 阿里云 DDoS「地域 ID」

您可以调用 DescribeRegions 查询所有地域 ID，请参考阿里云官方文档：

- [查询 DDoS 基础防护支持的地域信息](https://help.aliyun.com/document_detail/353250.htm?spm=a2c4g.11186623.0.0.73862845ORRFNr)
