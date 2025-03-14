# 获取所有label

---

<br />**POST /api/v1/object/hosts/label/list**

## 概述
获取`label`列表(label是有缓存的，一般会有不超过5分钟的缓存)




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| source | string | Y | 数据源<br>允许为空: False <br> |
| names | array |  | 对象名列表<br>允许为空: False <br> |
| timeRange | array |  | 时间范围<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/object/hosts/label/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"source": "HOST"}' \
--compressed
```




## 响应
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




