# 【服务清单】修改

---

<br />**POST /api/v1/service_manage/\{service_uuid\}/modify**

## 概述
修改一个服务清单配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service_uuid | string | Y | 服务uuid<br>例子: sman_xxx <br>允许为空: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| serviceCatelog | string | Y | 服务清单配置, toml配置字符串<br>$maxCustomLength: 65535 <br>允许为空: False <br> |

## 参数补充说明


**请求主体结构说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| serviceCatelog    |  string  |  Y | 服务清单配置的 原始 toml 格式字符串|
| service_uuid    |  string  |  Y | 服务清单的唯一uuid, 前缀为 sman_ |

**serviceCatelog 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| Team    |  dict  |  Y | 服务,团队相关相关信息 |
| Repos |  array  |  N | 仓库配置 |
| Docs    |  array  |  N | 帮助配置 |

**Team 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| service    |  string  |  Y | 服务名称 |
| type |  string  |  Y | 服务类型, 该字段值为枚举类型(app, framework, cache, message_queue, custom, db, web) |
| team    |  string  |  N | 团队名称 |
| oncall    |  array  |  N | 紧急联系人 |

**Repos, Docs 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| link    |  string  |  Y | 仓库代码URL/关联文档URL |
| name |  string  |  Y | 显示名称 |
| provider    |  string  |  N | 提供商名称 |

serviceCatelog 字段示列:
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
curl 'https://openapi.guance.com/api/v1/service_manage/sman_d4d1a628710240548bef465b8ca2613e/modify' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog":"[Team]    #团队\nservice = \"test11\"    # 必填\ntype = \"web\"  # 必填，当前服务所属类型\nteam = \"abc\"   # 当前服务所属团队\noncall = [\"xxx@guance.com\"]    # 服务异常或发生故障时紧急联系人名单\n\n[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本\nlink = \"https://www.guance.com\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Repos]]  # 仓库配置\nlink = \"https://func.guance.com\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[[Docs]]  # 帮助, 填写帮助链接对应的内容提供方和期望显示文本\nlink = \"https://www.docs.guance.com\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Docs]]  # 帮助\nlink = \"https://func.guance.com/doc\"\nname = \"func\"\nprovider = \"guanceyun\"\n"}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "service": "test11",
        "type": "web",
        "uuid": "sman_d4d1a628710240548bef465b8ca2613e"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-31BA6F1E-7507-4F6B-B114-C0296E0B9444"
} 
```




