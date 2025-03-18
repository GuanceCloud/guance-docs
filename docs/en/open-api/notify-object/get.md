# Get Notification Target Information

---

<br />**GET /api/v1/notify_object/get**

## Overview
Retrieve information for a specified notification target.


## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| notifyObjectUUID     | string   | Y        | Notification target UUID |

## Additional Parameter Explanation

**Response Body Parameter Explanation**

| Parameter Name           | Type    | Description                                                 |
| ------------------------ | ------- | ----------------------------------------------------------- |
| allow_operation          | boolean/None | True: Indicates that the current user is allowed to perform update operations such as modification or deletion, False: Not allowed, None: Indicates that it will follow the interface operation permissions |
| permissionSetInfo        | dict    | Custom operation configuration related information         |


## Response
```shell
 
```