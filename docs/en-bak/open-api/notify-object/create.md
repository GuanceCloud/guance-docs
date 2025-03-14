# Create a Notification Object

---

<br />**post /api/v1/notify_object/create**

## Overview
Create a notification object.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | trigger rule type, default to `trigger`<br>Allow null: True <br>Optional value: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms'] <br> |
| name | string | Y | Notification object name<br>Allow null: False <br> |
| optSet | json |  | Alarm setting<br>Allow null: False <br> |

## Supplementary Description of Parameters


*Data description.*


**1. Parameters of optSet When `type` Equals `dingTalkRobot`**

| key      | Type   | Required or not | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | Address adjustment of DingTalk machine |
| secret   | String | Required    | The key of the DingTalk machine (add the machine-security settings-sign) |


**2. Parameters of optSet When `type` Equals `HTTPRequest`**

| key      | Type   | Required or not | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP call address |


**3. Parameters of optSet When `type` Equals `wechatRobot`**

| key      | Type   | Required or not | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | bot call address |

**4. Parameters of optSet When `type` Equals `mailGroup`**

| key      | Type   | Required or not | Description  |
| :------- | :----- | :------- | :----------- |
| to  | Array | Required    | Member account list |

**5. Parameters of optSet When `type` Equals `feishuRobot`**

| key      | Type   | Required or not | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | Feishu machine adjustment address |
| secret   | String | Required    | Feishu Machine Adjustment Key (Add Machine-Security Settings-Add Signs) |

**6. Parameters of optSet When `type` Equals `sms`**

 | key      | Type   | Required or not | Description  |
 | :------- | :----- | :------- | :----------- |
 | to  | Array | Required    | Mobile phone number list |






## Response
```shell
 
```




