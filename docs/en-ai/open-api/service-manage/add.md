# 【Service List】Create

---

<br />**POST /api/v1/service_manage/add**

## Overview
Add a new service list configuration



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| serviceCatelog | string | Y | Service list configuration, toml configuration string<br>$maxCustomLength: 65535 <br>Allow empty: False <br> |

## Additional Parameter Explanation


**Request Body Structure Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| serviceCatelog    |  string  |  Y | Original toml format string of the service list configuration|


**serviceCatelog Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| Team    |  dict  |  Y | Information about services, teams, etc. |
| Repos |  array  |  N | Repository configurations |
| Docs    |  array  |  N | Help configurations |
| Related    |  array  |  N | Associated configurations |

**Team Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| service    |  string  |  Y | Service name |
| type |  string  |  N | Service type, this field value is an enumeration type (app, framework, cache, message_queue, custom, db, web) |
| team    |  string  |  N | Team name |
| colour    |  string  |  N | Service color |
| oncall    |  array  |  N | Contact information |

**colour Field Enumeration Types Include**
'#C75BC9', '#DE5565', '#C43243', '#D77D3D', '#2EB2EE', '#A7D650', '#417C51',
'#40C9C9', '#6454CB', '#E8C035', '#36AEAE', '#FDA82D', '#FFD33B', '#196AAB',
'#993C7E', '#6C7AEB', '#49B566', '#9E7EDD', '#8EB743', '#D47FD6', '#289ED4',
'#3F94DC', '#8934A4', '#1A9A82', '#AC8AF0', '#F19AF2'

**oncall Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| name    |  string  |  N | Contact name |
| type |  string  |  N | Contact type, enumerated values email,mobile,slack |
| emails    |  array  |  N | Emails |
| mobiles    |  array  |  N | Phone numbers |
| slack    |  string  |  N | Slack channel URL |

**Repos, Docs Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| link    |  string  |  N | Repository code URL/associated document URL |
| name |  string  |  N | Display name |
| provider    |  string  |  N | Provider name |

**Related Field Explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| AppId    |  string  |  N | User access monitoring application ID |
| DashboardUUIDs |  array  |  N | Bound built-in view UUIDs |
| Tags    |  array  |  N | Associated tags |

Example of serviceCatelog field:
```toml

[Team]    # Team
service = "jinlei_1"    # Required
type = "db"  # Required, current service type
team = "Testing Group"   # Current service team name
colour = "#40C9C9"   # Current service color information

[[Team.oncall]]  # Contact configuration
name = "Guance"
type = "email"
emails = ["test1@guance.com", "test2@guance.com"]

[[Team.oncall]]  # Contact configuration
name = "zhuyun"
type = "mobile"
mobiles = ["xxxxxxx5786", "xxxxxxx4231"]

[[Team.oncall]]  # Contact configuration
name = "test"
type = "slack"
slack = "#test"

[[Repos]]  # Repository configuration, fill in the provider and expected display text corresponding to the repository link
link = "https://www.guance.com"
name = "Guance"
provider = "Guance"

[[Repos]]  # Repository configuration
link = "https://func.guance.com"
name = "Func"
provider = "Guance"


[[Docs]]  # Help, fill in the content provider and expected display text corresponding to the help link
link = "https://www.docs.guance.com"
name = "Guance"
provider = "Guance"

[[Docs]]  # Help
link = "https://func.guance.com/doc"
name = "Func"
provider = "Guance"


[Related]  # Associated configuration
AppId = "a138bcb0_47ef_11ee_9d75_31ea50b9d85a"
Tags = ["test", "mysql"]
DashboardUUIDs = ["dsbd_xxxx32", "dsbd_xxxx32"]


```




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/add' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceCatelog": "\n[Team]    # Team\nservice = \"test\"    # Required\ntype = \"db\"  # Required, current service type\nteam = \"Testing Group\"   # Current service team UUID\ncolour = \"#40C9C9\"   # Current service color information\n\n[[Team.oncall]]  # Contact configuration\nname = \"Guance\"\ntype = \"email\"\nemails = [\"test1@guance.com\", \"test2@guance.com\"]\n\n[[Team.oncall]]  # Contact configuration\nname = \"zhuyun\"\ntype = \"mobile\"\nmobiles = [\"xxxxxxx5786\", \"xxxxxxx4231\"]\n\n[[Team.oncall]]  # Contact configuration\nname = \"test\"\ntype = \"slack\"\nslack = \"#test\"\n\n[[Repos]]  # Repository configuration, fill in the provider and expected display text corresponding to the repository link\nlink = \"https://www.guance.com\"\nname = \"Guance\"\nprovider = \"Guance\"\n\n[[Repos]]  # Repository configuration\nlink = \"https://func.guance.com\"\nname = \"Func\"\nprovider = \"Guance\"\n\n\n[[Docs]]  # Help, fill in the content provider and expected display text corresponding to the help link\nlink = \"https://www.docs.guance.com\"\nname = \"Guance\"\nprovider = \"Guance\"\n\n[[Docs]]  # Help\nlink = \"https://func.guance.com/doc\"\nname = \"Func\"\nprovider = \"Guance\"\n\n\n[Related]  # Associated configuration\nAppId = \"a138bcb0_47ef_11ee_9d75_31ea50b9d85a\"\nTags = [\"test\", \"mysql\"]\nDashboardUUIDs = [\"dsbd_xxxx32\", \"dsbd_xxxx32\"]"}' \
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