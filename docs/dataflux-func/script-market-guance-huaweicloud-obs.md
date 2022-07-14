# 采集器「华为云-OBS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                      |
| ------------ | ---- | -------- | ----------------------------------------- |
| `regions`    | list | 必须     | 所需采集数据的地域列表                    |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-north-4'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`华北-北京四`地域对应项目的 obs 实例数据

~~~python
collector_configs = {
    'regions': [ 'cn-north-4' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
    "measurement": "huaweicloud_obs",
    "tags": {
        "name"       : "test0-6153",
        "RegionId"   : "cn-north-4",
        "bucket_type": "OBJECT",
        "location"   : "cn-north-4"
    },
    "fields": {
        "create_date": "2022/06/16 10:51:16",
        "message"    : "{实例 JSON 数据}"
    }
}
~~~

部分参数说明如下

bucket_type（桶类型）取值含义

| 取值     | 说明         |
| -------- | ------------ |
| `OBJECT` | 对象存储桶   |
| `POSIX`  | 并行文件系统 |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为桶名称，作为唯一识别

## X. 附录

### 华为云 OBS「地域 ID」

请参考华为云官方文档：

- [华为云 地域 ID](https://developer.huaweicloud.com/endpoint?OBS)
