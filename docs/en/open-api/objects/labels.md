# Get All Labels

---

<br />**POST /api/v1/object/hosts/label/list**

## Overview
Retrieve the list of `labels` (labels are cached, usually with a cache duration not exceeding 5 minutes)

## Body Request Parameters

| Parameter Name | Type   | Required | Description             |
|:--------------|:-------|:--------|:-----------------------|
| source        | string | Y       | Data source<br>Can be empty: False <br> |
| names         | array  |         | List of object names<br>Can be empty: False <br> |
| timeRange     | array  |         | Time range<br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/object/hosts/label/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"source": "HOST"}' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": {
        "10-23-190-37": {
            "labels": [
                "haha",
                "lwctest"
            ]
        },
        "cbis-dev-qa-node-001": {
            "labels": [
                "test"
            ]
        },
        "cc-testing-cluster-001": {
            "labels": [
                "product"
            ]
        },
        "cc-testing-cluster-002": {
            "labels": [
                "product"
            ]
        },
        "cc-testing-cluster-003": {
            "labels": [
                "product"
            ]
        },
        "cc-testing-cluster-004": {
            "labels": [
                "product"
            ]
        },
        "lyl-ubuntu": {
            "labels": [
                "oa"
            ]
        },
        "testname": {
            "labels": [
                "jd"
            ]
        },
        "ubuntu": {
            "labels": [
                "oa",
                "EST",
                "SEEE"
            ]
        },
        "zy-dataflux-func-demo": {
            "labels": [
                "test",
                "terwei"
            ]
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5EFC56C8-F4E7-4E55-BDCE-B128B81B4DCA"
} 
```