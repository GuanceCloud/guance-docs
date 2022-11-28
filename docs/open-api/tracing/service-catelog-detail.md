# 获取链路服务清单配置

---

<br />**get /api/v1/tracing/service_catelog/detail**

## 概述
获取服务清单的配置信息, 通过originStr字段确认所需Service Catelog的是原始字符串,还是结构化数据




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service | string | Y | 服务<br>允许为空: False <br> |
| originStr | int | Y | 需要的数据是原始字符串传1,需要解析后的结构化数据传0<br>允许为空: False <br> |

## 参数补充说明

参数说明:

服务清单的获取, 通过字段originStr控制所需服务清单的数据是原始字符串还是结构化数据

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog             |string,dict |  服务清单的原始字符串或者结构化数据 |
|updatorInfo             |dict |  服务清单的更新者信息 |
|relatedLogs       |list |  全局的链路关联日志的自定义字段值配置, 两处信息同步 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tracing/service_catelog/detail?service=redis&originStr=1' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed \
  --insecure
```




## 响应
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
        "serviceCatelog": "\n[Team]    #团队\n\nservice = \"redis\"    # 必填，跟 dd-service 值一致\n\nteam = \"koko001\"   # 必填，当前服务所属团队\n\n# oncall = [\"xxx@guance.com\"]    # 服务异常或发生故障时紧急联系人名单\n\n[Repos]    # 仓库配置\n#repo1 = {\"https://www.xxx.com\",\"provider1\",\"name1\"}    # 填写仓库链接对应的提供商和期望显示文本\n# repo2 = {\"https://www.xxx.com\",\"provider2\",\"name2\"}\n\n[Related]   # 关联分析\n# 该配置适用于管理链路查看器中关联日志的字段，观测云默认提供 \"trace_id\",\"host\",\"all\" 3 个字段选项，您可在下方添加自定义的字段\n\n[Docs]   # 帮助\n# doc1 = {\"https://www.xxx.com\",\"provider1\",\"name1\"}    # 填写帮助链接对应的内容提供方和期望显示文本\n# doc2 = {\"https://www.xxx.com\",\"provider2\",\"name2\"}\n\n  ",
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




