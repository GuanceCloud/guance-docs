# OpenAPI
---

<<< custom_key.brand_name >>> supports obtaining and updating workspace data through calling Open API interfaces.

> For detailed information about the API list, refer to the [<<< custom_key.brand_name >>> OpenAPI Documentation Library](../../open-api/index.md).


## Authentication Method

Before calling the API interface, you need to create an [API Key](../../management/api-key/index.md) as the authentication method.


The interface uses API Key as the authentication method, verifying the validity of requests through the `DF-API-KEY` field in the request header and determining the workspace to which the request belongs (based on the workspace associated with that API Key).

All `GET` requests (used for data queries and retrieval) only require providing `DF-API-KEY` in the request header as the authentication credential.


## Request Structure

*Example: Delete a dashboard (POST request)*

```
curl -X POST "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/dsbd_922428e594ba44ce87229b8ca3007a90/delete" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

*Example: Validate interface (GET request)*

```
curl -X GET "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/validate" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**Note**: The system has simplified HTTP request methods, using only GET and POST. GET is used for data retrieval requests (such as "get a list of dashboards"), and POST is used for data modification requests (such as "create a dashboard" or "delete a dashboard").

### Endpoint Access Address

| SaaS Deployment Node | Endpoint |
| --- | --- |
| Alibaba Cloud | https://openapi.<<< custom_key.brand_main_domain >>> |
| AWS | https://aws-openapi.<<< custom_key.brand_main_domain >>> |

**Note**: The private deployment version also supports openapi access; specific endpoints depend on the actual deployment.

### Interface Routing Address Standard

Interface routing generally follows the following naming standard:

| Naming Standard |
| --- |
| /api/v1/{object type}/{object uuid}/{action} |

For example:

- Get dashboard list: **/api/v1/dashboard/list**
- Create a dashboard: **/api/v1/dashboard/create**
- Get a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/get**
- Delete a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/delete**
- Modify a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/modify**
- Get host object list: **/api/v1/object/host/list**
- Get process object list: **/api/v1/object/process/list**

**Note**: The **v1** in the route is the interface version number. Each released version of the interface must maintain backward compatibility. If there are incompatible interface changes or significant business adjustments, the version number must be incremented.

## Return Results

Interfaces follow the HTTP request-response standards:

- Successful requests return HTTP status code 200
- Failed API Key validation returns HTTP status code 403
- Server unable to handle or unknown errors return HTTP status code 500
- Other errors (such as no permission to access data or missing operation objects) return 403 and 404 respectively. Specific error definitions are provided below.

### Response Result Example

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

### Common Response Parameters

| Field | Type | Description |
| --- | --- | --- |
| code | Number | Return status code, consistent with the HTTP status code. Fixed at 200 when there are no errors. |
| content | String, Number, Array, Boolean, JSON | Returned data, the specific type depends on the interface's business logic. |
| pageInfo | JSON | Pagination information for all list interfaces. |
| errorCode | String | Error status code, empty when there are no errors. |
| message | String | Specific explanation of the returned error code. |
| success | Boolean | Fixed at `true` when the interface call is successful. |
| traceId | String | Unique identifier for tracking each request. |


## Common Error Definitions

| Error Code | HTTP Status Code | Error Information |
| --- | --- | --- |
| RouterNotFound | 400 | Requested route address does not exist. |
| InvalidApiKey | 403 | Invalid request API KEY. |
| InternalError | 503 | Unknown error. |
| ... |  |  |

> For more information about API interface lists, refer to the [OpenAPI Documentation Library](../../open-api/index.md).