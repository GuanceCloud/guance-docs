# 【Login Mapping】Switch Status Setting

---

<br />**POST /api/v1/login_mapping/set_disable**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean |  | Whether to disable<br>Example: True <br>Can be empty: False <br>Optional values: [True, False] <br> |
| type | string |  | Scope type when enabled<br>Example: GlobalValid <br>Can be empty: False <br>Optional values: ['ValidOnFirstLogin', 'GlobalValid'] <br> |

## Additional Parameter Notes

* Explanation of the type parameter*

| Optional Value | Description |
|:------|:----------------|
| ValidOnFirstLogin | Indicates that under the enabled mapping configuration, the mapping configuration is only valid for the user's first login |
| GlobalValid | Indicates that under the enabled mapping configuration, the mapping configuration is valid for each user login; this is the default value |




## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/set_disable' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>' \
  --data-raw $'{"isDisable": true,"type": "GlobalValid"}'
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A70C8126-9E92-4DF5-B387-59BD9B63C587"
} 
```