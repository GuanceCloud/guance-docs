# [Service List] Create

---

<br />**POST /api/v1/service_manage/add**

## Overview
Create a new service list configuration




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| serviceCatelog | string | Y | Service list configuration, toml configuration string<br>$maxCustomLength: 65535 <br>Allow empty: False <br> |

## Additional Parameter Explanation


**Request Body Structure Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| serviceCatelog    |  string  |  Y | Original toml format string of the service list configuration|


**serviceCatelog Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| Team    |  dict  |  Y | Service and team information |
| Repos |  array  |  N | Repository configuration |
| Docs    |  array  |  N | Help configuration |
| Related    |  array  |  N | Related configuration |

**Team Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| service    |  string  |  Y | Service name |
| type |  string  |  N | Service type, the value of this field is an enumeration type (app, framework, cache, message_queue, custom, db, web) |
| team    |  string  |  N | Team name |
| colour    |  string  |  N | Service color |
| oncall    |  array  |  N | Contact information |

**colour Field Enumeration Types as Follows**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| name    |  string  |  N | Contact name |
| type |  string  |  N | Contact type, enumeration values email,mobile,slack |
| emails    |  array  |  N | Email |
| mobiles    |  array  |  N | Phone |
| slack    |  string  |  N | Slack channel address |

**Repos, Docs Fields Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| link    |  string  |  N | Repository code URL/Related document URL |
| name |  string  |  N | Display name |
| provider    |  string  |  N | Provider name |

**Related Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|----------------------|----------|----|------------------------|
| AppId    |  string  |  N | Synthetic Tests application ID |
| DashboardUUIDs |  array  |  N | Bound built-in view UUID |
| Tags    |  array  |  N | Related tags |

serviceCatelog Field Example:
```toml

[Team]    # Team
service = "jinlei_1"    # Required
type = "db"  # Required, current service type
team = "测试组"   # Current service team name
colour = "#40C9C9"   # Current service color information

[[Team.oncall]]  # Contact configuration
name = "guanceyun"
type = "email"
emails = ["xxx@<<< custom_key.brand_main_domain >>>", "xxx@<<< custom_key.brand_main_domain >>>"]

[[Team.oncall]]  # Contact configuration
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # Contact configuration
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # Repository configuration, # Fill in the provider corresponding to the repository link and the expected display text
link = "https://www.<<< custom_key.brand_main_domain >>>"
name = "guance"
provider = "guanceyun"

[[Repos]]  # Repository configuration
link = "https://<<< custom_key.func_domain >>>"
name = "func"
provider = "guanceyun"


[[Docs]]  # Help, fill in the content provider and expected display text corresponding to the help link
link = "<<< homepage >>>"
name = "guance"
provider = "guanceyun"

[[Docs]]  # Help
link = "https://<<< custom_key.func_domain >>>/doc"
name = "func"
provider = "guanceyun"


[Related]  # Related configuration
AppId = "a138bcb0_47ef_11ee_9d75_31ea50b9d85a"
Tags = ["test", "mysql"]
DashboardUUIDs = ["dsbd_xxxx32", "dsbd_xxxx32"]


```




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/add' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog": "\n[Team]    #团队\nservice = \"test\"    # 必填\ntype = \"db\"  # 必填，当前服务所属类型\nteam = \"测试组\"   # 当前服务所属团队UUID\ncolour = \"#40C9C9\"   # 当前服务颜色信息\n\n[[Team.oncall]]  # 联系方式配置\nname = \"guanceyun\"\ntype = \"email\"\nemails = [\"xxx@<<< custom_key.brand_main_domain >>>\", \"xxx@<<< custom_key.brand_main_domain >>>\"]\n\n[[Team.oncall]]  # 联系方式配置\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # 联系方式配置\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # 仓库配置, # 填写仓库链接对应的提供商和期望显示文本\nlink = \"https://www.<<< custom_key.brand_main_domain >>>\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Repos]]  # 仓库配置\nlink = \"https://<<< custom_key.func_domain >>>\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[[Docs]]  # 帮助, 填写帮助链接对应的内容提供方和期望显示文本\nlink = \"<<< homepage >>>\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Docs]]  # 帮助\nlink = \"https://<<< custom_key.func_domain >>>/doc\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[Related]  # 关联配置\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\", \"mysql\"]\nDashboardUUIDs = [\"dsbd_xxxx32\", \"dsbd_xxxx32\"]"}' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "service": "test",
        "type": "db",
        "uuid": "sman_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-46F852D1-95CE-4783-B62A-9DDF66922A71"
} 
```