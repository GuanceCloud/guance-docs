# Account Modification

---

<br />**POST /api/v1/account/\{account_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| account_uuid          | string   | Y          | UUID of the account<br>  |


## Body Request Parameters

| Parameter Name            | Type     | Required   | Description              |
|:-------------------------|:---------|:-----------|:-------------------------|
| name                      | string   |            | Nickname<br>Example: supper_man <br>Can be empty: False <br> |
| mobile                    | string   |            | Mobile number<br>Example: 18621000000 <br>Can be empty: False <br>Allows empty string: True <br> |
| username                  | string   |            | Login account<br>Example: username <br>Can be empty: False <br> |
| email                     | string   |            | Email address<br>Example: email <br>Can be empty: False <br>Allows empty string: True <br>Maximum length: 256 <br> |
| password                  | string   |            | Password<br>Example: xxxx <br>Can be empty: False <br> |
| tokenHoldTime             | integer  |            | Inactive session hold duration (in seconds, default 1440 minutes, 86400 seconds)<br>Example: 604800 <br>Can be empty: False <br>Allows empty string: False <br>$minValue: 1800 <br>$maxValue: 604800 <br> |
| tokenMaxValidDuration     | integer  |            | Maximum login session duration (in seconds, default 7 days, 604800 seconds)<br>Example: 2592000 <br>Can be empty: False <br>Allows empty string: False <br>$minValue: 60 <br>$maxValue: 2592000 <br> |
| attributes                | json     |            | Account attribute information (JSON structure, KV format, V part preferably as string)<br>Example: {'部门': 'A部门'} <br>Can be empty: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```