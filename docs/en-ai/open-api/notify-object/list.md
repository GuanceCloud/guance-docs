# Get Notification Targets List

---

<br />**GET /api/v1/notify_object/list**

## Overview
Retrieve a paginated list of notification targets


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string | No  | Search for notification target names<br>Allow null: True <br> |
| pageIndex | integer | Yes  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | Yes  | Number of items per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation

**Response Body Parameter Explanation**

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| allow_operation       | boolean/None | True: Indicates that the current user is allowed to perform update operations such as modification/deletion, False: Not allowed, None: Indicates that it will follow the interface operation permissions |
| permissionSetInfo    | dict | Custom operation configuration related information                          |






## Response
```shell
 
```