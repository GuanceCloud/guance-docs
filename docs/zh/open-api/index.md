---
icon: zy/open-api
---

# 概述

---

观测云 Open API 是一个简化的 HTTP REST API。

* 只有 GET / POST 请求
* 使用面向资源的 URL 调用 API
* 使用状态码指示请求成功或失败
* 所有请求返回 JSON 结构
* Open API 以编程方式访问观测云平台

## 支持Endpoint

| 部署类型  | 节点名       | Endpoint                       |
|-------|-----------|--------------------------------|
| SaaS 部署 | 中国区1（杭州）  | https://openapi.guance.com     |
| SaaS 部署 | 中国区2（宁夏）  | https://aws-openapi.guance.com |
| SaaS 部署 | 中国区4（广州）  | https://cn4-openapi.guance.com |
| SaaS 部署 | 中国区6（香港）  | https://cn6-openapi.guance.one |
| SaaS 部署 | 海外区1（俄勒冈） | https://us1-openapi.guance.com |
| SaaS 部署 | 欧洲区1（法兰克福） | https://eu1-openapi.guance.one |
| SaaS 部署 | 亚太区1（新加坡） | https://ap1-openapi.guance.one |
| 私有部署版 | 私有部署版     | 以实际部署的 Endpoint 为准             |


## 公共请求头(Header)

| 参数名        | 类型      | 说明                                                                 |
|:-----------|:--------|:-------------------------------------------------------------------|
| Content-Type | string  | application/json                                                   |
| DF-API-KEY | string  | 调用者标识, 获取方式见[API Key 管理](../management/api-key/)|


## 认证方式

接口以 API KEY 为认证方式，每一次请求使用请求体 Header 中的 *DF-API-KEY* 的值作为有效性检验，以及本次请求的工作空间限定依据（取此 DF-API-KEY 所属的工作空间）。

当前 Open API 所展示的所有接口都只需要提供 API KEY（Header：DF-API-KEY）作为凭证。
如果凭据存在且有效，则视为认证通过。


## 公共响应结构

| 字段        | 类型      | 说明                                |
|-----------|-----------|-----------------------------------|
| code      | Number    | 返回的状态码，与 HTTP 状态码保持相同，无错误时固定为 200 |
| content   | String、Number、Array、Boolean、JSON | 返回的数据，具体返回什么类型的数据与实际接口的业务有关       |
| pageInfo  | JSON | 所有列表接口响应的列表分页信息                   |
| pageInfo.count | Number | 当前页数据量                            |
| pageInfo.pageIndex | Number | 分页页码                              |
| pageInfo.pageSize | Number | 每页大小                              |
| pageInfo.totalCount | Number | 符合条件的总数据量                         |
| errorCode | String | 返回的错误状态码，空表示无错误                   |
| message   | String | 返回的错误码对应的具体说明信息                   |
| success   | Boolean | 固定为 true，表示接口调用成功                 |
| traceId   | Boolean | traceId，用于跟踪每一次的请求情况              |

## 请求示例

### GET 请求

#### 以获取仪表板列表接口为例
请求如下
```bash
curl "https://openapi.guance.com/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

响应结果如下:
```bash
{
    "code":200,
    "content":[
        {Object}
    ],
    "errorCode":"",
    "message":"",
    "pageInfo":{
        "count":10,
        "pageIndex":1,
        "pageSize":10,
        "totalCount":836
    },
    "success":true,
    "traceId":"1749091119335873001"
}
```

### POST 请求

#### 以删除仪表板接口为例
请求如下
```bash
curl "https://openapi.guance.com/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

响应结果如下:
```bash
{
    "code":200,
    "content":true,
    "errorCode":"",
    "message":"",
    "success":true,
    "traceId":"4250149955169518608"
}
```

