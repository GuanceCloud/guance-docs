# OpenAPI
---


Guance supports obtaining and updating the data of Guance workspace by calling the Open API interface. 

> For a detailed list of APIs, see [Guance OpenAPI Doc Library](../../open-api/index.md).


## Authentication Method

Before calling the API interface, you need to create an API Key as the authentication method. Refer to the documentation [API Key management](../../management/api-key/index.md).

The interface takes API KEY as the authentication mode, and each request uses the value of DF-API-KEY in the Header of the request body as the validity test, and the workspace limitation basis of this request (taking the workspace to which this DF-API-KEY belongs).

All GET (**data query GET class**) interfaces need only provide API KEY (Header: **DF-API-KEY**) as credentials.


## Request Structure

**Example of URL POST request to delete dashboard interface:**

```
curl -X POST "https://openapi.guance.com/api/v1/dashboard/dsbd_922428e594ba44ce87229b8ca3007a90/delete" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

**Sample URL GET request with validate interface:**

```
curl -X GET "https://openapi.guance.com/api/v1/validate" \
-H "Content-Type: application/json" \
-H "DF-API-KEY: ${DF_API_KEY}"
```

Note: We simplify the HTTP request mode, only using GET and POST. GET is a data acquisition class request, such as obtaining dashboard list interface, and POST is all data change class requests, such as creating dashboard and deleting dashboard interface.

### Access Address Endpoint

| **SaaS Deployment Node** | **Endpoint** |
| --- | --- |
| Alibaba Cloud | https://openapi.guance.com |
| AWS | https://aws-openapi.guance.com |

Note: Private Deployment Plan also supports openapi access and is subject to the actual deployment of Endpoint.

### Interface Routing Address Specification

Interface routes generally follow the following naming conventions:

| /api/v1/{object type}/{object uuid}/{action} |
| --- |

Such as:

- dashboard list retrieval: **/api/v1/dashboard/list**
- create a dashboard: **/api/v1/dashboard/create**
- get a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/get**
- delete a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/delete**
- modify a dashboard: **/api/v1/dashboard/dsbd_0e233ee4804aca011ba94a9164a9ed7f/modify**
- host object list retrieval: **/api/v1/object/host/list**
- process object list retrieval: **/api/v1/object/process/list**

Note: **v1** in the route is the interface version number. Each release version of the interface needs to be forward compatible. If there are incompatible interface changes or major business changes, a version number needs to be added.

## Return Results

The interface return follows the HTTP request response specification, the normal return HTTP status code for the request is 200, the API KEY test fails to return the HTTP status code is 403, and the rest of the server can't handle or unknown error HTTP status code is 500, such as accessing unauthorized access data is 403, and can't find a certain operation object to return 404. See **Error Definition** below for details.

### Response Result Sample

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

### Common Response Result Parameter
| **Field** | **Type** | **Description** |
| --- | --- | --- |
| code | Number | The returned status code remains the same as the HTTP status code and is fixed at 200 when there are no errors. |
| content | String, Number, Array, Boolean, JSON | The data returned, and what type of data is returned is related to the business of the actual interface. |
| pageInfo | JSON | List paging information that all list interfaces respond to. |
| errorCode | String | The error status code returned. Null means no error. |
| message | String | Specific information corresponding to the returned error code. |
| success | Boolean | Fixed to true, indicating that the interface call was successful. |
| traceId | String | traceId, which is used to track the status of each request. |


## Public Error Definition
| **Error Code** | **HTTP Status Code** | **Error Message** |
| --- | --- | --- |
| RouterNotFound | 400 | Request routing address does not exist |
| InvalidApiKey | 403 | Invalid Request API KEY |
| InternalError | 503 | Unknown error |
| ... |  |  |

For a list of API interfaces, see [Guance OpenAPI Doc Library](../../open-api/index.md).


---


