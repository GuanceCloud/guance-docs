---
icon: zy/open-api
---

# Overview

---

Guance Open API is a simplified HTTP REST API.

* Only GET/POST requests
* Use resource-oriented URLs to invoke the API
* Use a status code to indicate success or failure of the request
* All requests return JSON structure
* The Open API programmatically accesses the observational cloud platform

## Support Endpoint

| Deploy Type  | Node Name       | Endpoint                       |
|-------|-----------|--------------------------------|
| SaaS deploy | China 1 (Hangzhou)  | https://openapi.guance.com     |
| SaaS deploy | China 2 (Ningxia)  | https://aws-openapi.guance.com |
| SaaS deploy | China 4 (Guangzhou)  | https://cn4-openapi.guance.com |
| SaaS deploy | Overseas Region 1 (Oregon) | https://us1-openapi.guance.com |
| Private deployment plan | Private deployment plan     | Based on the actually deployed Endpoint             |


## Common Request Header

| Parameter Name        | Type      | Description                                                                 |
|:-----------|:--------|:-------------------------------------------------------------------|
| Content-Type | string  | application/json                                                   |
| DF-API-KEY | string  |See [API Key management](../management/api-key/open-api.md) for caller identification and obtaining method|


## Authentication Method

The interface uses API KEY as authentication mode, and each request uses the value of *DF-API-KEY* in the Header of the request body as validity test, and the workspace limitation basis of this request (take the workspace to which this DF-API-KEY belongs).

All interfaces currently displayed by the Open API need to provide only API KEY (Header: DF-API-KEY) as credentials.
If the credentials exist and are valid, the authentication is considered passed.


## Common Response Structure

| Field        | Type      | Description                                |
|-----------|-----------|-----------------------------------|
| code      | Number    | The returned status code remains the same as the HTTP status code and is fixed at 200 when there are no errors. |
| content   | String, Number, Array, Boolean, JSON | The data returned, and what Type of data returned is related to the business of the actual interface.       |
| pageInfo  | JSON | List paging information for all list interface Response                   |
| pageInfo.count | Number | Current page data amount                            |
| pageInfo.pageIndex | Number | page number                              |
| pageInfo.pageSize | Number | Size per page                              |
| pageInfo.totalCount | Number | Total amount of eligible data                         |
| errorCode | String | The error status code returned. Null means no error.                   |
| message   | String | Specific Description information corresponding to the returned error code.                   |
| success   | Boolean | Fixed to true, indicating that the interface call was successful.                 |
| traceId   | Boolean | traceId, which is used to track the status of each request.              |

## Request Example

### GET Request

#### Take getting the dashboard list interface as an example
The request is as follows:
```bash
curl "http://testing-ft2x-open-api.cloudcare.cn/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result:
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

### POST Request

#### Take removing the dashboard interface as an example
The request is as follows:
```bash
curl "http://testing-ft2x-open-api.cloudcare.cn/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result:
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

