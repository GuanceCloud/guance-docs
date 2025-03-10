# Get All Labels

---

<br />**post /api/v1/object/hosts/label/list**

## Overview
Get the list of `label` (labels are cached, usually for no more than 5 minutes).




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| source | string | Y | Data source<br>Allow null: False <br> |
| names | array |  | List of object names<br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/object/hosts/label/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"source": "HOST"}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "10-23-190-37": {
            "labels": [
                "哈哈",
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
                "特尔为"
            ]
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5EFC56C8-F4E7-4E55-BDCE-B128B81B4DCA"
} 
```




