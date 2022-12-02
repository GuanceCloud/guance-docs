# 采集器「阿里云-TDS 日志」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器无需配置

## 2. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

### 安全告警处理

~~~json
{
  "measurement": "aliyun_susp_events",
  "tags": {
    "DataSource"      : "aegis_suspicious_event",
    "Uuid"            : "aa7f688e-a0ce-xxxxx-xxxx-e45016921596",
    "InstanceName"    : "atlassian-worker-01",
    "InstanceId"      : "i-bp1c0if9xxxxx5bz2zzzm",
    "EventStatus"     : "1",
    "SaleVersion"     : "1",
    "OperateErrorCode": "",
    "Level"           : "suspicious",
    "Id"              : "1747604"
  },
  "fields": {
    "InternetIp"     : "114.55.164.217",
    "IntranetIp"     : "192.168.196.153",
    "LastTime"       : "2022-05-30 10:43:49",
    "OperateMsg"     : "",
    "CanBeDealOnLine": false,
    "Details"        : "[{异常事件的详情 JSON 数据},]",
    "Name"           : "进程异常行为-Linux 可疑命令序列",
    "message"        : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下

| 字段          | 类型 | 说明                                                                                                                                                                                                  |
| ------------- | ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `EventStatus` | str  | 异常事件的状态。取值包括：<br>1：PENDING（待处理）<br>2：IGNORE（已忽略）<br>4：HANDLED（已确认）<br>8：FAULT（已标记误报）<br>6：DEALING（处理中）<br>32：DONE（处理完毕）<br>64：EXPIRE（已经过期） |
| `SaleVersion` | str  | 异常事件检测支持的产品售卖版本。取值包括：<br>0：基础版本 <br>1：企业版本                                                                                                                             |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`,`fields.Details`为 JSON 序列化后字符串

### 基线检查
~~~json
{
  "measurement": "aliyun_baseline_detection",
  "tags": {
    "RiskId"      : "92",
    "SubTypeAlias": "阿里云标准-Docker 安全基线检查",
    "TypeAlias"   : "容器安全",
    "RiskName"    : "阿里云标准-Docker 安全基线检查",
    "Level"       : "high"
  },
  "fields": {
    "LowWarningCount"    : 0,
    "MediumWarningCount" : 3,
    "HighWarningCount"   : 3,
    "LastFoundTime"      : "2022-06-17 03:56:13",
    "WarningMachineCount": 4,
    "CheckCount"         : 17,
    "message"            : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

### 漏洞管理

~~~json
{
  "measurement": "aliyun_vulnerability",
  "tags": {
    "InstanceId"  : "i-bp109znurxxxxmy5pcd",
    "InstanceName": "invest-staging-node:xxx",
    "Level"       : "serious",
    "Necessity"   : "asap",
    "RegionId"    : "cn-hangzhou",
    "Type"        : "sca",
    "Uuid"        : "e44fce33-fc07-xxxx-xxxx-511ed6f89bf4"
  },
  "fields": {
    "PrimaryId"  : 1050099807,
    "Name"       : "SCA:AVD-2022-1243027",
    "Tag"        : "1fc12eb00e9cf1d28ba415bfcd74b7d9",
    "Status"     : 1,
    "AliasName"  : "fastjson <= 1.2.80 反序列化任意代码执行漏洞",
    "AuthVersion": 3,
    "GroupId"    : 20553,
    "InternetIp" : "",
    "IntranetIp" : "10.0.xxx.152",
    "message"    : "{实例 JSON 数据}"
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

部分参数说明如下

| 字段          | 类型    | 说明                                                                                                                                                                                                                      |
| ------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Status`      | integer | 漏洞状态。取值：<br>1：未修复<br>2：修复失败<br>3：回滚失败<br>4：修复中<br>5：回滚中<br>6：验证中<br>7：修复成功<br>8：修复成功待重启<br>9：回滚成功<br>10：已忽略<br>11：回滚成功待重启<br>12：漏洞不存在<br>20：已失效 |
| `AuthVersion` | str     | 资产的授权版本。取值：<br>1：免费版<br>6：防病毒版<br>5：高级版<br>3：企业版<br>7：旗舰版<br>10：独立购买版                                                                                                               |

## X. 附录

### Aliyun-云安全中心「文档」

请参考 Aliyun 官方文档：

- [Aliyun-安全告警处理 ](https://help.aliyun.com/document_detail/421745.html)
- [Aliyun-基线检查 ](https://help.aliyun.com/document_detail/421798.html)
- [Aliyun-漏洞管理 ](https://help.aliyun.com/document_detail/421786.html)
