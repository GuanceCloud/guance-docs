# 【Service List】Create

---

<br />**POST /api/v1/service_manage/add**

## Overview
Add a new service list configuration


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| serviceCatelog | string | Y | Service list configuration, TOML configuration string<br>$maxCustomLength: 65535 <br>Allow empty: False <br> |

## Additional Parameter Explanation


**Request Body Structure Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| serviceCatelog    |  string  |  Y | Original TOML formatted string of the service list configuration|

**serviceCatelog Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| Team    |  dict  |  Y | Service, team information |
| Repos |  array  |  N | Repository configuration |
| Docs    |  array  |  N | Help configuration |
| Related    |  array  |  N | Associated configuration |

**Team Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| service    |  string  |  Y | Service name |
| type |  string  |  N | Service type, this field value is an enumeration type (app, framework, cache, message_queue, custom, db, web) |
| team    |  string  |  N | Team name |
| colour    |  string  |  N | Service color |
| oncall    |  array  |  N | Contact information |

**colour Field Enumeration Types**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| name    |  string  |  N | Contact name |
| type |  string  |  N | Contact type, enumerated values email,mobile,slack |
| emails    |  array  |  N | Emails |
| mobiles    |  array  |  N | Mobile numbers |
| slack    |  string  |  N | Slack channel URL |

**Repos, Docs Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| link    |  string  |  N | Repository code URL/related document URL |
| name |  string  |  N | Display name |
| provider    |  string  |  N | Provider name |

**Related Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| AppId    |  string  |  N | User access monitoring application ID |
| DashboardUUIDs |  array  |  N | Bound built-in view UUIDs |
| Tags    |  array  |  N | Associated tags |

Example of the serviceCatelog field:
```toml

[Team]    # Team
service = "jinlei_1"    # Required
type = "db"  # Required, current service type
team = "Testing Team"   # Current service team name
colour = "#40C9C9"   # Current service color

[[Team.oncall]]  # Contact information configuration
name = "Guance"
type = "email"
emails = ["test1@guance.com", "test2@guance.com"]

[[Team.oncall]]  # Contact information configuration
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # Contact information configuration
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # Repository configuration, fill in the repository link corresponding to the provider and expected display text
link = "https://<<< custom_key.brand_main_domain >>>"
name = "Guance"
provider = "Guance"

[[Repos]]  # Repository configuration
link = "https://<<< custom_key.func_domain >>>"
name = "func"
provider = "Guance"


[[Docs]]  # Help, fill in the help link corresponding content provider and expected display text
link = "https://www.docs.guance.com"
name = "Guance"
provider = "Guance"

[[Docs]]  # Help
link = "https://<<< custom_key.func_domain >>>/doc"
name = "func"
provider = "Guance"


[Related]  # Associated configuration
AppId = "a138bcb0_47ef_11ee_9d75_31ea50b9d85a"
Tags = ["test", "mysql"]
DashboardUUIDs = ["dsbd_xxxx32", "dsbd_xxxx32"]


```




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/add' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog": "\n[Team]    # Team\nservice = \"test\"    # Required\ntype = \"db\"  # Required, current service type\nteam = \"Testing Team\"   # Current service team UUID\ncolour = \"#40C9C9\"   # Current service color\n\n[[Team.oncall]]  # Contact information configuration\nname = \"Guance\"\ntype = \"email\"\nemails = [\"test1@guance.com\", \"test2@guance.com\"]\n\n[[Team.oncall]]  # Contact information configuration\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # Contact information configuration\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # Repository configuration, # Fill in the repository link corresponding to the provider and expected display text\nlink = \"https://<<< custom_key.brand_main_domain >>>\"\nname = \"Guance\"\nprovider = \"Guance\"\n\n[[Repos]]  # Repository configuration\nlink = \"https://<<< custom_key.func_domain >>>\"\nname = \"func\"\nprovider = \"Guance\"\n\n\n[[Docs]]  # Help, fill in the help link corresponding content provider and expected display text\nlink = \"https://www.docs.guance.com\"\nname = \"Guance\"\nprovider = \"Guance\"\n\n[[Docs]]  # Help\nlink = \"https://<<< custom_key.func_domain >>>/doc\"\nname = \"func\"\nprovider = \"Guance\"\n\n\n[Related]  # Associated configuration\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\", \"mysql\"]\nDashboardUUIDs = [\"dsbd_xxxx32\", \"dsbd_xxxx32\"]"}' \
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