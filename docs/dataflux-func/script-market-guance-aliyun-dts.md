# 采集器「阿里云-DTS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `Regions`    | List | 必须     | 所需采集的 dts 地域列表                    |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

```python
aliyun_dts_configs = {
    'regions': [ 'cn-hangzhou' ],
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_dts",
  "tags": {
    "name"         : "dtsy4is3g56xxxxx",
    "DtsInstanceID": "dtsy4is3g56xxxxx",
    "JobType"      : "online",
    "PayType"      : "PostPaid",
    "RegionId"     : "cn-hangzhou",
    "Status"       : "Finished"
  },
  "fields": {
    "CreateTime": "2022-03-23T09:48:12Z",
    "message"   : "{实例 JSON 数据}"
  }
}
```

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串，`tags.jobType`表示 DTS 实例的任务类型，取值：1、MIGRATION：迁移（默认值），2、SYNC：同步，3、SUBSCRIBE：订阅。`tags.status`表示 DTS 实例状态，取值详见附录文档。

## X. 附录

请参考阿里云官方文档：

- [阿里云 DTS](https://help.aliyun.com/document_detail/209702.html)
- [支持的地域列表](https://help.aliyun.com/document_detail/141033.html)
