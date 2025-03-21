---
icon: zy/open-api
---

# Overview

---

<<< custom_key.brand_name >>> Open API is a simplified HTTP REST API.

* Only GET / POST requests
* Use resource-oriented URLs to call the API
* Use status codes to indicate request success or failure
* All requests return JSON structures
* Open API provides programmatic access to the <<< custom_key.brand_name >>> platform

## Supported Endpoints

<<<% if custom_key.brand_key == 'truewatch' %>>>

| Node Name       | Endpoint                       |
|-----------|--------------------------------|
| US Region 1 (Oregon) | https://us1-openapi.<<< custom_key.brand_main_domain >>> |
| Europe Region 1 (Frankfurt) | https://eu1-openapi.<<< custom_key.brand_main_domain >>> |
| Asia-Pacific Region 1 (Singapore) | https://ap1-openapi.<<< custom_key.brand_main_domain >>> |
| Africa Region 1 (South Africa) | https://za1-openapi.<<< custom_key.brand_main_domain >>> |
| Indonesia Region 1 (Jakarta) | https://id1-openapi.<<< custom_key.brand_main_domain >>> |

<<<% else %>>>

| Deployment Type | Node Name       | Endpoint                       |
|-------|-----------|--------------------------------|
| SaaS Deployment | China Region 1 (Hangzhou)  | https://openapi.<<< custom_key.brand_main_domain >>>     |
| SaaS Deployment | China Region 2 (Ningxia)  | https://aws-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | China Region 4 (Guangzhou)  | https://cn4-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | China Region 6 (Hong Kong)  | https://cn6-openapi.guance.one |
| SaaS Deployment | US Region 1 (Oregon) | https://us1-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | Europe Region 1 (Frankfurt) | https://eu1-openapi.guance.one |
| SaaS Deployment | Asia-Pacific Region 1 (Singapore) | https://ap1-openapi.guance.one |
| SaaS Deployment | Africa Region 1 (South Africa) | https://za1-openapi.<<< custom_key.brand_main_domain >>> |
| SaaS Deployment | Indonesia Region 1 (Jakarta) | https://id1-openapi.<<< custom_key.brand_main_domain >>> |
| Private Deployment Edition | Private Deployment Edition     | Refer to the actual deployment Endpoint             |

<<<% endif %>>>

## Common Request Headers (Header)

| Parameter Name        | Type      | Description                                                                 |
|:-----------|:--------|:-------------------------------------------------------------------|
| Content-Type | string  | application/json                                                   |
| DF-API-KEY | string  | Caller identifier, see [API Key Management](../management/api-key/)|


## Authentication Method

The interface uses API KEY for authentication. For each request, the value of *DF-API-KEY* in the request header is used for validation and to determine the workspace context (based on the workspace associated with this DF-API-KEY).

All interfaces displayed in the current Open API only require providing the API KEY (Header: DF-API-KEY) as credentials.
If the credential exists and is valid, it is considered authenticated.


## Common Response Structure

| Field        | Type      | Description                                |
|-----------|-----------|-----------------------------------|
| code      | Number    | Returned status code, consistent with HTTP status codes, fixed at 200 when there are no errors |
| content   | String, Number, Array, Boolean, JSON | Returned data, the specific type depends on the actual business logic of the interface       |
| pageInfo  | JSON | Pagination information for all list interfaces                   |
| pageInfo.count | Number | Number of items on the current page                            |
| pageInfo.pageIndex | Number | Page number                              |
| pageInfo.pageSize | Number | Items per page                              |
| pageInfo.totalCount | Number | Total number of items matching the criteria                         |
| errorCode | String | Returned error code, empty indicates no error                   |
| message   | String | Specific description of the returned error code                   |
| success   | Boolean | Fixed at true, indicating successful API invocation                 |
| traceId   | Boolean | Trace ID, used to track each request              |

## Request Examples

### GET Request

#### Example: Retrieving the Dashboard List Interface
Request:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response:
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

#### Example: Deleting a Dashboard Interface
Request:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response:
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