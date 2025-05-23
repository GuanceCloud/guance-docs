# Create a single binding index configuration

---

<br />**POST /api/v1/log_index_cfg/bind**

## Overview
Create a custom storage binding index




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| extend | json |  | Frontend custom data<br>Can be empty: True <br> |
| name | string | Y | Index name<br>Example: xxx <br>Can be empty: False <br> |
| storeType | string | Y | Storage type<br>Example: xxx <br>Can be empty: False <br> |
| exterStoreName | string | Y | Externally mapped storage name corresponding to name (SLS type corresponds to StoreName, Volcengine's TLS corresponds to topic_name)<br>Can be empty: False <br> |
| exterStoreProject | string |  | External storage index corresponding project (SLS type corresponds to StoreProject, Volcengine's TLS corresponds to project_name)<br>Can be empty: False <br> |
| region | string |  | Specify the region of external resources<br>Can be empty: False <br> |
| isPublicNetworkAccess | boolean |  | Whether public network access, effective when storeType is sls, default is False (added in iteration on 2024-07-10)<br>Can be empty: True <br> |
| accessCfg | json | Y | External resource access configuration information<br>Can be empty: False <br> |
| accessCfg.ak | string |  | Key Id<br>Can be empty: False <br> |
| accessCfg.sk | string |  | Key<br>Can be empty: False <br> |
| accessCfg.url | string |  | URL address<br>Can be empty: False <br> |
| accessCfg.username | string |  | Username<br>Can be empty: False <br> |
| accessCfg.password | string |  | Password<br>Can be empty: False <br> |
| accessCfg.iamProjectName | string |  | Volcengine TLS iam_project_name<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.iamProjectDisplayName | string |  | Display name of Volcengine TLS iam_project_name<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.projectId | string |  | Volcengine TLS project_id<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.topicId | string |  | Volcengine TLS topic_id<br>Can be empty: False <br>Can be an empty string: True <br> |
| fields | array |  | List of field mapping configurations to update<br>Can be empty: False <br> |
| fields[*] | None |  | <br> |
| fields[*].field | string | Y | Field name<br>Example: message <br>Can be empty: False <br> |
| fields[*].originalField | string | Y | Original field name<br>Example: content <br>Can be empty: False <br>Can be an empty string: True <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/bind' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"accessCfg":{"url":"aa.com","password":"test","username":"test"},"exterStoreName":"aa_uuid","fields":[{"field":"time","originalField":"time"},{"field":"__docid","originalField":"__docid"},{"field":"message","originalField":"message"}],"storeType":"es","name":"openapi_test"}' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-31E0802B-E53A-4D9B-8FD7-57A0CA4C2D66"
} 
```