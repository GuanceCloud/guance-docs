# Get Function Menu (Old)

---

<br />**GET /api/v1/workspace/menu/get**

## Overview
Retrieve the current workspace function menu




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/menu/get' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "key": "Scene",
                "value": 1
            },
            {
                "key": "Events",
                "value": 1
            },
            {
                "key": "ExceptionsTracking",
                "value": 0
            },
            {
                "key": "Objectadmin",
                "value": 0
            },
            {
                "key": "MetricQuery",
                "value": 1
            },
            {
                "key": "LogIndi",
                "value": 1
            },
            {
                "key": "Tracing",
                "value": 1
            },
            {
                "key": "Rum",
                "value": 1
            },
            {
                "key": "CloudDial",
                "value": 1
            },
            {
                "key": "Security",
                "value": 1
            },
            {
                "key": "GitLabCI",
                "value": 1
            },
            {
                "key": "Monitor",
                "value": 1
            },
            {
                "key": "Integration",
                "value": 1
            },
            {
                "key": "Workspace",
                "value": 1
            },
            {
                "key": "Billing",
                "value": 1
            }
        ],
        "createAt": 1697627382,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 763,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1697627382,
        "updator": "acnt_xxxx32",
        "uuid": "ctcf_xxxx32",
        "workspaceUUID": "wksp_xxxx20"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13205984800302747785"
} 
```

### Explanation of Configuration Keys

- **Scene**: Indicates whether the scene feature is enabled.
- **Events**: Indicates whether the events feature is enabled.
- **ExceptionsTracking**: Indicates whether exception tracking is enabled.
- **Objectadmin**: Indicates whether object administration is enabled.
- **MetricQuery**: Indicates whether metric queries are enabled.
- **LogIndi**: Indicates whether log indicators are enabled.
- **Tracing**: Indicates whether tracing features are enabled.
- **Rum**: Indicates whether RUM features are enabled.
- **CloudDial**: Indicates whether cloud dial testing is enabled.
- **Security**: Indicates whether security features are enabled.
- **GitLabCI**: Indicates whether GitLab CI integration is enabled.
- **Monitor**: Indicates whether monitoring features are enabled.
- **Integration**: Indicates whether integrations are enabled.
- **Workspace**: Indicates whether workspace management features are enabled.
- **Billing**: Indicates whether billing features are enabled.