# 【服务清单】列出

---

<br />**GET /api/v1/service_manage/list**

## 概述
列出服务清单信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索服务名<br>例子: mysql <br>允许为空: False <br> |
| originStr | string |  | 原始字符串传1, 结构化数据传0, 默认为1<br>允许为空: False <br> |
| filter | string |  | 过滤条件<br>例子: total <br>允许为空: False <br>可选值: ['total', 'myCreate'] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明


**请求主体结构说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| search    |  string  |  N | 搜索服务名 |
| originStr |  string  |  N | 是否需要返回的 serviceCatelog 为原始字符串, 1为是, 0为否. 默认为1|
| filter    |  string  |  N | 过滤条件 |
| pageIndex |  string  |  N | 分页页码 |
| pageSize  |  string  |  N | 每页返回数量 |


**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog         |string,dict |  服务清单的原始字符串或者结构化数据 |
|service         |string |  服务名称 |
|type         |string |  服务类型 |
|dfStatus         |string |  服务状态 |
|creatorInfo             |dict |  服务清单的创建者信息 |
|updatorInfo             |dict |  服务清单的更新者信息 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/list?originStr=1' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1691233484,
            "createType": "openapi",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_7692b2cefe104fffa07916f09cbac52e",
                "iconUrl": "",
                "name": "API接口",
                "username": "wsak_7692b2cefe104fffa07916f09cbac52e"
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "service": "kodo",
            "serviceCatelog": "[[Repos]]\nlink = \\\"https://www.guance.com\\\"\nname = \\\"guance\\\"\nprovider = \\\"guanceyun\\\"\n\n[[Repos]]\nlink = \\\"https://func.guance.com\\\"\nname = \\\"func\\\"\nprovider = \\\"guanceyun\\\"\n\n[[Docs]]\nlink = \\\"https://www.docs.guance.com\\\"\nname = \\\"guance\\\"\nprovider = \\\"guanceyun\\\"\n\n[[Docs]]\nlink = \\\"https://func.guance.com/doc\\\"\nname = \\\"func\\\"\nprovider = \\\"guanceyun\\\"\n\n[Team]\nservice = \\\"kodo\\\"\ntype = \\\"custom\\\"\nteam = \\\"guance\\\"\noncall = [\\\"xxx@guance.com\\\"]\n",
            "type": "custom",
            "updateAt": 1691234734,
            "updatorInfo": {
                "acntWsNickname": "昵称asdasfasfasfagasgasdfasfa",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "sman_5eaba28c14e94876b4aa0157ecb1e090"
        },
        {
            "createAt": 1691045130,
            "createType": "manual",
            "creatorInfo": {
                "acntWsNickname": "昵称asdasfasfasfagasgasdfasfa",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "dfStatus": "ok",
            "isFavorite": false,
            "service": "anypath",
            "serviceCatelog": "[[Repos]]\nname = \\\"观测云\\\"\nprovider = \\\"gitlab\\\"\nlink = \\\"https://gitlab.jiagouyun.com/\\\"\n\n[[Docs]]\nname = \\\"服务清单配置\\\"\nprovider = \\\"观测云\\\"\nlink = \\\"https://preprod-docs.cloudcare.cn/open-api/tracing/service-catelogs-get/\\\"\n\n[Team]\nservice = \\\"anypath\\\"\ntype = \\\"app\\\"\nteam = \\\"test\\\"\noncall = [\\\"guanyu@guance.com\\\", \\\"tt@163.com\\\"]\n",
            "type": "app",
            "updateAt": 1691133424,
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "tt@jiagouyun.com",
                "iconUrl": "",
                "name": "tt",
                "username": "tt@jiagouyun.com"
            },
            "uuid": "sman_d1258a79a26a4c1fb0b946504ea4e498"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 2
    },
    "success": true,
    "traceId": "TRACE-26509352-0ED4-4A8F-8D28-8DEA416B294A"
} 
```




