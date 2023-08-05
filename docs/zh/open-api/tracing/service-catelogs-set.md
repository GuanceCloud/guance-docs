# 配置服务清单

---

<br />**POST /api/v1/tracing/service_catelogs/set**

## 概述
配置服务清单




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service | string | Y | 服务<br>允许为空: False <br> |
| serviceCatelog | string | Y | 服务清单配置, toml配置字符串<br>$maxCustomLength: 65535 <br>允许为空: False <br> |

## 参数补充说明

字段 serviceCatelog 为 toml 格式字符串
serviceCatelog 字段示例:
```toml

[Team]    #团队
service = "mysql"    # 必填
type = "db"  # 必填，当前服务所属类型
team = "abc"   # 当前服务所属团队
oncall = ["xxx@guance.com"]    # 服务异常或发生故障时紧急联系人名单

[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本
link = "https://www.guance.com"
name = "guance"
provider = "guanceyun"

[[Repos]]  # 仓库配置
link = "https://func.guance.com"
name = "func"
provider = "guanceyun"


[[Docs]]  # 帮助, 填写帮助链接对应的内容提供方和期望显示文本
link = "https://www.docs.guance.com"
name = "guance"
provider = "guanceyun"

[[Docs]]  # 帮助
link = "https://func.guance.com/doc"
name = "func"
provider = "guanceyun"

```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tracing/service_catelogs/set' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-binary '{"service":"kodo11","serviceCatelog":"[Team]    #团队\nservice = \"kodo11\"    # 必填\ntype = \"db\"  # 必填，当前服务所属类型\nteam = \"abc\"   # 当前服务所属团队\noncall = [\"xxx@guance.com\"]    # 服务异常或发生故障时紧急联系人名单\n\n[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本\nlink = \"https://www.guance.com\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Repos]]  # 仓库配置\nlink = \"https://func.guance.com\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[[Docs]]  # 帮助, 填写帮助链接对应的内容提供方和期望显示文本\nlink = \"https://www.docs.guance.com\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Docs]]  # 帮助\nlink = \"https://func.guance.com/doc\"\nname = \"func\"\nprovider = \"guanceyun\"\n"}' \
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




