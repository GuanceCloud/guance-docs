# Modify [Service List]

---

<br />**POST /api/v1/service_manage/\{service_uuid\}/modify**

## Overview
Modify a service list configuration


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| service_uuid          | string   | Y          | Service UUID<br>Example: sman_xxx <br>Allow empty: False <br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| serviceCatelog        | string   | Y          | Service list configuration, TOML configuration string<br>$maxCustomLength: 65535 <br>Allow empty: False <br> |

## Additional Parameter Notes

**Request Body Structure Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| serviceCatelog        | string   | Y          | Original TOML formatted string of the service list configuration|

**serviceCatelog Field Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| Team                  | dict     | Y          | Information about services, teams, etc. |
| Repos                 | array    | N          | Repository configurations |
| Docs                  | array    | N          | Help configurations |
| Related               | array    | N          | Associated configurations |

**Team Field Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| service              | string   | Y          | Service name |
| type                 | string   | N          | Service type, enum values (app, framework, cache, message_queue, custom, db, web) |
| team                 | string   | N          | Team name |
| colour               | string   | N          | Service color |
| oncall               | array    | N          | Contact methods |

**colour Field Enum Values**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall Field Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | N          | Contact method name |
| type                 | string   | N          | Contact method type, enum values (email, mobile, slack) |
| emails               | array    | N          | Emails |
| mobiles              | array    | N          | Phone numbers |
| slack                | string   | N          | Slack channel URL |

**Repos, Docs Field Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| link                 | string   | N          | Repository code URL/associated document URL |
| name                 | string   | N          | Display name |
| provider             | string   | N          | Provider name |

**Related Field Description**

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| AppId                | string   | N          | User access monitoring application ID |
| DashboardUUIDs       | array    | N          | Bound built-in view UUIDs |
| Tags                 | array    | N          | Associated tags |

Example of serviceCatelog field:
```toml

[Team]    # Team
service = "test_02"    # Required
type = "db"  # Required, current service type
team = "Development Group"   # Current service team name
colour = "#40C922"   # Current service color information

[[Team.oncall]]  # Contact configuration
name = "Guance"
type = "email"
emails = ["test1@guance.com", "test3@guance.com"]

[[Team.oncall]]  # Contact configuration
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # Contact configuration
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # Repository configuration, fill in provider and expected display text corresponding to repository link
link = "https://<<< custom_key.brand_main_domain >>>"
name = "guance"
provider = "Guance"

[[Repos]]  # Repository configuration
link = "https://<<< custom_key.func_domain >>>"
name = "func"
provider = "Guance"


[[Docs]]  # Help, fill in content provider and expected display text corresponding to help link
link = "https://www.docs.guance.com"
name = "guance"
provider = "Guance"

[[Docs]]  # Help
link = "https://<<< custom_key.func_domain >>>/doc"
name = "func"
provider = "Guance"


[Related]  # Associated configuration
AppId = "a138bcb0_47ef_11ee_9d75_31ea50b9d85a"
Tags = ["test"]
DashboardUUIDs = ["dsbd_xxxx32"]



```


## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/sman_xxxx32/modify' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog": "\n[Team]    # Team\nservice = \"test_02\"    # Required\ntype = \"db\"  # Required, current service type\nteam = \"Development Group\"   # Current service team UUID\ncolour = \"#40C922\"   # Current service color information\n\n[[Team.oncall]]  # Contact configuration\nname = \"Guance\"\ntype = \"email\"\nemails = [\"test1@guance.com\", \"test3@guance.com\"]\n\n[[Team.oncall]]  # Contact configuration\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # Contact configuration\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # Repository configuration, fill in provider and expected display text corresponding to repository link\nlink = \"https://<<< custom_key.brand_main_domain >>>\"\nname = \"guance\"\nprovider = \"Guance\"\n\n[[Repos]]  # Repository configuration\nlink = \"https://<<< custom_key.func_domain >>>\"\nname = \"func\"\nprovider = \"Guance\"\n\n\n[[Docs]]  # Help, fill in content provider and expected display text corresponding to help link\nlink = \"https://www.docs.guance.com\"\nname = \"guance\"\nprovider = \"Guance\"\n\n[[Docs]]  # Help\nlink = \"https://<<< custom_key.func_domain >>>/doc\"\nname = \"func\"\nprovider = \"Guance\"\n\n\n[Related]  # Associated configuration\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\"]\nDashboardUUIDs = [\"dsbd_xxxx32\"]\n\n\n"}' \
  --compressed
```


## Response
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