# OpenAPI
---

Guance supports obtaining and updating data from Guance workspaces through calling Open API interfaces.

> For detailed API lists, refer to the [Guance OpenAPI Documentation Library](../../open-api/index.md).


## Authentication Method

Before calling API interfaces, you need to create an API Key for authentication.

> For instructions on creating an API Key, refer to [API Key Management](../../management/api-key/index.md).

The API uses the API KEY as the authentication method. Each request validates the key using the value of the `DF-API-KEY` in the request header, which also determines the workspace scope for this request (based on the workspace associated with this `DF-API-KEY`).

All GET (**data query and retrieval**) interfaces only require providing the API KEY (Header: **DF-API-KEY**) as credentials.


## Request Structure

**Example of a URL POST request to delete a dashboard:**

```
curl -X POST "https://openapi.guance.com/api/v1/dashboard/dsbd_922428e594ba44ce87229b8ca3007a90/delete" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**Example of a URL GET request to validate:**

```
curl -X GET "https://openapi.guance.com/api/v1/validate" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**Note**: We have simplified HTTP request methods to use only GET and POST. GET is used for data retrieval requests, such as the **[get dashboard list]** interface, while POST is used for all data modification requests, such as the **[create dashboard, delete dashboard]** interfaces.

### Endpoint Access Address

| **SaaS Deployment Node** | **Endpoint** |
| --- | --- |
| Alibaba Cloud | https://openapi.guance.com |
| AWS | https://aws-openapi.guance.com |

**Note**: Private deployment versions also support OpenAPI access, using the actual deployment endpoint.

### Interface Routing Address Specification

Interface routing generally follows these naming conventions:

| Naming Convention |
| --- |
| /api/v1/{object type}/{object uuid}/{action} |

Examples:

- Retrieve dashboard list: **/api/v1/dashboard/list**
- Create a dashboard: **/api/v1/dashboard/create**
- Retrieve a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/get**
- Delete a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/delete**
- Modify a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/modify**
- Retrieve host object list: **/api/v1/object/host/list**
- Retrieve process object list: **/api/v1/object/process/list**

**Note**: The **v1** in the route represents the API version number. Each released version's API should maintain backward compatibility. If there are incompatible changes or significant business changes, a new version number should be added.

## Response Results

API responses follow HTTP request-response standards. A successful request returns an HTTP status code of 200, an invalid API KEY returns an HTTP status code of 403, and all other server-side unhandled or unknown errors return an HTTP status code of 500. For example, accessing unauthorized data returns 403, and not finding a specific operation object returns 404. Refer to the error definitions for more details.

### Example Response

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

| **Field** | **Type** | **Description** |
| --- | --- | --- |
| code | Number | Return status code, matching HTTP status codes. It is fixed at 200 when there are no errors. |
| content | String, Number, Array, Boolean, JSON | Returned data, the type depends on the specific business logic of the interface. |
| pageInfo | JSON | Pagination information for list interfaces. |
| errorCode | String | Error status code returned, empty if there is no error. |
| message | String | Detailed description of the error code. |
| success | Boolean | Fixed at true, indicating a successful API call. |
| traceId | String | Trace ID, used to track each request. |


## Common Error Definitions

| **Error Code** | **HTTP Status Code** | **Error Message** |
| --- | --- | --- |
| RouterNotFound | 400 | The requested route does not exist. |
| InvalidApiKey | 403 | Invalid API KEY. |
| InternalError | 503 | Unknown error. |
| ... |  |  |

> For more about API interface lists, refer to the [Guance OpenAPI Documentation Library](../../open-api/index.md).