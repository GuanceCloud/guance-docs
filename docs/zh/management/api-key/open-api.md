# OpenAPI
---


<<< custom_key.brand_name >>>支持通过调用 Open API 接口获取和更新工作空间数据。

> 关于 API 详细清单，可参考 [<<< custom_key.brand_name >>> OpenAPI 文档库](../../open-api/index.md)。


## 认证方式

在调用 API 接口前，需要先创建 [API Key](../../management/api-key/index.md) 作为认证方式。


接口采用 API Key 作为认证方式，通过请求头中的 `DF-API-KEY` 字段验证请求的有效性，并确定请求所属的工作空间（基于该 API Key 所属的工作空间）。

所有 `GET` 请求（用于数据查询和获取）仅需在请求头中提供 `DF-API-KEY` 作为认证凭证。


## 请求结构

*示例：删除仪表板（POST 请求）*

```
curl -X POST "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/dsbd_922428e594ba44ce87229b8ca3007a90/delete" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

*示例：验证接口（GET 请求）*

```
curl -X GET "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/validate" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**注意**：系统简化了 HTTP 请求方式，仅使用 GET 和 POST 两种。GET 用于数据获取类请求（如“获取仪表板列表”），POST 用于数据变更类请求（如“创建仪表板”或“删除仪表板”）。

### 接入地址 Endpoint

| SaaS 部署节点 | Endpoint |
| --- | --- |
| 阿里云 | https://openapi.<<< custom_key.brand_main_domain >>> |
| AWS | https://aws-openapi.<<< custom_key.brand_main_domain >>> |

**注意**：私有部署版也支持 openapi 接入，具体以实际部署的 Endpoint 为准。

### 接口路由地址规范

接口路由一般遵循以下命名规范：

| 命名规范 |
| --- |
| /api/v1/{对象类型}/{对象 uuid}/{动作} |

例如：

- 仪表板列表获取：**/api/v1/dashboard/list**
- 创建一个仪表板：**/api/v1/dashboard/create**
- 获取一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/get**
- 删除一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/delete**
- 修改一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/modify**
- 主机对象列表获取：**/api/v1/object/host/list**
- 进程对象列表获取：**/api/v1/object/process/list**

**注意**：路由中的 **v1** 为接口版本号，每个发布版本的接口，都需要向前兼容。如有不兼容的接口变更或重大业务调整，需增加版本号。

## 返回结果

接口返回遵循 HTTP 请求响应规范：  

- 正常请求返回 HTTP 状态码 200       
- API Key 验证失败返回 HTTP 状态码 403      
- 服务端无法处理或未知错误返回 HTTP 状态码 500         
- 其他错误（如无权限访问数据或找不到操作对象）分别返回 403 和 404 等。具体错误定义见下文。 

### 响应结果示例

```
{
    "code":200,
    "content":{
 
    },
    "pageInfo": {
        "count": 20,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 10
    },
    "errorCode":"",
    "message":"",
    "success":true,
    "traceId":"3412000720344969928"
}
```

### 公共响应结果参数

|   字段   |   类型   |   说明   |
| --- | --- | --- |
| code | Number | 返回状态码，与 HTTP 状态码一致。无错误时固定为 200。 |
| content | String、Number、Array、Boolean、JSON | 返回数据，具体类型取决于接口业务。 |
| pageInfo | JSON | 所有列表接口的分页信息。 |
| errorCode | String | 错误状态码，无错误时为空。 |
| message | String | 返回错误码对应的具体说明信息。 |
| success | Boolean | 接口调用成功时固定为 `true`。 |
| traceId | String | 用于跟踪每次请求的唯一标识。 |


## 公共错误定义

|   错误代码   |   HTTP 状态码   |   错误信息   |
| --- | --- | --- |
| RouterNotFound | 400 | 请求路由地址不存在。 |
| InvalidApiKey | 403 | 无效的请求 API KEY。 |
| InternalError | 503 | 未知错误。 |
| ... |  |  |

> 更多关于 API 接口列表，可参考 [OpenAPI 文档库](../../open-api/index.md)。





