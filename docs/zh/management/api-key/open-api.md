# OpenAPI
---


{{{ custom_key.brand_name }}}支持通过调用 Open API 接口的方式来获取和更新{{{ custom_key.brand_name }}}工作空间的数据。

> 关于 API 详细清单，可参考 [{{{ custom_key.brand_name }}} OpenAPI 文档库](../../open-api/index.md)。


## 认证方式

在调用 API 接口前，需要先创建 API Key 作为认证方式。

> 关于如何创建 API Key，可参考 [API Key 管理](../../management/api-key/index.md)。

接口以 API KEY 为认证方式，每一次请求使用请求体 Header 中的 DF-API-KEY 的值作为有效性检验，以及本次请求的工作空间限定依据（取此 DF-API-KEY 所属的工作空间）。

所有 GET （**数据查询获取类**）接口，只需要提供 API KEY（Header：**DF-API-KEY**） 作为凭证。


## 请求结构

**以 删除仪表板 接口的 URL POST 请求示例：**

```
curl -X POST "https://openapi.guance.com/api/v1/dashboard/dsbd_922428e594ba44ce87229b8ca3007a90/delete" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**以 validate 接口的 URL GET 请求示例：**

```
curl -X GET "https://openapi.guance.com/api/v1/validate" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**注意**：我们简化了 HTTP 的请求方式，只使用 GET、POST 两种，GET 为数据获取类请求，如【获取仪表板列表】接口， POST 为所有数据变更类请求，如【创建仪表板、删除仪表板】接口等。

### 接入地址 Endpoint

| **SaaS 部署节点** | **Endpoint** |
| --- | --- |
| 阿里云 | https://openapi.guance.com |
| AWS | https://aws-openapi.guance.com |

**注意**：私有部署版也支持 openapi 接入，以实际部署的 Endpoint 为准。

### 接口路由地址规范

接口路由一般遵循以下命名规范：

| 命名规范 |
| --- |
| /api/v1/{对象类型}/{对象 uuid}/{动作} |

如：

- 仪表板列表获取：**/api/v1/dashboard/list**
- 创建一个仪表板：**/api/v1/dashboard/create**
- 获取一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/get**
- 删除一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/delete**
- 修改一个仪表板：**/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/modify**
- 主机对象列表获取：**/api/v1/object/host/list**
- 进程对象列表获取：**/api/v1/object/process/list**

**注意**：路由中的 **v1** 为接口版本号，每个发布版本的接口，都需要向前兼容，如有不兼容的接口变化、或业务重大变化，需要增加一个版本号。

## 返回结果

接口返回遵循 HTTP 请求响应规范，对请求正常的返回 HTTP 状态码为 200，API KEY 检验不通过返回 HTTP 状态码为 403，其余所有服务端无法处理或未知的错误 HTTP 状态码为 500，如访问无权限访问的数据为 403，找不到某个操作对象返回 404 等。具体可以见错误定义。

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

| **字段** | **类型** | **说明** |
| --- | --- | --- |
| code | Number | 返回的状态码，与 HTTP 状态码保持相同，无错误时固定为 200。 |
| content | String、Number、Array、Boolean、JSON | 返回的数据，具体返回什么类型的数据与实际接口的业务有关。 |
| pageInfo | JSON | 所有列表接口响应的列表分页信息。 |
| errorCode | String | 返回的错误状态码，空表示无错误。 |
| message | String | 返回的错误码对应的具体说明信息。 |
| success | Boolean | 固定为 true，表示接口调用成功。 |
| traceId | String | traceId，用于跟踪每一次的请求情况。 |


## 公共错误定义

| **错误代码** | **HTTP 状态码** | **错误信息** |
| --- | --- | --- |
| RouterNotFound | 400 | 请求路由地址不存在。 |
| InvalidApiKey | 403 | 无效的请求 API KEY。 |
| InternalError | 503 | 未知的错误。 |
| ... |  |  |

> 更多关于 API 接口列表，可参考 [{{{ custom_key.brand_name }}} OpenAPI 文档库](../../open-api/index.md)。


---


