# 导出一个笔记

---

<br />**GET /api/v1/notes/\{notes_uuid\}/export**

## 概述
将`notes_uuid`指定的笔记导出为模板结构




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## 参数补充说明


笔记模板结构说明:

模板的基础结构组成包含: 视图结构(只含图表结构)

**`templateInfo`的主体结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string | 必须 |  笔记标题 |
|main             |json |  |  导出内容主体结构 |
|main.charts             |array |  |  图表模板结构列表 |
|main.charts[#]             |json |  |  图表模板结构 |

**`main.charts[#]`的结构说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string | 必须 |  图表名字 |
|type             |string | 必须 |  图表类型 |
|queries             |array[json] | 必须 |  图表查询查询语句结构列表 |

**`时序图表` 结构 `type=sequence` 其主体结构参数如下: **

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string | 必须 |  图表名字 |
|type             |string | 必须 |  图表类型 |
|queries             |array[json] | 必须 |  图表查询查询语句结构列表 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "main": {
            "charts": [
                {
                    "extend": {},
                    "name": "",
                    "queries": [
                        {
                            "query": {
                                "content": "笔记内容"
                            }
                        }
                    ],
                    "type": "text"
                }
            ]
        },
        "name": "我的笔记"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8FD9876D-842E-4E0D-AC9E-F76E98943984"
} 
```




