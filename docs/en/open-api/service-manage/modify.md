# [Service List] Modification

---

<br />**POST /api/v1/service_manage/\{service_uuid\}/modify**

## Overview
Modify a service list configuration




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| service_uuid         | string   | Y          | Service uuid<br>Example: sman_xxx <br>Can be empty: False <br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| serviceCatelog       | string   | Y          | Service list configuration, toml configuration string<br>$maxCustomLength: 65535 <br>Can be empty: False <br> |

## Additional Parameter Explanation


**Request Body Structure Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| serviceCatelog        | string   | Y         | Original toml format string of the service list configuration|


**serviceCatelog Field Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| Team                  | dict     | Y         | Service, team information |
| Repos                 | array    | N         | Repository configuration |
| Docs                  | array    | N         | Help configuration |
| Related               | array    | N         | Associated configuration |

**Team Field Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| service              | string   | Y         | Service name |
| type                 | string   | N         | Service type, this field value is an enumeration type(app, framework, cache, message_queue, custom, db, web) |
| team                 | string   | N         | Team name |
| colour               | string   | N         | Service color |
| oncall               | array    | N         | Contact information |

**colour Field Enumerated Types Are As Follows**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall Field Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| name                 | string   | N         | Contact information name |
| type                 | string   | N         | Contact information type, enumerated values email,mobile,slack |
| emails               | array    | N         | Emails |
| mobiles              | array    | N         | Phones |
| slack                | string   | N         | Slack channel address |

**Repos, Docs Fields Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| link                 | string   | N         | Repository code URL/Associated document URL |
| name                 | string   | N         | Display name |
| provider             | string   | N         | Provider name |

**Related Field Explanation**

| Parameter Name        | Type     | Required  | Description          |
|-----------------------|----------|-----------|---------------------|
| AppId                 | string   | N         | Synthetic Tests application ID |
| DashboardUUIDs        | array    | N         | Bound built-in view UUID |
| Tags                 | array    | N         | Associated tags |

Example of serviceCatelog field:
```toml

[Team]    # Team
service = "test_02"    # Required
type = "db"  # Required, current service type
team = "Development Group"   # Current service team name
colour = "#40C922"   # Current service color information

[[Team.oncall]]  # Contact information configuration
name = "guanceyun"
type = "email"
emails = ["xxx@<<< custom_key.brand_main_domain >>>", "xxx@<<< custom_key.brand_main_domain >>>"]

[[Team.oncall]]  # Contact information configuration
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # Contact information configuration
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # Repository configuration, # Fill in the corresponding provider and desired display text for the repository link
link = "https://www.<<< custom_key.brand_main_domain >>>"
name = "guance"
provider = "guanceyun"

[[Repos]]  # Repository configuration
link = "https://<<< custom_key.func_domain >>>"
name = "func"
provider = "guanceyun"


[[Docs]]  # Help, fill in the content provider and desired display text corresponding to the help link
link = "<<< homepage >>>"
name = "guance"
provider = "guanceyun"

[[Docs]]  # Help
link = "https://<<< custom_key.func_domain >>>/doc"
name = "func"
provider = "guanceyun"


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
  --data-binary '{"serviceCatelog": "\n[Team]    # Team\nservice = \"test_02\"    # Required\ntype = \"db\"  # Required, current service type\nteam = \"Development Group\"   # Current service team UUID\ncolour = \"#40C922\"   # Current service color information\n\n[[Team.oncall]]  # Contact information configuration\nname = \"guanceyun\"\ntype = \"email\"\nemails = [\"xxx@<<< custom_key.brand_main_domain >>>\", \"xxx@<<< custom_key.brand_main_domain >>>\"]\n\n[[Team.oncall]]  # Contact information configuration\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # Contact information configuration\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # Repository configuration, # Fill in the corresponding provider and desired display text for the repository link\nlink = \"https://www.<<< custom_key.brand_main_domain >>>\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Repos]]  # Repository configuration\nlink = \"https://<<< custom_key.func_domain >>>\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[[Docs]]  # Help, fill in the content provider and desired display text corresponding to the help link\nlink = \"<<< homepage >>>\"\nname = \"guance\"\nprovider = \"guanceyun\"\n\n[[Docs]]  # Help\nlink = \"https://<<< custom_key.func_domain >>>/doc\"\nname = \"func\"\nprovider = \"guanceyun\"\n\n\n[Related]  # Associated configuration\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\"]\nDashboardUUIDs = [\"dsbd_xxxx32\"]\n\n\n"}' \
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