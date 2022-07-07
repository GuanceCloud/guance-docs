# 采集器「阿里云-CLOUDFW」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement"             : "aliyun_cloudfw",
  "tags": {
    "AttackApp"             : "MySql",
    "EventId"               : "2b58efae-xxxx",
    "EventName"             : "WEB 目录穿越攻击",
    "RuleId"                : "1000xxxx",
    "AttackType"            : "1",
    "ResourceType"          : "EcsPublicIP",
    "DstIP"                 : "192.0.XXXX",
    "EventCount"            : "100",
    "RuleResult"            : "2",
    "RuleSource"            : "1",
    "VulLevel"              : "1"
  },
  "fields": {
    "Description"           : "检测到 HTTP 请求的 WEB 访问中使用了目录穿越攻击",
    "FirstEventTime"        : 1534408189,
    "LastEventTime"         : 1534408267,
    "ResourcePrivateIPList" : "{该入侵防御事件的私网 IP 信息}",
    "VpcSrcInfo"            : "{该入侵防御事件的源 VPC 信息}",
    "VpcDstInfo"            : "{该入侵防御事件的目的 VPC 信息}",
    "message"               : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下：

`AttackType`（入侵防御事件的攻击类型）取值含义：

| 取值 | 说明           |
| ---- | -------------- |
| `1`  | 表示异常连接   |
| `2`  | 表示命令执行   |
| `3`  | 表示暴力破解   |
| `4`  | 表示扫描       |
| `5`  | 表示其它       |
| `6`  | 表示信息泄露   |
| `7`  | 表示 Dos 攻击  |
| `8`  | 表示溢出攻击   |
| `9`  | 表示 Web 攻击  |
| `10` | 表示木马后门   |
| `11` | 表示病毒蠕虫   |
| `12` | 表示挖矿行为   |
| `13` | 表示反弹 Shell |

`ResourceType`（该入侵防御事件的公网 IP 类型）取值含义：

| 取值          | 说明             |
| ------------- | ---------------- |
| `EIP`         | 表示弹性公网 IP  |
| `EcsPublicIP` | 表示 ECS 公网 IP |
| `EcsEIP`      | 表示 ECS EIP     |
| `NatPublicIP` | 表示 NAT 公网 IP |
| `NatEIP`      | 表示 NAT EIP     |

`RuleResult`（防御状态）取值含义：

| 取值 | 说明     |
| ---- | -------- |
| `1`  | 表示告警 |
| `2`  | 表示拦截 |

`RuleSource`（本次入侵防御事件的检测规则来源）取值含义：

| 取值 | 说明         |
| ---- | ------------ |
| `1`  | 表示基础防御 |
| `2`  | 表示虚拟补丁 |
| `4`  | 表示威胁情报 |

`VulLevel`（该入侵防御事件的安全等级）取值含义：

| 取值 | 说明     |
| ---- | -------- |
| `1`  | 表示低危 |
| `2`  | 表示中危 |
| `4`  | 表示高危 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`均为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [地域和可用区](https://help.aliyun.com/document_detail/195657.html)
- [CLOUDFW](https://help.aliyun.com/document_detail/276903.html)
