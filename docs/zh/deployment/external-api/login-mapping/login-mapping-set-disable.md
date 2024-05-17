# 【Login Mapping】开关状态设置

---

<br />**POST /api/v1/login_mapping/set_disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean |  | 是否禁用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |
| type | string |  | 启用状态下作用范围类型<br>例子: GlobalValid <br>允许为空: False <br>可选值: ['ValidOnFirstLogin', 'GlobalValid'] <br> |

## 参数补充说明

* type 参数说明*

|可选值|说明|
|:------|:----------------|
| ValidOnFirstLogin | 表示启用映射配置情况下, 映射配置只在用户首次登录时有效 |
| GlobalValid | 表示启用映射配置情况下, 映射配置在用户每次登录时有效; 作为默认值 |




## 请求例子
```shell
curl '<Endpoint>/api/v1/login_mapping/set_disable' \
  -X 'POST' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>' \
  --data-raw $'{"isDisable": true,"type": "GlobalValid"}'
```




## 响应
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




