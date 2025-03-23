---
icon: zy/open-api
---

# Overview

---

<<< custom_key.brand_name >>> Open API is a simplified HTTP REST API.
* Only GET / POST requests
* Use resource-oriented URLs to call the API
* Use status codes to indicate whether the request was successful or failed
* All requests return JSON structures
* Open API programmatically accesses the <<< custom_key.brand_name >>> platform

## Supported Endpoints

<<<% if custom_key.brand_key == 'truewatch' %>>>

| Node Name       | Endpoint                       |
|-----------|--------------------------------|
| Overseas Region 1 (Oregon) | https://us1-openapi.<<< custom_key.brand_main_domain >>> |
| Europe Region 1 (Frankfurt) | https://eu1-openapi.<<< custom_key.brand_main_domain >>> |
| Asia-Pacific Region 1 (Singapore) | https://ap1-openapi.<<< custom_key.brand_main_domain >>> |
| Africa Region 1 (South Africa) | https://za1-openapi.<<< custom_key.brand_main_domain >>> |
| Indonesia Region 1 (Jakarta) | https://id1-openapi.<<< custom_key.brand_main_domain >>> |

<<<% else %>>>

| Deployment Type  | Node Name       | Endpoint                       |
|-------|-----------|--------------------------------|
| SaaS Deployment | China Region 1 (Hangzhou) | https://openapi.<<< custom_key.brand_main_domain >>>     |
| SaaS Deployment | China Region 2 (Ningxia) | https://aws-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | China Region 4 (Guangzhou) | https://cn4-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | China Region 6 (Hong Kong) | https://cn6-openapi.guance.one |
| SaaS Deployment | Overseas Region 1 (Oregon) | https://us1-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | Europe Region 1 (Frankfurt) | https://eu1-openapi.guance.one |
| SaaS Deployment | Asia-Pacific Region 1 (Singapore) | https://ap1-openapi.guance.one |
| SaaS Deployment | Africa Region 1 (South Africa) | https://za1-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | Indonesia Region 1 (Jakarta) | https://id1-openapi.<<< custom_key.brand_main_domain >>> |
| Private Deployment Edition | Private Deployment Edition     | Use the actual deployed Endpoint as standard             |

<<<% endif %>>>

## Common Request Header (Header)

| Parameter Name        | Type      | Description                                                                 |
|:------------------|:--------|:-------------------------------------------------------------------|
| Content-Type | string  | application/json                                                   |
| DF-API-KEY | string  | Caller identifier, see [API Key Management](../management/api-key/)|


## Authentication Method

The interface uses API KEY as the authentication method. For each request, the value of *DF-API-KEY* in the request body's Header is used for validity checks and as the basis for limiting the workspace for this request (takes the workspace to which this DF-API-KEY belongs).

All interfaces displayed by the current Open API only require providing the API KEY (Header: DF-API-KEY) as credentials.
If the credentials exist and are valid, it is considered authenticated.


## Common Response Structure

| Field        | Type      | Description                                |
|-------------|-----------|--------------------------------------------|
| code      | Number    | The returned status code, same as the HTTP status code, fixed at 200 when there is no error |
| content   | String, Number, Array, Boolean, JSON | Returned data, the specific type of data returned depends on the actual business of the interface       |
| pageInfo  | JSON | Pagination information for all list interface responses                   |
| pageInfo.count | Number | Data volume of the current page                            |
| pageInfo.pageIndex | Number | Pagination page number                              |
| pageInfo.pageSize | Number | Page size                              |
| pageInfo.totalCount | Number | Total amount of data that meets the conditions                         |
| errorCode | String | Returned error status code, empty means no error                   |
| message   | String | Specific description information corresponding to the returned error code                   |
| success   | Boolean | Fixed at true, indicating successful interface invocation                 |
| traceId   | Boolean | TraceId, used to track each request situation              |

## Request Example

### GET Request

#### Example using the dashboard list retrieval interface
Request as follows:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result as follows:
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

#### Example using the delete dashboard interface
Request as follows:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result as follows:
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