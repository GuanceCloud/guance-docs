# Get Link Service List Configuration

---

<br />**get /api/v1/tracing/service_catelogs/get**

## Overview
Get the configuration information of the service manifest, and confirms whether the required Service Catelog is raw string or structured data through the originStr field.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| service | string | Y | service<br>Allow null: False <br> |
| originStr | int | Y | The required data is the original string to pass 1, and the parsed structured data to pass 0.<br>Allow null: False <br> |

## Supplementary Description of Parameters

Parameter description:

The retrieval of the service list, using the originStr field to control whether the data of the required service list is raw string or structured data.

**Response Body Structure Description**

|  Parameter Name                |   type  |          Description          |
|-----------------------|----------|------------------------|
|serviceCatelog             |string,dict |  Raw string or structured data of service list |
|updatorInfo             |dict |  Updater information of service list |
|relatedLogs       |list |  Custom field value configuration of global link association log, and synchronization of two information |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/tracing/service_catelogs/get?service=redis&originStr=1' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed \
  --insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "config": {},
        "createAt": 1669114500,
        "creator": "acnt_e0c66e43899645846bdcf6663a0b4",
        "deleteAt": -1,
        "id": 1,
        "relatedLogs": [
            "browser_version",
            "action_id"
        ],
        "service": "redis",
        "serviceCatelog": "\n[Team]    #团队\n\nservice = \\\"redis\\\"    # 必填，跟 dd-service 值一致\n\nteam = \\\"koko001\\\"   # 必填，当前服务所属团队\n\n# oncall = [\\\"xxx@guance.com\\\"]    # 服务异常或发生故障时紧急联系人名单\n\n[Repos]    # 仓库配置\n#repo1 = {\\\"https://www.xxx.com\\\",\\\"provider1\\\",\\\"name1\\\"}    # 填写仓库链接对应的提供商和期望显示文本\n# repo2 = {\\\"https://www.xxx.com\\\",\\\"provider2\\\",\\\"name2\\\"}\n\n[Related]   # 关联分析\n# 该配置适用于管理链路查看器中关联日志的字段，观测云默认提供 \\\"trace_id\\\",\\\"host\\\",\\\"all\\\" 3 个字段选项，您可在下方添加自定义的字段\n\n[Docs]   # 帮助\n# doc1 = {\\\"https://www.xxx.com\\\",\\\"provider1\\\",\\\"name1\\\"}    # 填写帮助链接对应的内容提供方和期望显示文本\n# doc2 = {\\\"https://www.xxx.com\\\",\\\"provider2\\\",\\\"name2\\\"}\n\n  ",
        "status": 0,
        "updateAt": 1669114500,
        "updator": "acnt_e0c66e438996458b6bdcf6663a0b4",
        "updatorInfo": {
            "email": "88@qq.com",
            "name": "88",
            "updateAt": 1669114500
        },
        "uuid": "apmc_990c37d66bab4f310da4a37dd1d95",
        "workspaceUUID": "wksp_a03bcea1b4e2e9a30141712931f1e"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DC1F4D44-13A7-4C3B-9581-DA6EBF308D74"
} 
```




