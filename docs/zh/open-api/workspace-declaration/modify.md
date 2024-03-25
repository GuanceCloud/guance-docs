# 修改声明信息

---

<br />**POST /api/v1/workspace/declaration/modify**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| declaration | json | Y | 工作空间属性声明信息<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/declaration/modify' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{"declaration":{"aad12":["asdaf"],"business":["事业部","产业一部","产品组啊时"],"organization":"88"}}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-352C3704-3FC6-432E-8D51-EEBEA8E90B5A"
} 
```




