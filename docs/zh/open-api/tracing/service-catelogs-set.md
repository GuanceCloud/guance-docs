# 配置链路服务清单

---

<br />**POST /api/v1/tracing/service_catelogs/set**

## 概述
配置服务清单




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service | string | Y | 服务<br>允许为空: False <br> |
| serviceCatelog | string | Y | 服务清单配置<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tracing/service_catelogs/set' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-binary '{"service":"kodox.nsq.consumer","serviceCatelog":"\n[Team]    #团队\n\nservice = \"kodox.nsq.consumer\"    # 必填，跟 dd-service 值一致\n\nteam = \"logFill2\"   # 必填，当前服务所属团队\n\n# oncall = [\"xxx@guance.com\"]    # 服务异常或发生故障时紧急联系人名单\n\n[Repos]    # 仓库配置\n#repo1 = {link=\"https://www.xxx.com\",provider=\"provider1\",name=\"name1\"}    # 填写仓库链接对应的提供商和期望显示文本\n# repo2 = {link=\"https://www.xxx.com\",provider=\"provider2\",name=\"name2\"}\n\n[Related]   # 关联分析\n# 该配置适用于管理链路查看器中关联日志的字段，观测云默认提供 \"trace_id\",\"host\",\"all\" 3 个字段选项，您可在下方添加自定义的字段\nlog = [\"browser_version\",\"action_id\"]\n[Docs]   # 帮助\n# doc1 = {link=\"https://www.xxx.com\",provider=\"provider1\",name=\"name1\"}    # 填写帮助链接对应的内容提供方和期望显示文本\n# doc2 = {link=\"https://www.xxx.com\",provider=\"provider2\",name=\"name2\"}\n\n  "}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F7CEEA99-D3DE-4A89-941A-E0E603ACDAD78"
} 
```




