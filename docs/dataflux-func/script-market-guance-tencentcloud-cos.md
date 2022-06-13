# 采集器「腾讯云-COS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration-intro)

提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                  |
| ------------ | ---- | -------- | ------------------------------------- |
| `Regions`    | List | 必须     | 所需采集的地域列表                    |
| `regions[#]` | str  | 必须     | 地域ID。如：`'ap-shanghai'`总表见附录 |

## 2. 配置示例

### 指定地域

采集上海地域的cos实例数据

```python
tencentcloud_configs = {
   'regions': [ 'ap-shanghai' ],
}
```

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义（对象）」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_cos",
  "tags": {
    "name"		: "smart-xxxx",
    "RegionId"	: "ap-nanjing",
    "BucketType": "cos",
    "Location"	: "ap-nanjing"
  },
  "fields": {
    "CreationDate": "2022-04-20T03:12:08Z",
    "message"	  : "{实例JSON数据}"
  }
}
```

*注意：*`*tags*`*、*`*fields*`*中的字段可能会随后续更新有所变动*

> 提示：`tags.name` 取自腾讯云api的Name字段

> 提示2：`fields.message` 为JSON序列化后字符串

## X. 附录

请参考腾讯云官方文档：

- [地域和可用区](https://cloud.tencent.com/document/product/436/6224)
- [对象存储COS](https://cloud.tencent.com/document/product/436/8291)

