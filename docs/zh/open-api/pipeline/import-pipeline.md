# 导入 Pipeline 规则

---

<br />**POST /api/v1/pipeline/import**

## 概述
导入一个/多个Pipeline




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pipelines | array | Y | pipeline列表<br>允许为空: False <br> |
| isForce | boolean |  | 具体类型存在default时, 是否进行替换<br>允许为空: False <br> |
| pipelineType | string | Y | 用于区分导入是从日志菜单导入还是管理菜单导入<br>例子: logging <br>可选值: ['logging', 'all'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/pipeline/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"pipelines":[{"asDefault":0,"category":"logging","content":"ZW51bWVyYXRl\n","extend":{},"isDisable":false,"name":"eee","source":["calico-node"],"testData":"W10=\n"}],"pipelineType":"all"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "fail_count": 0,
        "success_count": 1
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F1FA4700-68DF-4808-995E-45D6161D67B1"
} 
```




