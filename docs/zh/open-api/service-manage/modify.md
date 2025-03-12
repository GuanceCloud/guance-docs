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


**serviceCatelog 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| Team    |  dict  |  Y | 服务,团队等信息 |
| Repos |  array  |  N | 仓库配置 |
| Docs    |  array  |  N | 帮助配置 |
| Related    |  array  |  N | 关联配置 |

**Team 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| service    |  string  |  Y | 服务名称 |
| type |  string  |  N | 服务类型, 该字段值为枚举类型(app, framework, cache, message_queue, custom, db, web) |
| team    |  string  |  N | 团队名称 |
| colour    |  string  |  N | 服务颜色 |
| oncall    |  array  |  N | 联系方式 |

**colour 字段 枚举类型如下**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| name    |  string  |  N | 联系方式名称 |
| type |  string  |  N | 联系方式类型, 枚举值 email,mobile,slack |
| emails    |  array  |  N | 邮件 |
| mobiles    |  array  |  N | 电话 |
| slack    |  string  |  N | Slack 频道地址 |

**Repos, Docs 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| link    |  string  |  N | 仓库代码URL/关联文档URL |
| name |  string  |  N | 显示名称 |
| provider    |  string  |  N | 提供商名称 |

**Related 字段 说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| AppId    |  string  |  N | 用户访问监测应用ID |
| DashboardUUIDs |  array  |  N | 绑定内置视图UUID |
| Tags    |  array  |  N | 关联标签 |

serviceCatelog 字段示列:
```toml

[Team]    #团队
service = "test_02"    # 必填
type = "db"  # 必填，当前服务所属类型
team = "开发组"   # 当前服务所属团队名称
colour = "#40C922"   # 当前服务颜色信息

[[Team.oncall]]  # 联系方式配置
name = "guanceyun"
type = "email"
emails = ["test1@guance.com", "test3@guance.com"]

[[Team.oncall]]  # 联系方式配置
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # 联系方式配置
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本
link = "https://<<< custom_key.brand_main_domain >>>"
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


[Related]  # 关联配置
AppId = "a138bcb0_47ef_11ee_9d75_31ea50b9d85a"
Tags = ["test"]
DashboardUUIDs = ["dsbd_xxxx32"]



```




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/sman_xxxx32/modify' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog": "\n[Team]    #团队\nservice = \"test_02\"    # 必填\ntype = \"db\"  # 必填，当前服务所属类型\nteam = \"开发组\"   # 当前服务所属团队UUID\ncolour = \"#40C922\"   # 当前服务颜色信息\n\n[[Team.oncall]]  # 联系方式配置\nname = \"guanceyun\"\ntype = \"email\"\nemails = [\"test1@guance.com\", \"test3@guance.com\"]\n\n[[Team.oncall]]  # 联系方式配置\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # 联系方式配置\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本\nlink = \"https://<<< custom_key.brand_main_domain >>>\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Repos]]  # 仓库配置\nlink = \"https://func.guance.com\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[[Docs]]  # 帮助, 填写帮助链接对应的内容提供方和期望显示文本\nlink = \"https://www.docs.guance.com\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Docs]]  # 帮助\nlink = \"https://func.guance.com/doc\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[Related]  # 关联配置\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\"]\nDashboardUUIDs = [\"dsbd_xxxx32\"]\n\n\n"}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "service": "test11",
        "type": "web",
        "uuid": "sman_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-31BA6F1E-7507-4F6B-B114-C0296E0B9444"
} 
```




