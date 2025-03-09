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

| Deployment Type | Node Name       | Endpoint                       |
|-----------------|-----------------|--------------------------------|
| SaaS Deployment | China Region 1 (Hangzhou) | https://openapi.guance.com     |
| SaaS Deployment | China Region 2 (Ningxia)   | https://aws-openapi.guance.com |
| SaaS Deployment | China Region 4 (Guangzhou) | https://cn4-openapi.guance.com |
| SaaS Deployment | China Region 6 (Hong Kong) | https://cn6-openapi.guance.one |
| SaaS Deployment | Overseas Region 1 (Oregon) | https://us1-openapi.guance.com |
| SaaS Deployment | Europe Region 1 (Frankfurt) | https://eu1-openapi.guance.one |
| SaaS Deployment | Asia-Pacific Region 1 (Singapore) | https://ap1-openapi.guance.one |
| Private Deployment Edition | Private Deployment Edition | Use the actual deployed Endpoint |

## Common Request Headers

| Parameter Name | Type      | Description                                                                 |
|:--------------|:---------|:---------------------------------------------------------------------------|
| Content-Type  | string   | application/json                                                           |
| DF-API-KEY    | string   | Caller identifier, see [API Key Management](../management/api-key/)|


## Authentication Method

The interface uses API KEY for authentication. For each request, the value of *DF-API-KEY* in the request header is used as validation and to determine the workspace scope (based on the workspace associated with this DF-API-KEY).

All interfaces currently displayed by the Open API require only an API KEY (Header: DF-API-KEY) as credentials.
If the credentials exist and are valid, the authentication is considered successful.


## Common Response Structure

| Field        | Type      | Description                                |
|-------------|-----------|--------------------------------------------|
| code        | Number    | Returned status code, consistent with HTTP status codes, fixed at 200 if there are no errors |
| content     | String, Number, Array, Boolean, JSON | Returned data, the specific type depends on the actual business of the interface |
| pageInfo    | JSON      | Pagination information for all list interface responses |
| pageInfo.count | Number | Data count on the current page                            |
| pageInfo.pageIndex | Number | Page number                              |
| pageInfo.pageSize | Number | Page size                              |
| pageInfo.totalCount | Number | Total data count that meets the conditions                         |
| errorCode   | String    | Returned error status code, empty indicates no error                   |
| message     | String    | Specific description of the returned error code                   |
| success     | Boolean   | Fixed at true, indicating successful API call                 |
| traceId     | String    | Trace ID, used to track each request              |

## Request Examples

### GET Request

#### Example of Getting Dashboard List Interface
Request as follows:
```bash
curl "https://openapi.guance.com/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
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

#### Example of Deleting Dashboard Interface
Request as follows:
```bash
curl "https://openapi.guance.com/api/v1/dashboards/${dashboard_uuid}/delete" \
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