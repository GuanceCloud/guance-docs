# 新建单个索引配置

---

<br />**POST /api/v1/log_index_cfg/add**

## 概述
修改单个默认存储索引配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 索引名字<br>例子: xxx <br>允许为空: False <br>最大长度: 256 <br> |
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| duration | string |  | 数据保留时长<br>允许为空: False <br>例子: 7d <br> |
| setting | json |  | 相关配置信息<br>允许为空: False <br> |
| setting.hot_retention | int | Y | 火山引擎存储, 标准存储-热存储<br>允许为空: False <br> |
| setting.cold_retention | int |  | 火山引擎存储, 低频存储-冷数据<br>允许为空: False <br> |
| setting.archive_retention | int |  | 火山引擎存储, 归档存储-归档数据<br>允许为空: False <br> |

## 参数补充说明



**1. 请求参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name                   |String|必须| 索引名称|
|extend                   |Json|| 用于前端回显的扩展信息|
|duration                   |Json|| 索引总存储时长, 示列: 60d|
|setting                   |Json|| 当日志为火山存储时, 索引配置信息|

--------------

**2. **`setting` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|hot_retention                   |int|必须| 标准存储 - 热数据, 需为整天小时数 单位: 小时 h |
|cold_retention                   |int|| 低频存储 - 冷数据, 需为整天小时数 单位: 小时 h|
|archive_retention                   |int|| 归档存储 - 归档数据, 需为整天小时数 单位: 小时 h|

2.1、火山存储时长限制：
      <br/>
标准存储：即热数据存储，数据范围：1-1800 天。若有低频存储，则数据范围：7-1800 天；若有归档存储，则数据范围：30-1800 天。
      <br/>
低频存储：冷数据存储，数据范围：30-1800 天。
      <br/>
归档存储：即归档数据等存储，数据范围：60-1800 天。
      <br/>
2.2、火山存储时长限制：
      <br/>
总存储时长（标准存储 + 低频存储 + 归档存储）不可大于 1800 天。

--------------

**3. **`extend` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|filters                   |Array[dict]|| 的过滤条件列表|

--------------

**4. `extend.filters`的主体结构说明**

|  参数名             |   type  | 必选  |          说明          |
|--------------------|----------|----|------------------------|
|condition           |string |  |  与前一个过滤条件的关系，可选值:`and`, `or`; 默认值: `and` |
|name                |string |  |  待过滤的字段名 |
|operation           |string |  |  运算符, 可选值:  `in`, `not_in`|
|value               |array |  |  值列表 |
|value[#]            |string/int/boolean |  | 可为字符串/数值/布尔类型|

--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name": "test_index", "duration":"14d","extend":{"filters":[{"condition":"and","name":"host","operation":"in","value":["custom_host1"]}]}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{  `host` in [ 'custom_host1' ] }",
        "createAt": 1698751853,
        "creator": "xxx",
        "deleteAt": -1,
        "duration": "14d",
        "extend": {
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "custom_host1"
                    ]
                }
            ]
        },
        "exterStoreName": "",
        "exterStoreProject": "",
        "externalResourceAccessCfgUUID": "",
        "id": null,
        "isBindCustomStore": 0,
        "isPublicNetworkAccess": 0,
        "name": "test_index",
        "queryType": "logging",
        "region": "",
        "setting": {},
        "sortNo": 3,
        "status": 0,
        "storeType": "",
        "updateAt": 1698751853,
        "updator": "xxx",
        "uuid": "lgim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-600346C3-6C89-4391-9CA3-2152D10149D8"
} 
```




