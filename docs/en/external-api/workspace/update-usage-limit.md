# 【Workspace】Usage Limit Update

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/usage_limit/update**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| config | json | Y | Usage limit configurations for different types, metric "Metrics", network "Network", rum "RUM PV", logging "Logging", tracing "APM Trace", profile "APM Profile", dialing "Synthetic Tests"<br>Example: {rum: {openLimit: false, value: 0},logging: {openLimit: false, value: 0} <br>Nullable: False <br> |

## Additional Parameter Notes

**Request Body Structure Explanation**

| Parameter Name                | Type  |          Description          |
|-----------------------|----------|------------------------|
|config         |json |  Daily usage limits for specific types within the workspace |

Example of config structure:

```json
      {
          "rum": {"openLimit": false, "value": 0},
          "logging": {"openLimit": false, "value": 0},
          "tracing": {"openLimit": true, "value": 10000},
          "metric": {"openLimit": false, "value": 0},
          "network": {"openLimit": false, "value": 0},
          "profile": {"openLimit": false, "value": 0},
          "dialing": {"openLimit": false, "value": 0},
      }
```






## Response
```shell
 
```