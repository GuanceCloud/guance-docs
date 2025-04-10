# Create a Notification Target

---

<br />**POST /api/v1/notify_object/create**

## Overview
Create a notification target



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| type | string | Y | Trigger rule type, default is `trigger`<br>Can be empty: True <br>Optional values: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms', 'simpleHTTPRequest', 'slackIncomingWebhook', 'teamsWorkflowWebhook'] <br> |
| name | string | Y | Notification target name<br>Can be empty: False <br> |
| optSet | json |  | Alert settings<br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), after enabling the operation permissions for this rule will be based on permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (roles (excluding owners), member UUIDs, team UUIDs)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Additional Parameter Explanation


*Data explanation.*

**Request parameter explanation: **
| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | Notification target name |
| type             | string | Trigger rule type                                                 |
| optSet             | dict | Alert settings                                                 |
| openPermissionSet             | boolean | Whether to enable custom permission configuration, default false                                                 |
| permissionSet             | array | Operation permission configuration                                                 |

**1. `type`=`dingTalkRobot` parameters in optSet **

| key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | DingTalk bot invocation address |
| secret   | String | Required    | DingTalk bot invocation secret key (add bot - security settings - sign) |


**2. `type`=`HTTPRequest` when optSet parameters **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation address |


**3. `type`=`wechatRobot` when optSet parameters **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | Bot invocation address |

**4. `type`=`mailGroup` when optSet parameters **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| to  | Array | Required    | Member account list |

**5. `type`=`feishuRobot` optSet parameters **

| key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | Lark bot invocation address |
| secret   | String | Required    | Lark bot invocation secret key (add bot - security settings - sign) |

**6. `type`=`sms` when optSet parameters **

 | key      | Type   | Required | Description  |
 | :------- | :----- | :------- | :----------- |
 | to  | Array | Required    | Phone number list |

**7. `type`=`simpleHTTPRequest` when optSet parameters **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation address |

**8. `type`=`slackIncomingWebhook` when optSet parameters (added in iteration 2025-03-26)**

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | Bot invocation address |

**9. `type`=`teamsWorkflowWebhook` when optSet parameters (added in iteration 2025-03-26)**

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | Bot invocation address |

**Explanation of `permissionSet`, `openPermissionSet` fields (fields added in iteration 2024-06-26): **
When the notification target configuration has `openPermissionSet` enabled, only space owners and roles, teams, members configured in `permissionSet` can edit/delete.
When `openPermissionSet` is disabled (default), delete/edit permissions follow the existing interface edit/delete permissions.

The `permissionSet` field can be configured with role UUIDs (`wsAdmin`, `general`, `readOnly`, `role_xxxxx`), team UUIDs (`group_yyyy`), and member UUIDs (`acnt_xxx`).
Example of `permissionSet` field:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```






## Response
```shell
 
```