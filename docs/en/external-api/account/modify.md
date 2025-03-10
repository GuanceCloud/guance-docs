# Account Modification

---

<br />**POST /api/v1/account/{account_uuid}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| account_uuid          | string   | Y        | UUID of the account<br>   |


## Body Request Parameters

| Parameter Name            | Type     | Required | Description              |
|:-------------------------|:---------|:---------|:-------------------------|
| name                     | string   |          | Nickname<br>Example: supper_man <br>Allow null: False <br> |
| mobile                   | string   |          | Phone number<br>Example: 18621000000 <br>Allow null: False <br>Allow empty string: True <br> |
| username                 | string   |          | Login account<br>Example: username <br>Allow null: False <br> |
| email                    | string   |          | Email address<br>Example: email <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| password                 | string   |          | Password<br>Example: xxxx <br>Allow null: False <br> |
| tokenHoldTime            | integer  |          | Session hold time without operation (in seconds, default 1440 minutes, 86400 seconds)<br>Example: 604800 <br>Allow null: False <br>Allow empty string: False <br>$minValue: 1800 <br>$maxValue: 604800 <br> |
| tokenMaxValidDuration    | integer  |          | Maximum session hold time (in seconds, default 7 days, 604800 seconds)<br>Example: 2592000 <br>Allow null: False <br>Allow empty string: False <br>$minValue: 60 <br>$maxValue: 2592000 <br> |
| attributes               | json     |          | Account attribute information (JSON structure, KV structure, try to use strings for V part)<br>Example: {'department': 'Department A'} <br>Allow null: False <br> |

## Additional Parameter Notes



## Response
```shell
 
```