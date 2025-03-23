# Account - Modify

---

<br />**POST /api/v1/account/\{account_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| account_uuid         | string   | Y          | UUID of the account<br> |


## Body Request Parameters

| Parameter Name           | Type     | Required   | Description              |
|:------------------------|:---------|:-----------|:------------------------|
| name                    | string   |            | Nickname<br>Example: supper_man <br>Allow empty: False <br> |
| mobile                  | string   |            | Phone number<br>Example: 18621000000 <br>Allow empty: False <br>Allow empty string: True <br> |
| username                | string   |            | Login account<br>Example: username <br>Allow empty: False <br> |
| email                   | string   |            | Email<br>Example: email <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| password                | string   |            | Password<br>Example: xxxx <br>Allow empty: False <br> |
| tokenHoldTime           | integer  |            | Inactive session hold duration (in seconds, default 1440 minutes, 86400 seconds)<br>Example: 604800 <br>Allow empty: False <br>Allow empty string: False <br>$minValue: 1800 <br>$maxValue: 604800 <br> |
| tokenMaxValidDuration   | integer  |            | Maximum login session duration (in seconds, default 7 days, 604800 seconds)<br>Example: 2592000 <br>Allow empty: False <br>Allow empty string: False <br>$minValue: 60 <br>$maxValue: 2592000 <br> |
| attributes              | json     |            | Account attribute information (JSON structure, KV structure, V part should preferably be strings, suitable for automatic updates during SSO login)<br>Example: {'department': 'Department A'} <br>Allow empty: False <br> |
| customAttributes        | json     |            | Custom account attribute information (JSON structure, KV structure, V part should preferably be strings, only applicable for business-side updates)<br>Example: {'department': 'Department A'} <br>Allow empty: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```




